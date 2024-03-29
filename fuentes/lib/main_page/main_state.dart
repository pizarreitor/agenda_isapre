import 'package:agenda_isapre/view_model/task/task_state.dart';
import 'package:mobx/mobx.dart';

part 'main_state.g.dart';

class MainState = _MainStateBase with _$MainState;

abstract class _MainStateBase with Store {
  late TaskState taskState;
  _MainStateBase(){
    taskState = TaskState(main:  this as MainState);
  }
}