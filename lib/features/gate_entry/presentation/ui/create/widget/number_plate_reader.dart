import 'dart:io';

import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image/image.dart' as img;


class BlurryImageException implements Exception {
  final double sharpnessScore;
  final double threshold;

  BlurryImageException(this.sharpnessScore, this.threshold);

  @override
  String toString() =>
      'BlurryImageException: sharpness=$sharpnessScore (threshold=$threshold)';
}

class NumberPlateReader {
  static const double _blurThreshold = 80.0;

  static String extractIndianPlate(String rawText) {
    print('RAW: $rawText');
    String cleaned = rawText.toUpperCase().replaceAll(RegExp(r'[^A-Z0-9]'), '');

    print('CLEANED: $cleaned');

    final RegExp plateRegex = RegExp(
      r'(AP|AR|AS|BR|CG|CH|DD|DL|DN|GA|GJ|HR|HP|JH|JK|KA|KL|LA|LD|MH|ML|MN|MP|MZ|NL|OD|PB|PY|RJ|SK|TN|TS|TG|TR|UK|UP|WB)'
      r'\d{2}'
      r'[A-Z]{1,3}'
      r'\d{4}',
    );

    final directMatch = plateRegex.firstMatch(cleaned);
    if (directMatch != null) {
      return _formatPlate(directMatch.group(0)!);
    }

    String normalized = cleaned
        .replaceAll('O', '0')
        .replaceAll('I', '1')
        .replaceAll('Z', '2')
        .replaceAll('B', '8');

    print('NORMALIZED: $normalized');

    final normalizedMatch = plateRegex.firstMatch(normalized);
    if (normalizedMatch != null) {
      return _formatPlate(normalizedMatch.group(0)!);
    }

    const states = [
      'AP', 'AR', 'AS', 'BR', 'CG', 'CH', 'DD', 'DL', 'DN', 'GA', 'GJ', 'HR',
      'HP', 'JH', 'JK', 'KA', 'KL', 'LA', 'LD', 'MH', 'ML', 'MN', 'MP', 'MZ',
      'NL', 'OD', 'PB', 'PY', 'RJ', 'SK', 'TN', 'TS', 'TG', 'TR', 'UK', 'UP',
      'WB'
    ];

    for (int i = 0; i < cleaned.length; i++) {
      for (int len = 8; len <= 11; len++) {
        if (i + len > cleaned.length) continue;

        final candidate = cleaned.substring(i, i + len);

        for (final state in states) {
          if (!candidate.startsWith(state)) continue;

          final rto = candidate.substring(2, 4);
          if (!RegExp(r'\d{2}').hasMatch(rto)) continue;

          final tail = candidate.substring(4);
          if (tail.length < 5) continue;

          final number = tail.substring(tail.length - 4);
          String series = tail.substring(0, tail.length - 4);

          if (!RegExp(r'\d{4}').hasMatch(number)) continue;

          series = series
              .replaceAll('0', 'O')
              .replaceAll('1', 'T')
              .replaceAll('2', 'Z')
              .replaceAll('5', 'S')
              .replaceAll('8', 'B');

          if (!RegExp(r'^[A-Z]{1,3}$').hasMatch(series)) continue;

          return '$state$rto$series$number';
        }
      }
    }

    return 'Plate not confidently detected';
  }

  static String _formatPlate(String plate) {
    return plate;
  }

  /// Computes a sharpness score for [image] using the variance of the
  /// Laplacian (edge-response) of the grayscale image. Lower scores mean
  /// a smoother/blurrier image (fewer sharp edges); higher scores mean a
  /// crisper image. This mirrors the classic OpenCV `cv2.Laplacian(...).var()`
  /// blur-detection approach.
  static double _computeSharpness(img.Image image) {
    // Downscale for speed — sharpness signal survives fine at smaller sizes.
    final resized = img.copyResize(
      image,
      width: image.width > 640 ? 640 : image.width,
    );
    final gray = img.grayscale(resized);

    final width = gray.width;
    final height = gray.height;

    if (width < 3 || height < 3) return 0.0;

    final List<double> laplacianValues = [];

    // Simple 3x3 Laplacian kernel: [[0,1,0],[1,-4,1],[0,1,0]]
    for (int y = 1; y < height - 1; y++) {
      for (int x = 1; x < width - 1; x++) {
        final center = gray.getPixel(x, y).r;
        final up = gray.getPixel(x, y - 1).r;
        final down = gray.getPixel(x, y + 1).r;
        final left = gray.getPixel(x - 1, y).r;
        final right = gray.getPixel(x + 1, y).r;

        final lap = (up + down + left + right - 4 * center).toDouble();
        laplacianValues.add(lap);
      }
    }

    if (laplacianValues.isEmpty) return 0.0;

    final mean =
        laplacianValues.reduce((a, b) => a + b) / laplacianValues.length;
    final variance = laplacianValues
            .map((v) => (v - mean) * (v - mean))
            .reduce((a, b) => a + b) /
        laplacianValues.length;

    return variance;
  }

  /// Throws [BlurryImageException] if [file] is too blurry to OCR reliably.
  /// Returns the decoded image (so callers don't have to decode twice).
  static img.Image _assertNotBlurry(File file) {
    final bytes = file.readAsBytesSync();
    final decoded = img.decodeImage(bytes);

    if (decoded == null) {
      // Can't even decode it — let downstream OCR handle/report this,
      // rather than misreporting it as a blur issue.
      throw Exception('Could not decode image file: ${file.path}');
    }

    final sharpness = _computeSharpness(decoded);
    print('Sharpness score: $sharpness (threshold: $_blurThreshold)');

    if (sharpness < _blurThreshold) {
      throw BlurryImageException(sharpness, _blurThreshold);
    }

    return decoded;
  }

  /// MAIN FUNCTION
  /// Throws [BlurryImageException] if the image is too blurry to read.
  static Future<String?> readPlate(File originalImage) async {
    // Blur check happens first — no point running ML Kit on a smear.
    _assertNotBlurry(originalImage);

    final inputImage = InputImage.fromFile(originalImage);
    final recognizer = TextRecognizer();

    try {
      final result = await recognizer.processImage(inputImage);

      final lines = <String>[];
      for (final block in result.blocks) {
        for (final line in block.lines) {
          final text = line.text.trim();
          if (text.isNotEmpty) {
            print('Processing line text: $text');
            lines.add(text);
          }
        }
      }

      if (lines.isEmpty) return null;

      // Always go through extractIndianPlate — it has the direct regex,
      // O/I/Z/B normalization, AND the state-anchored fuzzy fallback that
      // can recover plates a strict regex misses (e.g. stray OCR noise
      // characters between the RTO code and series letters).

      // 1. Try each line on its own.
      for (final line in lines) {
        final plate = extractIndianPlate(line);
        if (plate != 'Plate not confidently detected') return plate;
      }

      // 2. Try combining adjacent lines (plates often split across lines).
      for (int i = 0; i < lines.length - 1; i++) {
        final plate = extractIndianPlate(lines[i] + lines[i + 1]);
        if (plate != 'Plate not confidently detected') return plate;
      }

      // 3. Last resort: everything combined.
      return extractIndianPlate(lines.join());
    } finally {
      recognizer.close();
    }
  }

  static Future<String?> extractPlate(RecognizedText result) async {
    final RegExp vehicleRegex = RegExp(r'[A-Z]{2}[0-9]{2}[A-Z]{1,2}[0-9]{4}');

    final List<String> lines = [];

    String normalize(String text) {
      return text
          .toUpperCase()
          .replaceAll('O', '0')
          .replaceAll('I', '1')
          .replaceAll('Z', '2')
          .replaceAll(RegExp(r'[^A-Z0-9]'), '');
    }

    // Collect & normalize all lines
    for (final block in result.blocks) {
      for (final line in block.lines) {
        final cleaned = normalize(line.text);
        if (cleaned.isNotEmpty) {
          lines.add(cleaned);
          print('Processing line text: $cleaned');
        }
      }
    }

    // 🔹 1. Try single-line match
    for (final line in lines) {
      final match = vehicleRegex.firstMatch(line);
      if (match != null) {
        return match.group(0);
      }
    }

    // 🔹 2. Try combining adjacent lines (MOST IMPORTANT)
    for (int i = 0; i < lines.length - 1; i++) {
      final combined = lines[i] + lines[i + 1];
      final match = vehicleRegex.firstMatch(combined);
      if (match != null) {
        return match.group(0);
      }
    }

    // 🔹 3. Try combining all lines (fallback)
    final allCombined = lines.join();
    final match = vehicleRegex.firstMatch(allCombined);
    if (match != null) {
      return match.group(0);
    }

    return null;
  }
}