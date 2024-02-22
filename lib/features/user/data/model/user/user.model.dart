import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hot_place/features/user/domain/entity/user/user.entity.dart';

import '../../../../app/constant/user.constant.dart';

part 'user.model.freezed.dart';

part 'user.model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    @Default('') String uid,
    @Default('') String email,
    @Default('') String username,
    @Default('') String phoneNumber,
    @Default('') String profileImageUrl,
    @Default(UserStatus.offline) UserStatus status,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}

extension UserModelEx on UserModel {
  UserEntity toEntity() => UserEntity(
      uid: uid,
      email: email,
      username: username,
      phoneNumber: phoneNumber,
      status: status);
}
