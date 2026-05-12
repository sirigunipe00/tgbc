import 'dart:developer';

import 'package:tgbc_app/app/presentation/app_update_blocprovider.dart';
import 'package:tgbc_app/app/widgets/app_feature_widget.dart';
import 'package:tgbc_app/core/core.dart';
import 'package:tgbc_app/styles/app_text_styles.dart';
import 'package:tgbc_app/styles/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class AppHomePage extends StatelessWidget {
  const AppHomePage({super.key});

  @override
  Widget build(BuildContext context) {


  Future<void> launchCredits() async {
    final String base = Urls.baseUrl.replaceAll('/api', '');
  final Uri url = Uri.parse('$base/app/credits-u1');
  try {
    bool launched = await launchUrl(
      url, 
      mode: LaunchMode.externalApplication,
    );
  if (!launched) {
      debugPrint('Could not launch $url');
    }
  } catch (e) {
    debugPrint('Error launching URL: $e');

  }
}
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white, 
      statusBarIconBrightness: Brightness.dark, 
    ));

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(height: 50),
          const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  'Welcome Home!',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              )),
          Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, top: 0),
                child: Text(
                  context.user.firstName,
                  style: const TextStyle(fontSize: 15),
                ),
              )), // Further adjusted spacing to move search bar down
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          //   child: Container(
          //     decoration: BoxDecoration(
          //       color: Colors.white,
          //       borderRadius: BorderRadius.circular(30), // More rounded corners
          //       boxShadow: [
          //         BoxShadow(
          //           color: Colors.black12.withValues(0.1), // Subtle shadow
          //           blurRadius: 6,
          //           offset: const Offset(0, 3),
          //         ),
          //       ],
          //     ),
          //     child: TextField(
          //       decoration: const InputDecoration(
          //         hintText: "Search",
          //         prefixIcon: Icon(Icons.search, color: Colors.grey),
          //         border: InputBorder.none,
          //         filled: true,
          //         fillColor: Colors.white,
          //         contentPadding: EdgeInsets.symmetric(vertical: 14),
          //       ),
          //       onChanged: (value) {},
          //     ),
          //   ),
          // ),

          const SizedBox(height: 20),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: ImageSlider(),
          ),
          // ImageSlider(),

          // const SectionTitle(title: "Security"),

          Expanded(
            child: SingleChildScrollView(
              child: BlocListener<AppVersionCubit, AppVersionCubitState>(
                listener: (context, state) {
                  state.maybeWhen(
                    orElse: () {},
                    success: (data) {
                      if (data) {
                        // showDialog(
                        //     context: context,
                        //     builder: (ctx) => const AppUpdateDialog(
                        //         appName: 'TGBC',
                        //         packageName: 'in.easycloud.tgbc_app'),
                        //     barrierDismissible: false);
                      }
                    },
                  );
                },
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(
                        left: 20,
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Security',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: AppFeatureWidget(
                              icon: AppIcons.vechileEntry.toWidget(
                                  height: 120, width: 140, fit: BoxFit.contain),
                              title: Text('Gate Entry',
                                  style:
                                      AppTextStyles.featureLabelStyle(context)),
                              featureColor: const Color(0xFFCDB3D8),
                              onTap: () => AppRoute.gateEntry.push(context),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: AppFeatureWidget(
                              icon: AppIcons.vehcileExit.toWidget(
                                  height: 120, width: 140, fit: BoxFit.contain),
                              title: Text('Gate Exit',
                                  style:
                                      AppTextStyles.featureLabelStyle(context)),
                              featureColor: const Color(0xFFE9B6C7),
                              onTap: () => AppRoute.gateExit.push(context),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 210,
                        left: 8,
                        bottom: 5,
                      ),
                      child: AppFeatureWidget(
                        icon: AppIcons.vtr.toWidget(
                            height: 120, width: 140, fit: BoxFit.contain),
                        title: FittedBox(
                          child: Text('Vehicle Reporting\n          Entry',
                              style: AppTextStyles.featureLabelStyle(context)),
                        ),
                        featureColor: const Color(0xFFFFA95F),
                        onTap: () => AppRoute.vrt.push(context),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Divider(),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(
                        left: 20,
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Production',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        children: [
                          Expanded(
                            child: AppFeatureWidget(
                              icon: AppIcons.pufEntry.toWidget(
                                  height: 120, width: 140, fit: BoxFit.contain),
                              title: Text('PUF',
                                  style:
                                      AppTextStyles.featureLabelStyle(context)),
                              featureColor: const Color(0xFF67D4CF),
                              onTap: () => AppRoute.puf.push(context),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: AppFeatureWidget(
                              icon: AppIcons.assembly2.toWidget(
                                  height: 120, width: 140, fit: BoxFit.contain),
                              title: FittedBox(
                                  child: Text('Unit Assembly-1',
                                      style: AppTextStyles.featureLabelStyle(
                                          context))),
                              featureColor: const Color(0xFF67B7D4),
                              onTap: () => AppRoute.unitAssemble.push(context),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Padding(
                    //    padding: const EdgeInsets.only(
                    //     right: 210,
                    //     left: 8,
                    //     bottom: 5,
                    //   ),
                    //   child: AppFeatureWidget(
                    //     icon: AppIcons.Assembly1.toWidget(height: 120, width: 140, fit: BoxFit.contain),
                    //     title: FittedBox(
                    //       child: Text('Unit Assembly-2', style: AppTextStyles.featureLabelStyle(context))),
                    //     featureColor: const Color(0xFFD2BCFF),
                    //     onTap: () => AppRoute.unitAssemble2.push(context),
                    //   ),
                    // )

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        children: [
                          Expanded(
                            child: AppFeatureWidget(
                              icon: AppIcons.assembly1.toWidget(
                                  height: 120, width: 140, fit: BoxFit.contain),
                              title: FittedBox(
                                child: Text('Unit Assembly-2',
                                    style: AppTextStyles.featureLabelStyle(
                                        context)),
                              ),
                              featureColor: const Color(0xFFD2BCFF),
                              onTap: () => AppRoute.unitAssemble2.push(context),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: AppFeatureWidget(
                              icon: AppIcons.dashboard.toWidget(
                                  height: 120, width: 100, fit: BoxFit.contain),
                              title: FittedBox(
                                child: Text('Dashboard',
                                    style: AppTextStyles.featureLabelStyle(
                                        context)),
                              ),
                              featureColor: const Color(0xFFFFA95F),
                              onTap: () => AppRoute.dashboards.push(context),
                            ),
                            //   child: AppFeatureWidget(
                            //     icon: AppIcons.credits.toWidget(
                            //         height: 120, width: 140, fit: BoxFit.contain),
                            //     title: Text('Credits',
                            //         style:
                            //             AppTextStyles.featureLabelStyle(context)),
                            //     featureColor: const Color(0xFF87A2FF),
                            //     onTap: () => AppRoute.credits.push(context),
                            //   ),
                          ),
                          
                        ],
                      ),
                    ),

                    // const SizedBox(
                    //   height: 10,
                    // ),
                   Padding(
                     padding: const EdgeInsets.only(right: 210,
                        left: 8,
                        bottom: 5,),
                     child: AppFeatureWidget(
                                  icon: AppIcons.credits.toWidget(
                                      height: 120, width: 140, fit: BoxFit.contain),
                                  title: Text('Credits',
                                      style:
                                          AppTextStyles.featureLabelStyle(context)),
                                  featureColor: const Color(0xFF87A2FF),
                                  onTap: () => launchCredits()
                                ),
                   ),
                      

                    // Padding(
                    //   padding: const EdgeInsets.only(
                    //     right: 210,
                    //     left: 8,
                    //     bottom: 5,
                    //   ),
                    //   child: AppFeatureWidget(
                    //     icon: AppIcons.dashboard.toWidget(
                    //         height: 120, width: 100, fit: BoxFit.contain),
                    //     title: FittedBox(
                    //       child: Text('Dashboard',
                    //           style: AppTextStyles.featureLabelStyle(context)),
                    //     ),
                    //     featureColor: const Color(0xFFFFA95F),
                    //     onTap: () => AppRoute.dashboards.push(context),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ImageSlider extends StatefulWidget {
  const ImageSlider({super.key});

  @override
  _ImageSliderState createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, dynamic>> _images = [
    {
      'path': 'assets/logo/vehicle_entry.png',
      'name': 'Gate Entry',
      'color': const Color(0xFFCDB3D8), // Green
    },
    {
      'path': 'assets/logo/vehicle_exit.png',
      'name': 'Gate Exit',
      'color': const Color(0xFFE9B6C7), // Orange
    },
    {
      'path': 'assets/logo/logo3.png',
      'name': 'PUF',
      'color': const Color(0xFF67D4CF), // Red
    },
    {
      'path': 'assets/logo/unit 1.png',
      'name': 'Unit Assembly-1',
      'color': const Color(0xFF67B7D4), // Purple
    },
    {
      'path': 'assets/logo/unit2.png',
      'name': 'Unit Assembly-2',
      'color': const Color(0xFFD2BCFF), // Yellow
    },
    {
      'path': 'assets/logo/credits.png',
      'name': 'Credits',
      'color': const Color(0xFF87A2FF), // Pink
    },
    {
      'path': 'assets/logo/dash.png',
      'name': 'DashBoard',
      'color': const Color(0xFFFFA95F),
    },
  ];

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  void _startAutoSlide() {
    Future.delayed(const Duration(seconds: 3), () {
      if (_pageController.hasClients) {
        setState(() {
          _currentPage = (_currentPage + 1) % _images.length;
        });
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
        _startAutoSlide();
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200, // Adjust height as needed
      child: PageView.builder(
        controller: _pageController,
        itemCount: _images.length,
        itemBuilder: (context, index) {
          final image = _images[index];
          return Padding(
            padding: const EdgeInsets.all(10.0), // Padding around each card
            child: Container(
              decoration: BoxDecoration(
                color: image['color'], // Apply background color
                borderRadius: BorderRadius.circular(20), // Rounded corners
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween, // Align left and right
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Image.asset(
                      image['path'],
                      width: 180, // Increased image size
                      height: 180,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          right: 16.0), // Push text to the right
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment:
                            CrossAxisAlignment.end, // Align text right
                        children: [
                          const Text(
                            "TGBC", // Static title
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            image['name'],
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
    
  }
   
}
