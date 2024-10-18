import 'package:dartz/dartz.dart';
import 'package:newapp/CleanArch/core/utils/error_handliing.dart';

abstract class PostCommentRepo {
 Future<Either<Failure,void>>addComment(String postId,String newComment);
   Future<List<Map<String, dynamic>>> getPostComments({required String postId});

}