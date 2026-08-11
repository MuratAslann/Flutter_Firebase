import 'package:firebase_deneme/pages/guest_book.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, PhoneAuthProvider;

import 'package:provider/provider.dart';

import '../app_state.dart';
import '../src/authentication.dart';
import '../src/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("FIREBASE ÖGRENME")),

      body: ListView(
        children: [
          Image.asset('assets/codelab.png'),
          const SizedBox(height: 8),
          const IconAndDetail(Icons.calendar_today, '21.08'),
          const IconAndDetail(Icons.location_city, 'İstanbul'),

          Consumer<ApplicationState>(
            builder: (context, appstate, _) => AuthFunc(
              loggedIn: appstate.loggedin,
              signOut: () {
                FirebaseAuth.instance.signOut();
              },
            ),
          ),

          const Divider(
            height: 8,
            thickness: 1,
            indent: 8,
            endIndent: 8,
            color: Colors.grey,
          ),

          const Header("Bugün ne yiyeceğiz"),
          const Paragraph("Pasta yada dondurma"),

          const Divider(
            height: 8,
            thickness: 1,
            indent: 8,
            endIndent: 8,
            color: Colors.grey,
          ),

          Consumer<ApplicationState>(
            builder: (context, appstate, _) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                if (appstate.loggedin) ...[
                  const Header("SOHBET"),

                  GuestBook(
                    addMessage: (message) =>
                        appstate.addMessageToGuestBook(message),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
