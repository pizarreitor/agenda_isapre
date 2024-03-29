import 'dart:io';

import 'package:agenda_isapre/data/network/api.dart';
import 'package:agenda_isapre/locator.dart';
import 'package:agenda_isapre/model/task_model.dart';
import 'package:device_info_plus/device_info_plus.dart';

abstract class TaskRepo{
  Future<List<TaskModel>> fetchTask();
  Future<TaskModel> createTask(Map body);
  Future<TaskModel> updateTask(int id,Map body);
  Future<bool> deleteTask(int id);
  Future<bool> finalizeTask(int id);
  Future<List<TaskModel>> fetchFinalicedTask();
}

class TaskRepoImpl extends TaskRepo{
  final Api _api = sl<Api>();
  
  @override
  Future<List<TaskModel>> fetchTask() async{
    final String _idUsuario = await _getId();
    var jsonResponse = await _api.get("/agenda/ConsultaTarea/$_idUsuario");
    return (jsonResponse as List).map((map) => TaskModel.toObject(map)).toList();
  }

  @override
  Future<TaskModel> createTask(Map body)async {
    final String _idUsuario = await _getId();
    body["idUsuario"] = _idUsuario;
    var jsonResponse = await _api.post("/agenda/CrearTarea/", body);
    return TaskModel.toObject(jsonResponse);
  }
  @override
  Future<TaskModel> updateTask(int id,Map body) async{
    var jsonResponse = await _api.put("/agenda/ModificarTarea/$id", body);
    return TaskModel.toObject(jsonResponse);
  }
  @override
  Future<bool> deleteTask(int id) async{    
    var jsonResponse = await _api.get("/agenda/EliminarTarea/$id");
    return jsonResponse.isEmpty;
  }
  @override
  Future<bool> finalizeTask(int id) async{
    //print("finalizeTask ${id}");
    var jsonResponse = await _api.get("/agenda/MarcarTerminada/$id");
    return jsonResponse.isEmpty;
  }
  @override
  Future<List<TaskModel>> fetchFinalicedTask() async{
    final String _idUsuario = await _getId();
    var jsonResponse = await _api.get("/agenda/ConsultaTareaTerminada/$_idUsuario");
    return (jsonResponse as List).map((map) => TaskModel.toObject(map)).toList();
  }




  Future<String> _getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor ?? ""; // unique ID on iOS
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.androidId ?? ""; // unique ID on Android
    }
    return "";
  }

}