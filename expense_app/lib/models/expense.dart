class Expense {
  final String id;
  final double amount;
  final String categoryId;
  final String payee;
  final String note;
  final DateTime date;
  final String tag;

  // intialize the Expense object
  Expense({
    required this.id,
    required this.amount,
    required this.categoryId,
    required this.payee,
    required this.note,
    required this.date,
    required this.tag,
  });

  // create an expense instance from a map Converting JSON Back to a Dart Object (fromJson())
  factory Expense.fromJson(Map<String, dynamic> jsonData) {
    return Expense(
      id: jsonData['id'],
      amount: jsonData['amount'],
      categoryId: jsonData['categoryId'],
      payee: jsonData['payee'],
      note: jsonData['note'],
      date: jsonData['date'],
      tag: jsonData['tag'],
    );
  }

  //convert the object map to json using the toJson()

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount,
      'categoryId': categoryId,
      'payee': payee,
      'note': note,
      'date': date.toIso8601String(),
      'tag': tag,
    };
  }
}
