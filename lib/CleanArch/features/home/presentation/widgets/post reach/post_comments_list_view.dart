import 'package:flutter/material.dart';
import 'package:newapp/CleanArch/features/home/presentation/widgets/post%20reach/comment_widget.dart';

class CommentsList extends StatelessWidget {
  const CommentsList({super.key,required this.comments});
  final List<Map<String,dynamic>>comments;

  @override
  Widget build(BuildContext context) {
    return  ListView.builder(
      physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) =>
            CommentWidget(index: index,comment: comments,),
        itemCount:comments.length);
  }
}