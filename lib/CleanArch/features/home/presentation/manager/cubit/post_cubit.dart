import 'dart:convert';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newapp/CleanArch/features/home/data/models/post_model.dart';
import 'package:newapp/CleanArch/features/home/data/repositories/post_comment_repo_impl.dart';
import 'package:newapp/CleanArch/features/home/data/repositories/post_like_repo_impl.dart';
import 'package:newapp/CleanArch/features/home/data/repositories/posts_repo_impl.dart';
import 'package:newapp/CleanArch/features/home/domain/use_cases/create_post_usecase.dart';
part 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit({required this.postRepository,
  required this.postLikeRepo,required this.postCommentRepo,
  required this.createPostUseCase,
  }) : super(PostInitial());

  final CreatePostUseCase createPostUseCase;


  final PostRepository postRepository;
  final PostLikeRepository postLikeRepo;
  final PostCommentRepository postCommentRepo;
  static PostCubit get(context)=>BlocProvider.of(context);
  
  List <String>postsId=[];
  List<PostModel>allPostsList=[];
  void fetchAllPosts(){
    emit(GetPostsLoadingState());
    final response=postRepository.getAllPosts();
    response.fold((l) =>emit(GetPostsErrorState(errMessage: l.message)),
     (allPosts) {
       allPosts.listen((posts) {
         allPostsList=posts;
         emit(GetPostsSuccessState());
       });
     });
    getPostsId();
  }

  void changeLikeButton({required int postIndex})async{
    allPostsList[postIndex].isUserLike=!allPostsList[postIndex].isUserLike!;
  }

  void addLike({required int postIndex}){
       postLikeRepo.addLike(postsId[postIndex]);

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
           
  void addComment({required int postIndex,required String newComment}){
     postCommentRepo.addComment(postsId[postIndex],newComment);  
  }
  
  void getPostLikedUser({required int postIndex})async{
    emit(GetLikedUsersLoadingState());
    final response=await postLikeRepo.getLikedUsers(postId: postsId[postIndex]);
    GetLikedUsersSuccessState.setLikedUsers(response);
    emit(GetLikedUsersSuccessState());
    }

    void getPostComments({required int postIndex})async{
    emit(GetPostCommentsLoadingState());
    final response=await postCommentRepo.getPostComments(postId: postsId[postIndex]);
    GetPostCommentsSuccessState.setPostComments(response);
    emit(GetPostCommentsSuccessState(postIndex));
    }

 Future<void> createPost({required String postText})async{
  emit(CreatePostLoadingState());
  if(imageString!=''){
  await uploadPostImage().then((value)async {
      final response=await createPostUseCase.call(postText);
  response.fold((l) =>emit(CreatePostErrorState()),
   (r) =>emit(CreatePostSuccessState()));
   imageString='';
  }
  );}else{
  final response=await createPostUseCase.call(postText);
  response.fold((l) =>emit(CreatePostErrorState()),
   (r) =>emit(CreatePostSuccessState()));
   imageString='';
  }
  }

  Uint8List? imageAsByte;
  String imageString='';

  Future<void> pickPostImage()async{
    emit(PickPostImageLoadingState());
    final response=await createPostUseCase.pickPostImageUseCase.call();
    response.fold((l) =>emit(PickPostImageErrorState()),
     (r)async {
      
      await r.readAsBytes().then((value) {
      imageString= base64Encode(value);
      imageAsByte=value;
      });
      emit(PickPostImageSuccessState());
     });
  }
  
  Future<void> uploadPostImage()async{
    emit(UploadPostImageLoadingState());
    final response=await createPostUseCase.uploadPostImageUseCase.call();
    response.fold((l) =>emit(UploadPostImageErrorState()),
     (r) =>emit(UploadPostImageSuccessState()));
  }

}
