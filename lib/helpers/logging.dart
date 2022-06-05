
import 'package:flutter/foundation.dart';

print_debug(String printString){
  if(kDebugMode){
    print(printString);
  }
}