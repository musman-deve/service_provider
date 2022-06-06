class ServiceSubCategoriesModel {
  List<SubServices> subServices;

  ServiceSubCategoriesModel({this.subServices});

  ServiceSubCategoriesModel.fromJson(Map<String, dynamic> json) {
    if (json['sub_services'] != null) {
      subServices = <SubServices>[];
      json['sub_services'].forEach((v) {
        subServices.add(new SubServices.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.subServices != null) {
      data['sub_services'] = this.subServices.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubServices {
  int id;
  String name;

  SubServices({this.id, this.name});

  SubServices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
