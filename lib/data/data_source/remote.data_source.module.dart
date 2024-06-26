import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hot_place/data/data_source/auth/remote_data_source.dart';
import 'package:hot_place/data/data_source/auth/remote_data_source.impl.dart';
import 'package:hot_place/data/data_source/chat/open_chat/message/remote_data_source.dart';
import 'package:hot_place/data/data_source/chat/open_chat/message/remote_data_source.impl.dart';
import 'package:hot_place/data/data_source/chat/open_chat/room/remote_data_source.dart';
import 'package:hot_place/data/data_source/chat/open_chat/room/remote_data_source.impl.dart';
import 'package:hot_place/data/data_source/chat/private_chat/message/remote_data_source.dart';
import 'package:hot_place/data/data_source/feed/base/remote_data_source.dart';
import 'package:hot_place/data/data_source/feed/like/remote_data_source.dart';
import 'package:hot_place/data/data_source/feed/base/remote_data_source.impl.dart';
import 'package:hot_place/data/data_source/geo/remote_data_source.impl.dart';
import 'package:hot_place/data/data_source/notification/remote_data_source.dart';
import 'package:hot_place/data/data_source/notification/remote_data_source.impl.dart';
import 'package:hot_place/data/data_source/user/remote_data_source.dart';
import 'package:hot_place/data/data_source/user/remote_data_source.impl.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'chat/private_chat/message/remote_data_source.impl.dart';
import 'chat/private_chat/room/remote.data_source.dart';
import 'chat/private_chat/room/remote_data_source.impl.dart';
import 'feed/comment/remote_data_source.dart';
import 'feed/comment/remote_data_source.impl.dart';
import 'feed/like/remote_data_source.impl.dart';
import 'geo/remote_data_source.dart';

@module
abstract class RemoteDataSource {
  final _client = Supabase.instance.client;
  final _logger = Logger();
  final _dio = Dio();
  final _geoLocator = Geolocator();

  @singleton
  RemoteAuthDataSource get auth =>
      RemoteAuthDataSourceImpl(client: _client, logger: _logger);

  @singleton
  RemoteUserDataSource get user =>
      RemoteUserDataSourceImpl(client: _client, logger: _logger);

  @singleton
  RemoteNotificationDataSource get notification =>
      RemoteNotificationDataSourceImpl(client: _client, logger: _logger);

  @lazySingleton
  RemoteFeedDataSource get feed =>
      RemoteFeedDataSourceImpl(client: _client, logger: _logger);

  @lazySingleton
  RemoteFeedCommentDataSource get feedComment =>
      RemoteFeedCommentDataSourceImpl(client: _client, logger: _logger);

  @lazySingleton
  RemoteGeoDataSource get geo => RemoteGeoDataSourceImpl(
      client: _client, logger: _logger, geoLocator: _geoLocator, dio: _dio);

  @lazySingleton
  RemoteLikeFeedDataSource get feedLike =>
      RemoteLikeFeedDataSourceImpl(client: _client, logger: _logger);

  @lazySingleton
  RemoteOpenChatDataSource get openChat =>
      RemoteOpenChatDataSourceImpl(client: _client, logger: _logger);

  @lazySingleton
  RemoteOpenChatMessageDataSource get openChatMessage =>
      RemoteOpenChatMessageDataSourceImpl(client: _client, logger: _logger);

  @lazySingleton
  RemotePrivateChatDataSource get privateChatMessage =>
      RemotePrivateChatDataSourceImpl(client: _client, logger: _logger);

  @lazySingleton
  RemotePrivateChatMessageDataSource get privateChat =>
      RemotePrivateChatMessageDataSourceImpl(client: _client, logger: _logger);
}
