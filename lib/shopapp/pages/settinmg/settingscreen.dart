import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../Homelayout/Appcubit.dart';
import '../../Homelayout/states.dart';
import '../../component/component.dart';

class setting extends StatelessWidget {
  var namecontroller = TextEditingController();
  var emailcontroller = TextEditingController();
  var phoecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Appcubit, states>(
        listener: (context, state) {},
        builder: (context, state) {
          var model = Appcubit.get(context).userdata;

          namecontroller.text = model!.data!.name!;
          emailcontroller.text = model.data!.email!;
          phoecontroller.text = model.data!.phone!;

          return ConditionalBuilder(
              condition: Appcubit.get(context).userdata != null,
              builder: (context) => SingleChildScrollView(
                child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          if (state is Updateuserloading)
                            LinearProgressIndicator(),
                          SizedBox(
                            height: 20,
                          ),
                          defaultForm(
                            
                              type: TextInputType.name,
                              controller: namecontroller,
                              label: 'USER NAME',prefix: Icons.person),
                          SizedBox(
                            height: 20,
                          ),
                          defaultForm(
                              type: TextInputType.name,
                              controller: emailcontroller,
                              label: 'EMAIL',prefix: Icons.email),
                          SizedBox(
                            height: 20,
                          ),
                          defaultForm(
                              type: TextInputType.phone,
                              controller: phoecontroller,
                              label: 'PHONE',prefix: Icons.phone_iphone_rounded),
                          SizedBox(
                            height: 40,
                          ),
                          defultbutton(
                              Onpressed: () {
                                Appcubit.get(context).Updateuserdata(
                                    name: namecontroller.text,
                                    email: emailcontroller.text,
                                    phone: phoecontroller.text);
                              },
                              text: 'Update',
                              size: 19),
                          SizedBox(
                            height: 20,
                          ),
                          defultbutton(
                              Onpressed: () {
                                signOut(context);
                              },
                              text: 'Log out',
                              size: 19)
                        ],
                      ),
                    ),
              ),
              fallback: (context) => CircularProgressIndicator());
        });
  }
}
