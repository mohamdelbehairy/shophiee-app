import 'package:app/constants.dart';
import 'package:app/models/message_model.dart';
import 'package:app/models/users_model.dart';
import 'package:app/utils/save_image.dart';
import 'package:app/utils/share_media.dart';
import 'package:app/widgets/all_chats_page/chat_page/custom_message/show_chat_media/show_chat_media_appbar.dart';
import 'package:app/widgets/show_toast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

class ShowChatImagePage extends StatefulWidget {
  const ShowChatImagePage(
      {super.key, required this.message, required this.user});
  final MessageModel message;
  final UserModel user;

  @override
  State<ShowChatImagePage> createState() => _ShowChatImagePageState();
}

class _ShowChatImagePageState extends State<ShowChatImagePage> {
  bool isClick = true;
  showToastMethod() {
    ShowToast(
        context: context,
        showToastText: 'Image saved successfully',
        position: StyledToastPosition.bottom);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: isClick
          ? AppBar(
              backgroundColor: kPrimaryColor,
              titleSpacing: size.width * -.02,
              title: ShowChatMediaAppBar(
                message: widget.message,
                user: widget.user,
                saveOnTap: () async {
                  await saveImage(imageUrl: widget.message.messageImage!);
                  showToastMethod();
                },
                shareOnTap: () async {
                  await shareMedia(
                      mediaUrl: widget.message.messageImage!,
                      mediaType: 'image.jpg');
                },
              ))
          : AppBar(
              backgroundColor: Colors.transparent,
              automaticallyImplyLeading: false),
      body: Padding(
        padding: EdgeInsets.only(top: size.height * .06),
        child: GestureDetector(
          onTap: () {
            setState(() {
              isClick = !isClick;
            });
          },
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image:
                      CachedNetworkImageProvider(widget.message.messageImage!),
                  fit: BoxFit.fitWidth),
            ),
          ),
        ),
      ),
    );
  }
}
