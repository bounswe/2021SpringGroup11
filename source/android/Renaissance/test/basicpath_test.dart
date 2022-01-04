import 'package:flutter_test/flutter_test.dart';
import 'package:portakal/models/basic_path.dart';

void main() {
  test('BasicPath.fromJSON should be correct', () {
    final path = BasicPath.fromJSON({
      "title": "Radiohead albums",
      "_id": "9874",
      "photo": "10000",
      "isFollowed": false,
      "effort": 4.0,
      "rating": 8.9
    });
    expect(path.isFollowed, false);
    expect(path.id, "9874");
    expect(path.photo, "10000");
    expect(path.isFollowed, false);
    expect(path.effort, 4.0);
    expect(path.rating, 8.9);
  });
}