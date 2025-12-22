import '../../domain/entities/character_entity.dart';

/// Character Model - Extends entity and adds JSON serialization
class CharacterModel extends CharacterEntity {
  const CharacterModel({
    required super.id,
    required super.name,
    required super.status,
    required super.species,
    required super.type,
    required super.gender,
    required super.image,
    required super.locationName,
    required super.originName,
  });

  /// Create model from JSON
  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
      id: json['id'] as int,
      name: json['name'] as String,
      status: json['status'] as String,
      species: json['species'] as String,
      type: json['type'] as String? ?? '',
      gender: json['gender'] as String,
      image: json['image'] as String,
      locationName: (json['location'] as Map<String, dynamic>)['name'] as String,
      originName: (json['origin'] as Map<String, dynamic>)['name'] as String,
    );
  }

  /// Convert model to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'status': status,
      'species': species,
      'type': type,
      'gender': gender,
      'image': image,
      'location': {'name': locationName},
      'origin': {'name': originName},
    };
  }
}
