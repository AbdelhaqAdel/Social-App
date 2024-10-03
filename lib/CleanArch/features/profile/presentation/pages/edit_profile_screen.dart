import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:newapp/CleanArch/config/theme/colors.dart';
import 'package:newapp/CleanArch/core/utils/widgets/text_form_feild.dart';
import 'package:newapp/CleanArch/features/profile/presentation/manager/profile_cubit.dart';
import '../../data/models/user_model.dart';
import '../../../../core/utils/widgets/static_component.dart';

class EditProfileScreen extends StatelessWidget {
  final nameController = TextEditingController();
  final nicknameController = TextEditingController();
  final phoneController = TextEditingController();
  final bioController = TextEditingController();
  final UserModel userModel;
  EditProfileScreen({super.key, required this.userModel});
  @override
  Widget build(BuildContext context) {
      nameController.text = userModel.name!;
        phoneController.text=userModel.phone!;
        bioController.text = userModel.bio!;
        nicknameController.text=userModel.nickname!;
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {},
      builder: (context, state) {
        var screenSize=MediaQuery.of(context).size;
        ProfileCubit cubit = ProfileCubit.get(context);
      
        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: 'Edit your profile',
            actions: [
              TextButton(
                onPressed: () {
                  cubit.updateUserInfo(
                      name: nameController.text,
                      phone: phoneController.text,
                      bio: bioController.text,
                    nickname: nicknameController.text
                  ).then((value) => 
                  GoRouter.of(context).pop());
                },
                child: Text(
                  "Update",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                if (state is UserUpdateLoadingState||state is ImageUploadLoadingState)
                  const LinearProgressIndicator(),
                SizedBox(
                  height: 15.h,
                ),
                SizedBox(
                  height: screenSize.height/3.5,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Align(
                        alignment: AlignmentDirectional.topCenter,
                        child: Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              SizedBox(
                                width: double.infinity,
                                height: screenSize.height/4.5,
                                child: Card(
                                  elevation: 10,
                                  child:cubit.coverImage != null
                                      ?Image.memory(
                                    cubit.coverImage!,
                                    fit: BoxFit.cover,
                                  )
                                      :   Image.network(
                                    '${userModel.cover}',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: CircleAvatar(
                                    backgroundColor: AppColor.defaultColor,
                                    radius: 20,
                                    child: IconButton(
                                            onPressed: () {
                                              cubit.pickCoverImage();
                                            },
                                            icon: Icon(
                                              Icons.add_a_photo_outlined,
                                              size: 20.sp,
                                            ))),
                              ),
                            ]),
                      ),
                      Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                        cubit.image != null
                            ? CircleAvatar(
                                backgroundImage: MemoryImage(cubit.image!),
                                radius: 45,
                              )
                            : CircleAvatar(
                                backgroundImage:
                                    NetworkImage('${userModel.image}'),
                                radius: 45,
                              ),
                        CircleAvatar(
                            backgroundColor: AppColor.defaultColor,
                            radius: 18,
                            child: IconButton(
                                    onPressed: () {
                                      cubit.pickProfileImage();
                                    },
                                    icon: Icon(
                                      Icons.add_a_photo_outlined,
                                      size: 18.sp,
                                    ))),
                      ]),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                
                ProfileCustomTextFormField(controller: nameController, labelText: 'Name', icon: Icons.perm_identity,),
                   SizedBox(
                  height: 15.h,
                ),
                ProfileCustomTextFormField(controller: nicknameController, labelText: 'Nick name', icon: Icons.perm_identity,),
                   SizedBox(
                  height: 15.h,
                ),
                ProfileCustomTextFormField(controller: phoneController, labelText: 'phone', icon: Icons.phone_android,),
                    SizedBox(
                  height: 15.h,
                ),
                ProfileCustomTextFormField(controller: bioController, labelText: 'bio', icon: Icons.info_outline,),

              ],
            ),
          ),
        );
      },
    );
  }
}
