import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newapp/CleanArch/features/home/data/models/post_model.dart';
import 'package:newapp/CleanArch/features/home/data/repositories/posts_repo_impl.dart';

part 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit({required this.postRepository}) : super(PostInitial());
  final PostRepository postRepository;
  static PostCubit get(context)=>BlocProvider.of(context);
 
  List<PostModel>allPostsList=[];
  Future <void>fetchAllPosts()async{
    final response=await postRepository.getAllPosts();
    response.fold((l) =>emit(GetPostsErrorState(errMessage: l.message)),
     (allPosts) {
      for (var element in allPosts){
           allPostsList.add(element);
      }
       emit(GetPostsSuccessState(posts:allPosts ,
        postLikes: postRepository.postLikes,
        postLikeNum: postRepository.postLikeNum,
        postCommrntsNum: postRepository.postCommrntsNum));
     });
  }  
}
