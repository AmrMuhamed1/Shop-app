import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shop/shopapp/Homelayout/Homescreen.dart';
import 'package:shop/shopapp/component/component.dart';
import 'package:shop/shopapp/pages/search/searchstates.dart';

import 'searchcubit.dart';

class searchscreen extends StatelessWidget {
  var Searchcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => Searchcubit(),
      child: BlocConsumer<Searchcubit, searchstate>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(

              appBar: AppBar(
                leading: IconButton(onPressed: (){
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>homelayout()), (route) => false);
                },icon: Icon(Icons.arrow_back,color: Colors.green,),),
                backgroundColor: Colors.white,
                elevation: 0.0,
              ),
              body: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    defaultForm(
                        type: TextInputType.name,
                        controller: Searchcontroller,
                        label: 'Search',
                        suffix: Icons.search,
                        onSubmit: (String text) {
                          Searchcubit.get(context).Search(text);
                        }),
                    SizedBox(
                      height: 20,
                    ),
                    if (state is relodsearch) LinearProgressIndicator(),
                    SizedBox(
                      height: 30,
                    ),
                    if(state is searchsucess)
                    Expanded(
                      child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) => Favitem(
                            Searchcubit.get(context).searchmodule?.data.data[index]
                             ,
                              context, isOldPrice: false),
                          separatorBuilder: (context, index) => mydriver(),
                          itemCount: Searchcubit.get(context)
                              .searchmodule!
                              .data
                              .data
                              .length),
                    )
                  ],
                ),
              ));
        },
      ),
    );
  }
}
