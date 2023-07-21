import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sportsadda/constants/app_colors.dart';
import 'package:sportsadda/controllers/home_screen_controller.dart';

import '../models/sports_data_model.dart';
import '../utility/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  HomeScreenController controller = Get.put(HomeScreenController());
  late TabController tabController;
  bool loading = false;
  List<Tab> tabList = [];
  List<Widget> tabBody = [];

  @override
  void initState() {
    tabController = TabController(length: 0, vsync: this);
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: Obx(() => mainBody())));
  }

  mainBody() => controller.loading.value
      ? const Center(
          child: CircularProgressIndicator(),
        )
      : controller.sportsDataModel.value.teams?.isEmpty ?? true
          ? Center(
              child: Text(
                "No data found",
                style: Utils.normalTextStyle(),
              ),
            )
          : Column(
              children: [
                ElevatedButton(
                    onPressed: () {
                      getData();
                    },
                    child: Text('Get data')),
                tabs(),
                playerText(),
                tabView(),
              ],
            );

  tabs() => Container(
        margin: const EdgeInsets.only(left: 10.0, right: 10.0),
        decoration: BoxDecoration(
            borderRadius: borderRadius(),
            border: Border.all(
              color: AppColors.green,
            )),
        child: TabBar(
          tabs: tabList,
          controller: tabController,
          onTap: (value) {
            setState(() {});
          },
          indicator: BoxDecoration(
            borderRadius: borderRadius(),
            color: AppColors.green,
          ),
          labelColor: Colors.white,
          unselectedLabelColor: Colors.black,
        ),
      );

  playerText() => Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 15.0, top: 8.0, bottom: 8.0),
        child: Text(
          'Players',
          style: Utils.normalTextStyle(fontWeight: FontWeight.bold),
        ),
      );

  tabView() => Expanded(child: tabBody[tabController.index]);

  borderRadius() => BorderRadius.circular(
        25.0,
      );

  getData() async {
    try {
      await controller.fetchData();
      if (controller.sportsDataModel.value.teams?.isEmpty ?? true) {
        return;
      }
      tabBody.clear();
      tabList.clear();
      controller.sportsDataModel.value.teams!.forEach((element) {
        tabList.add(Tab(
          child: Text(element.nameFull ?? 'Team'),
        ));
        tabBody.add(bodyListView(element.players ?? []));
      });
      tabController = TabController(
          length: controller.sportsDataModel.value.teams?.length ?? 0,
          vsync: this);
      print(
          'tabController.length: ${tabController.length} tabBody: ${tabBody.length} tabList: ${tabList.length}');
      tabController.animateTo(0);
      setState(() {});
    } catch (e) {
      log('getData: $e');
    } finally {}
  }

  bodyListView(List<Players> list) => ListView.separated(
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.only(left: 15.0),
          child: Text(
            list[index].nameFull ?? 'Name',
            style: Utils.normalTextStyle(
                color: list[index].isKeeper ?? false
                    ? AppColors.green
                    : AppColors.black),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.all(8.0),
          color: AppColors.green,
          height: 1.0,
          width: Utils.getWidth(context),
        );
      },
      itemCount: list.length);
}
