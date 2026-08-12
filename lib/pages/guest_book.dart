import 'package:flutter/material.dart';

import 'dart:async';

import '../src/widgets.dart';
import '../src/guest_book_message.dart';

class GuestBook extends StatefulWidget {
  const GuestBook({
    super.key,
    required this.addMessage,
    required this.messages,
  });

  final FutureOr<void> Function(String message) addMessage;
  final List<GuestBookMessage> messages;

  @override
  State<GuestBook> createState() => _GuestBookState();
}

class _GuestBookState extends State<GuestBook> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_GuestBookState');
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Padding(
            padding: const EdgeInsets.all(8),

            child: Form(
              key: _formKey,

              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _controller,

                      decoration: const InputDecoration(
                        hintText: 'Mesaj yaz',
                      ),

                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Mesaj yeri boş bırakılamaz.';
                        }

                        return null;
                      },
                    ),
                  ),

                  const SizedBox(width: 8),

                  StyledButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await widget.addMessage(_controller.text);

                        _controller.clear();
                      }
                    },

                    child: Row(
                      children: [
                        Icon(Icons.send),
                        SizedBox(width: 4),
                        Text("GÖNDER"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          for (GuestBookMessage message in widget.messages)
            Text("${message.name}: ${message.message}"),
        ],
      ),
    );
  }
}
