import 'dart:io';
import 'package:catalogged/models/receipt.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:catalogged/notifier/receipt_notifier.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';

getReceipts(ReceiptNotifier receiptNotifier) async {
  QuerySnapshot snapshot =
      await Firestore.instance.collection('receipt_table').getDocuments();
  print(snapshot);
  List<Receipt> _receiptList = [];

  snapshot.documents.forEach((document) {
    Receipt receipt = Receipt.fromMap(document.data);
//    print(receipt.purchase_date);
    _receiptList.add(receipt);
  });
  receiptNotifier.receiptList = _receiptList;
}

uploadReceiptAndImage(Receipt receipt, bool isUpdating, File localFile,
    Function receiptUploaded) async {
  if (localFile != null) {
    print("uploading image");

    var fileExtension = path.extension(localFile.path);
    print(fileExtension);

    var uuid = Uuid().v4();

    final StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('photos/$uuid$fileExtension');

    await firebaseStorageRef
        .putFile(localFile)
        .onComplete
        .catchError((onError) {
      print(onError);
      return false;
    });

    String url = await firebaseStorageRef.getDownloadURL();
    print("download url: $url");
    _uploadReceipt(receipt, isUpdating, receiptUploaded, imageUrl: url);
  } else {
    print('...skipping image upload');
    _uploadReceipt(receipt, isUpdating, receiptUploaded);
  }
}

_uploadReceipt(Receipt receipt, bool isUpdating, Function receiptUploaded,
    {String imageUrl}) async {
  CollectionReference receiptRef =
      Firestore.instance.collection('receipt_table');

  if (imageUrl != null) {
    receipt.img_url = imageUrl;
  }

  if (isUpdating) {
    await receiptRef.document(receipt.receipt_id).updateData(receipt.toMap());

    receiptUploaded(receipt);
    print('updated food with id: ${receipt.receipt_id}');
  } else {
//    receipt.createdAt = Timestamp.now();

    DocumentReference documentRef = await receiptRef.add(receipt.toMap());

    receipt.receipt_id = documentRef.documentID;

    print('uploaded food successfully: ${receipt.toString()}');

    await documentRef.setData(receipt.toMap(), merge: true);

    receiptUploaded(receipt);
  }
}
