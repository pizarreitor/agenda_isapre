// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TaskState on _TaskStateBase, Store {
  Computed<bool>? _$hasCurrentTaskComputed;

  @override
  bool get hasCurrentTask =>
      (_$hasCurrentTaskComputed ??= Computed<bool>(() => super.hasCurrentTask,
              name: '_TaskStateBase.hasCurrentTask'))
          .value;

  late final _$loadingAtom =
      Atom(name: '_TaskStateBase.loading', context: context);

  @override
  Observable<bool> get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(Observable<bool> value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  late final _$tasksAtom = Atom(name: '_TaskStateBase.tasks', context: context);

  @override
  ObservableList<TaskModel> get tasks {
    _$tasksAtom.reportRead();
    return super.tasks;
  }

  @override
  set tasks(ObservableList<TaskModel> value) {
    _$tasksAtom.reportWrite(value, super.tasks, () {
      super.tasks = value;
    });
  }

  late final _$currentTaskAtom =
      Atom(name: '_TaskStateBase.currentTask', context: context);

  @override
  Observable<TaskModel?> get currentTask {
    _$currentTaskAtom.reportRead();
    return super.currentTask;
  }

  @override
  set currentTask(Observable<TaskModel?> value) {
    _$currentTaskAtom.reportWrite(value, super.currentTask, () {
      super.currentTask = value;
    });
  }

  late final _$fetchTaskAsyncAction =
      AsyncAction('_TaskStateBase.fetchTask', context: context);

  @override
  Future<dynamic> fetchTask() {
    return _$fetchTaskAsyncAction.run(() => super.fetchTask());
  }

  late final _$createTaskAsyncAction =
      AsyncAction('_TaskStateBase.createTask', context: context);

  @override
  Future<dynamic> createTask(TaskModel taskModel) {
    return _$createTaskAsyncAction.run(() => super.createTask(taskModel));
  }

  late final _$updateTaskAsyncAction =
      AsyncAction('_TaskStateBase.updateTask', context: context);

  @override
  Future<dynamic> updateTask(TaskModel taskModel) {
    return _$updateTaskAsyncAction.run(() => super.updateTask(taskModel));
  }

  late final _$removeTaskAsyncAction =
      AsyncAction('_TaskStateBase.removeTask', context: context);

  @override
  Future removeTask(TaskModel taskModel) {
    return _$removeTaskAsyncAction.run(() => super.removeTask(taskModel));
  }

  late final _$finalizeTaskAsyncAction =
      AsyncAction('_TaskStateBase.finalizeTask', context: context);

  @override
  Future finalizeTask(TaskModel taskModel) {
    return _$finalizeTaskAsyncAction.run(() => super.finalizeTask(taskModel));
  }

  late final _$fetchFInalicedTaskAsyncAction =
      AsyncAction('_TaskStateBase.fetchFInalicedTask', context: context);

  @override
  Future<dynamic> fetchFinalicedTask() {
    return _$fetchFInalicedTaskAsyncAction
        .run(() => super.fetchFinalicedTask());
  }

  late final _$_TaskStateBaseActionController =
      ActionController(name: '_TaskStateBase', context: context);

  @override
  dynamic addCurrentTask(dynamic taskModel) {
    final _$actionInfo = _$_TaskStateBaseActionController.startAction(
        name: '_TaskStateBase.addCurrentTask');
    try {
      return super.addCurrentTask(taskModel);
    } finally {
      _$_TaskStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
loading: ${loading},
tasks: ${tasks},
currentTask: ${currentTask},
hasCurrentTask: ${hasCurrentTask}
    ''';
  }
}
