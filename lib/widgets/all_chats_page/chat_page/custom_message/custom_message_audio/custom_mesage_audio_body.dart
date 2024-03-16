import 'package:app/models/message_model.dart';
import 'package:app/models/users_model.dart';
import 'package:app/widgets/all_chats_page/chat_page/custom_message/custom_message_audio/custom_message_sound_component.dart';
import 'package:app/widgets/all_chats_page/chat_page/custom_message/custom_message_audio/message_sound_length.dart';
import 'package:flutter/material.dart';

class CustomMessageAudioBody extends StatelessWidget {
  const CustomMessageAudioBody(
      {super.key,
      required this.message,
      required this.size,
      required this.user});

  final MessageModel message;
  final Size size;
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomMessageSoundComponent(message: message, size: size, user: user),
        if (message.messageSoundPlaying == false)
          MessageSoundLength(size: size, message: message),
      ],
    );
  }
}
