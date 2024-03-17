import 'package:hot_place/data/model/response/response.model.dart';
import 'package:hot_place/domain/entity/user/user.entity.dart';
import 'package:hot_place/domain/repository/user/user.repository.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

import '../../data_source/user/user.data_source.dart';

@Singleton(as: UserRepository)
class UserRepositoryImpl extends UserRepository {
  final UserDataSource _userDataSource;
  final _logger = Logger();

  UserRepositoryImpl(this._userDataSource);

  @override
  Future<ResponseModel<void>> insertUser(UserEntity user) async {
    try {
      await _userDataSource.insertUser(user.toModel());
      return ResponseModel<void>.success(data: null);
    } catch (err) {
      _logger.e(err);
      return ResponseModel<void>.error();
    }
  }

  @override
  Future<ResponseModel<void>> updateUser(UserEntity user) async {
    try {
      await _userDataSource.updateUser(user.toModel());
      return ResponseModel<void>.success(data: null);
    } catch (err) {
      _logger.e(err);
      return ResponseModel<void>.error();
    }
  }

  @override
  ResponseModel<Stream<List<UserEntity>>> getAllUserStream() {
    try {
      final stream = _userDataSource.allUserStream;
      return ResponseModel.success(data: stream);
    } catch (err) {
      _logger.e(err);
      return ResponseModel<Stream<List<UserEntity>>>.error();
    }
  }

  @override
  ResponseModel<Stream<UserEntity>> getUserStream(String uid) {
    try {
      final stream = _userDataSource.getUserStream(uid);
      return ResponseModel.success(data: stream);
    } catch (err) {
      _logger.e(err);
      return ResponseModel<Stream<UserEntity>>.error();
    }
  }
}
