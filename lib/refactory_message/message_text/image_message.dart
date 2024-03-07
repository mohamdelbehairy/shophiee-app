import 'package:app/constants.dart';
import 'package:app/models/message_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ImageMessage extends StatelessWidget {
  const ImageMessage(
      {super.key, required this.messageModel, required this.size});
  final MessageModel messageModel;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * .7,
      child: ClipRRect(
        borderRadius: BorderRadiusDirectional.only(
          topStart:
              messageModel.senderID == FirebaseAuth.instance.currentUser!.uid
                  ? Radius.circular(24)
                  : Radius.circular(0),
          bottomStart:
              messageModel.senderID == FirebaseAuth.instance.currentUser!.uid
                  ? Radius.circular(24)
                  : Radius.circular(0),
          topEnd:
              messageModel.senderID == FirebaseAuth.instance.currentUser!.uid
                  ? Radius.circular(0)
                  : Radius.circular(24),
          bottomEnd:
              messageModel.senderID == FirebaseAuth.instance.currentUser!.uid
                  ? Radius.circular(0)
                  : Radius.circular(24),
        ),
        child: CachedNetworkImage(
          imageUrl: messageModel.messageImage!,
          fit: BoxFit.cover,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(
                color: messageModel.senderID ==
                        FirebaseAuth.instance.currentUser!.uid
                    ? Colors.white
                    : kPrimaryColor),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      ),
    );
  }
}
