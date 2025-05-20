// widgets/history_item_tile.dart
import 'package:flutter/material.dart';

class HistoryItemTile extends StatelessWidget {
  final String title;
  final String date;

  const HistoryItemTile({
    Key? key,
    required this.title,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.transparent,
          backgroundImage: AssetImage('assets/images/logo.png'), // Replace with your asset
        ),
        title: Text(title),
        subtitle: Text('Date: $date'),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFFD9F3EC),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
            'Paid',
            style: TextStyle(color: Color(0xFF177D5E)),
          ),
        ),
      ),
    );
  }
}
