import 'package:app/cubit/message/message_cubit.dart';
import 'package:app/models/message_model.dart';
import 'package:app/widgets/all_chats_page/chat_page/custom_message/custom_message_text/replay_message_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class CustomMessageText extends StatelessWidget {
  const CustomMessageText(
      {super.key,
      required this.messageModel,
      required this.size,
      required this.messageTextColor,
      required this.itemController});
  final MessageModel messageModel;
  final Size size;
  final Color messageTextColor;
  final ItemScrollController itemController;

  @override
  Widget build(BuildContext context) {
    var messages = context.read<MessageCubit>();
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
            GestureDetector(
              onTap: () async {
                if (messageModel.replayMessageID != null) {
                  final originalMessage = messages.messages.firstWhere(
                    (element) =>
                        element.messageID == messageModel.replayMessageID,
                  );

                  int messageIndex = messages.messages.indexOf(originalMessage);

                  itemController.scrollTo(
                      index: messageIndex,
                      curve: Curves.easeIn,
                      duration: const Duration(seconds: 2));
                }
              },
              child: ReplayMessageText(
                  size: size,
                  messageModel: messageModel,
                  messageTextColor: messageTextColor),
            ),
          Text(
            messageModel.messageText,
            style: TextStyle(color: messageTextColor),
          ),
        ],
      ),
    );
  }
}
