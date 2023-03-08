import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/shopapp/Homelayout/states.dart';

import '../../Homelayout/Appcubit.dart';
import '../../component/component.dart';

class Favscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Appcubit, states>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
            condition: Appcubit.get(context).favorite_model_data!=null, builder: (context) =>
            ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    Favitem(Appcubit
                        .get(context)
                        .favorite_model_data!
                        .data!.data[index].data, context),
                separatorBuilder: (context, index) => mydriver(),
                itemCount: Appcubit
                    .get(context)
                    .favorite_model_data!
                    .data!
                    .data
                    .length), fallback: (context)=>CircularProgressIndicator());
      },
    );
  }


}
