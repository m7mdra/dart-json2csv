part of json2csv;

Table convert(input) {
  var outRows = [];
  var inList = _listFrom(input is String ? json.decode(input) : input);
  var firstRow = Row();
  for (var row in inList) {
    var it = Row();
    var obj = JSONFlattener.flatten(row);
    for (var key in obj.keys) {
      if (!firstRow.values.contains(key)) {
        firstRow.values.add(key);
      }
    }
    it.values.addAll(obj.values.map((value) => value.toString()));
    outRows.add(it);
  }
  var table = Table();
  table.append(firstRow);
  for (var element in outRows) {
    table.append(element);
  }
  return table;
}

List<dynamic> _listFrom(input, [key]) {
  if (input is List) {
    return input;
  } else if (key != null) {
    return input[key];
  } else {
    for (var key in input.keys) {
      if (input[key] is List) {
        return input[key];
      }
    }

    return [input];
  }
}

class JSONFlattener {
  static Map<String, dynamic> flatten(input) {
    return visit(input);
  }

  static Map<String, dynamic> visit(input, [String? path]) {
    path ??= "";

    var scalar =
        input is num || input is String || input is bool || input == null;

    if (input is Map) {
      var out = {};
      for (var key in input.keys) {
        var newStuff = visit(input[key], "${path + key}/");
        out.addAll(newStuff);
      }
      return out.cast();
    } else if (scalar) {
      var out = {};
      // Single Scalar
      if (path == "") {
        path = "value/";
      }
      var endPath = path.substring(0, path.length - 1);
      out[endPath] = input;
      return out.cast();
    } else if (input is List) {
      var out = {};
      for (int i = 0; i < input.length; i++) {
        var newStuff = visit(input[i], "$path$i/");
        out.addAll(newStuff);
      }
      return out.cast();
    } else {
      return {};
    }
  }
}
