import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CounterOfferController extends GetxController{
  var buttonClicked=false.obs;
  TextEditingController quantity = TextEditingController();
  TextEditingController price = TextEditingController();


  changeButton(){
    buttonClicked.value=!buttonClicked.value;
  }

}