import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:newapp/CleanArch/core/utils/Get%20it/auth_locator.dart';
import 'package:newapp/CleanArch/core/utils/app_router.dart';
import 'package:newapp/CleanArch/features/stories/domain/use_cases/add_user_status_use_case.dart';
import 'package:newapp/CleanArch/features/stories/domain/use_cases/get_all_status_use_case.dart';
import 'package:newapp/CleanArch/features/stories/presentation/manager/cubit/story_cubit.dart';
import 'package:newapp/CleanArch/features/stories/presentation/widgets/status_builder.dart';
import 'package:newapp/CleanArch/core/utils/widgets/static_component.dart';
import 'package:newapp/shared/Cubit/cubit/app_cubit.dart';
import 'add_status_screen.dart';

class StatusScreen extends StatelessWidget {
  const StatusScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StatusCubit(getAllStatusUseCase: getIt.get<GetAllStatusUseCase>(), 
      addUserStatusUseCase: getIt.get<AddUserStatusUseCase>())..fetchStatuses(),
      child: BlocConsumer<StatusCubit, StatusState>(
          listener: (context, state) {},
          builder: (context, state) {
            AppCubit cubit = AppCubit.get(context);

            // List<statusModel> status =AppCubit.get(context).convertListQuerySnapshotToList(snapshot.data!);
            // !.docs
            //     .map((doc) => statusModel.fromJson(doc.data()as Map<String,dynamic>))
            //     .toList();
            //print(cubit.convertListQuerySnapshotToList(snapshot.data!)?.toMap().length);
            // else if (snapshot.){
            //   print(snapshot.data);
            //   status?.add(
            //       cubit.convertListQuerySnapshotToList(querySnapshot:snapshot.data!)!);
            //  // snapshot.data?.docs.clear();
            //
            // }
            // snapshot.data = null;
            // status== cubit.allUserAddStatus;
            // FirebaseFirestore.instance.collection('users')
            //    .doc(cubit.userModel?.uId).collection('status').get().then((value) {
            //      print(value.docs);
            //      if(value.docs!=[]){
            //snapshot.data.?docs
            //.map((doc) => statusModel.fromJson(doc.data() as Map<String, dynamic>))
            //       }
            // });
            // status = snapshot.data.docs
            //    .map((doc) => statusModel.fromJson(doc.data() as Map<String, dynamic>))
            //    .toList();
            // if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            //   return Center(child: Text('No status updates available.'));
            // }
            //   cubit.AddUsersStatus();
            // var ss =cubit.convertListQuerySnapshotToList(snapshot.requireData);
            //  String aa= snapshot.data!.docs.
            //      .map((doc) =>
            //          statusModel.fromJson(doc.data() as Map<String, dynamic>))
            //      .toString();
            //  print(aa[]);
            //cubit.AddUsersStatus(statusText:aa);
            // print(aa[0].postText);

            return Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                title: Text(
                  'Status',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: Colors.grey),
                ),
              ),
              body: Container(
                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              cubit.pickStatusImage = null;
                              NavigateTo(context, AddStatusScreen());
                            },
                            child: Row(children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundImage:
                                    NetworkImage('${cubit.userModel?.image}'),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                'Add to your story',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(height: 1.5.h),
                              ),
                            ]),
                          ),
                          const Spacer(),
                          IconButton(
                              onPressed: () {
                                cubit.anotherGetStatus(cubit.userModel!.uId);
                               AppRouter.cubitContext=context;
                               GoRouter.of(context).push(AppRouter.kWriteStatus,);},
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.white,
                              )),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: 1,
                        color: Colors.grey[300],
                        width: double.infinity,
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Text(
                        'Recent updates',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontSize: 20.sp),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      const Expanded(child: StatusBuilder()),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
