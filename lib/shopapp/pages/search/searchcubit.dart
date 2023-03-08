import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shop/shopapp/pages/search/searchstates.dart';
import 'package:shop/shopapp/remote/endpoints.dart';

import '../../Dio/DioHelper.dart';
import '../../component/component.dart';
import '../../models/searchmoudles.dart';

class  Searchcubit extends Cubit<searchstate>{

  Searchcubit() : super(intialsearch());

  static Searchcubit get(context)=> BlocProvider.of(context);

  SearchModel? searchmodule;

  void Search(String text){

    emit(relodsearch());

    Diohelper.postdata(url: searchend ,token: token, data:{
      'text':text
    } ,).then((value) {
      searchmodule = SearchModel.fromJson(value.data);
      print(value.data);

      emit(searchsucess());
    }).catchError((error){

      emit(searcherror());
    });
  }




}