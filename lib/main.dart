import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/DataScreen.dart';
import 'package:project/EditScreen.dart';
import 'package:project/First.dart';
import 'package:project/HomeScreen.dart';
import 'package:flutter/services.dart';
void main()
{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
   runApp(
     MaterialApp(
       debugShowCheckedModeBanner: false,
       initialRoute: '/',
       routes: {
         '/' : (context) => FirstScreen(),
         'Home' : (context) => HomeScreen(),
         'Data' : (context) => DataScreen(),
         'Edit' : (context) => EditScreen(),
       },
     )
   );
}