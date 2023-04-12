import "package:json2csv/json2csv.dart" as JSON2CSV;

import "dart:io";

void main(List<String> args) {
  var file = File("example/input.json");
  var data = file.readAsStringSync();
  final csv = JSON2CSV.convert(data);
  var resultFile = File("example/result.csv");
  resultFile.writeAsStringSync(csv.toString());
}
