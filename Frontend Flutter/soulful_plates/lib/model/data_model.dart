/// id : ""
/// name : ""

class DataModel {
  DataModel({
    String? id,
    String? name,
  }) {
    _id = id;
    _name = name;
  }

  DataModel.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
  }
  String? _id;
  String? _name;
  DataModel copyWith({
    String? id,
    String? name,
  }) =>
      DataModel(
        id: id ?? _id,
        name: name ?? _name,
      );
  String? get id => _id;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    return map;
  }

  static List<DataModel> fromJsonArray(List<dynamic> contactList) {
    List<DataModel> list =
        contactList.map<DataModel>((a) => DataModel.fromJson(a)).toList();
    return list;
  }
}
