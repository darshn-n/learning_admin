// ignore_for_file: unused_local_variable, depend_on_referenced_packages

import 'package:admin/providers/product_provider.dart';
import 'package:admin/screens/product_details_screen.dart';
import 'package:admin/services/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDisplayCard extends StatefulWidget {
  const ProductDisplayCard({
    Key? key,
    required this.data,
  }) : super(key: key);

  final QueryDocumentSnapshot<Object?> data;

  @override
  State<ProductDisplayCard> createState() => _ProductDisplayCardState();
}

class _ProductDisplayCardState extends State<ProductDisplayCard> {
  FirebaseService service = FirebaseService();



  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProductProvider>(context);
    return InkWell(
      onTap: () {
        provider.getProductDetails(widget.data);
        Navigator.pushNamed(context, ProductDetailsScreen.id);
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black26,
          ),
          borderRadius: BorderRadius.circular(
            4,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  const SizedBox(
                    height: 60.0,
                  ),
                  // Price:
                  Text(
                    widget.data['text'],
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    widget.data['link'],
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
