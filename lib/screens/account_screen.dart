import 'package:admin/screens/categories/category_list_with_sortID.dart';
import 'package:admin/widgets/account_menu.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

String? encodeQueryParameters(Map<String, String> params) {
  return params.entries
      .map((MapEntry<String, String> e) =>
          '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
      .join('&');
}

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});
  static const String id = "account-screen";

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.0,
        title: InkWell(
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Made by Darshan',
                  style: GoogleFonts.syne(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
          child: Text(
            'My Account',
            style: GoogleFonts.lato(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top,
                  left: 25,
                  right: 25,
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Hello Admin",
                style: GoogleFonts.nunito(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: const Color(
                    0xff050609,
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              AccountMenu(
                accountButtonIcon: Icons.pages_outlined,
                accountButtonText: 'Question Papers',
                onPressed: () {
                  Navigator.push<void>(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) =>
                          const CategoryListScreenWithSortIDMainVideos(
                        adminID: 4,
                      ),
                    ),
                  );
                },
              ),
              AccountMenu(
                accountButtonIcon: Icons.video_camera_back,
                accountButtonText: 'YT Vids',
                onPressed: () {
                  Navigator.push<void>(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) =>
                          const CategoryListScreenWithSortIDMainVideos(
                        adminID: 1,
                      ),
                    ),
                  );
                },
              ),
              AccountMenu(
                accountButtonIcon: Icons.book_outlined,
                accountButtonText: 'Books',
                onPressed: () {
                  Navigator.push<void>(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) =>
                          const CategoryListScreenWithSortIDMainVideos(
                        adminID: 2,
                      ),
                    ),
                  );
                },
              ),
              AccountMenu(
                accountButtonIcon: Icons.notes_outlined,
                accountButtonText: 'Notes',
                onPressed: () {
                  Navigator.push<void>(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) =>
                          const CategoryListScreenWithSortIDMainVideos(
                        adminID: 3,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 30.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _launchUrl(url) async {
  if (!await launchUrl(url)) throw 'Could not launch $url';
}
