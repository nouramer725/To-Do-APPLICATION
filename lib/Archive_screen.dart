import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_application/shared/components.dart';
import 'package:todo_application/shared/cubit/cubit.dart';
import 'package:todo_application/shared/cubit/states.dart';

class ArchivedScreen extends StatelessWidget {
  const ArchivedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<APPCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks = APPCubit.get(context).tasks
            .where((task) => task['status'] == 'archived')
            .toList();

        return ListView.separated(
          itemBuilder: (context, index) => buildTaskItem(context, tasks[index]),
          separatorBuilder: (context, index) => Container(
            width: double.infinity,
            height: 2,
            color: Colors.grey[300],
          ),
          itemCount: tasks.length,
        );
      },
    );
  }
}
