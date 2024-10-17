import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newapp/CleanArch/core/cubit/app_cubit.dart';
import 'package:newapp/CleanArch/features/notification/data/NotificationModelAndAdabpter/notify_model.dart';
import 'package:newapp/CleanArch/features/notification/presentation/widgets/history_card.dart';

class RecentActivityList extends StatefulWidget {
  final BuildContext cubitContext;

  const RecentActivityList({super.key, required this.cubitContext});

  @override
  _RecentActivityListState createState() => _RecentActivityListState();
}

class _RecentActivityListState extends State<RecentActivityList> {
  late List<NotifyModel> activities;

  final List<IconData> recent = [
    FontAwesomeIcons.penClip,
    FontAwesomeIcons.bookBookmark,
    FontAwesomeIcons.featherPointed,
    FontAwesomeIcons.book,
    FontAwesomeIcons.bookBookmark,
    FontAwesomeIcons.penClip,
    FontAwesomeIcons.featherPointed,
    FontAwesomeIcons.book,
  ];

  @override
  void initState() {
    super.initState();
        AppCubit.get(widget.cubitContext).getNotifyData();
  }

  void removeItem({required int index}) {
    setState(() {
     activities.removeAt(index);
        AppCubit.get(widget.cubitContext).deleteNotify(
          hisIndex:index,
          context:context,
        );
       
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
      condition: activities.isNotEmpty,
      builder: (context) => Expanded(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 40,
            left: 15,
            bottom: 0,
            right: 15,
          ),
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return NotifyCard(
                icon: recent[index < recent.length ? index : 0],
                history: activities[index],
                index: index,
                // Pass the removeItem method correctly
                onDismissed: (d) => removeItem(index: index),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 15),
            itemCount: activities.length,
          ),
        ),
      ),
      fallback: (context) => const SizedBox(),
    );
  }
}
