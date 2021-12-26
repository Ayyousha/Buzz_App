
import 'package:buzz_app/shared/bloc/shared_state.dart';
import 'package:buzz_app/shared/network/local/cach_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SharedCubit extends ChangeNotifier {



  bool isDark = false;

  void changeThemeMode({bool? sharedType})
  {
    if(sharedType != null)
    {
     isDark = sharedType ;
     notifyListeners();
    } else
      {
        isDark = !isDark;
        print(isDark);
        CacheHelper.saveData(key: 'isDark', value: isDark).then((value)
        {
          notifyListeners();
        });
      }
  }

}