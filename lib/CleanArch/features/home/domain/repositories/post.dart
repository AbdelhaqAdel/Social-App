import 'package:dartz/dartz.dart';
import 'package:newapp/CleanArch/core/utils/error_handliing.dart';
import 'package:newapp/CleanArch/features/home/data/models/post_model.dart';

abstract class PostRepo {
 Either<Failure,Stream<List<PostModel>>> getAllPosts();
}