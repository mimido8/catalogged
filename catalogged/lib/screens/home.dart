import 'package:catalogged/screens/receipt_detail.dart';
import 'package:catalogged/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:catalogged/notifier/receipt_notifier.dart';
import 'package:catalogged/api/receipt_api.dart';
import 'package:catalogged/screens/add_receipt.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final AuthService _auth = AuthService();
  @override
  void initState() {
    ReceiptNotifier receiptNotifier =
        Provider.of<ReceiptNotifier>(context, listen: false);
    getReceipts(receiptNotifier);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ReceiptNotifier receiptNotifier = Provider.of<ReceiptNotifier>(context);
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.blue[700],
          title: Row(
            children: <Widget>[
              Image.asset('assets/images/receipt-logo.png', height: 35),
              SizedBox(width: 10),
              Text('CataLogged', style: TextStyle(color: Colors.white))
            ],
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add_circle_outline, color: Colors.white),
              onPressed: () {
                receiptNotifier.currentReceipt = null;
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddReceipt()));
              },
            ),
            FlatButton.icon(
              icon: Icon(Icons.account_circle, color: Colors.white),
              label: Text("logout", style: TextStyle(color: Colors.white)),
              onPressed: () async {
                await _auth.signOut();
              },
            )
          ],
        ),
        body: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              contentPadding: const EdgeInsets.all(10),
                leading: Image.network(
                  receiptNotifier.receiptList[index].img_url,
                  width: 120,
                  fit: BoxFit.fitWidth,
                ),
                title: Text(
                    "Receipt At " + receiptNotifier.receiptList[index].store),
                subtitle: Text("Purchase Date: " +
                    receiptNotifier.receiptList[index].purchase_date
                        .toString() +
                    "\nReturn Date : " +
                    receiptNotifier.receiptList[index].return_date.toString()),
                onTap: () {
                  receiptNotifier.currentReceipt =
                      receiptNotifier.receiptList[index];
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return ReceiptDetail();
                  }));
                });
          },
          itemCount: receiptNotifier.receiptList.length,
          separatorBuilder: (BuildContext context, int index) {
            return Divider(
              color: Colors.black,
            );
          },
        ));
  }
}
