import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
  import 'package:shop/shopapp/Dio/DioHelper.dart';

import 'package:shop/shopapp/Homelayout/Appcubit.dart';
import 'package:shop/shopapp/Homelayout/Homescreen.dart';
import 'package:shop/shopapp/component/component.dart';
import 'package:shop/shopapp/pages/login/lOGINsCREEN.dart';
import 'package:shop/shopapp/pages/onboarding/Onboard__screen.dart';
import 'package:shop/shopapp/shared_perfernce/cach.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  Diohelper.init();
  await CacheHelper.init();

  Widget widget;
  bool ?onboarding = await CacheHelper.getData(key: 'ONBOARD');
  token = await CacheHelper.getData(key: 'token');
  print(token);
  if(onboarding != null){
    if(token !=null){
      widget = homelayout();
    }else { widget = LOGIN();}
  }else {
   widget= ONBOARD();
  }

  runApp(myapp(
    startwidget: widget,
  ));
}

class myapp extends StatelessWidget {
  final Widget startwidget;

  myapp({required this.startwidget});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=> Appcubit()..getdatahome()..getcatigories()..Getfav()..Getuserdata(),
      child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(primarySwatch: Colors.green,bottomNavigationBarTheme: BottomNavigationBarThemeData(
              selectedItemColor: Colors.green,
              unselectedItemColor: Colors.grey,
                backgroundColor: Colors.white,
              unselectedIconTheme: IconThemeData(color: Colors.grey)
            )),
            home: startwidget),
    );
  }
}
