import 'package:app/constants.dart';
import 'package:app/cubit/message/message_cubit.dart';
import 'package:app/models/message_model.dart';
import 'package:app/models/users_model.dart';
import 'package:app/pages/chats/message_forward_page.dart';
import 'package:app/utils/save_sound.dart';
import 'package:app/utils/share_media.dart';
import 'package:app/utils/widget/messages/custom_pop_menu_item.dart';
import 'package:app/utils/widget/messages/delete_message_show_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart' as getnav;

class CustomChatPopMenuButton extends StatelessWidget {
  const CustomChatPopMenuButton(
      {super.key,
      required this.child,
      required this.size,
      required this.message,
      this.messageCubit,
      this.user});
  final Widget child;
  final Size size;
  final MessageModel message;
  final MessageCubit? messageCubit;
  final UserModel? user;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        color: kPrimaryColor,
        offset: Offset(
            message.senderID == FirebaseAuth.instance.currentUser!.uid ? 1 : 0,
            -size.height * .2),
        itemBuilder: (BuildContext context) {
          return [
            if (message.messageText == '')
              customPopMenuItemMethod(
                  name: 'Share',
                  size: size,
                  icon: Icons.share,
                  onTap: () async {
                    String? mediaUrl;
                    String? mediaType;
                    if (message.messageImage != null) {
                      mediaUrl = message.messageImage;
                      mediaType = 'image.jpg';
                    } else if (message.messageVideo != null) {
                      mediaUrl = message.messageVideo;
                      mediaType = 'video.mp4';
                    } else if (message.messageFile != null) {
                      mediaUrl = message.messageFile;
                      mediaType = '${message.messageFileName}';
                    } else if (message.phoneContactNumber != null) {
                      mediaUrl = message.phoneContactNumber;
                      mediaType = 'phone_number';
                    } else if (message.messageText != '') {
                      mediaUrl = message.messageText;
                      mediaType = message.messageText;
                    } else if (message.messageSound != null) {
                      mediaUrl = message.messageSound;
                      mediaType = '${message.messageSoundName}';
                    } else if (message.messageRecord != null) {
                      mediaUrl = message.messageRecord;
                      mediaType =
                          'record.${DateTime.now().millisecondsSinceEpoch}';
                    }
                    if (mediaUrl != null && mediaType != null) {
                      await shareMedia(
                          mediaUrl: mediaUrl, mediaType: mediaType);
                    }
                  }),
            if (message.messageSound != null || message.messageRecord != null)
              customPopMenuItemMethod(
                  name: 'Save',
                  size: size,
                  icon: Icons.save,
                  onTap: () async {
                    await saveSound(messages: message);
                  }),
            if (message.messageText.isNotEmpty)
              customPopMenuItemMethod(
                  name: 'Copy',
                  size: size,
                  icon: FontAwesomeIcons.copy,
                  onTap: () async {
                    final value = ClipboardData(text: message.messageText);
                    Clipboard.setData(value);
                  }),
            customPopMenuItemMethod(
                name: 'Forward',
                size: size,
                icon: FontAwesomeIcons.share,
                onTap: () {
                  getnav.Get.to(
                      MessageForwardPage(user: user, message: message),
                      transition: getnav.Transition.leftToRight);
                }),
            if (message.messageText.isNotEmpty)
              customPopMenuItemMethod(
                  name: 'Pin',
                  size: size,
                  icon: Icons.push_pin_outlined,
                  angle: .5,
                  onTap: () {}),
            if (message.messageText.isNotEmpty)
              customPopMenuItemMethod(
                  name: 'Edit', size: size, icon: Icons.edit, onTap: () {}),
            customPopMenuItemMethod(
                name: 'Delete',
                size: size,
                icon: FontAwesomeIcons.trash,
                onTap: () {
                  deleteMessageShowDialog(
                      context: context,
                      onPressed: () async {
                        Navigator.of(context).pop(false);

                        if (messageCubit != null && user != null) {
                          await messageCubit!.deleteMessage(
                              friendID: user!.userID,
                              messageID: message.messageID);
                        }
                      });
                }),
          ];
        },
        child: child);
  }
}
