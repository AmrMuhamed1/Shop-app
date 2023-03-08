import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shop/shopapp/Homelayout/states.dart';
import 'package:shop/shopapp/component/component.dart';
import 'package:shop/shopapp/models/HOMEMODEL/Fav_data_model.dart';
import 'package:shop/shopapp/models/HOMEMODEL/Favmodels.dart';
import 'package:shop/shopapp/models/HOMEMODEL/HOMEDATA.dart';
import 'package:shop/shopapp/models/HOMEMODEL/catogriesmodels.dart';
import 'package:shop/shopapp/models/shop_models.dart';
import 'package:shop/shopapp/pages/catigories/Catogires%20screen.dart';
import 'package:shop/shopapp/pages/faviorte/favoritescreen.dart';
import 'package:shop/shopapp/pages/productscreen/Productscreen.dart';
import 'package:shop/shopapp/pages/settinmg/settingscreen.dart';
import 'package:shop/shopapp/remote/endpoints.dart';

import '../Dio/DioHelper.dart';

class Appcubit extends Cubit<states> {
  Appcubit() : super(Intialstates());

  static Appcubit get(context) => BlocProvider.of(context);

  int currentindex = 0;

  List<Widget> bottomscreens = [
    Productscreen(),
    Catogries(),
    Favscreen(),
    setting(),
  ];

  void changebottom(index) {
    currentindex = index;
    emit(bottomnavigate());
  }

   HomeModel? homemodel;
  Map<int, dynamic> addFavorites = {};

  void getdatahome() {
    emit(Shoploadinghomed());

    Diohelper.getdata(url: home, token: token).then((value) {
      homemodel = HomeModel.fromJson(value.data);
      // print(homemodel.toString());
      // print(homemodel.status);
      homemodel!.data!.products?.forEach((element) {
        addFavorites.addAll({element.id: element.inFavorites});
      });
      print(addFavorites.toString());

      emit(Shopsucesshomed());
    }).catchError((error) {
      emit(Shoperrorhomed());
      print(error.toString());
    });
  }

   CategoriesModel? catogriesmodels;

  void getcatigories() {
    emit(shoploadingcatogires());

    Diohelper.getdata(url: catogries, token: token).then((value) {
      catogriesmodels = CategoriesModel.fromJson(value.data);
      print(value.data);

      emit(catogriessucess());
    }).catchError((error) {
      emit(catogrieserror());
      print(error.toString());
    });
  }
  favdata? Favdata;

  void changefav(int productid){
    addFavorites[productid] =!addFavorites[productid];
    emit(Favesycess());

    Diohelper.postdata(url: add_fav , data:{
      'product_id':productid
    } , token: token).then((value) {
      Favdata = favdata.fromJson(value.data);
      print(value.data);
      if(!Favdata!.status!){
         addFavorites[productid] =  !addFavorites[productid]!;

       }else{
        Getfav();
      }
      emit(Favesycess());
    }).catchError((error){
      addFavorites[productid] = addFavorites[productid];
      emit(Faverror());
    });
  }

  FavoritesGetModel? favorite_model_data;
  void Getfav() {
    emit(Favloading());


    Diohelper.getdata(url: add_fav, token: token).then((value) {
      favorite_model_data = FavoritesGetModel.fromJson(value.data);
      print(value.data);

      emit(Favdataget());
    }).catchError((error) {
      emit(Favdataerror());
      print(error.toString());
    });
  }

  shopmodel? userdata;
  void Getuserdata() {
    emit(Settingloading());


    Diohelper.getdata(url: profile, token: token).then((value) {
      userdata = shopmodel.fromJson(value.data);
      print(value.data);


      emit(settingsucess(userdata));
    }).catchError((error) {
      emit(settingataerror());
      print(error.toString());
    });
  }



  void Updateuserdata({required String name,required String email,required String phone}) {
    emit(Updateuserloading());


    Diohelper.putdata(url: update_data, token: token,data: {
       'name':name,
      'email': email,
       'phone': phone,


    }).then((value) {
      userdata = shopmodel.fromJson(value.data);
      print(value.data);


      emit(settingsucess(userdata));
    }).catchError((error) {
      emit(settingataerror());
      print(error.toString());
    });
  }




}
