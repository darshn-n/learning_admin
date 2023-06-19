// ignore_for_file: avoid_unnecessary_containers

import 'package:admin/forms/seller_form_videos_books.dart';
import 'package:admin/providers/category_provider.dart';
import 'package:admin/services/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CategoryListScreenWithSortIDMainVideos extends StatelessWidget {
  const CategoryListScreenWithSortIDMainVideos({super.key, required this.adminID});
  final int adminID;

  static const String id = "category-videos-upload-screen";

  @override
  Widget build(BuildContext context) {
    FirebaseService service = FirebaseService();
    var catProvider = Provider.of<CategoryProvider>(context);

    return MyCategoriesAtHomeSortID(
      service: service,
      catProvider: catProvider,
      isEqualTo: adminID,
      route: SellerFormVideos.id,
    );
  }
}


class MyCategoriesAtHomeSortID extends StatelessWidget {
  const MyCategoriesAtHomeSortID({
    super.key,
    required this.service,
    required this.catProvider,
    required this.isEqualTo,
    required this.route,
  });
  static const String id = "my-cat-at-home-screen";

  final FirebaseService service;
  final CategoryProvider catProvider;
  final int isEqualTo;
  final String route;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Row(
          children: [
            InkWell(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Made by Darshan',
                      style: GoogleFonts.syne(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                );
              },
              child: Text(
                'Categories',
                style: GoogleFonts.lato(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: FutureBuilder<QuerySnapshot>(
          future: service.categories
              .where(
                "admin",
                isEqualTo: isEqualTo,
              )
              .get(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                          route,
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
      ),
    );
  }
}
