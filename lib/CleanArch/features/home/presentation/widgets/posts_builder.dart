import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newapp/CleanArch/features/home/presentation/manager/cubit/post_cubit.dart';
import 'package:newapp/CleanArch/features/home/presentation/widgets/posts_list_view.dart';

class PostsBuilder extends StatelessWidget {
  const PostsBuilder({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostCubit,PostState>(builder:(context,state){
      if(PostCubit.get(context).allPostsList.isNotEmpty){
           return FadeInUp(
             animate: true,
             from: 200,
             child:
             PostsList(posts:PostCubit.get(context).allPostsList,cubitContext: context,));
           }else if(state is GetPostsLoadingState){
             return const Center(child: CircularProgressIndicator(),);
           }
           else if(state is GetPostsErrorState){
             return Text(state.errMessage);
           }
           else{
            return const Center(child: Expanded(child: Text('No available Posts')),);
           }
       
    //    StreamBuilder<QuerySnapshot>(
    //      stream: FirebaseFirestore.instance.collection('posts').orderBy('postDate', descending: false)
    //          .snapshots(),
    //      builder: (BuildContext context, snapshot) {
    //        if (snapshot.hasError) {
    //          return Text('Error: ${snapshot.error}');
    //        }
    //        if (snapshot.connectionState == ConnectionState.waiting) {
    //          return const Center(
    //              child: CircularProgressIndicator()); // or any other loading indicator
    //        }
    //        if(snapshot.hasData){
    //         final List<QueryDocumentSnapshot>newData=snapshot.data!.docs;
    //         final List<PostModel>newList=[];
    //         for(var element in newData){
    //          newList.add(PostModel.fromJson(element.data()as Map<String, dynamic>));
    //         }
    //        return FadeInUp(
    //          animate: true,
    //          from: 200,
    //          child:
    //          PostsList(scaffoldKey: scaffoldKey, posts:newList,cubitContext: context,));
    //        }
    //        else if(state is GetPostsErrorState){
    //          return Text(state.errMessage);
    //        }else{
    //          return const Center(child: CircularProgressIndicator(),);
    //        }
    // } );
   
   
    });}  
}

