import 'package:app/models/message_model.dart';
import 'package:app/widgets/all_chats_page/chat_page/custom_message/custom_message_text/replay_message_text.dart';
import 'package:flutter/material.dart';

class CustomMessageText extends StatelessWidget {
  const CustomMessageText(
      {super.key,
      required this.messageModel,
      required this.size,
      required this.messageTextColor});
  final MessageModel messageModel;
  final Size size;
  final Color messageTextColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: messageModel.messageImage != null &&
                  messageModel.messageText == ''
              ? 0.0
              : messageModel.messageImage != null &&
                      messageModel.messageText != ''
                  ? size.height * .01
                  : size.height * .015,
          bottom: messageModel.messageImage != null &&
                  messageModel.messageText == ''
              ? 0.0
              : messageModel.messageImage != null &&
                      messageModel.messageText != ''
                  ? size.height * .01
                  : size.height * .015,
          left: size.width * .032,
          right: messageModel.messageText.length > 5 ? 8 : 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (messageModel.replayTextMessage != '' ||
              messageModel.replayImageMessage != '' ||
              messageModel.replayFileMessage != '' ||
              messageModel.replayContactMessage != '')
            ReplayMessageText(
                size: size,
                messageModel: messageModel,
                messageTextColor: messageTextColor),
          Text(
            messageModel.messageText,
            style: TextStyle(color: messageTextColor),
          ),
        ],
      ),
    );
  }
}

