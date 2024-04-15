import 'package:hot_place/domain/model/chat/open_chat/open_chat.model.dart';

abstract interface class LocalOpenChatDataSource {}

abstract interface class RemoteOpenChatDataSource {
  Stream<List<OpenChatModel>> get openChatStream;

  Future<OpenChatModel> createOpenChat(OpenChatModel chat);

  Future<String> modifyOpenChat(OpenChatModel chat);

  Future<void> deleteOpenChatById(String openChatId);
}
