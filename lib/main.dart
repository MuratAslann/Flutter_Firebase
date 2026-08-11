import 'package:flutter/material.dart';

import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'app_state.dart';
import 'pages/homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ChangeNotifierProvider(
      create: (context) => ApplicationState(),
      builder: ((context, child) => const MyApp()),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Firebase Öğrenme',

      theme: ThemeData(
        buttonTheme: Theme.of(
          context,
        ).buttonTheme.copyWith(highlightColor: Colors.deepPurple),

        colorScheme: .fromSeed(seedColor: Colors.deepPurple),

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),

      routerConfig: _router,
    );
  }
}

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
      routes: [
        GoRoute(
          path: 'sign-in',
          builder: (context, state) {
            return SignInScreen(
              actions: [
                ForgotPasswordAction(((context, email) {
                  final uri = Uri(
                    path: '/sign-in/forgot-password',
                    queryParameters: <String, String?>{'email': email},
                  );

                  context.push(uri.toString());
                })),

                AuthStateChangeAction(((context, state) {
                  final user = switch (state) {
                    SignedIn state => state.user,
                    UserCreated state => state.credential.user,
                    _ => null,
                  };

                  if (user == null) {
                    return;
                  }

                  if (state is UserCreated) {
                    user.updateDisplayName(user.email!.split('@')[0]);
                  }

                  if (!user.emailVerified) {
                    user.sendEmailVerification();
                    const snackBar = SnackBar(
                      content: Text(
                        "Lütfen mailinizden email adresinizi doğrulayın",
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }

                  context.pushReplacement('/');
                })),
              ],
            );
          },

          routes: [
            GoRoute(
              path: 'forgot-password',
              builder: (context, state) {
                final arguments = state.uri.queryParameters;

                return ForgotPasswordScreen(
                  email: arguments['email'],
                  headerMaxExtent: 200,
                );
              },
            ),
          ],
        ),

        GoRoute(
          path: 'profile',
          builder: (context, state) {
            return ProfileScreen(
              providers: const [],
              actions: [
                SignedOutAction((context) {
                  context.pushReplacement('/');
                }),
              ],
            );
          },
        ),
      ],
    ),
  ],
);
