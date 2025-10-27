import 'package:freezed_annotation/freezed_annotation.dart';

part 'dashboard_event.freezed.dart';

@freezed
class DashboardEvent with _$DashboardEvent {
  const factory DashboardEvent.started() = _Started;
  const factory DashboardEvent.refreshRequested() = _RefreshRequested;
  const factory DashboardEvent.syncRequested() = _SyncRequested;
}
