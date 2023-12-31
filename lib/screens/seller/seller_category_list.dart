import 'package:admin/constants/colors.dart';
import 'package:admin/providers/category_provider.dart';
import 'package:admin/services/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SellerCategoryListScreen extends StatelessWidget {
  const SellerCategoryListScreen({
    super.key,
  });

  static const String id = "seller-category-list-screen";

  @override
  Widget build(BuildContext context) {
    FirebaseService service = FirebaseService();

    var catProvider = Provider.of<CategoryProvider>(context);

    return Scaffold(
      backgroundColor: kscreenBackground,
      appBar: AppBar(
        backgroundColor: kscreenBackground,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        elevation: 0.0,
        title: const Text(
          'Select Your Category',
          style: TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: service.categories
            .orderBy(
              "sortID",
              descending: false,
            )
            .get(),
        builder:
            (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Container();
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              var doc = snapshot.data!.docs[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  onTap: () {
                    catProvider.getCategory(doc['catName']);
                    catProvider.getCatSnapshot(doc);
                    // Sub Categories
                    // Navigator.pushNamed(
                    //   context,
                    //   SellerForm.id,
                    //   arguments: doc,
                    // );
                  },
                  leading: Image.network(
                    doc['image'],
                    width: 40,
                  ),
                  title: Text(
                    doc['catName'],
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 12,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
