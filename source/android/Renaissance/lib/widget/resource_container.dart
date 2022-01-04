import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portakal/models/Resource.dart';

class ResourceContainer extends StatelessWidget {
  final Resource resource;
  const ResourceContainer({ Key? key, required this.resource}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        borderOnForeground: true,
        color: Colors.lightGreen,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.red,
                    child: Text("I"),
                    radius: 20,
                  ),
                  SizedBox(width: 6,),
                  Text("${resource.username} for Task ${resource.taskId}:", style: TextStyle(color: Colors.pink, fontSize: 16),)
                ],
              ),
              SizedBox(height: 5,),
              Text(resource.description!,
                style: TextStyle(fontSize: 13, color: Colors.black87),
              ),
              SizedBox(height: 5,),
              Text(resource.link!, style: TextStyle(fontSize: 13, color: Colors.blueAccent),)
            ],
          ),
        ),
      ),
    );
  }

}