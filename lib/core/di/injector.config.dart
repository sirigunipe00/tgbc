// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:connectivity_plus/connectivity_plus.dart' as _i895;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:http/http.dart' as _i519;
import 'package:injectable/injectable.dart' as _i526;
import 'package:package_info_plus/package_info_plus.dart' as _i655;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../app/data/app_repository.dart' as _i691;
import '../../app/data/app_version.dart' as _i346;
import '../../app/presentation/app_update_blocprovider.dart' as _i266;
import '../../features/auth/data/auth_repo.dart' as _i585;
import '../../features/auth/data/auth_repo_impl.dart' as _i328;
import '../../features/auth/presentation/bloc/auth/auth_cubit.dart' as _i190;
import '../../features/auth/presentation/bloc/sign_in/sign_in_cubit.dart'
    as _i140;
import '../../features/Credits/data/credits_repo.dart' as _i888;
import '../../features/Credits/data/credits_repo_implementation.dart' as _i946;
import '../../features/Credits/presentation/bloc/bloc_provider.dart' as _i965;
import '../../features/dashboard/data/dashboard_repo.dart' as _i876;
import '../../features/dashboard/data/dashboard_repoimpl.dart' as _i959;
import '../../features/dashboard/presentation/bloc/blocprovider.dart' as _i955;
import '../../features/gate_entry/data/gate_entry_repo.dart' as _i820;
import '../../features/gate_entry/data/gate_entry_repo_impl.dart' as _i174;
import '../../features/gate_entry/presentation/bloc/bloc_provider.dart'
    as _i210;
import '../../features/gate_entry/presentation/bloc/new_gate_entry/new_gate_entry_cubit.dart'
    as _i586;
import '../../features/gate_exit/data/gate_exit_repo.dart' as _i495;
import '../../features/gate_exit/data/gate_exit_repo_impl.dart' as _i100;
import '../../features/gate_exit/presentation/bloc/bloc_provider.dart' as _i565;
import '../../features/gate_exit/presentation/bloc/create_gate_exit/create_gate_exit_cubit.dart'
    as _i161;
import '../../features/puf/data/puf_entry_repo.dart' as _i408;
import '../../features/puf/data/puf_entry_repo_implementation.dart' as _i416;
import '../../features/puf/presentation/bloc/bloc_provider.dart' as _i166;
import '../../features/unit_assemble-1/data/unit1_entry_repo.dart' as _i98;
import '../../features/unit_assemble-1/data/unit1_entry_repo_implementation.dart'
    as _i240;
import '../../features/unit_assemble-1/presentation/bloc/bloc_provider.dart'
    as _i798;
import '../../features/unit_assemble-2/data/unit2_entry_repo.dart' as _i317;
import '../../features/unit_assemble-2/data/unit2_entry_repo_implementation.dart'
    as _i324;
import '../../features/unit_assemble-2/presentation/bloc/bloc_provider.dart'
    as _i475;
import '../../features/Vehicle_reporting_entry/data/vrt_repo.dart' as _i207;
import '../../features/Vehicle_reporting_entry/data/vrt_repo_impl.dart'
    as _i1052;
import '../../features/Vehicle_reporting_entry/presentation/bloc/bloc_provider.dart'
    as _i542;
import '../../features/Vehicle_reporting_entry/presentation/bloc/vrt_cubit.dart'
    as _i289;
import '../core.dart' as _i351;
import '../local_storage/key_vale_storage.dart' as _i1012;
import '../network/api_client.dart' as _i557;
import '../network/internet_check.dart' as _i402;
import 'injector.dart' as _i811;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final thirdPartyDependencies = _$ThirdPartyDependencies();
    gh.factory<DateTime>(() => thirdPartyDependencies.defaultDateTime);
    gh.singleton<_i519.Client>(() => thirdPartyDependencies.httpClient);
    gh.singleton<_i895.Connectivity>(() => thirdPartyDependencies.connectivity);
    gh.singleton<_i558.FlutterSecureStorage>(
        () => thirdPartyDependencies.secureStorage);
    await gh.singletonAsync<_i655.PackageInfo>(
      () => thirdPartyDependencies.packageInfo,
      preResolve: true,
    );
    await gh.singletonAsync<_i460.SharedPreferences>(
      () => thirdPartyDependencies.sharedPreferences,
      preResolve: true,
    );
    gh.lazySingleton<_i402.InternetConnectionChecker>(
        () => _i402.InternetConnectionChecker(gh<_i895.Connectivity>()));
    gh.factory<_i1012.KeyValueStorage>(() => _i1012.KeyValueStorage(
          gh<_i558.FlutterSecureStorage>(),
          gh<_i460.SharedPreferences>(),
        ));
    gh.factory<_i557.ApiClient>(() => _i557.ApiClient(
          gh<_i519.Client>(),
          gh<_i402.InternetConnectionChecker>(),
        ));
    gh.lazySingleton<_i495.GateExitRepo>(
        () => _i100.GateExitRepoImpl(gh<_i351.ApiClient>()));
    gh.lazySingleton<_i888.CreditsRepo>(
        () => _i946.CreditsRepoImpl(gh<_i351.ApiClient>()));
    gh.lazySingleton<_i98.Unit1Repo>(
        () => _i240.Unit1RepoImpl(gh<_i351.ApiClient>()));
    gh.lazySingleton<_i317.Unit2Repo>(
        () => _i324.Unit2RepoImpl(gh<_i351.ApiClient>()));
    gh.lazySingleton<_i876.DashboardRepo>(
        () => _i959.DashboardRepoimpl(gh<_i351.ApiClient>()));
    gh.lazySingleton<_i346.AppVersion>(
        () => _i346.AppVersion(gh<_i655.PackageInfo>()));
    gh.lazySingleton<_i475.Unit2BlocProvider>(
        () => _i475.Unit2BlocProvider(gh<_i317.Unit2Repo>()));
    gh.lazySingleton<_i955.DashboardBlocProvider>(
        () => _i955.DashboardBlocProvider(gh<_i876.DashboardRepo>()));
    gh.factory<_i161.CreateGateExitCubit>(
        () => _i161.CreateGateExitCubit(gh<_i495.GateExitRepo>()));
    gh.lazySingleton<_i565.GateExitBlocProvider>(
        () => _i565.GateExitBlocProvider(gh<_i495.GateExitRepo>()));
    gh.lazySingleton<_i820.GateEntryRepo>(
        () => _i174.GateEntryRepoImpl(gh<_i351.ApiClient>()));
    gh.factory<_i586.NewGateEntryCubit>(
        () => _i586.NewGateEntryCubit(gh<_i820.GateEntryRepo>()));
    gh.lazySingleton<_i210.GateEntryBlocProvider>(
        () => _i210.GateEntryBlocProvider(gh<_i820.GateEntryRepo>()));
    gh.lazySingleton<_i585.AuthRepo>(() => _i328.AuthRepoImpl(
          gh<_i351.ApiClient>(),
          gh<_i351.KeyValueStorage>(),
        ));
    gh.lazySingleton<_i207.VrtRepo>(
        () => _i1052.VrtRepoImpl(gh<_i351.ApiClient>()));
    gh.lazySingleton<_i798.Unit1BlocProvider>(
        () => _i798.Unit1BlocProvider(gh<_i98.Unit1Repo>()));
    gh.lazySingleton<_i965.CreditsBlocProvider>(
        () => _i965.CreditsBlocProvider(gh<_i888.CreditsRepo>()));
    gh.lazySingleton<_i408.PufEntryRepo>(
        () => _i416.PufEntryRepoImpl(gh<_i351.ApiClient>()));
    gh.lazySingleton<_i691.AppRepository>(() => _i691.AppRepository(
          gh<_i351.ApiClient>(),
          gh<_i346.AppVersion>(),
        ));
    gh.lazySingleton<_i542.VRTBlocProvider>(
        () => _i542.VRTBlocProvider(gh<_i207.VrtRepo>()));
    gh.factory<_i289.CreateVrtCubit>(
        () => _i289.CreateVrtCubit(gh<_i207.VrtRepo>()));
    gh.lazySingleton<_i266.AppUpdateBlocprovider>(
        () => _i266.AppUpdateBlocprovider(gh<_i691.AppRepository>()));
    gh.factory<_i140.SignInCubit>(
        () => _i140.SignInCubit(gh<_i585.AuthRepo>()));
    gh.factory<_i190.AuthCubit>(() => _i190.AuthCubit(gh<_i585.AuthRepo>()));
    gh.lazySingleton<_i166.PufBlocProvider>(
        () => _i166.PufBlocProvider(gh<_i408.PufEntryRepo>()));
    return this;
  }
}

class _$ThirdPartyDependencies extends _i811.ThirdPartyDependencies {}
