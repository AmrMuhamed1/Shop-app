import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shop/shopapp/Homelayout/Appcubit.dart';
import 'package:shop/shopapp/Homelayout/states.dart';
import 'package:shop/shopapp/pages/search/Searchscreen.dart';

class homelayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Appcubit, states>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = Appcubit.get(context);
        return Scaffold(
          drawer: Drawer(),
          appBar: AppBar(
            title: Text('Tec_Market'),
            actions: [
              IconButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>searchscreen()));
              }, icon: Icon(Icons.search)),

            ],

          ),
          body: cubit.bottomscreens[cubit.currentindex],

          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentindex,
            onTap: (index) {
              cubit.changebottom(index);
            },
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.apps), label: 'Categories'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite), label: 'Favorite'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: 'Settings'),

            ],
          ),
        );
      },
    );
  }
}
