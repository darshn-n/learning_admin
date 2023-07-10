// ignore_for_file: depend_on_referenced_packages

import 'package:admin/providers/category_provider.dart';
import 'package:admin/services/firebase_services.dart';
import 'package:admin/widgets/product_display_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ProductList extends StatelessWidget {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseService service = FirebaseService();
    final format = NumberFormat("##,##,##0");
    var catProvider = Provider.of<CategoryProvider>(context);

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          12,
          8,
          12,
          8,
        ),
        child: FutureBuilder<QuerySnapshot>(
          future: service.products
              .where(
                "category",
                isEqualTo: catProvider.selectedCategory,
              )
              .get(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Padding(
                padding: const EdgeInsets.only(
                  left: 140.0,
                  right: 140.0,
                ),
                child: LinearProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor,
                  ),
                  color: Colors.grey.shade100,
                ),
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 50,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Your Uploads',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 1.3 / 2.8,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: snapshot.data!.size,
                  itemBuilder: (BuildContext context, int index) {
                    var data = snapshot.data!.docs[index];

                    // Display Card:
                    return ProductDisplayCard(
                        data: data,);
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
