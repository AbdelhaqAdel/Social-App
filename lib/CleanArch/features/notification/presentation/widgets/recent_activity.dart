import 'package:flutter/material.dart';
import 'package:newapp/CleanArch/config/theme/colors.dart';
import 'package:newapp/CleanArch/core/utils/widgets/glass_box.dart';
import 'package:newapp/CleanArch/features/notification/presentation/widgets/recent_activity_list_builder.dart';
class RecentActivityDialog extends StatelessWidget {
  final BuildContext cubitContext;

  const RecentActivityDialog({super.key, required this.cubitContext});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: GlassBox(
          widget: RecentActivityContent(cubitContext: cubitContext),
          color: Colors.transparent,
          borderRadius: 0,
          x: 50,
          y: 50,
          border: false,
        ),
      ),
    );
  }
}


class RecentActivityContent extends StatelessWidget {
  final BuildContext cubitContext;

  const RecentActivityContent({super.key, required this.cubitContext});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            const SizedBox(height:60),
            const Center(child: RecentActivityHeader()),
            RecentActivityList(cubitContext: cubitContext),
          ],
        ),
      ],
    );
  }
}

class RecentActivityHeader extends StatelessWidget {
  const RecentActivityHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Recent Activity',
      style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.w900,
        color:AppColor.whiteColor,
      ),
    );
  }
}