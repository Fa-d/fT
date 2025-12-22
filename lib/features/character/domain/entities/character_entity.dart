import 'package:equatable/equatable.dart';

/// Character Entity from Rick and Morty API
/// Represents a character from the show with essential information
class CharacterEntity extends Equatable {
  final int id;
  final String name;
  final String status; // Alive, Dead, or unknown
  final String species;
  final String type;
  final String gender;
  final String image; // Avatar URL
  final String locationName;
  final String originName;

  const CharacterEntity({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.image,
    required this.locationName,
    required this.originName,
  });

  @override
  List<Object> get props => [
        id,
        name,
        status,
        species,
        type,
        gender,
        image,
        locationName,
        originName,
      ];
}
