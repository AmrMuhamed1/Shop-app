import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shop/shopapp/Homelayout/Appcubit.dart';
import 'package:shop/shopapp/Homelayout/states.dart';
import 'package:shop/shopapp/component/component.dart';
import 'package:shop/shopapp/models/HOMEMODEL/catogriesmodels.dart';

class Catogries extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Appcubit, states>(
        listener: (context, state) {},
        builder: (context, state) {
          return ListView.separated(
              itemBuilder: (context, index) => buildscreencatogires(Appcubit.get(context).catogriesmodels!.data!.data![index]),
              separatorBuilder: (context, index) => mydriver(),
              itemCount: Appcubit.get(context).catogriesmodels!.data!.data!.length);

        });


  }
  Widget buildscreencatogires(CategoriesData model) => InkWell(
    onTap: (){},
    child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Image(
                image: NetworkImage(
                    '${model.image}'),
                fit: BoxFit.cover,
                height: 80,
                width: 80,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                '${model.name}',
                style: TextStyle(fontSize: 20),
              ),
              Spacer(),
              Icon(Icons.arrow_forward),
            ],
          ),
        ),
  );
}
