class User {
  List<EBOOKAPP> eBOOKAPP;

  User({this.eBOOKAPP});

  User.fromJson(Map<String, dynamic> json) {
    if (json['EBOOK_APP'] != null) {
      eBOOKAPP = new List<EBOOKAPP>();
      json['EBOOK_APP'].forEach((v) {
        eBOOKAPP.add(new EBOOKAPP.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.eBOOKAPP != null) {
      data['EBOOK_APP'] = this.eBOOKAPP.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EBOOKAPP {
  String userId;
  String name;
  String success;
  String msg;

  EBOOKAPP({this.userId, this.name, this.success});

  EBOOKAPP.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    name = json['name'];
    success = json['success'];
    msg =json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['success'] = this.success;
    data['msg'] = this.msg;
    return data;
  }
}