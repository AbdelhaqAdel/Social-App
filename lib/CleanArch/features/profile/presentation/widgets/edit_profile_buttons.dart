import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:newapp/CleanArch/core/cache_helper.dart';
import 'package:newapp/CleanArch/core/utils/app_router.dart';
import 'package:newapp/CleanArch/features/profile/data/models/user_model.dart';
import 'package:newapp/CleanArch/features/profile/presentation/manager/profile_cubit.dart';

class EditProfileAndLogout extends StatelessWidget {
  const EditProfileAndLogout({super.key, required this.userModel, 
  required this.cubitContext});
  final UserModel userModel;
  final BuildContext cubitContext;
  @override
  Widget build(BuildContext context) {
    return Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: (){
                    ProfileCubit.get(context).image = null;
                    ProfileCubit.get(context).coverImage=null;
                    AppRouter.cubitContext=cubitContext;

                     GoRouter.of(context).push(AppRouter.kEditProfile,extra: userModel);
                          },
                  child: Container(
                      height: 30.h,
                      padding: EdgeInsets.all(7.r),
                      decoration:BoxDecoration(
                        borderRadius: BorderRadius.circular(10,),
                        color: Colors.grey[500],
                      ),
                      child:
                      Row(
                        mainAxisAlignment:MainAxisAlignment.center,
                        children: [
                          Text('Edit profile',
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontSize: 17.sp,
                            ),
                          ),
                          const SizedBox(width: 5,),

                        ],
                      )
                  ),
                ),
              ),
              SizedBox(width: 10.w,),

              Expanded(
                child: GestureDetector(
                  onTap: (){
                    CacheHelper.removeData(key: 'UID');
             GoRouter.of(context).pushReplacement(AppRouter.kLogin);
                  },
                  child:  Container(
                        height: 30.h,
                        padding: const EdgeInsets.all(7),
                        decoration:BoxDecoration(
                          borderRadius: BorderRadius.circular(10,),
                          color: Colors.grey[500],
                        ),
                        child:
                        Row(
                          mainAxisAlignment:MainAxisAlignment.center,
                          children: [
                            Text('Log out',
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                fontSize: 17.sp,

                              ),
                            ),

                          ],
                        )
                    ),
                  
                ),
              ),
            ],
          );}
}