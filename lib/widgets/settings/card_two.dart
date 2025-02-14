import 'package:app/constants.dart';
import 'package:app/cubit/auth/auth_settings/auth_settings_cubit.dart';
import 'package:app/cubit/auth/login/login_cubit.dart';
import 'package:app/cubit/get_friends/get_friends_cubit.dart';
import 'package:app/cubit/get_friends/get_friends_state.dart';
import 'package:app/pages/login_page.dart';
import 'package:app/widgets/settings/custom_items_two.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart' as getnav;

class CustomCardTwo extends StatefulWidget {
  const CustomCardTwo({super.key});

  @override
  State<CustomCardTwo> createState() => _CustomCardTwoState();
}

class _CustomCardTwoState extends State<CustomCardTwo> {
  bool showProgressIndicator = false;

  void logOut() {
    context.read<AuthSettingsCubit>().signOut();
    getnav.Get.to(() => LoginPage(), transition: getnav.Transition.leftToRight);
  }

  void onTap() async {
    showProgressIndicator = true;
    setState(() {});
    await Future.delayed(Duration(seconds: 2));
    logOut();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthSettingsCubit, AuthSettingsState>(
      listener: (context, state) {
        if (state is SignOutSuccess) {
          context.read<GetFriendsCubit>().emit(GetFriendsInitial());
        }
      },
      child: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.only(top: 12, left: 12, right: 12),
            child: Container(
              height: 155,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: Colors.transparent, boxShadow: [
                BoxShadow(
                  blurRadius: 40,
                  color: context.read<LoginCubit>().isDark
                      ? Colors.grey.withOpacity(.1)
                      : Colors.grey.withOpacity(.4),
                  // spreadRadius: 10,
                  // offset: Offset(10, 10),
                )
              ]),
              child: Card(
                color: context.read<LoginCubit>().isDark
                    ? Color(0xff2b2c33)
                    : Colors.white,
                elevation: 0,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: onTap,
                        child: CustomItemsTwo(
                            textColor: context.read<LoginCubit>().isDark
                                ? Colors.white
                                : Colors.black,
                            enableFeedback: false,
                            color: Colors.orange,
                            icon: Icons.lock,
                            size: 18,
                            text: 'Logout'),
                      ),
                      if (showProgressIndicator)
                        Center(
                          child: CircularProgressIndicator(
                            color: kPrimaryColor,
                          ),
                        ),
                      SizedBox(height: 12),
                      Expanded(
                        child: CustomItemsTwo(
                          textColor: Color(0xfffe6e6e),
                          icon2: FontAwesomeIcons.chevronRight,
                          text: 'Delete Account',
                          size: 18,
                          icon: Icons.person,
                          color: Color(0xfffe6e6e),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
