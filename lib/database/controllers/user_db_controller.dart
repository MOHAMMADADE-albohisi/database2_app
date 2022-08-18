
import 'package:database_app/database/db_controller.dart';
import 'package:database_app/models/process_response.dart';
import 'package:database_app/models/user.dart';
import 'package:database_app/shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class UserDbController {
  //Login ,Regester

  final Database _database = DbController().database;

  Future<processResponse> login(
      {required String email, required String password}) async {
    //SELECT *FROM user WHERE  email =email AND password = password;
    List<Map<String, dynamic>> rowMap = await _database.query(
      User.tableName,
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    if (rowMap.isNotEmpty) {
      User user = User.fromMap(rowMap.first);
      SharedPrefController().save(user: user);
      // return processResponse(message: 'Logged in successfully', success: true);
      return processResponse(message: 'Logged in successfully', success: true);
    }
    return processResponse(
        message: 'Credentials error, checked and try again!');
  }

  Future<processResponse> register({required User user}) async {
    // FIRST: ROW INSERT (SQL)
    // int newRowId = await _database.rawInsert(
    //      'INSERT INFO users (name, email, password) VALUES (?, ?, ?)',
    //      [user.name, user.email, user.password]);
    //**************************************************************
    //SCANNED :INSERT

    if (await _isEmailExist(email: user.email)) {
      int newRowId = await _database.insert(User.tableName, user.toMap());
      return processResponse(
        message: newRowId != 0 ? 'Registered successfully' : 'Registered filde',
        success: newRowId != 0,
      );
    } else {
      return processResponse(
        message: 'Email exist, use another',
        success: false,
      );
    }
  }

  Future<bool> _isEmailExist({required String email}) async {
    //
    List<Map<String, dynamic>> rowMap =
        await _database.rawQuery('SELECT * FROM user WHERE email = ?', [email]);
    return rowMap.isEmpty;
  }
}

/**
 * SQL:
 *  1) Create => INSERT  SQL
 *    =>INSERT INFO tableName (c1, c2, c3) VALUES (v1, v2, v3);
 *
 *  2) READE =>SELECT SQL
 *    =>SELECT * FROM tableName
 *    =>SELECT * FROM tableName WHERE c1 = Value
 *    =>SELECT * FROM tableName WHERE c1 = Value AND c2 Value
 *    =>SELECT * FROM tableName WHERE c1 = Value OR c2 Value
 *
 *  3) UPDATE => UPDATE SQL
 *    =>UPDATE tableName SET c1 = V1
 *    =>UPDATE tableName SET c1 = Value WHERE c2 = v2
 *    =>UPDATE tableName SET c1 = Value , c2 = v2, c3 = v3 WHERE c4 = v4
 *
 *  4)DELETE => DELETE SQL
 *    =>DELETE from tableName
 *    =>DELETE from tableName WHERE c1 = v1
 *
 *----------------------
 *   *)DROP =>TABLE tableName
 *   *)ALTER
 *     1)ADD COLUMN: AFTER TABLE tableName ADD columnName VARCHAR(45) NOT NULL AFTER id;
 *----------------------------
 *    ADD FOREIGN KEY (user_id) reference user(id) on delete cascade
 *    ADD FOREIGN KEY (user_id) reference user(id) on delete cascade null
 *    ADD FOREIGN KEY (user_id) reference user(id) on delete cascade restrict
 *
 *
 *
 * */
