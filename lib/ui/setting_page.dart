import 'package:flutter/material.dart';
import 'package:restaurant_app/common/styles.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          Material(
            child: ListTile(
              title: Text('Restaurant Notification', style: subText1),
              trailing: Switch.adaptive(
                value: false,
                onChanged: (value) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Coming Soon!', style: heading3),
                        content: Text('This feature will be coming soon!', style: subText2),
                        actions: [
                          OutlinedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Back', style: subText1),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}