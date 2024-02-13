import 'package:app/cubit/auth/login/login_page_cubit.dart';
import 'package:app/cubit/get_user_data/get_user_data_cubit.dart';
import 'package:app/cubit/get_user_data/get_user_data_state.dart';
import 'package:app/models/users_model.dart';
import 'package:app/pages/my_friend_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FriendsPageListView extends StatelessWidget {
  const FriendsPageListView(
      {super.key, required this.itemCount, required this.friend});
  final int itemCount;
  final List<UserModel> friend;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDark = context.read<LoginCubit>().isDark;
    return Expanded(
      child: ListView.builder(
          itemCount: itemCount,
          itemBuilder: (context, index) {
            return BlocBuilder<GetUserDataCubit, GetUserDataStates>(
              builder: (context, state) {
                if (state is GetUserDataSuccess && state.userModel.isNotEmpty) {
                  final currentUser = friend[index].userID;
                  final data = state.userModel
                      .firstWhere((element) => element.userID == currentUser);
                  return GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyFriendPage(
                          user: data,
                        ),
                      ),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: size.height * .028,
                        backgroundColor: Colors.transparent,
                        backgroundImage: NetworkImage(data.profileImage),
                      ),
                      title: Text(
                        data.userName,
                        style: TextStyle(
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              },
            );
          }),
    );
  }
}
