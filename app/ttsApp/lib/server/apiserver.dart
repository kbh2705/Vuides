import 'dart:io';

class ApiServer{
<<<<<<< HEAD
  final apiserver = "http://192.168.20.192:5000";
=======
  final apiserver = "http://192.168.0.114:5000";
>>>>>>> e2630bafaa020b5810ba888b17e1283164048abe


  // final apiserver = "http://ec2-3-36-26-208.ap-northeast-2.computea.amazonaws.com:5000";

  String getApiServer(){
    return apiserver;
  }


}