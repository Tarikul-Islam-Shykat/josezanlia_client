// widgets/history_item_tile.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HistoryItemTile extends StatelessWidget {
  final String title;
  final String date;

  const HistoryItemTile({super.key, required this.title, required this.date});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.3,
      // shadowColor: Color(0xFF000000).withValues(alpha: 0.15),
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.transparent,
          backgroundImage: AssetImage('assets/images/logo.png'),
        ),
        title: Text(title),
        subtitle: Text('Date: $date'),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            // color: const Color(0xFF66B3A6),
            color: Color(0xFF66B3A6),
            borderRadius: BorderRadius.circular(8.r),
            // borderRadius: BorderRadius.horizontal(
            //   left: Radius.circular(16.0),
            //   right: Radius.circular(16.0),
            // ),
          ),
          child: const Text('Paid', style: TextStyle(color: Color(0xFFFFFFFF))),
        ),
      ),
    );
  }
}
