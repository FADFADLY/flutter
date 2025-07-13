import 'package:hive_flutter/hive_flutter.dart';
import '../../features/chatbot/data/model/chat_item_model.dart';
import '../../features/chatbot/data/model/chat_list_response_model.dart';
import '../../features/chatbot/data/model/chat_data_model.dart';
import '../../features/chatbot/data/model/chat_response_model.dart';
import '../../features/chatbot/data/model/chat_message_model.dart';
import '../../features/chatbot/data/model/chat_messages_api_response_model.dart';

Future<void> initHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ChatItemModelAdapter()); // typeId: 0
  Hive.registerAdapter(ChatListResponseModelAdapter()); // typeId: 1
  Hive.registerAdapter(ChatDataModelAdapter()); // typeId: 2
  Hive.registerAdapter(ChatResponseModelAdapter()); // typeId: 3
  Hive.registerAdapter(ChatMessageModelAdapter()); // typeId: 4
  Hive.registerAdapter(ChatMessagesApiResponseModelAdapter()); // typeId: 5
}