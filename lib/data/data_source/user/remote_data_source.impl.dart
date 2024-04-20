import 'dart:io';

import 'package:hot_place/core/constant/supbase.constant.dart';
import 'package:hot_place/core/error/custom_exception.dart';
import 'package:hot_place/core/error/failure.constant.dart';
import 'package:hot_place/data/data_source/user/remote_data_source.dart';
import 'package:hot_place/domain/model/user/user.model.dart';
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/util/image.util.dart';

class RemoteUserDataSourceImpl implements RemoteUserDataSource {
  final SupabaseClient _client;
  final Logger _logger;

  RemoteUserDataSourceImpl({required SupabaseClient client, required Logger logger})
      : _client = client,
        _logger = logger;

  @override
  Future<UserModel> findUserById(String uid) async {
    try {
      return await _client.rest
          .from(TableName.user.name)
          .select('*')
          .eq('id', uid)
          .limit(1)
          .then((fetched) => fetched.first)
          .then((json) => UserModel.fromJson(json));
    } catch (err) {
      _logger.e(err);
      throw CustomException(
          code: ErrorCode.postgresError,
          message: 'fail to find user with id: $uid');
    }
  }

  @override
  Future<void> modifyUser(UserModel user) async {
    try {
      await _client.rest
          .from(TableName.user.name)
          .update(user.toJson())
          .eq('id', user.id);
    } catch (err) {
      _logger.e(err);
      throw CustomException(
          code: ErrorCode.postgresError, message: 'modify user fails');
    }
  }

  @override
  Future<String> upsertProfileImageAndReturnDownloadLink(File image) async {
    try {
      final currentUid = _client.auth.currentUser!.id;
      final compressedImage = await ImageUtil.compressImage(image);
      final path = '$currentUid/profile-image.jpg';
      await _client.storage
          .from(BucketName.user.name)
          .upload(path, compressedImage,
              fileOptions: const FileOptions(
                cacheControl: '3600',
                upsert: true,
              ));
      return _client.storage.from(BucketName.user.name).getPublicUrl(path);
    } catch (err) {
      _logger.e(err);
      throw CustomException(
          code: ErrorCode.storageError,
          message: 'error occurs on uploading profile image');
    }
  }
}