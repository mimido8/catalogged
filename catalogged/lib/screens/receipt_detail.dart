import 'package:catalogged/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:catalogged/notifier/receipt_notifier.dart';
import 'package:provider/provider.dart';

class ReceiptDetail extends StatelessWidget {
  final AuthService _auth = AuthService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    ReceiptNotifier receiptNotifier =
        Provider.of<ReceiptNotifier>(context, listen: false);

    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.blue[700],
          title: Text("Receipt Detail", textAlign: TextAlign.left),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(15),
            child: Form(
              key: _formKey,
              child: Center(
                  child: Container(
                      child: Column(children: <Widget>[
                        Image.network(
                          receiptNotifier.currentReceipt.img_url != null
                              ? receiptNotifier.currentReceipt.img_url
                              : 'https://www.generationsforpeace.org/wp-content/uploads/2018/03/empty.jpg',
                          width: MediaQuery.of(context).size.width,
                          height: 250,
                          fit: BoxFit.fitWidth,
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Purchase Date'),
                          initialValue: receiptNotifier.currentReceipt.purchase_date,
                          readOnly: false,
                          onSaved: (value) => receiptNotifier.currentReceipt.purchase_date = value,
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Return Date'),
                          initialValue: receiptNotifier.currentReceipt.return_date,
                          readOnly: false,
                          onSaved: (value) => receiptNotifier.currentReceipt.return_date = value,
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Note'),
                          initialValue: receiptNotifier.currentReceipt.note,
                          readOnly: false,
                          style: TextStyle(fontSize: 20),
                          onSaved: (value) => receiptNotifier.currentReceipt.note = value,
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Payment Type'),
                          initialValue: receiptNotifier.currentReceipt.payment_type,
                          readOnly: false,
                          onSaved: (value) => receiptNotifier.currentReceipt.payment_type = value,
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Store'),
                          initialValue: receiptNotifier.currentReceipt.store,
                          readOnly: false,
                          style: TextStyle(fontSize: 20),
                          onSaved: (value) => receiptNotifier.currentReceipt.store = value,
                        ),
                        SizedBox(height: 10),
                        FlatButton(
                          onPressed: (){_formKey.currentState.save();
                          Navigator.pop(context);
                          },
                          color: Colors.green,
                          child: Text("Save"),
                        )
                      ]))),
            )));
  }
}
