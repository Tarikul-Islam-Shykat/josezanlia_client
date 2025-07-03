// widgets/history_item_tile.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HistoryItemTile extends StatelessWidget {
  final String title;
  final String date;
  final String status;

  const HistoryItemTile({
    super.key,
    required this.title,
    required this.date,
    required this.status,
  });

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
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
            fontSize: 17,
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        subtitle: Text(
          'Date: $date',
          style: TextStyle(
            fontWeight: FontWeight.normal,
            color: Colors.black54,
            fontSize: 15,
          ),
        ),
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
          child: Text(status, style: TextStyle(color: Color(0xFFFFFFFF))),
        ),
      ),
    );
  }
}
