import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> putData({required String key,required dynamic value}) async {
    if (value is bool)return await sharedPreferences.setBool(key, value);
    if (value is String)return await sharedPreferences.setString(key, value);
    if (value is int)return await sharedPreferences.setInt(key, value);
    return await sharedPreferences.setDouble(key, value);
  }

  static Future<bool> putDataInList({required String key,required dynamic value, bool unique = false}) async {
    List<String> list = CacheHelper.getData(key) ?? [];
    if(unique){
      if(!list.contains(value)) {
        list.add(value);
      } else {
        return false;
      }
    } else {
      list.add(value);
    }
    return await sharedPreferences.setStringList(key, list);
  }

  static dynamic getData(String key)  {

    return  sharedPreferences.get(key);

  }

  static Future<bool> removeData({required String key})
  async
  {
    return await sharedPreferences.remove(key);
  }


}
