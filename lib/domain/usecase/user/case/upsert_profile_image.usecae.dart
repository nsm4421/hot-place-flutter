import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:hot_place/domain/repository/user/user.repository.dart';

import '../../../../core/error/failure.constant.dart';

class UpsertProfileImageUseCase {
  final UserRepository _repository;

  UpsertProfileImageUseCase(this._repository);

  Future<Either<Failure, String>> call(File image) async =>
      await _repository.upsertProfileImageAndReturnDownloadLink(image);
}
