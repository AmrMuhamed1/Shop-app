import 'package:shop/shopapp/models/shop_models.dart';

abstract class Loginstate {}
class Loginintailstate extends Loginstate{}

class Loginrelodstate extends Loginstate{}

class Loginrunstate extends Loginstate{
 final shopmodel shoplogins;

  Loginrunstate(this.shoplogins);


}

class Loginerrorlstate extends Loginstate{
  final String error;

  Loginerrorlstate(this.error);



}

class loginchangepassword extends Loginstate{}

