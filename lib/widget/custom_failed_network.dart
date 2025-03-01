import 'package:flutter/material.dart';

class ConnectFailed extends StatelessWidget {
  const ConnectFailed({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.wifi_off, size: 50, color: Colors.red),
          SizedBox(height: 10),
          Text("Connection failed. Please check your internet."),
        ],
      ),
    );
  }
}
