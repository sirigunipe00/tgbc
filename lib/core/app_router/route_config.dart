import 'package:tgbc_app/app/presentation/app_home_page.dart';
import 'package:tgbc_app/app/presentation/app_profile_page.dart';
import 'package:tgbc_app/app/presentation/app_splash_scrn.dart';
import 'package:tgbc_app/app/presentation/app_update_blocprovider.dart';
import 'package:tgbc_app/app/widgets/app_scaffold_widget.dart';
import 'package:tgbc_app/app/widgets/image_preview_scrn.dart';
import 'package:tgbc_app/core/core.dart';
import 'package:tgbc_app/features/Credits/presentation/bloc/bloc_provider.dart';
import 'package:tgbc_app/features/Credits/presentation/ui/widgets/credits_screen.dart';
import 'package:tgbc_app/features/Credits/presentation/ui/widgets/credits_widget.dart';
import 'package:tgbc_app/features/Vehicle_reporting_entry/model/vrt_form.dart';
import 'package:tgbc_app/features/Vehicle_reporting_entry/presentation/bloc/bloc_provider.dart';
import 'package:tgbc_app/features/Vehicle_reporting_entry/presentation/bloc/vrt_cubit.dart';
import 'package:tgbc_app/features/Vehicle_reporting_entry/presentation/ui/new_vrt_widget.dart';
import 'package:tgbc_app/features/Vehicle_reporting_entry/presentation/ui/widgets/vrt_list_screen.dart';
import 'package:tgbc_app/features/auth/presentation/authentication_scrn.dart';
import 'package:tgbc_app/features/dashboard/presentation/bloc/blocprovider.dart';
import 'package:tgbc_app/features/dashboard/presentation/screen/dashboard_screen.dart';
import 'package:tgbc_app/features/gate_entry/presentation/bloc/bloc_provider.dart';
import 'package:tgbc_app/features/gate_entry/presentation/bloc/new_gate_entry/new_gate_entry_cubit.dart';
import 'package:tgbc_app/features/gate_entry/presentation/ui/create/new_gate_entry.dart';
import 'package:tgbc_app/features/gate_entry/presentation/ui/gate_entry_list/gate_entry_list.dart';
import 'package:tgbc_app/features/gate_exit/presentation/bloc/bloc_provider.dart';
import 'package:tgbc_app/features/gate_exit/presentation/bloc/create_gate_exit/create_gate_exit_cubit.dart';
import 'package:tgbc_app/features/gate_exit/presentation/ui/create/new_gate_exit.dart';
import 'package:tgbc_app/features/gate_exit/presentation/ui/gate_exit_list/gate_exit_list.dart';
import 'package:tgbc_app/features/puf/presentation/bloc/bloc_provider.dart';
import 'package:tgbc_app/features/puf/presentation/ui/widgets/puf%20_widget.dart';
import 'package:tgbc_app/features/unit_assemble-1/presentation/bloc/bloc_provider.dart';
import 'package:tgbc_app/features/unit_assemble-1/presentation/ui/widgets/unit_assembly-1_widget.dart';
import 'package:tgbc_app/features/unit_assemble-2/presentation/bloc/bloc_provider.dart';
import 'package:tgbc_app/features/unit_assemble-2/presentation/ui/widgets/unit_assembly-2_widget.dart';
import 'package:tgbc_app/widgets/dialogs/app_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:go_router/go_router.dart';

class AppRouterConfig {
  static final parentNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: parentNavigatorKey,
    initialLocation: AppRoute.initial.path,
    routes: <RouteBase>[
      GoRoute(
        path: AppRoute.initial.path,
        builder: (_, state) => const AppSplashScreen(),
      ),
      GoRoute(
        path: AppRoute.login.path,
        builder: (_, state) => const AuthenticationScrn(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return AppScaffoldWidget(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoute.home.path,
                builder: (_, state) => BlocProvider(
                  create: (_) =>
                      AppUpdateBlocprovider.get().appversionCubit()..request(),
                  child: const AppHomePage(),
                ),
                routes: [
                  GoRoute(
                    path: _getPath(AppRoute.gateEntry),
                    builder: (ctxt, state) => const GateEntryListScrn(),
                    routes: [
                      GoRoute(
                        path: _getPath(AppRoute.newGateEntry),
                        builder: (ctxt, state) {
                          final provider = GateEntryBlocProvider.get();
                          final name = state.extra as String?;
                          return MultiBlocProvider(
                            providers: [
                              if (name.isNull) ...[
                                BlocProvider(
                                    create: (_) => provider.getDetails()),
                              ] else ...[
                                BlocProvider(
                                    create: (_) =>
                                        provider.getDetails()..request(name!)),
                              ],
                              BlocProvider(
                                  create: (_) =>
                                      provider.fetchPONumbers()..request()),
                              BlocProvider(
                                  create: (_) => $sl.get<NewGateEntryCubit>()),
                            ],
                            child: const NewGateEntry(),
                          );
                        },
                        routes: [
                          GoRoute(
                            path: _getPath(AppRoute.newGateEntryPreview),
                            builder: (_, state) {
                              final data = state.extra as Pair<String, String?>;
                              return ImagePreviewScrn.fromPair(data);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  GoRoute(
                    path: _getPath(AppRoute.gateExit),
                    builder: (ctxt, state) => const GateExitListScrn(),
                    routes: [
                      GoRoute(
                        path: _getPath(AppRoute.newGateExit),
                        builder: (_, state) {
                          final provider = GateExitBlocProvider.get();
                          final name = state.extra as String?;
                          return MultiBlocProvider(
                            providers: [
                              if (name.isNull) ...[
                                BlocProvider(
                                    create: (_) => provider.getDetails()),
                              ] else ...[
                                BlocProvider(
                                    create: (_) =>
                                        provider.getDetails()..request(name!)),
                              ],
                              BlocProvider(
                                  create: (_) => provider.getVehicleNumber()),
                              BlocProvider(
                                  create: (_) =>
                                      $sl.get<CreateGateExitCubit>()),
                            ],
                            child: const NewGateExit(),
                          );
                        },
                        routes: [
                          GoRoute(
                            path: _getPath(AppRoute.newGateExitPreview),
                            builder: (_, state) {
                              final data = state.extra as Pair<String, String?>;
                              return ImagePreviewScrn.fromPair(data);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  GoRoute(
                    path: _getPath(AppRoute.puf),
                    builder: (context, state) => MultiBlocProvider(
                      providers: [
                        BlocProvider(
                          create: (context) =>
                              PufBlocProvider.get().pufcreation(),
                        ),
                        BlocProvider(
                          create: (context) =>
                              PufBlocProvider.get().fetchPufList()
                                ..fetchInitial(''),
                        ),
                        BlocProvider(
                            create: (_) =>
                                PufBlocProvider.get().fetchItemLines()),

                        BlocProvider(
                          create: (context) =>
                           DashboardBlocProvider.get().
                           pufToday()..request(),
                           )
                      ],
                      child: const PufWidget(),
                    ),
                  ),
                  GoRoute(
                    path: _getPath(AppRoute.unitAssemble),
                    builder: (context, state) => MultiBlocProvider(
                      providers: [
                        BlocProvider(
                          create: (context) =>
                              Unit1BlocProvider.get().unit1creation(),
                        ),
                        BlocProvider(
                          create: (context) =>
                              Unit1BlocProvider.get().fetchUnit1List()
                                ..fetchInitial(''),
                        ),
                        BlocProvider(
                            create: (_) =>
                                Unit1BlocProvider.get().fetchUnit1ItemLines()),
                        BlocProvider(
                          create: (context) =>
                              Unit1BlocProvider.get().unitToday()
                                ..request(),
                        ),
                      ],
                      child: const Unit1Widget(),
                    ),
                  ),
                  GoRoute(
                    path: _getPath(AppRoute.unitAssemble2),
                    builder: (context, state) => MultiBlocProvider(
                      providers: [
                        BlocProvider(
                          create: (context) =>
                              Unit2BlocProvider.get().unit2creation(),
                        ),
                        BlocProvider(
                          create: (context) =>
                              Unit2BlocProvider.get().fetchUnit2List()
                                ..fetchInitial(''),
                        ),
                        BlocProvider(
                            create: (_) =>
                                Unit2BlocProvider.get().fetchUnit2ItemLines()),
                          BlocProvider(
                          create: (context) =>
                              Unit2BlocProvider.get().unit2Today()
                                ..request(),
                        ),
                      ],
                      child: const Unit2Widget(),
                    ),
                  ),
                  GoRoute(
                      path: _getPath(AppRoute.credits),
                      builder: (context, state) => MultiBlocProvider(
                            providers: [
                              BlocProvider(
                                create: (context) =>
                                    CreditsBlocProvider.get().creditscreation(),
                              ),
                              BlocProvider(
                                create: (context) => CreditsBlocProvider.get()
                                    .creditsSubmission(),
                              ),
                              BlocProvider(
                                create: (context) =>
                                    CreditsBlocProvider.get().fetchcreditsList()
                                      ..fetchInitial(''),
                              ),
                              BlocProvider(
                                  create: (_) => CreditsBlocProvider.get()
                                      .fetchCreditsItemLines()),
                              BlocProvider(create: (_) =>
                                  DashboardBlocProvider.get().creditToday()
                                  ..request(),
                              ),
                            ],
                            child: const CreditsWidget(),
                          ),
                      routes: [
                        GoRoute(
                          path: _getPath(AppRoute.creditComp),
                          onExit: (context, state) async =>
                              await _promptConf(context),
                          builder: (context, state) {
                            final data = state.extra as Pair;
                            return MultiBlocProvider(
                                providers: [
                                  BlocProvider(
                                    create: (context) =>
                                        CreditsBlocProvider.get()
                                            .fetchcreditsList(),
                                  ),
                                  BlocProvider(
                                    create: (context) =>
                                        CreditsBlocProvider.get()
                                            .fetchCreditsItemLines()
                                          ..request(data.first),
                                  ),
                                  BlocProvider(
                                    create: (context) =>
                                        CreditsBlocProvider.get()
                                            .creditsValidation(),
                                  ),
                                  BlocProvider(
                                    create: (context) =>
                                        CreditsBlocProvider.get()
                                            .creditsSubmission(),
                                  ),
                                ],
                                child: CreditsScreen(
                                    item: data.first, docst: data.second));
                          },
                        )
                      ]),
                  GoRoute(
                      path: _getPath(AppRoute.dashboards),
                      builder: (context, state) => const DashboardScreen()
                      // MultiBlocProvider(
                      //   providers: [
                      //     BlocProvider(
                      //       create: (context) =>
                      //           DashboardBlocProvider.get().creditMonth()
                      //            ,
                      //     ),
                      //     BlocProvider(
                      //       create: (context) =>
                      //           DashboardBlocProvider.get().creditYear()
                      //            ,
                      //     ),
                      //     BlocProvider(
                      //       create: (context) =>
                      //           DashboardBlocProvider.get().creditToday()
                      //           ,
                      //     ),
                      //   ],
                      //   child:
                      // const DashboardScreen()
                      // ),
                  ),
                  GoRoute(
                      path: _getPath(AppRoute.vrt),
                      builder: (context, state) => const VrtListScreen(),
                      routes: [
                        GoRoute(
                          path: _getPath(AppRoute.newVrt),
                          builder: (context, state) {
                            final form = state.extra as VrtForm?;
                            return MultiBlocProvider(
                              providers: [
                                BlocProvider(
                                  create: (context) =>
                                      VRTBlocProvider.get().supplierNameList()
                                        ..request(),
                                ),
                                BlocProvider(
                                  create: (context) =>
                                      VRTBlocProvider.get().vehicleTypeList()
                                        ..request(),
                                ),
                                BlocProvider(
                                  create: (context) => $sl.get<CreateVrtCubit>()
                                    ..initDetails(form),
                                ),
                              ],
                              child: const NewVRTWidget(),
                            );
                          },
                        )
                      ])
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoute.account.path,
                builder: (_, __) => const AppProfilePage(),
              ),
            ],
          ),
        ],
      ),
    ],
  );

  static Future<bool> _promptConf(BuildContext context) async {
  
    final promptConf = shouldAskForConfirmation.value;
    if (!promptConf) return true;
    return await AppDialog.askForConfirmation<bool?>(
          context,
          title: '',
          confirmBtnText: 'Okay',
          content: Messages.clearConfirmation,
          onTapConfirm: () => context.exit(false),
          onTapDismiss: () => context.exit(false),
        ) ??
        false;
  }

  static String _getPath(AppRoute route) => route.path.split('/').last;
}
