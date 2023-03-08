import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/shopapp/models/shop_models.dart';
import 'package:shop/shopapp/pages/login/cubit/sLogin%20states.dart';
import 'package:shop/shopapp/remote/endpoints.dart';

import '../../../Dio/DioHelper.dart';


class logincubit extends Cubit<Loginstate> {
  logincubit() : super(Loginintailstate());


  static logincubit get(context) => BlocProvider.of(context);


  bool ispassword = true;
  IconData suffix = Icons.visibility_off_outlined;

  void changepassword() {
    ispassword = !ispassword;

    suffix =
        ispassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;

    emit(loginchangepassword());
  }

  void userlogin({
    required String email,
    required String pass,
  }) {
    emit(Loginrelodstate());
    Diohelper.postdata(url: Login, data: {
      'email': email,
      'password': pass,
    }).then((value) {
      shopmodel shoplogins = shopmodel.fromJson(value.data);

      emit(Loginrunstate(shoplogins));
    }).catchError((error) {
      emit(Loginerrorlstate(error.toString()));
    });
  }
}
