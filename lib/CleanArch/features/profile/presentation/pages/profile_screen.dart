import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newapp/CleanArch/core/utils/Get%20it/auth_locator.dart';
import 'package:newapp/CleanArch/features/profile/data/repositories/profile_repo_impl.dart';
import 'package:newapp/CleanArch/features/profile/presentation/manager/profile_cubit.dart';
import 'package:newapp/CleanArch/features/profile/presentation/pages/profile_body.dart';
import '../../../../core/utils/key_constants.dart';
import '../../../../core/cache_helper.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ProfileScreen()),
        );
        return Future.value(false); 
      },
      child: BlocProvider(
        create: (context) => ProfileCubit(authRepository: getIt.get<ProfileRepository>())..getUserData(uid: uid),
        child: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state is GetUserDataSuccessState) {
              userData = state.userData;
              uid = CacheHelper.getData('UID');
            }
          },
          builder: (context, state) {
            if (state is GetUserDataSuccessState) {
              return ProfileBody(userModel: userData!);
            } else if (state is GetUserDataErrorState) {
              return Center(child: Text(state.errMessage));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
