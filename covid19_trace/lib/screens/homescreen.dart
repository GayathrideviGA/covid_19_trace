import 'package:covid19_trace/contact.dart';
import 'package:covid19_trace/scan.dart';
import 'package:covid19_trace/utils/styles.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      width: width,
      height: height,
      color: ColorConstants.primaryColor,
      child: DefaultTabController(
        
        length: 2,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(80.0),
            child: AppBar(
              backgroundColor: ColorConstants.background,
              automaticallyImplyLeading: false,
              elevation: 0,
              bottom: TabBar(
                indicatorColor: ColorConstants.subBg,
                tabs: [
                  Tab(
                    text: 'Trace',
                  ),
                  Tab(
                    text: 'Person Log',
                  ),
                ],
              ),
              title: Text('Covid\'19 Trace'),
            ),
          ),
          body: TabBarView(
            children: [
              MyHomePage(),
              ContactList(),
            ],
          ),
        ),
      ),
    );
  }
}
