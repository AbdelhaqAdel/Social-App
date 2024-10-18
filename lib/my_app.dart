
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newapp/CleanArch/core/cubit/app_cubit.dart';
import 'package:newapp/CleanArch/core/utils/app_router.dart';
import 'package:newapp/CleanArch/config/theme/themes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.startWidget});
  final Widget startWidget;
  @override
  Widget build(BuildContext context){
    return  BlocProvider(create: (BuildContext context)=>AppCubit(),
      child: BlocConsumer<AppCubit,AppState>(
        listener:(context,state){} ,
        builder: (context,state){
          return  ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_ , child) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'My App',
            theme: lightTheme,
            themeMode: ThemeMode.light,
            routerConfig: AppRouter.router,
          );});
        },
      ),
    );


  }
}

