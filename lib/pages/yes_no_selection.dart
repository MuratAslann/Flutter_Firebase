import 'package:firebase_deneme/src/app_state.dart';
import 'package:flutter/material.dart';

class YesNoSelection extends StatelessWidget {
  const YesNoSelection({
    super.key,
    required this.state,
    required this.onSelection,
  });

  final Attending state;
  final void Function(Attending selection) onSelection;

  @override
  Widget build(BuildContext context) {
    switch (state) {
      case Attending.yes:
        return Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              FilledButton(
                onPressed: () => onSelection(Attending.yes),
                child: Text("KATIL"),
              ),

              SizedBox(width: 8),

              FilledButton(
                onPressed: () => onSelection(Attending.no),
                child: Text("KATILMA"),
              ),
            ],
          ),
        );

      case Attending.no:
        return Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              FilledButton(
                onPressed: () => onSelection(Attending.yes),
                child: Text("KATIL"),
              ),

              SizedBox(width: 8),

              FilledButton(
                onPressed: () => onSelection(Attending.no),
                child: Text("KATILMA"),
              ),
            ],
          ),
        );

      default:
        return Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              FilledButton(
                onPressed: () => onSelection(Attending.yes),
                child: Text("KATIL"),
              ),

              SizedBox(width: 8),

              FilledButton(
                onPressed: () => onSelection(Attending.no),
                child: Text("KATILMA"),
              ),
            ],
          ),
        );
    }
  }
}
