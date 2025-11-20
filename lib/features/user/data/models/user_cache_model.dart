import 'package:isar/isar.dart';
import '../../domain/entities/user_entity.dart';
import 'user_model.dart';

part 'user_cache_model.g.dart';

/// Isar cache model for User
///
/// This model is separate from UserModel to keep clean separation between
/// API models and database models. It includes additional metadata for
/// cache management.
@Collection()
class UserCacheModel {
  /// Isar auto-increment ID (different from user ID)
  Id id = Isar.autoIncrement;

  /// User ID from the API
  @Index(unique: true)
  late int userId;

  /// User name
  late String name;

  /// User email
  late String email;

  /// User phone
  late String phone;

  /// Timestamp when this data was cached
  late DateTime cachedAt;

  /// Default constructor (required by Isar)
  UserCacheModel();

  /// Convert to domain entity
  UserEntity toEntity() {
    return UserEntity(
      id: userId,
      name: name,
      email: email,
      phone: phone,
    );
  }

  /// Create from UserModel (API response)
  factory UserCacheModel.fromUserModel(UserModel model) {
    return UserCacheModel()
      ..userId = model.id
      ..name = model.name
      ..email = model.email
      ..phone = model.phone
      ..cachedAt = DateTime.now();
  }

  /// Create from UserEntity
  factory UserCacheModel.fromEntity(UserEntity entity) {
    return UserCacheModel()
      ..userId = entity.id
      ..name = entity.name
      ..email = entity.email
      ..phone = entity.phone
      ..cachedAt = DateTime.now();
  }
}
