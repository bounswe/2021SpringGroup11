import 'package:flutter/material.dart';
import 'package:portakal/http_services.dart';
import 'package:portakal/models/tag.dart';
import 'package:portakal/my_colors.dart';

class TagContainer extends StatefulWidget {
  TagContainer(this.tag);
  var tag;
  @override
  State<TagContainer> createState() => _TagContainerState();
}

class _TagContainerState extends State<TagContainer> {
  late var isFav = widget.tag.isFav;
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          setState(() {
           isFav = !isFav;
          });
          if (isFav) {
            HttpService.shared.favoriteTopic(widget.tag.id);
          } else {
            HttpService.shared.unfavoriteTopic(widget.tag.id);
          }
        },
        child: Container(
          margin: EdgeInsets.all(5),
          color: Colors.transparent,
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 7, vertical: 7),
              decoration: BoxDecoration(
                  color: MyColors.lightGreen,
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(widget.tag.name!,
                      overflow: TextOverflow.clip,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14)),
                  Icon(
                    // NEW from here...
                    isFav ? Icons.favorite : Icons.favorite_border,
                    color: isFav ? Colors.red : null,
                    semanticLabel: isFav ? 'Remove from fav' : 'Add to fav',
                  ),
                ],
              )
          ),
        )
    );
  }
}
