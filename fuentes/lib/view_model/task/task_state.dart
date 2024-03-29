import 'package:agenda_isapre/main_page/main_state.dart';
import 'package:agenda_isapre/model/task_model.dart';
import 'package:agenda_isapre/repository/task_repo.dart';
import 'package:mobx/mobx.dart';
import '../../../locator.dart';
part 'task_state.g.dart';

class TaskState = _TaskStateBase with _$TaskState;

abstract class _TaskStateBase with Store {
  late MainState main;

  _TaskStateBase({required this.main});

  final TaskRepoImpl _postRepoImpl= sl<TaskRepoImpl>();

  @observable
  Observable<bool>loading = Observable(false);

  @observable
  ObservableList<TaskModel> tasks = ObservableList<TaskModel>();
  @observable
  ObservableList<TaskModel> tasksFinaliced = ObservableList<TaskModel>();

  @observable
  Observable<TaskModel?> currentTask= Observable(null);

  @action
  Future fetchTask() async {
    loading.value = true;
    tasks.clear();
    tasks.addAll(await _postRepoImpl.fetchTask().asObservable());
    loading.value = false;
  }

  @action
  Future createTask(TaskModel taskModel)async{
    TaskModel task = await _postRepoImpl.createTask(taskModel.toMap());
    tasks.add(task);
  }

  @action
  Future updateTask(TaskModel taskModel)async{
    TaskModel post = await _postRepoImpl.updateTask(taskModel.idTarea,taskModel.toMap());
    tasks[tasks.indexWhere((element) => element.idTarea == post.idTarea)] = post;
  }

  @action
  removeTask(TaskModel taskModel)async{
    await _postRepoImpl.deleteTask(taskModel.idTarea);
    tasks.removeWhere((element) => element ==taskModel);
  }

  @action
  finalizeTask(TaskModel taskModel)async{
    await _postRepoImpl.finalizeTask(taskModel.idTarea);
    taskModel.titulo += " (S)";
    tasks[tasks.indexWhere((element) => element.idTarea == taskModel.idTarea)] = taskModel;    
    //tasks.removeWhere((element) => element ==taskModel);
  }

  @action
  Future fetchFinalicedTask() async {
    loading.value = true;
    tasksFinaliced.clear();
    tasksFinaliced.addAll(await _postRepoImpl.fetchFinalicedTask().asObservable());
    loading.value = false;
  }

  @action
  addCurrentTask(taskModel){
    currentTask.value= taskModel;
  }

  @computed
  bool get hasCurrentTask => currentTask.value!=null;

}