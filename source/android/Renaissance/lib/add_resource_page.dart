
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portakal/my_colors.dart';

class AddResourcePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddResourcePageState();

}

class _AddResourcePageState extends State<AddResourcePage> {
  TextEditingController descriptionController = TextEditingController();
  TextEditingController linkController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.black54,
          title: Text("ADD RESOURCE"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'DESCRIPTION',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              TextField(
                maxLines: 6,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Description of the Resource",
                  contentPadding: EdgeInsets.all(10)
                ),
                style: TextStyle(
                  color: MyColors.coolGray,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400
                ),
                controller: descriptionController
              ),
              SizedBox(height: 20,),
              Text(
                'LINK',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              TextField(
                  maxLines: 1,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Link-Url of the Resource",
                      contentPadding: EdgeInsets.symmetric(horizontal: 10)
                  ),
                  style: TextStyle(
                      color: MyColors.coolGray,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400
                  ),
                  controller: linkController,
              ),
              SizedBox(height: 20,),
              Align(
                alignment: Alignment.centerRight,
                child: MaterialButton(
                  onPressed:() {},
                  color: Colors.green,
                  child: Text("SUBMIT"),
                ),
              ),
              Spacer()
            ],
          ),
        ),
      ),
    );
  }

}