import 'package:app/constants.dart';
import 'package:app/cubit/get_user_data/get_user_data_cubit.dart';
import 'package:app/cubit/get_user_data/get_user_data_state.dart';
import 'package:app/models/group_model.dart';
import 'package:app/models/users_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupsCoverImage extends StatelessWidget {
  const GroupsCoverImage({super.key, required this.groupModel});
  final GroupModel groupModel;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.transparent,
          backgroundImage: NetworkImage(groupModel.groupImage!),
        ),
        BlocBuilder<GetUserDataCubit, GetUserDataStates>(
          builder: (context, state) {
            if (state is GetUserDataSuccess && state.userModel.isNotEmpty) {
              UserModel? memberData;
              Color color;
              for (var memberID in groupModel.usersID) {
                if (memberID != FirebaseAuth.instance.currentUser!.uid) {
                  memberData = state.userModel
                      .firstWhere((element) => element.userID == memberID);
                }
              }
              int differenceInMinutes = Timestamp.now()
                  .toDate()
                  .difference(memberData!.onlineStatue)
                  .inMinutes;
              color = differenceInMinutes < 1 ? kPrimaryColor : Colors.grey;
              return CircleAvatar(
                radius: 8,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 6,
                  backgroundColor: color,
                ),
              );
            } else {
              return Container();
            }
          },
        )
      ],
    );
  }
}
