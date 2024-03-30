import 'package:agenda_isapre/main_page/main_state.dart';
import 'package:agenda_isapre/model/task_model.dart';
import 'package:agenda_isapre/view/task/task_form_page.dart';
import 'package:agenda_isapre/view_model/task/task_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TaskListView extends StatefulWidget {
  const TaskListView({super.key});

  @override
  State<StatefulWidget> createState() => TaskListViewState();
}

class TaskListViewState extends State<TaskListView> {
  late TaskState taskState;


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => taskState.fetchTask());
  }

  @override
  Widget build(BuildContext context) {
    taskState = Provider.of<MainState>(context).taskState;
    final localizations = AppLocalizations.of(context)!;
    final themeColor = Theme.of(context).colorScheme;

    return Scaffold(
        appBar: AppBar(
          title: Text(
            localizations.allTask,
            style: TextStyle(fontSize: 23.sp),
          ),
        ),
        body: Observer(
            builder: (_) => taskState.loading.value
                ? const LinearProgressIndicator()
                : ListView.builder(
                    itemCount: taskState.tasks.length,
                    itemBuilder: (context, index) {
                      TaskModel taskModel = taskState.tasks[index];
                      return Card(
                          child: Slidable(
                        endActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (_) {
                                taskState.finalizeTask(taskModel);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(localizations.finalizedTaskMsg, style: TextStyle(fontSize: 23.sp)),
                                  ),
                                );
                              },
                              backgroundColor: themeColor.secondaryContainer,//  Colors.greenAccent,
                              foregroundColor: themeColor.onSecondaryContainer,// Colors.white,
                              icon: Icons.check_circle_rounded,
                              label: localizations.finalized,
                            ),
                          ],
                        ),
                        child: ListTile(
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit, color: themeColor.tertiary,),
                                onPressed: () {
                                  taskState.addCurrentTask(taskModel);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              const TaskFormPage()));
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: themeColor.tertiary,),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return alertDelete(context, taskModel);
                                      });
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.done), color: themeColor.tertiary,
                                onPressed: () {
                                  taskState.finalizeTask(taskModel);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(localizations.finalizedTaskMsg, style: TextStyle(fontSize: 23.sp)),
                                  ),
                                );
                                },
                              ),
                            ],
                          ),
                          title: Text(
                            taskModel.titulo,
                            style: TextStyle(fontSize: 18.sp),
                          ),
                          subtitle: Text(
                            taskModel.detalle,
                            style: TextStyle(fontSize: 15.sp),
                          ),
                          onTap: () {
                            // taskState.addCurrentTask(taskModel);
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (_) => TaskFormPage()));
                          },
                        ),
                      ));
                    })));
  }

  AlertDialog alertDelete(context, taskModel) {
    final localizations = AppLocalizations.of(context)!;

    return AlertDialog(
      title: Text(localizations.confirm),
      content: Text(localizations.confirmDelete),
      actions: [
        TextButton(
            onPressed: () {
              taskState.removeTask(taskModel);
              Navigator.pop(context);
            },
            child: Text(localizations.okDelete)),
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(localizations.cancel))
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
