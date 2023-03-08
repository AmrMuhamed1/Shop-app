import 'dart:convert';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shop/shopapp/Homelayout/Appcubit.dart';
import 'package:shop/shopapp/pages/login/cubit/logincubit.dart';
import 'package:shop/shopapp/pages/singup/SignupScreen.dart';
import 'package:sizer/sizer.dart';

import '../../Homelayout/Homescreen.dart';
import '../../component/component.dart';
import '../../shared_perfernce/cach.dart';
import 'cubit/sLogin states.dart';

class LOGIN extends StatelessWidget {
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var EmailContoller = TextEditingController();
    var passController = TextEditingController();
    return BlocProvider(
      create: (BuildContext context) => logincubit(),
      child: BlocConsumer<logincubit, Loginstate>(
        listener: (context, state) {
          if (state is Loginrunstate) {
            if (state.shoplogins.status!) {
              CacheHelper.setData(
                      key: 'token', value: state.shoplogins.data!.token)
                  .then((value) {
                token = state.shoplogins.data!.token!;
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => homelayout()),
                    (route) => false);
                Appcubit.get(context).currentindex = 0;
                Appcubit.get(context).Getuserdata();
              });
            } else {
              showtoast(
                  text: state.shoplogins.message!, state: toastcolors.error);
            }
          }
        },
        builder: (context, state) {
          return Sizer(builder: (context, orientation, devicetype) {
            return Scaffold(
                body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'login now to browse our offers',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.grey),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        defaultForm(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your email';
                              }
                            },
                            controller: EmailContoller,
                            type: TextInputType.emailAddress,
                            prefix: Icons.email),
                        SizedBox(
                          height: 30,
                        ),
                        defaultForm(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Pass is to short';
                              }
                            },
                            onSubmit: (value) {
                              if (formkey.currentState!.validate()) {
                                logincubit.get(context).userlogin(
                                    email: EmailContoller.text,
                                    pass: passController.text);
                              }
                              logincubit.get(context).userlogin(
                                  email: EmailContoller.text,
                                  pass: passController.text);
                            },
                            controller: passController,
                            type: TextInputType.visiblePassword,
                            prefix: Icons.password,
                            suffix: logincubit.get(context).suffix,
                            isPassword: logincubit.get(context).ispassword,
                            suffixOnPressed: () {
                              logincubit.get(context).changepassword();
                            }),
                        SizedBox(
                          height: 30,
                        ),
                        Center(
                          child: ConditionalBuilder(
                              condition: state is! Loginrelodstate,
                              builder: (context) => defultbutton(
                                  Onpressed: () {
                                    if (formkey.currentState!.validate()) {
                                      logincubit.get(context).userlogin(
                                          email: EmailContoller.text,
                                          pass: passController.text);
                                    }
                                    logincubit.get(context).userlogin(
                                        email: EmailContoller.text,
                                        pass: passController.text);
                                  },
                                  text: 'Login',
                                  size: 30),
                              fallback: (context) =>
                                  CircularProgressIndicator()),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account?',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SIGNUP()));
                              },
                              child: Text(
                                'REGISTER',
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 16,
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ));
          });
        },
      ),
    );
  }
}
