import 'package:tgbc_app/widgets/buttons/app_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

extension BuildContextExt on BuildContext {
  Size get mediasize => MediaQuery.of(this).size;

  void showErrorSnackbar(String text, [Color? bgColor]) {
    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: bgColor ?? Colors.black,
          content: Container(
            alignment: Alignment.center,
            height: 50,
            child: Text(text, style: const TextStyle(fontSize: 16)),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
      );
  }

  Future<void> showSuccessDialog(BuildContext context, String message) async {
    return showDialog(
      context: this,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        actionsAlignment: MainAxisAlignment.center,
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(10.0), // Customize the border radius here
        ),
        title: Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(64.0),
              border: Border.all(color: Colors.green, width: 4.0),
            ),
            padding: const EdgeInsets.all(32.0),
            child: const Icon(Icons.done, size: 48, color: Colors.green),
          ),
        ),
        content: Text(message, style: const TextStyle(), textAlign: TextAlign.center),
        actions: [
          SizedBox(
            width: 150,
            child: AppButton(
              onPressed: Navigator.of(this).pop,
              label: 'OK',
              bgColor: Colors.green,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> showErrorDialog(BuildContext context, String message) async {
    return showDialog(
      context: this,
      barrierDismissible: false,
      builder: (ctx2) => AlertDialog(
        actionsAlignment: MainAxisAlignment.center,
        title: const Center(
          child: Icon(Icons.dangerous_outlined),
        ),
        content: Text(message, style: const TextStyle(), textAlign: TextAlign.center),
        actions: [
          SizedBox(
            width: 200,
            child: AppButton(
              onPressed: Navigator.of(context).pop,
              label: 'OK',
              bgColor: Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  void showSnackbar(
    BuildContext context,
    String message, {
    Duration? duration,
    Color? color,
    SnackBarAction? action,
  }) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: duration ?? const Duration(seconds: 2),
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        padding: const EdgeInsets.all(16.0),
        backgroundColor: color,
        action: action,
      ),
    );
  }

  void exit<T>([T? data]) => Navigator.of(this).pop(data);

  void goToPage(Widget child) =>
      Navigator.of(this).push(MaterialPageRoute(builder: (ctx) => child));

  T bloc<T extends Cubit<dynamic>>() => BlocProvider.of<T>(this);

  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => theme.textTheme;

  ColorScheme get colorScheme => theme.colorScheme;

  double get sizeOfheight => MediaQuery.sizeOf(this).height;
}
