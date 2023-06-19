// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseService {
  User? user = FirebaseAuth.instance.currentUser;
  CollectionReference products =
      FirebaseFirestore.instance.collection("uploadsByAdmin");
  CollectionReference categories =
      FirebaseFirestore.instance.collection("categories");

  Future<void> deleteData(String jobId) async {
    try {
      await products.doc(jobId).delete();
    } catch (e) {
      const SnackBar(
        content: Text(
          'Failed to Delete',
        ),
      );
    }
  }
}
