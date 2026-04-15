import 'package:tgbc_app/core/model/page_list_filters.dart';
import 'package:tgbc_app/core/model/pair.dart';
import 'package:tgbc_app/core/utils/typedefs.dart';
import 'package:tgbc_app/features/gate_entry/model/gate_entry.dart';
import 'package:tgbc_app/features/gate_entry/model/new_gate_entry_form.dart';
import 'package:tgbc_app/features/gate_entry/model/purchase_order.dart';

abstract interface class GateEntryRepo {
  AsyncValueOf<List<GateEntry>> fetchEntries(
      int start, int end, PageListFilters filters);
  AsyncValueOf<GateEntry> getEntry(String name);

  AsyncValueOf<List<PurchaseOrder>> fetchPONumbers();
  AsyncValueOf<Pair<String, String>> createGateEntry(NewGateEntryForm form);
  AsyncValueOf<Pair<String, String>> submitGateEntry(NewGateEntryForm form);
  AsyncValueOf<List<PurchaseOrder>> fetchSupplierName(String name);
}
