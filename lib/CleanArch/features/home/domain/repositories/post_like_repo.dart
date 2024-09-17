abstract class PosLikeRepo {
Future<void>addLike(String postId);

Future<List<Map<String,dynamic>>>getLikedUsers({required String postId});
}