import 'dart:ui';

import 'package:dartz/dartz.dart';
import 'package:newapp/CleanArch/core/utils/error_handliing.dart';
import 'package:newapp/CleanArch/features/stories/data/models/status_model.dart';

abstract class StatusRepository {
  Either<Failure,Stream<List<Map<String, dynamic>>>>getAllUsersAddedStatus();
  Either<Failure,Stream<List<StatusModel>>> getUserStatus({required String userId});
  Future<Either<Failure,void>> addUserStatus( {required String statusText,required Color statusColor});


}