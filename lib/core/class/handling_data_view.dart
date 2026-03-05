import 'package:flutter/material.dart';
import 'package:purchase_request_manager/core/class/state_request.dart';

class HandlingDataView extends StatelessWidget {
  final StateRequest state;
  final Widget child;

  const HandlingDataView({super.key, required this.state, required this.child});

  @override
  Widget build(BuildContext context) {
    switch (state) {
      case StateRequest.loading:
        return Center(
          child: CircularProgressIndicator(color: Colors.blueAccent),
        );
      // مثال لإضافته في حالة الـ Offline Failure داخل ملفك
      case StateRequest.offlinefailure:
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [const Text("لا يوجد اتصال بالإنترنت")],
          ),
        );
      case StateRequest.serverfailure:
        return Center(child: Text("Server Failure"));
      case StateRequest.failure:
        return Center(child: Text("failure"));
      case StateRequest.noData:
        return Center(child: Text("NO DATA"));
      default:
        return child;
    }
  }
}
