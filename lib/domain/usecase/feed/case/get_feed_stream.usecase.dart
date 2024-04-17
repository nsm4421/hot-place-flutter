import '../../../../data/entity/feed/feed.entity.dart';
import '../../../repository/feed/feed.repository.dart';

class GetFeedStreamUseCase {
  final FeedRepository _repository;

  GetFeedStreamUseCase(this._repository);

  Stream<List<FeedEntity>> call() => _repository.feedStream;
}