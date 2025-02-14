import 'package:app/cubit/user_date/get_user_data/get_user_data_cubit.dart';
import 'package:app/cubit/user_date/get_user_data/get_user_data_state.dart';
import 'package:app/models/group_model.dart';
import 'package:app/models/message_model.dart';
import 'package:app/models/users_model.dart';
import 'package:app/utils/widget/chats/high_light_page/high_light_list_tile.dart';
import 'package:app/utils/widget/chats/high_light_page/high_light_message_date_time.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HighLightListViewItem extends StatelessWidget {
  const HighLightListViewItem(
      {super.key,
      required this.message,
      required this.size,
      this.groupModel,
      this.userData});

  final MessageModel message;
  final Size size;
  final GroupModel? groupModel;
  final UserModel? userData;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetUserDataCubit, GetUserDataStates>(
      builder: (context, state) {
        if (state is GetUserDataSuccess && state.userModel.isNotEmpty) {
          final currentUser = message.senderID;
          final data = state.userModel
              .firstWhere((element) => element.userID == currentUser);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HighLightListTile(
                  userData: userData,
                  message: message,
                  size: size,
                  user: data,
                  groupModel: groupModel),
              HighLightMessageDateTime(size: size, message: message),
              // Divider()
              Container(
                  height: .3,
                  width: size.width,
                  color: Colors.grey.shade400,
                  margin: EdgeInsets.symmetric(horizontal: size.width * .04)),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }
}
