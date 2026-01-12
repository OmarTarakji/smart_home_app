import 'dart:convert';

enum DashboardLayout { list, grid }

enum DashboardGroupBy { byRoom, byDevice, none }

class DashboardState {
  final DashboardLayout layout;
  final DashboardGroupBy groupBy;

  const DashboardState({required this.layout, required this.groupBy});

  DashboardState copyWith({
    DashboardLayout? layout,
    DashboardGroupBy? groupBy,
  }) {
    return DashboardState(
      layout: layout ?? this.layout,
      groupBy: groupBy ?? this.groupBy,
    );
  }

  String toJson() =>
      jsonEncode({'layout': layout.name, 'filter': groupBy.name});

  factory DashboardState.fromJson(Map<String, dynamic> json) {
    return DashboardState(
      layout: DashboardLayout.values.firstWhere(
        (e) => e.name == json['layout'],
        orElse: () => DashboardLayout.grid,
      ),
      groupBy: DashboardGroupBy.values.firstWhere(
        (e) => e.name == json['filter'],
        orElse: () => DashboardGroupBy.none,
      ),
    );
  }
}
