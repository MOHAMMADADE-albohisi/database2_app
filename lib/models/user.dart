class User {
  late int id;
  late String name;
  late String email;
  late String password;

  static const String tableName = 'user';

  User();

  ///Reade row data from database table
  //قراءة بيانات الصف من جدول قاعدة البيانات
  //الاسماء الموجودة داخل اسطر 11و12و13 بين []هي اسماءالاعمدةالموجودة فلجدول
  User.fromMap(Map<String, dynamic> rowMap) {
    id = rowMap['id'];
    name = rowMap['name'];
    email = rowMap['email'];
  }

  ///prepare map to be saved in database
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    //ملاحظة:لا يتم تعريف عمود ال id لانه AUTOINCREMENT
    map['name'] = name;
    map['email']= email;
    map['password'] = password;
    return map;
  }
}
