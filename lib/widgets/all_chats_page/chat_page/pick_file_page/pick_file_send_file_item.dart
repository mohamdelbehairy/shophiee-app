import 'package:app/constants.dart';
import 'package:app/models/users_model.dart';
import 'package:flutter/material.dart';

class PickFileSendFileItem extends StatelessWidget {
  const PickFileSendFileItem({super.key, required this.user, required this.onTap});
  final UserModel user;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.height * .025),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: size.height * .05,
            width: size.width * .2,
            decoration: BoxDecoration(
                color: Color(0xff1e2c32),
                borderRadius: BorderRadius.circular(size.height *.032)),
            child: Center(
                child: Text(user.userName.split(' ')[0],
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.normal))),
          ),
          GestureDetector(
            onTap: onTap,
            child: CircleAvatar(
              radius: size.height *.032,
              backgroundColor: kPrimaryColor,
              child: Icon(Icons.send, color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
