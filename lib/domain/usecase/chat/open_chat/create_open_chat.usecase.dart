import 'package:fpdart/fpdart.dart';
import 'package:hot_place/core/util/uuid.util.dart';
import 'package:hot_place/data/entity/chat/open_chat/open_chat.entity.dart';
import 'package:hot_place/data/entity/user/user.entity.dart';
import 'package:hot_place/domain/repository/chat/chat.repository.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failure.constant.dart';

@lazySingleton
class CreateOpenChatUseCase {
  final ChatRepository _repository;

  CreateOpenChatUseCase(this._repository);

  Future<Either<Failure, OpenChatEntity>> call({
    required String title,
    required List<String> hashtags,
    required UserEntity currentUser,
  }) async {
    final id = UuidUtil.uuid();
    return await _repository.createOpenChat(OpenChatEntity(
        id: id,
        host: currentUser,
        title: title,
        hashtags: hashtags,
        createdAt: DateTime.now()));
  }
}
