import 'package:tgbc_app/core/core.dart';

import 'package:tgbc_app/features/Vehicle_reporting_entry/data/vrt_repo.dart';
import 'package:tgbc_app/features/Vehicle_reporting_entry/model/vrt_form.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'vrt_cubit.freezed.dart';

enum VrtView { create, edit, completed, rejected }

extension ActionType on VrtView {
  String toName() {
    return switch (this) {
      VrtView.create => 'Create',
      VrtView.edit => 'Submit',
      VrtView.completed => 'Submitted',
      VrtView.rejected => 'Rejected'
    };
  }
}

@injectable
class CreateVrtCubit extends AppBaseCubit<CreateVrtState> {
  CreateVrtCubit(this.repo) : super(CreateVrtState.initial());
  final VrtRepo repo;

  void onValueChanged({
    String? documentDate,
    int? docstatus,
    String? transporterDetails,
    String? driverName,
    String? driverNumber,
    String? tokeStatus,
    String? vehicleNo,
    String? vehicleType,
    String? rejectreason,
  }) {
    shouldAskForConfirmation.value = true;
    final form = state.form;

    final newForm = form.copyWith(
      documentDate: documentDate ?? form.documentDate,
      vehicleType: vehicleType ?? form.vehicleType,
      vehicleNo: vehicleNo ?? form.vehicleNo,
      driverName: driverName ?? form.driverName,
      driverNumber: driverNumber ?? form.driverNumber,
      docstatus: form.docstatus,
      tokeStatus: tokeStatus ?? form.tokeStatus,
      transporterDetails: transporterDetails ?? form.transporterDetails,
      rejectReason: rejectreason ?? form.rejectReason

    );
    emitSafeState(state.copyWith(form: newForm));
  }

  void initDetails(Object? entry) {
    shouldAskForConfirmation.value = false;
    if (entry is VrtForm) {
      final parsedDate =
          DFU.toDateTime(entry.documentDate.valueOrEmpty, 'yyyy-MM-dd');
      final formattedStr = DFU.friendlyFormat(parsedDate);

      final status = entry.docstatus;

      final isSubmitted = StringUtils.equalsIgnoreCase(
          StringUtils.docStatus(status!), 'Submitted');
      final isCancelled = StringUtils.equalsIgnoreCase(
          StringUtils.docStatus(status).trim(), 'Cancelled');
      final mode =
          (isSubmitted || isCancelled) ? VrtView.completed : VrtView.edit;
      emitSafeState(state.copyWith(
        form: entry.copyWith(documentDate: formattedStr),
        view: mode,
      ));
    }
    if (entry == null) return;
  }

  void save() async {
    final validation = _validate();
    return validation.fold(
      () async {
        emitSafeState(state.copyWith(isLoading: true, isSuccess: false));
        final nextMode = switch (state.view) {
          VrtView.create => VrtView.edit,
          VrtView.edit || VrtView.completed => VrtView.completed,
          VrtView.rejected => VrtView.rejected
        };

        if (state.view == VrtView.create) {
          final response = await repo.createVrt(state.form);

          return response.fold(
            (l) => emitSafeState(state.copyWith(isLoading: false, error: l)),
            (r) {
              shouldAskForConfirmation.value = false;
              final docNo = r;
              const message = 'Vehicle Reporting Entry Created Successfully';
              emitSafeState(state.copyWith(
                isLoading: false,
                isSuccess: true,
                form: state.form.copyWith(name: docNo, docstatus: 0),
                successMsg: message,
                view: nextMode,
              ));
            },
          );
        } else if(state.view == VrtView.completed) {
          final response = await repo.rejectvrt(state.form.name ?? '', state.form.rejectReason ?? '' );

          return response.fold(
            (l) => emitSafeState(state.copyWith(isLoading: false, error: l)),
            (r) {
              shouldAskForConfirmation.value = false;
              // final docNo = r;
              const message = 'Rejected Vehicle Reporting Entry.';
              emitSafeState(state.copyWith(
                isLoading: false,
                isSuccess: true,
                form: state.form.copyWith(),
                successMsg: message,
                view: VrtView.rejected,
              ));
            },
          );

        } else {
          final response = await repo.submitVrt(state.form);
          return response.fold(
            (l) => emitSafeState(state.copyWith(isLoading: false, error: l)),
            (r) {
              shouldAskForConfirmation.value = false;
              emitSafeState(state.copyWith(
                isLoading: false,
                isSuccess: true,
                form: state.form.copyWith(docstatus: 1),
                successMsg: 'Vehicle Reporting Entry Submitted Successfully',
                view: VrtView.completed,
              ));
            },
          );
        }
      },
      _emitError,
    );
  }

  void _emitError(String error) {
    final failure = Failure(error: error, title: 'Missing Fields');
    emitSafeState(state.copyWith(error: failure, isLoading: false));
  }

  void errorHandled() {
    emitSafeState(state.copyWith(
        error: null, isLoading: false, isSuccess: false, successMsg: null));
  }

  Option<String> _validate() {
    final form = state.form;

    if (form.transporterDetails.doesNotHaveValue) {
      return optionOf('Select Transporter Details');
    } else if (form.vehicleNo.isNull) {
      return optionOf('Select Vehicle No.');
    } else if (form.vehicleType.doesNotHaveValue) {
      return optionOf('Select Vehicle Type');
    } else if (form.driverName.isNull) {
      return optionOf('Enter Driver Name');
    } else if (form.driverNumber.doesNotHaveValue) {
      return optionOf('Enter Driver Number');
    }
    //  else if (form.remarks.doesNotHaveValue && form.transporterList == 'Other'){
    //   return optionOf('Enter Remarks');
    // }

    return const None();
  }
}

@freezed
class CreateVrtState with _$CreateVrtState {
  const factory CreateVrtState({
    required VrtForm form,
    required bool isLoading,
    required bool isSuccess,
    required VrtView view,
    String? successMsg,
    Failure? error,
  }) = _CreateVrtState;

  factory CreateVrtState.initial() {
    final creationDate = DFU.friendlyFormat(DFU.now());

    return CreateVrtState(
      form: VrtForm(
        documentDate: creationDate,
      ),
      view: VrtView.create,
      isLoading: false,
      isSuccess: false,
    );
  }
}
