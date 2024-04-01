import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hot_place/domain/model/user/user.model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'user.entity.freezed.dart';

part 'user.entity.g.dart';

@freezed
class UserEntity with _$UserEntity {
  const factory UserEntity({
    String? id,
    String? email,
    String? nickname,
    String? profileImage,
  }) = _UserEntity;

  factory UserEntity.fromJson(Map<String, dynamic> json) =>
      _$UserEntityFromJson(json);

  factory UserEntity.fromModel(UserModel user) => UserEntity(
      id: user.id.isNotEmpty ? user.id : null,
      email: user.email.isNotEmpty ? user.email : null,
      nickname: user.nickname.isNotEmpty ? user.nickname : null,
      profileImage: user.profileImage.isNotEmpty ? user.profileImage : null);

  factory UserEntity.fromSession(User sessionUser) =>
      UserEntity.fromModel(UserModel.fromSession(sessionUser));
}
