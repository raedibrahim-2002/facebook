class StoryModel {
  final String imageUrl;
  final String personAccountName;
  final bool shown;
  final bool online;

  StoryModel(
      {required this.imageUrl,
      required this.personAccountName,
      required this.shown,
      required this.online});
}

class ChatsModel {
  final String imageUrlChat;
  final String personAccountNameChat;
  final String ChatText;
  final bool onlineBlue;
  final bool onlineInTheChat;

  ChatsModel({
    required this.imageUrlChat,
    required this.personAccountNameChat,
    required this.ChatText,
    required this.onlineBlue,
    required this.onlineInTheChat,
  });
}
