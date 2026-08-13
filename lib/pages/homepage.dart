import 'package:firebase_deneme/pages/guest_book.dart';
import 'package:firebase_deneme/pages/yes_no_selection.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, PhoneAuthProvider;

import 'package:provider/provider.dart';

import '../src/app_state.dart';
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
          IconAndDetail(Icons.calendar_today, "10.08.2026"),
          const IconAndDetail(Icons.location_city, 'İstanbul'),

          Consumer<ApplicationState>(
            builder: (context, appstate, _) => AuthFunc(
              loggedIn: appstate.loggedIn,
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
            builder: (context, appState, _) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                switch (appState.attendees) {
                  1 => const Paragraph('Sadece 1 insan katılıyor'),

                  >= 2 => Paragraph(
                    '${appState.attendees} kadar kişi geliyor ',
                  ),

                  _ => const Paragraph('Kimse katılmıyor'),
                },

                if (appState.loggedIn) ...[
                  YesNoSelection(
                    state: appState.attending,
                    onSelection: (attending) =>
                        appState.attending = attending,
                  ),

                  const Divider(
                    height: 8,
                    thickness: 1,
                    indent: 8,
                    endIndent: 8,
                    color: Colors.grey,
                  ),

                  const Header("SOHBET"),

                  GuestBook(
                    addMessage: (message) =>
                        appState.addMessageToGuestBook(message),
                    messages: appState.guestBookMessage,
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
