class ReportModel {
  int? id;
  int? typeId;
  String? type;
  String? docs;

  ReportModel({
    this.typeId,
    this.id,
    this.type,
    this.docs,
  });

  ReportModel.fromJson(Map<String, dynamic> json) {
    typeId = json['type_id'];
    id = json['id'];
    type = json['type'];
    docs = json['docs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data['id'] = id;
    data['type_id'] = typeId;
    data['type'] = type;
    data['docs'] = docs;
    return data;
  }
}
