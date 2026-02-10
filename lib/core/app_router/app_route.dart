import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

abstract class _AppRoutePaths {
  static const initial = '/';
  static const login = '/login';
  static const home = '/home';
  static const gateEntry = '/home/gateentry';
  static const newGateEntry = '/home/gateentry/newGateEntry';
  static const newGateEntryPreview = '/home/gateentry/newGateEntry/preview';
  static const gateExit = '/home/gateexit';
  static const newGateExit = '/home/gateexit/newGateExit';
  static const newGateExitPreview = '/home/gateexit/newGateExit/preview';
  static const puf = '/home/puf';
  static const unitAssembly1 = '/home/unitassembly-1';
  static const unitAssembly2 = '/home/unitassembly-2';
  static const credits = '/home/credits';
  static const dashboard = '/home/dashboard';
  static const creditsComp = '/home/credits/componants';
  static const vrt = '/home/vrt';
  static const newVrt = '/home/vrt/newvrt';

  static const account = '/account';
}

enum AppRoute {
  initial(_AppRoutePaths.initial),
  login(_AppRoutePaths.login),
  home(_AppRoutePaths.home),
  gateEntry(_AppRoutePaths.gateEntry),
  newGateEntry(_AppRoutePaths.newGateEntry),
  newGateEntryPreview(_AppRoutePaths.newGateEntryPreview),
  gateExit(_AppRoutePaths.gateExit),
  newGateExit(_AppRoutePaths.newGateExit),
  newGateExitPreview(_AppRoutePaths.newGateExitPreview),
  puf(_AppRoutePaths.puf),

  unitAssemble(_AppRoutePaths.unitAssembly1),

  unitAssemble2(_AppRoutePaths.unitAssembly2),

  credits(_AppRoutePaths.credits),


  dashboards(_AppRoutePaths.dashboard),


  creditComp(_AppRoutePaths.creditsComp),
  vrt(_AppRoutePaths.vrt),
  newVrt(_AppRoutePaths.newVrt),


  account(_AppRoutePaths.account);

  const AppRoute(this.path);
  final String path;
}

extension AppRouteNavigation on AppRoute {
  void go(BuildContext context, {Object? extra}) {
    context.go(path, extra: extra);
  }

  void goNamed(BuildContext context, {Object? extra}) {
    context.goNamed(path, extra: extra);
  }

  Future<T?> push<T>(BuildContext context, {Object? extra}) async {
    return await context.push(path, extra: extra);
  }
}
