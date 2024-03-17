import 'package:hot_place/core/constant/response.constant.dart';
import 'package:hot_place/data/data_source/chat/chat.data_source.dart';
import 'package:hot_place/data/data_source/user/credential.data_source.dart';
import 'package:hot_place/data/data_source/user/user.data_source.dart';
import 'package:hot_place/data/model/chat/message.model.dart';
import 'package:hot_place/data/model/response/response.model.dart';
import 'package:hot_place/domain/entity/chat/chat.entity.dart';
import 'package:hot_place/domain/entity/chat/message.entity.dart';
import 'package:hot_place/domain/entity/user/user.entity.dart';
import 'package:hot_place/domain/repository/chat/chat.repository.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

import '../../model/chat/chat.model.dart';

@Singleton(as: ChatRepository)
class ChatRepositoryImpl extends ChatRepository {
  final UserDataSource _userDataSource;
  final CredentialDataSource _credentialDataSource;
  final ChatDataSource _chatDataSource;

  final _logger = Logger();

  ChatRepositoryImpl({
    required UserDataSource userDataSource,
    required CredentialDataSource credentialDataSource,
    required ChatDataSource chatDataSource,
  })  : _userDataSource = userDataSource,
        _credentialDataSource = credentialDataSource,
        _chatDataSource = chatDataSource;

  /// stream 가져오기
  @override
  Future<ResponseModel<Stream<List<ChatEntity>>>> getChatStream() async {
    try {
      final stream = _chatDataSource.getChatStream().asyncMap(
          (List<ChatModel> chatModels) async => await Future.wait(chatModels
              .map((chat) async => ChatEntity.fromModel(
                  model: chat,
                  opponent: UserEntity.fromModel(
                      await _userDataSource.findUserById(chat.opponentUid))))
              .toList()) as List<ChatEntity>);
      return ResponseModel<Stream<List<ChatEntity>>>.success(
          responseType: ResponseType.ok, data: stream);
    } catch (err) {
      _logger.e(err);
      return ResponseModel<Stream<List<ChatEntity>>>.error();
    }
  }

  @override
  Future<ResponseModel<Stream<List<MessageEntity>>>> getMessageStream(
      String chatId) async {
    try {
      final chatEntity = (await findChatById(chatId)).data;
      final currentUser = UserEntity.fromModel(await _userDataSource
          .findUserById(_credentialDataSource.currentUid!));
      final opponent = UserEntity.fromModel(
          await _userDataSource.findUserById(chatEntity!.opponent!.uid!));
      final stream = _chatDataSource.getMessageStream(chatId).asyncMap(
          (List<MessageModel> messageModels) => messageModels
              .map((model) => MessageEntity.fromModel(
                  model: model,
                  sender: model.senderUid == currentUser.uid
                      ? currentUser
                      : opponent,
                  receiver: model.senderUid == currentUser.uid
                      ? opponent
                      : currentUser))
              .toList());
      return ResponseModel<Stream<List<MessageEntity>>>.success(data: stream);
    } catch (err) {
      _logger.e(err);
      return ResponseModel<Stream<List<MessageEntity>>>.error();
    }
  }

  /// id로 단건 조회
  @override
  Future<ResponseModel<ChatEntity>> findChatById(String chatId) async {
    try {
      final chatModel = await _chatDataSource.findChatById(chatId);
      final chat = ChatEntity(
          id: chatModel.id,
          lastMessage: chatModel.lastMessage,
          unReadCount: chatModel.unReadCount,
          opponent: UserEntity.fromModel(
              await _userDataSource.findUserById(chatModel.opponentUid)));
      return ResponseModel.success(data: chat);
    } catch (err) {
      _logger.e(err);
      return ResponseModel<ChatEntity>.error();
    }
  }

  @override
  Future<ResponseModel<MessageEntity>> findMessageById(
      {required String chatId, required String messageId}) async {
    try {
      final model = await _chatDataSource.findMessageById(
          chatId: chatId, messageId: messageId);
      final sender = UserEntity.fromModel(
          await _userDataSource.findUserById(model.senderUid));
      final receiver = UserEntity.fromModel(
          await _userDataSource.findUserById(model.receiverUid));
      final message = MessageEntity.fromModel(
          model: model, sender: sender, receiver: receiver);
      return ResponseModel.success(data: message);
    } catch (err) {
      _logger.e(err);
      return ResponseModel<MessageEntity>.error();
    }
  }

  /// Create
  @override
  Future<ResponseModel<void>> sendMessage(MessageEntity message) async {
    try {
      final chatId = message.chatId ??
          // 채팅방 id가 주어지지 않은 경우, 채팅방을 새로 개설 후 id 가져오기
          await _chatDataSource.createChat(ChatEntity(
                  lastMessage: "채팅방이 개설되었습니다",
                  opponent: UserEntity(uid: message.receiver?.uid))
              .toModel());
      await _chatDataSource
          .createMessage(message.copyWith(chatId: chatId).toModel());
      return ResponseModel<void>.success(data: null);
    } catch (err) {
      _logger.e(err);
      return ResponseModel<void>.error();
    }
  }

  /// Read
  /// Update

  // TODO : 채팅메시지 읽은 경우 처리
  @override
  Future<ResponseModel<void>> seenMessageUpdate(MessageEntity message) async {
    throw UnimplementedError();
  }

  /// Delete
  @override
  Future<ResponseModel<void>> deleteChat(ChatEntity chat) async {
    try {
      await _chatDataSource.deleteChatById(chat.id!);
      return ResponseModel<void>.success(data: null);
    } catch (err) {
      _logger.e(err);
      return ResponseModel<void>.error();
    }
  }

  @override
  Future<ResponseModel<void>> deleteMessage(MessageEntity message) async {
    try {
      final currentUid = _credentialDataSource.currentUid;
      if (message.sender?.uid != currentUid) {
        return ResponseModel<void>.error(
            responseType: ResponseType.unAuthorized);
      }
      await _chatDataSource.deleteMessage(message.toModel());
      return ResponseModel<void>.success(data: null);
    } catch (err) {
      _logger.e(err);
      return ResponseModel<void>.error();
    }
  }
}
