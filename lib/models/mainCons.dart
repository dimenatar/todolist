import 'lab3.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main(List<String> arguments) async{
  //await Lab2.proceed();
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  Lab3.proceed();
  print("123");
}
 