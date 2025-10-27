import '../../domain/entities/counter_entity.dart';

/// Counter Model - Extends the entity with data layer functionality
/// Handles JSON serialization/deserialization
class CounterModel extends CounterEntity {
  const CounterModel({required super.value});

  /// Create a CounterModel from JSON
  factory CounterModel.fromJson(Map<String, dynamic> json) {
    return CounterModel(
      value: json['value'] as int,
    );
  }

  /// Convert CounterModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'value': value,
    };
  }

  /// Create a CounterModel from an entity
  factory CounterModel.fromEntity(CounterEntity entity) {
    return CounterModel(value: entity.value);
  }
}
