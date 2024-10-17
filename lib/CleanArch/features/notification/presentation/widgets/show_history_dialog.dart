
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newapp/CleanArch/core/cubit/app_cubit.dart';

class ShowDialogFun {
  static Future<void> call({
    required BuildContext context,
    required Widget dialogWidget,
  }) async {
     showDialog<String>(
              context: context,
              barrierColor: Colors.black.withOpacity(.3),
              useSafeArea: true,
              builder: (BuildContext context) => BlocProvider(
                create: (context) => AppCubit(),
                child:   BlocConsumer<AppCubit,AppState>(
                     listener: (context, state) {},
                     builder: (context, state) {
                       return AlertDialog(
                  insetPadding: const EdgeInsets.all(0.0),
                  scrollable: false,
                  shadowColor: Colors.transparent,
                  content: Center(
                    child:dialogWidget
                      ),
                  elevation: 0,
                  clipBehavior: Clip.none,
                  surfaceTintColor: Colors.transparent,
                  backgroundColor: Colors.transparent,
                  contentPadding: EdgeInsets.zero,
                );
           })),
            );
  }}