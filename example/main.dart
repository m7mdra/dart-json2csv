import "package:json2csv/json2csv.dart" as json2csv;

import "dart:io";

void main(List<String> args) {
  var file = File("example/input.json");
  var data = file.readAsStringSync();
  final csv = json2csv.convert(data);
  var resultFile = File("example/result.csv");
  resultFile.writeAsStringSync(csv.toString());
}
