
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Homelayout/Appcubit.dart';
import '../../Homelayout/states.dart';
import '../../models/HOMEMODEL/HOMEDATA.dart';
import '../../models/HOMEMODEL/catogriesmodels.dart';


class Productscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Appcubit, states>(
        listener: (context, state) {},
        builder: (context, state) {
          return ConditionalBuilder(
              condition: Appcubit.get(context).homemodel!=null  && Appcubit.get(context).catogriesmodels!=null,
              builder: (context) =>
                  PRODUCT(Appcubit.get(context).homemodel!,Appcubit.get(context).catogriesmodels!,context),
              fallback: (context) =>
                  Center(child: CircularProgressIndicator()));
        });
  }

  Widget PRODUCT(HomeModel model,CategoriesModel categoriesModel,context) =>
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
                items: model.data!.banners!
                    .map(
                      (e) =>
                      Image(
                        image: NetworkImage('${e.image}'),
                        width: double.infinity,
                      ),
                )
                    .toList(),
                options: CarouselOptions(
                    height: 200,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayAnimationDuration: Duration(seconds: 1),
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    scrollDirection: Axis.horizontal,
                    viewportFraction: 1)),
            SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(('categrois'),style: TextStyle(fontSize: 20),),
                  SizedBox(height: 10,),
                  Container(
                    height: 100.0,
                    child: ListView.separated(physics: BouncingScrollPhysics(),scrollDirection: Axis.horizontal,itemBuilder: (context,index)=>Buildcategories(categoriesModel.data!.data![index],context), separatorBuilder: (context,index)=>SizedBox(
                      width: 5,
                    ), itemCount: categoriesModel.data!.data!.length),
                  ),
                  SizedBox(height: 20,),
                  Text(('New Products'),style: TextStyle(fontSize: 20),),
                ],
              ),
            ),
            SizedBox(height: 20,),
            Container(
              color: Colors.grey[300],
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 1.0,
                crossAxisSpacing: 1.0,
                childAspectRatio: 1 / 1.83,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: List.generate(model.data!.products!.length,
                        (index) =>
                        Buildgridproducts(model.data!.products![index],context)),
              ),
            ),


          ],
        ),
      );

  Widget Buildgridproducts( model,context) =>
      Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage('${model.image}'),
                  width: double.infinity,
                  height: 200,
                ),
                if (model.disCount != 0)
                  Container(
                    color: Colors.red,
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    child: Text(
                      'DISCOUNT',
                      style: TextStyle(fontSize: 10.0, color: Colors.white),
                    ),
                  )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model.name}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text(
                        '${model.price.round()}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 13.0,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      if (model.disCount != 0)
                        Text(
                          '${model.oldPrice.round()}',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 13.0,
                              decoration: TextDecoration.lineThrough),
                        ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          Appcubit.get(context).changefav(model.id);
                        },
                        icon: CircleAvatar(
                          radius: 15,
                          backgroundColor:Appcubit.get(context).addFavorites[model.id]==true ? Colors.red : Colors.grey,

                          child: Icon(

                            Icons.favorite_border_outlined,
                            size: 18,
                            color: Colors.white,

                          ),
                        ),
                        padding: EdgeInsets.zero,
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      );

  Widget Buildcategories(CategoriesData model,context)=> Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children: [
      Image(
        image: NetworkImage(
            '${model.image}'),
        height: 100,
        width: 100,
        fit: BoxFit.cover,
      ),
      Container(
        width: 100,
        color: Colors.black.withOpacity(0.8),

        child: Text(
          '${model.name}',
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: Colors.white),
        ),
      ),
    ],
  );
}


