
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shop/shopapp/models/shop_models.dart';
import 'package:shop/shopapp/pages/singup/state.dart';

import '../../Dio/DioHelper.dart';
import '../../remote/endpoints.dart';

class registercubit extends Cubit<Registerstate> {
  registercubit() : super(registerintailstate());

  static registercubit get(context) => BlocProvider.of(context);

  bool ispassword = true;
  IconData suffix = Icons.visibility_off_outlined;

  void changepassword() {
    ispassword = !ispassword;

    suffix =
    ispassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;

    emit(loginregisterchangepassword());
  }

  void userregister({
    required String name,
    required String email,
    required String pass,
    required String phone,
  }) {
    emit(registerrelodstate());
  }
}