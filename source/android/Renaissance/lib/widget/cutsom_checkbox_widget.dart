import 'package:flutter/material.dart';


class LabeledCheckbox extends StatelessWidget {
  const LabeledCheckbox({
    Key? key,
    required this.title,
    required this.description,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  final String title;
  final String description;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          onChanged(!value);
        },
        child: Padding(
            padding: EdgeInsets.all(5),
            child: Row(
                children: <Widget>[
            Expanded(child:
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,softWrap: true,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                    Text(description,softWrap: true,
                      style: TextStyle(fontSize: 14, ),),
                  ],
                ),
            ),
    Checkbox(
    value: value,
    onChanged: (bool? newValue) {
    onChanged(newValue!);
    },
    ),
    ],
    ),
    ),
    );
  }
}