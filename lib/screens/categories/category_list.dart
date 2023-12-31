// ignore_for_file: avoid_unnecessary_containers

import 'package:admin/providers/category_provider.dart';
import 'package:admin/screens/products_by_category.dart';
import 'package:admin/services/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryListScreen extends StatelessWidget {
  const CategoryListScreen({super.key});

  static const String id = "category-list-screen";

  @override
  Widget build(BuildContext context) {
    FirebaseService service = FirebaseService();
    var catProvider = Provider.of<CategoryProvider>(context);

    return MyCategoriesAtHome(service: service, catProvider: catProvider);
  }
}

class MyCategoriesAtHome extends StatelessWidget {
  const MyCategoriesAtHome({
    super.key,
    required this.service,
    required this.catProvider,
  });

  final FirebaseService service;
  final CategoryProvider catProvider;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: FutureBuilder<QuerySnapshot>(
        future: service.categories.get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Container();
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Container(
                child: const Center(child: CircularProgressIndicator()),
              ),
            );
          }

          return Container(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                var doc = snapshot.data!.docs[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    onTap: () {
                      // Products by Category
                      catProvider.getCategory(doc['catName']);
                      catProvider.getCatSnapshot(doc);
                      // Product by category
                      Navigator.pushNamed(
                        context,
                        ProductByCategory.id,
                        arguments: doc,
                      );
                    },
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
            ),
          );
        },
      ),
    );
  }
}
