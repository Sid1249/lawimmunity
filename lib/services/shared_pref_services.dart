import 'package:get_it/get_it.dart';
import 'package:lawimmunity/helpers/shared_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefServices{

  GetIt getIt = GetIt.instance;
  late SharedPreferences _keyValueStore;


  SharedPrefServices(){
    _keyValueStore = getIt<SharedPreferences>();
  }

  getUserName(){
    return _keyValueStore.getString(SharedKeys.userNameKey);
  }

  setUserName(String userName){
    return _keyValueStore.setString(SharedKeys.userNameKey,userName);
  }


}