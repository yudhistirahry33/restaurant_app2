import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/styles.dart';

import '../provider/providers.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Material(
        child: ListTile(
          title: Text('Restaurant Notification', style: subText1),
          trailing: Consumer<SchedulingProvider>(
            builder: (context, scheduled, _) {
              return Switch.adaptive(
                value: scheduled.isScheduled,
                onChanged: (value) async {
                  scheduled.scheduledRestaurant(value);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
