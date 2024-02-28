import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newapp/shared/Cubit/cubit/app_cubit.dart';
import '../../../models/UserModel/UsersModel.dart';
import '../../../shared/Component/StaticComponent.dart';

class EditProfileScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var nicknameController = TextEditingController();
  var phoneController = TextEditingController();
  var bioController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);

        // XFile? profileImage =  cubit.profileImage;
        //  void selectaprofileImage()async{
        //    Uint8List img = await cubit.PickImage();
        //    Image=img;
        //  }

        UserRegisterModel? userModel = cubit.userModel;
        nameController.text = userModel!.name!;
        phoneController.text=userModel.phone!;
        bioController.text = userModel.bio!;
        nicknameController.text=userModel.nickname!;
        return Scaffold(
          appBar: DefaultAppBar(
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
                  //print(' profile url : ${cubit.profileImageUrl}');
                },
                child: Text(
                  "Update",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  if (state is UserUpdateLoagingState||state is UserCoverUpdateLoagingState)
                    LinearProgressIndicator(),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 200,
                    child: Stack(
                      alignment: Alignment.bottomLeft,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
                              alignment: AlignmentDirectional.bottomEnd,
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 180,
                                  child: Card(
                                    //margin: EdgeInsets.all(8),
                                    //clipBehavior:Clip.antiAliasWithSaveLayer,
                                    elevation: 10,
                                    child:   cubit.coverImage != null
                                        ?   Image.memory(
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
                                                size: 20,
                                              ))
                                          : IconButton(
                                              onPressed: () {
                                                cubit.PickCoverImage();
                                              },
                                              icon: Icon(
                                                Icons.add_a_photo_outlined,
                                                size: 20,
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
                                  //MemoryImage(Image),
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
                                        size: 18,
                                      ))
                                  : IconButton(
                                      onPressed: () {
                                        cubit.PickProfileImage();
                                      },
                                      icon: Icon(
                                        Icons.add_a_photo_outlined,
                                        size: 18,
                                      ))),
                        ]),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: nameController,
                    // onChanged: (data){
                    //   nameController.text=data;
                    // },
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'name can\'t be empty';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Name',
                      prefixIcon: Icon(
                        Icons.perm_identity,
                      ),
                      // suffixIcon: Icons.person !=null ? IconButton(onPressed: (){
                      // },
                      //   icon: Icon(Icons.person,),
                      // ):null,
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: nicknameController,
                    // onChanged: (data){
                    //   nameController.text=data;
                    // },
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'can\'t be empty';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Name',
                      prefixIcon: Icon(
                        Icons.perm_identity,
                      ),
                      // suffixIcon: Icons.person !=null ? IconButton(onPressed: (){
                      // },
                      //   icon: Icon(Icons.person,),
                      // ):null,
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: phoneController,
                    // onChanged: (data){
                    //   nameController.text=data;
                    // },
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'phone can\'t be empty';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Phone',
                      prefixIcon: Icon(
                        Icons.mobile_friendly,
                      ),
                      // suffixIcon: Icons.person !=null ? IconButton(onPressed: (){
                      // },
                      //   icon: Icon(Icons.person,),
                      // ):null,
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: bioController,
                    keyboardType: TextInputType.text,
                    // validator: (value) {
                    //   if (value!.isEmpty) {
                    //     return 'name can\'t be empty';
                    //   }
                    //   return null;
                    // },
                    decoration: InputDecoration(
                      labelText: 'edit your bio',
                      prefixIcon: Icon(
                        Icons.info_outlined,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
