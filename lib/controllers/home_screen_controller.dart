import 'dart:developer';

import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';

import '../models/sports_data_model.dart';
import '../network/api_network.dart';
import '../network/api_sheet.dart';

class HomeScreenController extends GetxController {
  Rx<SportsDataModel> sportsDataModel = SportsDataModel().obs;
  RxBool loading = false.obs;

  fetchData() async {
    try {
      loading.value = true;
      dio.Response response = await ApiNetwork().getRequest(ApiSheet.sapkLive);
      log('response.data ${response.data}');
      sportsDataModel.value = SportsDataModel.fromJson(response.data);
    } catch (e) {
      log('fetchData: $e');
    } finally {
      loading.value = false;
    }
  }
}
