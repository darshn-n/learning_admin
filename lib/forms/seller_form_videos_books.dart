// ignore_for_file: avoid_print, depend_on_referenced_packages

import 'package:admin/constants/colors.dart';
import 'package:admin/providers/category_provider.dart';
import 'package:admin/services/firebase_services.dart';
import 'package:admin/widgets/confirm_dialog.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class SellerFormVideos extends StatefulWidget {
  const SellerFormVideos({Key? key}) : super(key: key);
  static const String id = "seller-video-form";

  @override
  State<SellerFormVideos> createState() => _SellerFormVideosState();
}

class _SellerFormVideosState extends State<SellerFormVideos> {
  final _formKey = GlobalKey<FormState>();

  final FirebaseService _service = FirebaseService();
  String postID = const Uuid().v1();
  final _linkController = TextEditingController();
  final _textController = TextEditingController();

  validate(CategoryProvider provider) {
    if (_formKey.currentState!.validate()) {
      if (provider.urlList.isEmpty) {
        provider.dataToCloud.addAll(
          {
            'category': provider.selectedCategory,
            'link': _linkController.text,
            'text': _textController.text,
            'postID': postID
          },
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Your Form failed to Upload.",
            ),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Required Fields are Missing.",
          ),
        ),
      );
    }
  }

  Future<void> saveProductToDb(CategoryProvider provider, context) {
    return _service.products
        .doc(postID)
        .set(
          provider.dataToCloud,
        )
        .then(
      (value) {
        provider.clearData();
      },
    ).catchError(
      (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Failed to Update',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var catProvider = Provider.of<CategoryProvider>(context);

    showConfirmDialog() {
      return confirmDialog(context, catProvider);
    }

    return Scaffold(
      backgroundColor: kscreenBackground,
      appBar: AppBar(
        backgroundColor: kscreenBackground,
        elevation: 0.0,
        iconTheme: const IconThemeData(
          color: Colors.black54,
        ),
        title: const Text(
          "Seller Form",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    catProvider.selectedCategory.toString(),
                    style: GoogleFonts.bebasNeue(
                      fontSize: 40,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.165,
                  ),
                  TextFormField(
                    controller: _linkController,
                    decoration: const InputDecoration(
                      labelText: "Link*",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter the required Field";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: _textController,
                    maxLines: 3,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Masked Text*",
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter the required Field";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 140.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomSheet: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: NeumorphicButton(
                style: NeumorphicStyle(
                  color: Theme.of(context).primaryColor,
                ),
                child: const Text(
                  "Post",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  validate(catProvider);
                  showConfirmDialog();
                  saveProductToDb(catProvider, context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
