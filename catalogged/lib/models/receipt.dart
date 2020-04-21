import 'package:intl/intl.dart';

class Receipt {
  String receipt_id;
  String category;
  String person;
  String store;
  String payment_type;
  String purchase_date;
  String return_date;
  String img_url;
  String note;

  Receipt();

  Receipt.fromMap(Map<String, dynamic> data) {
    receipt_id = data['receipt_id'] ?? null;
    category = data['category'] ?? null;
    person = data['person'] ?? null;
    store = data['store'] ?? null;
    payment_type = data['payment_type'];

    print(data['purchase_date']);
//    DateFormat formatter = new DateFormat('yyyy-MM-dd');

    if (!["", null, 0, 'null'].contains(data['purchase_date'])) {
      purchase_date = data['purchase_date'].toString();
    }
    if (!["", null, 0, 'null'].contains(data['return_date'])) {
      return_date = data['return_date'].toString();
    }
//    if (data['return_date'] != null) {
//      DateTime returnDate = DateTime.parse(data['return_date'].toDate());
//      return_date = formatter.format(returnDate);
//    }

//    purchase_date = DateTime.parse(data['purchase_date'].toDate().toString());
//    return_date = DateTime.parse(data['return_date'].toDate().toString());

    img_url = data['img_url'];
    note = data['note'];
  }

  Map<String, dynamic> toMap() {
    return {
      'receipt_id': receipt_id,
      'category': category,
      'person': person,
      'store': store,
      'payment_type': payment_type,
      'purchase_date': purchase_date,
      'return_date': return_date,
      'img_url': img_url,
      'note': note
    };
  }

  String convertDateTimeDisplay(String date) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    final DateFormat serverFormater = DateFormat('dd-MM-yyyy');
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    return formatted;
  }
}
