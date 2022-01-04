import 'package:flutter_test/flutter_test.dart';
import 'package:portakal/models/tag.dart';

void main() {
  test('Tag.fromJSON should be correct', () {
    final tag = Tag.fromJSON({"name": "Chemistry", "id": "6f1s", "isFav": true, "description": "The nature of the earth" });
    expect(tag.name, "Chemistry");
    expect(tag.id, "6f1s");
    expect(tag.isFav, true);
    expect(tag.description, "The nature of the earth");
  });

  test('Tag.fromSpecialJSON should be correct', () {
    final tag = Tag.fromSpecialJSON({"name": "Chemistry", "ID": "5ed04", "isFav": true, "description": "The nature of the earth" });
    expect(tag.name, "Chemistry");
    expect(tag.id, "5ed04");
    expect(tag.isFav, true);
    expect(tag.description, "The nature of the earth");
  });
}