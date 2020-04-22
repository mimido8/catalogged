import 'dart:io';

import 'package:catalogged/screens/wrapper.dart';
import 'package:catalogged/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:catalogged/models/user.dart';
import 'package:catalogged/models/receipt.dart';
import 'package:catalogged/notifier/receipt_notifier.dart';
import 'package:catalogged/api/receipt_api.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

class AddReceipt extends StatefulWidget {
  final bool isUpdating;

  AddReceipt({@required this.isUpdating});

  @override
  _AddReceiptState createState() => _AddReceiptState();
}

class _AddReceiptState extends State<AddReceipt> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final AuthService _auth = AuthService();
  final format = DateFormat("yyyy-MM-dd");

  Receipt _currentReceipt;
  String _imageUrl;
  File _imageFile;
  TextEditingController subingredientController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    ReceiptNotifier receiptNotifier =
        Provider.of<ReceiptNotifier>(context, listen: false);
    if (receiptNotifier.currentReceipt != null) {
      _currentReceipt = receiptNotifier.currentReceipt;
    } else {
      _currentReceipt = Receipt();
    }
  }

  Widget _showImage() {
    if (_imageFile == null && _imageUrl == null) {
      return Container(
        height: 100, width: 100, color: Colors.black12, child: Center(child: Text('+ add image')),
      );
    } else if (_imageFile != null) {
      print('showing image from local file');
      return Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: <Widget>[
          Image.file(
            _imageFile,
            fit: BoxFit.cover,
            height: 250,
          ),
          FlatButton(
            padding: EdgeInsets.all(16),
            color: Colors.black54,
            child: Text(
              'Change Image',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w400),
            ),
            onPressed: () => _getLocalImage(),
          )
        ],
      );
    } else if (_imageUrl != null) {
      print('showing image from url');
      return Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: <Widget>[
          Image.network(
            _imageUrl,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
            height: 250,
          ),
          FlatButton(
            padding: EdgeInsets.all(16),
            color: Colors.black54,
            child: Text(
              'Change Image',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w400),
            ),
            onPressed: () => _getLocalImage(),
          )
        ],
      );
    }
  }

  _getLocalImage() async {
    File imageFile = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50, maxWidth: 400);

    if (imageFile != null) {
      setState(() {
        _imageFile = imageFile;
      });
    }
  }

  Widget _buildStoreField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Store'),
//      initialValue: _currentFood.name,
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 20),
      validator: (String value) {
        if (value.isEmpty) {
          return "Store is required";
        }
      },
      onSaved: (String value) {
        _currentReceipt.store = value;
      },
    );
  }

  Widget _buildCategoryField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Category'),
//      initialValue: _currentFood.name,
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 20),
      validator: (String value) {
        if (value.isEmpty) {
          return "Category is required";
        }
      },
      onSaved: (String value) {
        _currentReceipt.category = value;
      },
    );
  }

  Widget _buildPaymentTypeField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Payment Type'),
//      initialValue: _currentFood.name,
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 20),
      validator: (String value) {
        if (value.isEmpty) {
          return "Payment Type is required";
        }
      },
      onSaved: (String value) {
        _currentReceipt.payment_type = value;
      },
    );
  }

  Widget _buildNoteField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Note'),
//      initialValue: _currentFood.name,
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 20),
      validator: (String value) {
        if (value.isEmpty) {
          return "Note Type is required";
        }
      },
      onSaved: (String value) {
        _currentReceipt.note = value;
      },
    );
  }

  Widget _buildPersonField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Author'),
//      initialValue: _auth,
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 20),
      validator: (String value) {
        if (value.isEmpty) {
          return "Author is required";
        }
      },
      onSaved: (String value) {
        _currentReceipt.person = value;
      },
    );
  }

  Widget _buildPurchaseDateField() {
    return DateTimeField(
      format: format,
      decoration: InputDecoration(labelText: 'Purchase Date'),
      onShowPicker: (context, currentValue) {
        return showDatePicker(
            context: context,
            firstDate: DateTime(1900),
            initialDate: currentValue ?? DateTime.now(),
            lastDate: DateTime(2100));
      },
      onSaved: (DateTime purchaseDate) {
        //Convert to string ("yyyy-MM-dd")
        _currentReceipt.purchase_date = format.format(purchaseDate) ?? null;
      },
    );
  }

  Widget _buildReturnDateField() {
    return DateTimeField(
      format: format,
      decoration: InputDecoration(labelText: 'Return Date'),
      onShowPicker: (context, currentValue) {
        return showDatePicker(
            context: context,
            firstDate: DateTime(1900),
            initialDate: currentValue ?? DateTime.now(),
            lastDate: DateTime(2100));
      },
      onSaved: (DateTime purchaseDate) {
        //Convert to string ("yyyy-MM-dd")
        _currentReceipt.return_date = format.format(purchaseDate) ?? null;
      },
    );
  }

  _receiptUploaded(Receipt receipt) {
    ReceiptNotifier receiptNotifier =
        Provider.of<ReceiptNotifier>(context, listen: false);
    receiptNotifier.addReceipt(receipt);
    Navigator.pop(context);
  }

  _saveReceipt() {
    print('save new Receipt Called');
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    print('form saved');
    uploadReceiptAndImage(_currentReceipt, false, _imageFile, _receiptUploaded);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.blue[700],
        title: Text("Add New Receipt", textAlign: TextAlign.left),
      ),
      body: SingleChildScrollView(
          padding: EdgeInsets.all(32),
          child: Form(
              key: _formKey,
              autovalidate: true,
              child: Column(
                children: <Widget>[
                  _showImage(),
                  SizedBox(height: 16),
                  /*Text(
                    "Create Receipt",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 30),
                  ),*/
                  SizedBox(height: 16),
                  ButtonTheme(
                    child: RaisedButton(
                      onPressed: () => _getLocalImage(),
                      child: Text(
                        "Add Image",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  _buildPurchaseDateField(),
                  _buildReturnDateField(),
                  //_buildPersonField(),
                  _buildStoreField(),
                  //_buildCategoryField(),
                  _buildPaymentTypeField(),
                  _buildNoteField(),
                  SizedBox(height: 16),
                ],
              ))),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FocusScope.of(context).requestFocus(new FocusNode());
          _saveReceipt();
        },
        child: Icon(Icons.save),
        foregroundColor: Colors.white,
      ),
    );
  }
}
