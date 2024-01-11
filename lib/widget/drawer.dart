import 'package:flutter/material.dart';

class AiDrawer extends StatelessWidget {
  const AiDrawer({super.key, required this.updateLanguage});
  final Function(String) updateLanguage;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Theme.of(context).appBarTheme.backgroundColor),
            height: 50,
            child: Center(
              child: Text("AI Assistant"),
            ),
          ),
          ExpansionTile(
            title: Text("Choose Voice"),
            children: [
              ListTile(title: Text("    • Man")),
              ListTile(title: Text("    • Woman"))
            ],
          ),
          ExpansionTile(
            title: Text("Choose Language"),
            children: [
              ListTile(
                title: const Text("   • English"),
                onTap: () {
                  updateLanguage("English");
                },
              ),
              ListTile(
                title: const Text("   • French"),
                onTap: () {
                  updateLanguage("French");
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
