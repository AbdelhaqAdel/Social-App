import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newapp/CleanArch/core/utils/key_constants.dart';
import 'package:newapp/CleanArch/features/home/data/models/post_model.dart';
import 'package:newapp/CleanArch/features/home/presentation/manager/cubit/post_cubit.dart';
class PostInteraction extends StatefulWidget {
   PostInteraction({super.key,
    required this.commentController,
    required this.index,
    required this.post,
  });
   final TextEditingController commentController;
   final int index;
   final PostModel post;
   final GlobalKey<FormState> formKey=GlobalKey<FormState>();
   bool isCommentIconPressed=false;
   ScrollController scrollController=ScrollController();
  @override
  State<PostInteraction> createState() => _PostInteractionState();
}

class _PostInteractionState extends State<PostInteraction> {
  @override
  Widget build(BuildContext context) {
    return  Form(
      key: widget.formKey,
      child: Row(
          children: [
            CircleAvatar(
              radius: 10,
              backgroundImage: NetworkImage(
                  '${userModel?.image
                    // userImage==''?AppCubit.get(context).userModel?.image:userImage
                    }'),
            ),
            SizedBox(
              width: 10.w,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width*0.5,
              child: TextFormField(
                    style:  TextStyle(
                      fontSize: 18.sp
                    ),
                    controller: widget.commentController,
                    onTap: (){
                      setState(() {
                        widget.isCommentIconPressed=true;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Write a comment',
                      hintStyle:
                          Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontSize: 12.sp,
                                color: Colors.grey[400],
                              ),
                    ),
                    onFieldSubmitted: (value) {
                      if (value.isNotEmpty) {
                         PostCubit.get(context).addComment(postIndex:widget.index,
                        newComment:widget.commentController.text);
                        widget.commentController.clear();
                      }
                    },
                    validator: (value) {
                      if(value!.isEmpty){
                  return 'please enter your password';
                }return null;}
                  ),
            ),
            const Spacer(),
               widget.isCommentIconPressed
                  ?IconButton(onPressed: (){
                    if(widget.formKey.currentState!.validate()){
                     PostCubit.get(context).addComment(postIndex:widget.index,
                        newComment:widget.commentController.text);}
                  },
                   icon:  const Icon(Icons.send_outlined),color: Colors.blue,) 
                   :IconButton(
                onPressed: () {
                  PostCubit.get(context)
                      .addLike(postIndex: widget.index);
                },
                icon:  
                
                Stack(
                  children:[ const Icon(Icons.favorite_border_outlined,
                      size: 27,
                      color:Colors.red,
                      ),
                      Icon(Icons.favorite,
                      size: 27,
                      color://PostCubit.get(context).allPostsList[widget.index].isUserLike==true
                      widget.post.isUserLike==true
                      ?Colors.red:Colors.transparent,
                      ),
                      ]
                )),
          ],
        ),
    );
  }
}