import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'user.model.freezed.dart';

part 'user.model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel(
      {@Default('') String id,
      @Default('') String email,
      @Default('') String nickname,
      @Default('') String profileImage}) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  factory UserModel.fromSession(User sessionUser) => UserModel(
        id: sessionUser.id,
        email: sessionUser.email ?? '',
        nickname: (sessionUser.userMetadata ?? {})['nickname'] ?? '',
        profileImage: (sessionUser.userMetadata ?? {})['profileImage'] ?? '',
      );
}
