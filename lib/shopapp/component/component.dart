import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop/shopapp/Homelayout/Appcubit.dart';
import 'package:shop/shopapp/pages/login/lOGINsCREEN.dart';
import 'package:shop/shopapp/shared_perfernce/cach.dart';


Widget articleNewsBuilder(article, context, {isSearch = false}) {
  return InkWell(
    onTap: () {},
    child: Padding(
      padding: const EdgeInsets.all(15),
      child: Row(children: [
        Container(
          height: 120,
          width: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadiusDirectional.circular(20),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage('${article['urlToImage']}'),
            ),
          ),
        ),
        SizedBox(width: 30),
        Expanded(
          child: Container(
            height: 120,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    '${article['title']}',
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
                Text(
                  '${article['publishedAt']}',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    ),
  );
}

Widget mydriver() => Padding(
    padding: EdgeInsets.all(0.0),
    child: Column(
      children: [
        Divider(
          height: 5,
          thickness: 2,
          indent: 10,
        )
      ],
    ));

Widget defaultForm({
  GestureTapCallback? onTap,
  required TextEditingController controller,
  FormFieldValidator<String>? validator,
  required TextInputType type,
  ValueChanged<String>? onSubmit,
  ValueChanged<String>? onChange,
  String? label,
  IconData? prefix,
  bool isPassword = false,
  IconData? suffix,
  VoidCallback? suffixOnPressed,
  TextStyle? style,
}) =>
    TextFormField(
      style: style,
      validator: validator,
      onTap: onTap,
      controller: controller,
      keyboardType: type,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixOnPressed,
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        border: OutlineInputBorder(),
      ),
    );

Widget defultbutton({
  required VoidCallback Onpressed,
  required String text,
  double? size,
}) =>
    Container(

      decoration: BoxDecoration(

        borderRadius: BorderRadius.circular(50)
      ),

      width: double.infinity,
      height: 60,
      child: RaisedButton(
      color: Colors.green,


        onPressed: Onpressed,
        colorBrightness: Brightness.light,
        splashColor: Colors.white,
        child: Text(
          '$text',
          style: TextStyle(color: Colors.white, fontSize: size),
        ),
      ),
    );

void showtoast({required String text, required toastcolors state}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 5,
        backgroundColor: choosetoastcolor(state),
        textColor: Colors.white,
        fontSize: 18.0);

enum toastcolors { sucess, error, warning }

 Color ?choosetoastcolor(toastcolors state) {
  Color color;
  switch (state) {
    case toastcolors.sucess:
      color=Colors.green;
      break;
    case toastcolors.error:
      color=Colors.red;
      break;
    case toastcolors.warning:
      color=Colors.amber;
      break;

  }
}
 fucn(context){

  CacheHelper.Remove(key: 'token').then((value) {
    if(value){
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context)=>LOGIN()), (route) => false);

    }
  });
}
String ?token ='';
void signOut(context)
{

  CacheHelper.Remove(key: 'token').then((value)
  {
    if(value==true) {
      Appcubit.get(context).userdata=null;
    }
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context)=>LOGIN()), (route) => false);

  });
}
Widget buildProductListItem(model, context, { bool isOldPrice = true}) =>
    Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 120,
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage('${model.image}'),
                  height: 120,
                  // fit: BoxFit.cover,
                  width: 120,
                ),
                SizedBox(
                  width: 15,
                ),
                if (model.discount != 0 && isOldPrice)
                  Container(
                    color: Colors.red,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'DISCOUNT',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${model.name}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.2,
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        '${model.price}',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      if (model.discount != 0 && isOldPrice)
                        Text(
                          '${model.oldPrice}',
                          style: TextStyle(
                            color: Colors.grey[500],
                            decoration: TextDecoration.lineThrough,
                            fontSize: 14,
                          ),
                        ),
                      Spacer(),
                      IconButton(
                          onPressed: () async {
                            Appcubit.get(context)
                                .changefav(model.id);
                            // print(model.id);
                          },
                          icon: CircleAvatar(
                              backgroundColor: Appcubit.get(context).addFavorites[model.id] == true ? Colors.red
                                  : Colors.grey, radius: 20,child: Icon(
                            Icons.favorite_border,
                            color: Colors.white,
                          ))),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );



Widget Favitem( model, context, {bool isOldPrice =true}) =>
    Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 120,
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(
                      '${model.image}'),
                  width: 100,
                  height: 100,
                ),
                if(model.discount!=0 && isOldPrice)
                Container(
                  color: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 5.0),

                  child: Text(
                    'DISCOUNT',
                    style: const TextStyle(fontSize: 10.0, color: Colors.white),
                  ),
                )
              ],
            ),
            SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    '${model.name}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        '${model.price}',
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
                      if(model.discount != 0 && isOldPrice)
                        Text(
                          '${model.oldPrice}',
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
                          backgroundColor: Appcubit.get(context).addFavorites[model.id]==true?Colors.red: Colors.grey,

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
            ),
          ],
        ),
      ),
    );


