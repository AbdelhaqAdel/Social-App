import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newapp/CleanArch/features/profile/data/models/user_model.dart';
import 'package:newapp/CleanArch/features/profile/data/repositories/profile_repo_impl.dart';
part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({required this.authRepository}) : super(AuthInitial());
  static ProfileCubit get(context)=>BlocProvider.of(context);
  final ProfileRepository authRepository;

  Future<void> getUserData({required String uid})async{
   emit(GetUserDataLoadingState());
  final response=await authRepository.getUserProfile(uid: uid); 
  response.fold((errMessage) => emit(GetUserDataErrorState(errMessage: errMessage.message)),
   (userData)=> emit(GetUserDataSuccessState(userData: userData))
  );}
}
