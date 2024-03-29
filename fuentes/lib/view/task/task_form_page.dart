import 'package:agenda_isapre/main_page/main_state.dart';
import 'package:agenda_isapre/model/task_model.dart';
import 'package:agenda_isapre/view_model/task/task_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class TaskFormPage extends StatefulWidget {
  const TaskFormPage({super.key});

  @override
  State<StatefulWidget> createState() => TaskFormPageState();
}

class TaskFormPageState extends State<TaskFormPage> {
  GlobalKey<FormState> keyForm = GlobalKey();
  TextEditingController titleCtrl = TextEditingController();
  TextEditingController bodyCtrl = TextEditingController();
  late TaskState taskState;

  showText() {
    if (taskState.currentTask.value != null) {
      titleCtrl.text = taskState.currentTask.value!.titulo;
      bodyCtrl.text = taskState.currentTask.value!.detalle;
    }
  }

  @override
  Widget build(BuildContext context) {    
    TextTheme textTheme = Theme.of(context).textTheme;
    taskState = Provider.of<MainState>(context).taskState;
    final localizations = AppLocalizations.of(context)!;

    showText();
    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.addTask),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Form(
            key: keyForm,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  localizations.title,
                  style: textTheme.titleLarge,
                ),
                TextFormField(
                  controller: titleCtrl,
                  style: textTheme.bodyLarge,
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  localizations.detail,
                  style: textTheme.titleLarge,
                ),
                TextFormField(
                  controller: bodyCtrl,
                  style: textTheme.bodyLarge,
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                    width: double.infinity,
                    child: (taskState.hasCurrentTask)
                        ? Row(
                            children: [
                              ElevatedButton(
                                onPressed: () => save(),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.lightGreen,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5))),
                                child: Text(localizations.save),
                              ),
                              const SizedBox(width: 15,),
                              ElevatedButton(
                                onPressed: () => Navigator.pop(context),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.lightGreen,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5))),
                                child: Text(localizations.cancel),
                              ),
                            ],
                          )
                        : ElevatedButton(
                            onPressed: () => save(),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.lightGreen,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5))),
                            child: Text(localizations.save),
                          ))
              ],
            )),
      ),
    );
  }

  save() async {
    if (keyForm.currentState!.validate()) {
      TaskModel taskModel = (taskState.hasCurrentTask)
          ? taskState.currentTask.value!
          : TaskModel();
      taskModel.titulo = titleCtrl.text;
      taskModel.detalle = bodyCtrl.text;
      (taskState.hasCurrentTask)
          ? taskState.updateTask(taskModel)
          : taskState.createTask(taskModel);
      taskState.addCurrentTask(null);
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    super.dispose();
    taskState.addCurrentTask(null);
  }
}
