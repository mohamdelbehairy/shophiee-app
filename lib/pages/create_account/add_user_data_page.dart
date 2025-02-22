import 'package:app/constants.dart';
import 'package:app/cubit/pick_image/pick_image_cubit.dart';
import 'package:app/cubit/upload/upload_image/upload_image_cubit.dart';
import 'package:app/cubit/user_date/store_user_date/store_user_date_cubit.dart';
import 'package:app/widgets/create_accont_widget/add_user_data_page_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddUserDataPage extends StatelessWidget {
  const AddUserDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var pickImage = context.read<PickImageCubit>();
    var storeUserData = context.read<StoreUserDateCubit>();
    var uploadImage = context.read<UploadImageCubit>();
    return PopScope(
        canPop: false,
        child: Scaffold(
            // backgroundColor: Colors.white,
            appBar: AppBar(
                automaticallyImplyLeading: false,
                // titleSpacing: size.width * -.005,
                backgroundColor: kPrimaryColor,
                title: Text('Fill Your Profile',
                    style: TextStyle(
                        fontSize: size.width * .05,
                        fontWeight: FontWeight.normal))),
            body: AddUserDataPageBody(
                storeUserData: storeUserData,
                uploadImage: uploadImage,
                size: size,
                pickImage: pickImage)));
  }
}
