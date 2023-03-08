import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/shopapp/Homelayout/Homescreen.dart';
import 'package:shop/shopapp/component/component.dart';
import 'package:shop/shopapp/pages/singup/cubit.dart';
import 'package:shop/shopapp/pages/singup/state.dart';
import 'package:shop/shopapp/shared_perfernce/cach.dart';

class SIGNUP extends StatelessWidget {
  var formkey = GlobalKey<FormState>();
  var nameContoller = TextEditingController();
  var emailContoller = TextEditingController();
  var passController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (BuildContext context )=>registercubit(),
    child:  BlocConsumer<registercubit, Registerstate>(
        listener: (context, state) {


          if (state is registerrunstate) {
            if (state.shoploginss.status!) {


              CacheHelper.setData(key: 'token', value: state.shoploginss.data!.token).then((value) {
                token = state.shoploginss.data!.token!;
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context)=>homelayout()), (route) => false);

              });

            } else {
              showtoast(text: state.shoploginss.message!, state: toastcolors.error);
            }
          }


        },
        builder: (context, state) {
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
                            'RREGISTER',
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
                                  return 'Please enter your name';
                                }
                              },
                              controller: nameContoller,
                              type: TextInputType.name,
                              prefix: Icons.person),
                          SizedBox(
                            height: 30,
                          ),
                          defaultForm(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your email';
                                }
                              },
                              controller: emailContoller,
                              type: TextInputType.emailAddress,
                              prefix: Icons.email),
                          SizedBox(
                            height: 30,
                          ),
                          defaultForm(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your password';
                                }
                              },
                              onSubmit: (value) {},
                              controller: passController,
                              type: TextInputType.visiblePassword,
                              prefix: Icons.password,
                              suffix: registercubit.get(context).suffix,
                              isPassword: registercubit.get(context).ispassword,
                              suffixOnPressed: () {
                                registercubit.get(context).changepassword();
                              }),
                          SizedBox(
                            height: 30,
                          ),
                          defaultForm(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your phone';
                                }
                              },
                              controller: phoneController,
                              type: TextInputType.phone,
                              prefix: Icons.phone_iphone_rounded),
                          SizedBox(
                            height: 30,
                          ),
                          Center(
                            child: ConditionalBuilder(
                                condition: state is! registerrelodstate,
                                builder: (context) => defultbutton(
                                    Onpressed: () {
                                      if (formkey.currentState!.validate()) {
                                        registercubit.get(context).userregister(
                                            email: emailContoller.text,
                                            pass: passController.text,
                                            name: nameContoller.text,
                                            phone: phoneController.text);
                                      }
                                      // registercubit.get(context).userregister(
                                      //     email: emailContoller.text,
                                      //     pass: passController.text,
                                      //     name: nameContoller.text,
                                      //     phone: phoneController.text);
                                    },
                                    text: 'Register',
                                    size: 30),
                                fallback: (context) => CircularProgressIndicator()),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Center(
                            child: TextButton(
                                onPressed: () {},
                                child: Text(
                                  'Create an account? Sign Up',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )),
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
        }),);
  }
}
