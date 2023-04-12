part of json2csv.csv;

///A CSV Table
class Table {
  /// Table Rows
  final List<Row> rows;

  /// Creates an empty table.

  Table() : rows = [];

  ///Creates a Table that contains the same rows from the [original] table.

  Table.from(Table original)
      : rows = List.from(original.rows.map((it) {
          return Row.from(it);
        }));

  ///Creates a Table that syncs the rows from the [original] table.
  Table.sync(Table other) : rows = other.rows;

  ///Appends to Specified [row] at the end of the table.
  void append(Row row) => rows.add(row);

  /// Creates a row from the [values] and append it to thr table.
  void addRow(List<String> values) => append(Row.fromList(values));

  /// Gets the specified column's data by index (starting at 0).
  List<String> getColumn(int column) {
    var list = <String>[];
    for (var _ in rows) {
      list.add(list[column]);
    }
    return list;
  }

  ///Gets the specified [row]'s data by index (starting at 0).
  Row getRow(int row) {
    return rows[row];
  }

  @override
  String toString() {
    var buffer = StringBuffer();
    for (var row in rows) {
      buffer.writeln(row.toString());
    }
    return buffer.toString();
  }
}

class Row {
  /// The Row Values

  final List<String> values;

  /// Creates an Empty Row

  Row() : values = [];

  /// Creates a [Row] from an existing instance.
  Row.from(Row original) : values = List.from(original.values);

  /// Creates a [Row] that will use the same list as the other row to store the row's values.

  Row.sync(Row other) : values = other.values;

  /// Creates a [Row] instance from [list].

  Row.fromList(List<String> list) : values = List.from(list);

  /// Adds a value to [values].

  void addValue(String value) => values.add(value);

  @override
  String toString() => values.map(_escapeValue).join(",");
}

String _escapeValue(String input) {
  var buffer = StringBuffer();
  if (input.contains(",") ||
      input.contains("\n") ||
      input.contains("\r\n") ||
      input.contains("\r")) {
    buffer.write('"');
    buffer.write(input);
    buffer.write('"');
  } else {
    buffer.write(input);
  }
  return buffer.toString();
}
