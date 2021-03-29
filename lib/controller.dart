import 'bettingmodel.dart';
import 'package:http/http.dart' as http;

import 'idmodel.dart';

class ControllerBetting{
  static Future<BettingNumber>getBettingNumber() async{

    String url = "http://goldenapp.info/Cricket_tips_admin/bettingapi.php";
    final response = await http.get(url);

    return bettingNumberFromJson(response.body);
  }

}
class ControllerID{
  static Future<IdNumber>getIdNumber() async{

    String url = "http://goldenapp.info/Cricket_tips_admin/idapi.php";
    final response = await http.get(url);

    return idNumberFromJson(response.body);
  }

}