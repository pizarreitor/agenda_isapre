class TaskModel {
  int idTarea;
  String titulo;
  String detalle;
  String idUsuario;
  String terminada;

  TaskModel(
      {this.idTarea = 0,
      this.titulo = "",
      this.detalle = "",
      this.idUsuario = "",
      this.terminada = "N"});

  factory TaskModel.toObject(Map<String, dynamic> json) {
    return TaskModel(
        idTarea: int.parse(json["idTarea"].toString()),
        titulo: json["titulo"],
        detalle: json["detalle"],
        idUsuario: json["idUsuario"] ?? "",
        terminada: json["terminada"] ?? "N");
  }

  Map<String, dynamic> toMap() => {
        "idTarea": (idTarea > 0) ? idTarea.toString() : "",
        "titulo": titulo,
        "detalle": detalle,
        "idUsuario": idUsuario,
        "terminada": terminada
      };
}
