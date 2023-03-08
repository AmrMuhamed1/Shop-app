import 'package:shop/shopapp/models/shop_models.dart';

abstract class states{}


class Intialstates extends states{}

class bottomnavigate extends states{}

class Shoploadinghomed extends states{}
class Shopsucesshomed extends states{}
class Shoperrorhomed extends states{}
class shoploadingcatogires extends states{}
class catogriessucess extends states{}
class catogrieserror extends states{}

class Favesycess extends states{}
class Faverror extends states{}


class Favloading extends states{}

class Favdataget extends states{}
class Favdataerror extends states{}

class Settingloading extends states{}

class settingsucess extends states{
    shopmodel ?loginmodel;
    settingsucess(this.loginmodel);
}
class settingataerror extends states{}



class Updateuserloading extends states{}
class Updateusersucess extends states {
    shopmodel ?loginmodel;

    Updateusersucess(this.loginmodel);

}
class Updateusererror extends states{}