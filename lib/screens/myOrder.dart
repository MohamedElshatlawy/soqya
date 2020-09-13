import 'package:flutter/material.dart';
import 'tabs/orderF.dart';
import 'tabs/orderV.dart';
import 'tabs/orderN.dart';

class MyOrder extends StatefulWidget {
  @override
  MyOrderState createState() => new MyOrderState();
}

class MyOrderState extends State<MyOrder> with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    super.initState();
    controller = new TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  TabBar getTabBar() {
    return new TabBar(
      tabs: <Tab>[
        new Tab(
          child: Text(
            'قيد التنفيذ',
            style: TextStyle(fontFamily: 'GE-Dinar_One_Medium'),
          ),
        ),
        new Tab(
          child: Text(
            'تم التسليم',
            style: TextStyle(fontFamily: 'GE-Dinar_One_Medium'),
          ),
        ),
        new Tab(
          child: Text(
            'تم الالغاء',
            style: TextStyle(fontFamily: 'GE-Dinar_One_Medium'),
          ),
        ),
      ],
      controller: controller,
    );
  }

  TabBarView getTabBarView(var tabs) {
    return new TabBarView(
      children: tabs,
      controller: controller,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          title: Text(
            "طلباتى",
            style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: 'GE-Dinar_One_Medium'),
          ),
          //  centerTitle: true,
          backgroundColor: Color(0xff2fa4e0), 
          bottom: getTabBar()),  
      body:  getTabBarView(<Widget>[new OrderN(), new OrderF(), new OrderV()]),
    );
  }
}
