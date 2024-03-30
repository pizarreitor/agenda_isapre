import 'package:agenda_isapre/main_page/main_state.dart';
import 'package:agenda_isapre/model/task_model.dart';
import 'package:agenda_isapre/view_model/task/task_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class TaskFinalicedListView extends StatefulWidget {
  const TaskFinalicedListView({super.key});

  @override
  State<StatefulWidget> createState() => TaskFinalicedListViewState();
}

class TaskFinalicedListViewState extends State<TaskFinalicedListView> {
  late TaskState taskFinalicedState;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => taskFinalicedState.fetchFinalicedTask());
  }

  @override
  Widget build(BuildContext context) {    
    final localizations = AppLocalizations.of(context)!;    
    taskFinalicedState = Provider.of<MainState>(context).taskState;

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.taskFinalized, style: TextStyle(fontSize: 23.sp),),
      ),
      body: Observer(
        builder: (_) => taskFinalicedState.loading.value
            ? const LinearProgressIndicator()
            : ListView.builder(
                itemCount: taskFinalicedState.tasksFinaliced.length,
                itemBuilder: (context, index) 
                {
                  TaskModel taskFinalicedModel = taskFinalicedState.tasksFinaliced[index];
                  return Card(
                    child: ListTile(
                      title: Text(taskFinalicedModel.titulo, style: TextStyle(fontSize: 18.sp),),
                      subtitle: Text(taskFinalicedModel.detalle, style: TextStyle(fontSize: 15.sp),),
                    ),
                  );
                },
                ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
