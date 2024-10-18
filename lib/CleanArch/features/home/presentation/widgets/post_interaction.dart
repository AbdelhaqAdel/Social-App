import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newapp/CleanArch/config/theme/colors.dart';
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

  @override
  State<PostInteraction> createState() => _PostInteractionState();
}

class _PostInteractionState extends State<PostInteraction> {
  late bool? isLike=widget.post.isUserLike;
     bool isCommentIconPressed=false;
       double iconSize = 27.0;
   ScrollController scrollController=ScrollController();
  @override
  Widget build(BuildContext context) {
    return  Form(
      key: widget.formKey,
      child: Container(
           height: 65,
            decoration: BoxDecoration(
              border: Border.all(color: AppColor.layoutBackgroundColor.withOpacity(.5),width: 2),
              borderRadius: BorderRadius.circular(30,)
              ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 15,
                  backgroundImage: NetworkImage(
                      '${userModel?.image}'),
                ),
                SizedBox(
                  width: 10.w,
                ),
                SizedBox(
                  height: 26,
                  width: MediaQuery.of(context).size.width*0.5,
                  child: TextFormField(
                        style:  TextStyle(
                          fontSize: 18.sp
                        ),
                        controller: widget.commentController,
                        onTap: (){
                          setState(() {
                            isCommentIconPressed=true;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Write a comment',
                          hintStyle:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    fontSize: 12.sp,
                                    color: Colors.grey[400],
                                  ),
                                     border: InputBorder.none, 
                                 enabledBorder: InputBorder.none, 
                               focusedBorder: InputBorder.none,
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
             isCommentIconPressed
            ? IconButton(
                onPressed: () async{
                  if (widget.formKey.currentState!.validate()) {
                    PostCubit.get(context).addComment(
                        postIndex: widget.index,
                        newComment: widget.commentController.text);
                       await Future.delayed(const Duration(milliseconds:600));
                         setState(() {
                              isCommentIconPressed=false;
                            });
                  }
                },
                icon: const Icon(Icons.send_rounded),
                color: Colors.blue,
              )
            : IconButton(
                onPressed: () {
                  setState(() {
                    isLike = !isLike!;
                  });
                  setState(() {
                    iconSize = 35.0; 
                  });
                  Future.delayed(const Duration(milliseconds: 200), () {
                    setState(() {
                      iconSize = 27.0; 
                    });
                  });
              
                  PostCubit.get(context).addLike(postIndex: widget.index);
                },
                icon: AnimatedSize(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Icon(
                        Icons.favorite_border_outlined,
                        size: iconSize,
                        color: Colors.red,
                      ),
                      Icon(
                        Icons.favorite,
                        size: iconSize,
                        color: isLike! ? Colors.red : Colors.transparent,
                      ),
                    ],
                  ),
                ),
              )
             
              ],
            ),
        ),
      ),
    );
  }
}