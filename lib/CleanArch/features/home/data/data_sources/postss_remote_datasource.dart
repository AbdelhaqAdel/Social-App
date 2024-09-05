import 'package:newapp/CleanArch/features/home/data/models/post_model.dart';


abstract class PostRmoteDataSourse{
  Future <List<PostModel>>fetchPostss();
}
class PostRemoteDatasourceImpl extends PostRmoteDataSourse{
  List<PostModel>coursesList=[];
  @override
  Future<List<PostModel>> fetchPostss()async {
    // TODO: implement fetchPostss
    throw UnimplementedError();

// //      await  DioHelper.get(
// //         url: EndPoint.allCourses,
// //         token: 'eyJhbGciOiJodHRwOi8vd3d3LnczLm9yZy8yMDAxLzA0L3htbGRzaWctbW9yZSNobWFjLXNoYTI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9naXZlbm5hbWUiOiJhYmR1bG1hamVlZHNhbGxhbSIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL2VtYWlsYWRkcmVzcyI6IkFiZHVsTWFqZWVkU2FsbGFtQGdtYWlsLmNvbSIsImh0dHA6Ly9zY2hlbWFzLm1pY3Jvc29mdC5jb20vd3MvMjAwOC8wNi9pZGVudGl0eS9jbGFpbXMvcm9sZSI6IlN0dWRlbnQiLCJleHAiOjE3MjU2NTMzMzEsImlzcyI6Imh0dHBzOi8vbG9jYWxob3N0OjcyODYiLCJhdWQiOiJNeVNlY3VyZWRBcGlVc2VycyJ9.wWU3aYuyclcRU_lJM9GF54fndMSATcQdp4KfBrsk_NQ',
// //       ).then((value) {
// //        fillCoursesList(value);
// //   });
// //     HiveService.saveDataToHive<CoursesModel>(HiveConstants.coursesBox,coursesList, HiveConstants.coursesBox);
// //    return coursesList;
// // }
// //  void fillCoursesList(Response<dynamic> list) {
// //      for (var element in list.data) {
// //      coursesList.add(CoursesModel.fromJson(element));
// //     }
// //   }
}
}