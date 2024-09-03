import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newapp/shared/Cubit/cubit/app_cubit.dart';
import '../../data/models/user_model.dart';
import '../../../../core/utils/widgets/static_component.dart';

class EditProfileScreen extends StatelessWidget {
  final nameController = TextEditingController();
  final nicknameController = TextEditingController();
  final phoneController = TextEditingController();
  final bioController = TextEditingController();

  EditProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var screenSize=MediaQuery.of(context).size;
        AppCubit cubit = AppCubit.get(context);
        UserModel? userModel = cubit.userModel;
        nameController.text = userModel!.name!;
        phoneController.text=userModel.phone!;
        bioController.text = userModel.bio!;
        nicknameController.text=userModel.nickname!;
        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: 'Edit your profile',
            actions: [
              TextButton(
                onPressed: () {
                  cubit.uploadProfileImage(
                      name: nameController.text,
                      phone: phoneController.text,
                      bio: bioController.text,
                    nickname: nicknameController.text
                  );
                  cubit.uploadCoverImage(
                      name: nameController.text,
                      phone: phoneController.text,
                      bio: bioController.text,
                      nickname: nicknameController.text,
                  );
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
                if (state is UserUpdateLoagingState||state is UserCoverUpdateLoagingState)
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
                                    backgroundColor: Colors.deepOrange,
                                    radius: 20,
                                    child: cubit.coverImage != null
                                        ? IconButton(
                                            onPressed: () {
                                              cubit.uploadCoverImage(
                                                  name: nameController.text,
                                                  phone: phoneController.text,
                                                  bio: bioController.text,
                                                nickname: nicknameController.text,
                                              );
                                            },
                                            icon: Icon(
                                              Icons.check_circle,
                                              size: 20.sp,
                                            ))
                                        : IconButton(
                                            onPressed: () {
                                              cubit.PickCoverImage();
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
                        cubit.Image != null
                            ? CircleAvatar(
                                backgroundImage: MemoryImage(cubit.Image!),
                                radius: 45,
                              )
                            : CircleAvatar(
                                backgroundImage:
                                    NetworkImage('${userModel.image}'),
                                radius: 45,
                              ),
                        CircleAvatar(
                            backgroundColor: Colors.deepOrange,
                            radius: 18,
                            child: cubit.Image != null
                                ? IconButton(
                                    onPressed: () {
                                      cubit.uploadProfileImage(
                                          name: nameController.text,
                                          phone: phoneController.text,
                                          bio: bioController.text,
                                        nickname: nicknameController.text,
                                      );
                                    },
                                    icon: Icon(
                                      Icons.check_circle,
                                      size: 18.sp,
                                    ))
                                : IconButton(
                                    onPressed: () {
                                      cubit.PickProfileImage();
                                    },
                                    icon: Icon(
                                      Icons.add_a_photo_outlined,
                                      size: 18.sp,
                                    ))),
                      ]),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: nameController,
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'name can\'t be empty';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    prefixIcon: Icon(
                      Icons.perm_identity,
                    ),
                  
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                TextFormField(
                  controller: nicknameController,
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'can\'t be empty';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    prefixIcon: Icon(
                      Icons.perm_identity,
                    ),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'phone can\'t be empty';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Phone',
                    prefixIcon: Icon(
                      Icons.mobile_friendly,
                    ),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                TextFormField(
                  controller: bioController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: 'edit your bio',
                    prefixIcon: Icon(
                      Icons.info_outlined,
                    ),
                  ),
                ),

              ],
            ),
          ),
        );
      },
    );
  }
}
