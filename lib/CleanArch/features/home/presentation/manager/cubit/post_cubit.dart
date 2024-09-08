import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newapp/CleanArch/features/home/data/models/post_model.dart';
import 'package:newapp/CleanArch/features/home/data/repositories/post_reaction_reo_impl.dart';
import 'package:newapp/CleanArch/features/home/data/repositories/posts_repo_impl.dart';

part 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit({required this.postRepository,required this.postReactRepo}) : super(PostInitial());
  final PostRepository postRepository;
  final PostReactoinRepository postReactRepo;
  static PostCubit get(context)=>BlocProvider.of(context);
  
  List <String>postsId=[];
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
    getPostsId();
  
  }  


  void addLike({required int postIndex}){
     postReactRepo.addLike(postsId[postIndex]);
  }

  Future<void> getPostsId()async {
     FirebaseFirestore.instance.collection('posts').orderBy('postDate')
      .snapshots().listen((value) {
        fillPostsIdList(value.docs);
      });
  }
   void fillPostsIdList(list) {
      postsId=[];
     for (var element in list){
          postsId.add(element.id);
       }
 }
           


}




