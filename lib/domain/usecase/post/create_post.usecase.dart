import 'package:hot_place/domain/entity/post/post.entity.dart';
import 'package:hot_place/domain/entity/result/result.entity.dart';
import 'package:hot_place/domain/repository/post/post.repository.dart';
import 'package:injectable/injectable.dart';

@singleton
class CreatePostUseCase {
  final PostRepository _postRepository;

  CreatePostUseCase(this._postRepository);

  Future<ResultEntity<String>> call(
          {required String content,
          required List<String> hashtags,
          required List<String> images}) async =>
      await _postRepository
          .createPost(PostEntity(
              content: content,
              hashtags: hashtags,
              images: images,
              createdAt: DateTime.now()))
          .then((res) => ResultEntity<String>.fromResponse(res));
}
