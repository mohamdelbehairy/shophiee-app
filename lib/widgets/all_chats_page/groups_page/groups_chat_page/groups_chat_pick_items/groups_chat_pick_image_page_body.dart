import 'dart:io';

import 'package:app/cubit/upload/upload_image/upload_image_cubit.dart';
import 'package:app/utils/navigation.dart';
import 'package:app/cubit/groups/message_group/group_message_cubit.dart';
import 'package:app/models/group_model.dart';
import 'package:app/widgets/all_chats_page/chat_page/pick_chat_items/pick_chat_text_field.dart';
import 'package:app/widgets/all_chats_page/chat_page/pick_chat_items/pick_image_page_bottom.dart';
import 'package:app/widgets/all_chats_page/groups_page/groups_chat_page/groups_chat_page_send_chat_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GroupsChatPickImagePageBody extends StatefulWidget {
  const GroupsChatPickImagePageBody(
      {super.key, required this.image, required this.groupModel});
  final File image;
  final GroupModel groupModel;

  @override
  State<GroupsChatPickImagePageBody> createState() =>
      _GroupsChatPickImagePageBodyState();
}

class _GroupsChatPickImagePageBodyState
    extends State<GroupsChatPickImagePageBody> {
  TextEditingController controller = TextEditingController();
  bool isClick = false;
  navigation() {
    Navigation.navigationOnePop(context: context);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var sendMessage = context.read<GroupMessageCubit>();
    var uploadImage = context.read<UploadImageCubit>();

    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(top: size.height * .05),
          decoration: BoxDecoration(
            image: DecorationImage(
                image: FileImage(widget.image), fit: BoxFit.fitWidth),
          ),
        ),
        Positioned(
            height: size.height * .18,
            width: size.width,
            bottom: 0.0,
            child: PickChatTextField(
                controller: controller, hintText: 'Enter a message...')),
        Positioned(
          width: size.width,
          bottom: size.height * .015,
          child: GroupsChatSendItemChatBottom(
            groupModel: widget.groupModel,
            isClick: isClick,
            onTap: () async {
              try {
                setState(() {
                  isClick = true;
                });
                String imageUrl = await uploadImage.uploadImage(
                    imageFile: widget.image,
                    fieldName: 'groups_messages_images');
                await sendMessage.sendGroupMessage(
                    imageUrl: imageUrl,
                    videoUrl: null,
                    messageText: controller.text,
                    groupID: widget.groupModel.groupID, replayImageMessage: '', friendNameReplay: '', replayMessageID: '');
                navigation();
              } finally {
                setState(() {
                  isClick = false;
                });
              }
            },
          ),
        ),
        Positioned(
          top: size.height * .15,
          left: size.width * .04,
          child: PickImagePageBottom(
            icon: FontAwesomeIcons.xmark,
            color: Colors.transparent,
            onTap: () => Navigator.pop(context),
          ),
        ),
      ],
    );
  }
}
