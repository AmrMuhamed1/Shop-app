import 'package:shop/shopapp/models/shop_models.dart';

abstract class Registerstate {}
class registerintailstate extends Registerstate{}

class registerrelodstate extends Registerstate{}

class registerrunstate extends Registerstate{
  final shopmodel shoploginss;

  registerrunstate(this.shoploginss);


}

class registererrorlstate extends Registerstate{
  final String error;

  registererrorlstate(this.error);

}

class loginregisterchangepassword extends Registerstate{}

