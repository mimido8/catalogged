import 'package:catalogged/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:catalogged/notifier/receipt_notifier.dart';
import 'package:provider/provider.dart';

class ReceiptDetail extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    ReceiptNotifier receiptNotifier =
        Provider.of<ReceiptNotifier>(context, listen: false);

    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.lightBlue,
          title: Text("Receipt Detail", textAlign: TextAlign.left),
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.account_circle, color: Colors.white),
              label: Text("logout", style: TextStyle(color: Colors.white)),
              onPressed: () async {
                await _auth.signOut();
              },
            )
          ],
        ),
        body: SingleChildScrollView(
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
            decoration: InputDecoration(labelText: 'Author'),
            initialValue: receiptNotifier.currentReceipt.person,
            readOnly: true,
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 10),
          TextFormField(
            decoration: InputDecoration(labelText: 'Purchase Date'),
            initialValue: receiptNotifier.currentReceipt.purchase_date,
            readOnly: true,
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 10),
          TextFormField(
            decoration: InputDecoration(labelText: 'Return Date'),
            initialValue: receiptNotifier.currentReceipt.return_date,
            readOnly: true,
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 10),
          TextFormField(
            decoration: InputDecoration(labelText: 'Decription'),
            initialValue: receiptNotifier.currentReceipt.note,
            readOnly: true,
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 10),
          TextFormField(
            decoration: InputDecoration(labelText: 'Payment Type'),
            initialValue: receiptNotifier.currentReceipt.payment_type,
            readOnly: true,
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 10),
          TextFormField(
            decoration: InputDecoration(labelText: 'Store'),
            initialValue: receiptNotifier.currentReceipt.store,
            readOnly: true,
            style: TextStyle(fontSize: 20),
          ),
        ])))));
  }
}
