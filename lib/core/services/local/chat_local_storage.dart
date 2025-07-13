import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import '../../../features/chatbot/data/model/chat_data_model.dart';
import '../../../features/chatbot/data/model/chat_item_model.dart';
import '../../../features/chatbot/data/model/chat_list_response_model.dart';
import '../../../features/chatbot/data/model/chat_message_model.dart';
import '../../../features/chatbot/data/model/chat_messages_api_response_model.dart';
import '../../../features/chatbot/domain/entity/chat_item_entity.dart';

class ChatLocalStorage {
  final Map<int, Box<ChatMessagesApiResponseModel>> _boxes = {};

  Future<Box<ChatMessagesApiResponseModel>> _openBox(int chatId) async {
    if (_boxes.containsKey(chatId)) {
      return _boxes[chatId]!;
    }
    final box = await Hive.openBox<ChatMessagesApiResponseModel>('chatResponse_$chatId');
    _boxes[chatId] = box;
    debugPrint('فتحت box للشات $chatId');
    return box;
  }

  Future<void> saveResponse(int chatId, ChatMessagesApiResponseModel response) async {
    try {
      final box = await _openBox(chatId);
      await box.put('response', response);
      debugPrint('حفظت الرسائل للشات $chatId');
    } catch (e) {
      debugPrint('خطأ في حفظ الرسائل للشات $chatId: $e');
    }
  }

  Future<ChatMessagesApiResponseModel?> getResponse(int chatId) async {
    try {
      final box = await _openBox(chatId);
      final response = box.get('response');
      debugPrint('جبت الرسائل للشات $chatId: ${response?.data.length ?? 0} رسالة');
      return response;
    } catch (e) {
      debugPrint('خطأ في جلب الرسائل للشات $chatId: $e');
      return null;
    }
  }

  Future<void> addMessageFromChatData(int chatId, ChatDataModel chatData) async {
    try {
      final box = await _openBox(chatId);
      final response = box.get('response');
      final newMessage = ChatMessageModel(
        prompt: chatData.userPrompt,
        response: chatData.botResponse,
        dateTime: DateTime.now().toIso8601String(),
      );
      if (response != null) {
        response.data.add(newMessage);
        await box.put('response', response);
        debugPrint('أضفت رسالة جديدة للشات $chatId');
      } else {
        final newResponse = ChatMessagesApiResponseModel(
          success: true,
          message: 'تم إضافة رسالة جديدة',
          data: [newMessage],
          errors: null,
          code: 200,
        );
        await box.put('response', newResponse);
        debugPrint('أنشأت رسائل جديدة للشات $chatId');
      }
    } catch (e) {
      debugPrint('خطأ في إضافة رسالة للشات $chatId: $e');
    }
  }

  Future<void> deleteChat(int chatId) async {
    try {
      final box = await _openBox(chatId);
      await box.deleteFromDisk();
      _boxes.remove(chatId);
      // Update chats list
      final chatsBox = await _openChatsListBox();
      final chatsList = chatsBox.get('chatsList');
      if (chatsList != null) {
        chatsList.chatModels.removeWhere((chat) => chat.id == chatId);
        await chatsBox.put('chatsList', chatsList);
        debugPrint('حذفت الشات $chatId من Hive وقايمة الشاتات');
      }
    } catch (e) {
      debugPrint('خطأ في حذف الشات $chatId من Hive: $e');
    }
  }

  Future<Box<ChatListResponseModel>> _openChatsListBox() async {
    final box = await Hive.openBox<ChatListResponseModel>('chatsList');
    debugPrint('فتحت box لقايمة الشاتات');
    return box;
  }

  Future<void> saveChatsList(ChatListResponseModel response) async {
    try {
      if (!Hive.isAdapterRegistered(ChatListResponseModelAdapter().typeId)) {
        throw HiveError('ChatListResponseModelAdapter is not registered');
      }
      final box = await _openChatsListBox();
      await box.put('chatsList', response);
      debugPrint('حفظت قايمة الشاتات: ${response.chatModels.length} شات');
    } catch (e) {
      debugPrint('خطأ في حفظ قايمة الشاتات: $e');
    }
  }

  Future<ChatListResponseModel?> getChatsList() async {
    try {
      final box = await _openChatsListBox();
      final response = box.get('chatsList');
      debugPrint('جبت قايمة الشاتات: ${response?.chatModels.length ?? 0} شات');
      return response;
    } catch (e) {
      debugPrint('خطأ في جلب قايمة الشاتات: $e');
      return null;
    }
  }

  Future<void> addChat(ChatItemEntity chat) async {
    try {
      final box = await _openChatsListBox();
      final response = box.get('chatsList');
      final chatModel = ChatItemModel(
        id: chat.id,
        title: chat.title,
        dateTime: chat.dateTime,
      );
      if (response != null) {
        response.chatModels.add(chatModel);
        await box.put('chatsList', response);
        debugPrint('أضفت شات جديد: ${chat.id}');
      } else {
        final newResponse = ChatListResponseModel(
          success: true,
          message: 'تم إضافة شات جديد',
          chatModels: [chatModel],
          errors: null,
          code: 200,
        );
        await box.put('chatsList', newResponse);
        debugPrint('أنشأت قايمة شاتات جديدة: ${chat.id}');
      }
    } catch (e) {
      debugPrint('خطأ في إضافة الشات: $e');
    }
  }

  Future<void> clearAllChats() async {
    try {
      // Clear chats list
      final chatsBox = await _openChatsListBox();
      await chatsBox.clear();
      debugPrint('مسحت قايمة الشاتات من Hive');

      // Clear all individual chat response boxes
      for (final chatId in _boxes.keys.toList()) {
        final box = _boxes[chatId];
        await box?.deleteFromDisk();
        debugPrint('مسحت box للشات $chatId');
      }
      _boxes.clear();
      debugPrint('مسحت كل صناديق الشاتات من Hive');
    } catch (e) {
      debugPrint('خطأ في مسح الشاتات من Hive: $e');
    }
  }
}