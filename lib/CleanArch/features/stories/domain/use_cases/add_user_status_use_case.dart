import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:newapp/CleanArch/core/utils/error_handliing.dart';
import 'package:newapp/CleanArch/features/stories/domain/repositories/status_repo.dart';

class AddUserStatusUseCase {
  final StatusRepository repository;

  AddUserStatusUseCase(this.repository);

  Future<Either<Failure,void>> call({required String text,required Color statusColor}) {
    return repository.addUserStatus(statusText:text,statusColor: statusColor);
  }
}
