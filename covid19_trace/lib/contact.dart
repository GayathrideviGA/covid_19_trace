import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid19_trace/utils/styles.dart';
import 'package:flutter/material.dart';

class ContactList extends StatefulWidget {
  @override
  _ContactListState createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
 
  TextEditingController controller = new TextEditingController();
  String filter;

Widget _buildListItem(BuildContext context, DocumentSnapshot document ){
 return ListTile(
   leading: Icon(Icons.account_circle,color:ColorConstants.subBg),
title: Row(
children: [

Expanded(
child: Text(
document['name'],

),
),

],
),
);
}
void initState()
{
  super.initState();
  controller.addListener(() {
  setState(() {
    filter = controller.text;
  });
});
}
 @override
void dispose() {
  controller.dispose();
  super.dispose();
}

  @override
  Widget build(BuildContext context) {
     double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: 
            
            StreamBuilder(

stream: Firestore.instance.collection('users').snapshots(),
builder: (context, snapshot){
return Container(
width: width,
height: height,
child: snapshot.hasData==null? Center(child: CircularProgressIndicator()):SingleChildScrollView(child:Column(children: <Widget>[
 Padding(padding: EdgeInsets.only(top: 10,left:15,right: 15,bottom: 10),child: TextField(                     
  decoration: new InputDecoration(
    labelText: "Enter the name of the person to search"
  ),
  controller: controller,
),),
Container(
  width:width,
  height:height,
  color:ColorConstants.primaryColor,
  child:ListView.builder(
itemExtent: 80.0,
itemCount: snapshot.data.documents.length,
itemBuilder: (context, index) =>
 _buildListItem(context, snapshot.data.documents[index])
)
)
],)),
);
/*if(!snapshot.hasData) return const Text('loading....');

return ListView.builder(
itemExtent: 80.0,
itemCount: snapshot.data.documents.length,
itemBuilder: (context, index) =>
 
 _buildListItem(context, snapshot.data.documents[index])



);*/
}

),
        
                );
  }
}
