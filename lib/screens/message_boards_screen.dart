import 'package:flutter/material.dart';
import 'message_board_screen.dart';

class MessageBoardsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> boards = [
    {
      'id': 'general',
      'name': 'General Chat',
      'icon': Icons.chat_bubble,
    },
    {
      'id': 'tech',
      'name': 'Tech Talk',
      'icon': Icons.computer,
    },
    {
      'id': 'sports',
      'name': 'Sports',
      'icon': Icons.sports_soccer,
    },
    {
      'id': 'movies',
      'name': 'Movies & TV',
      'icon': Icons.movie,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: boards.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: Icon(boards[index]['icon'], size: 40),
              title: Text(boards[index]['name']),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MessageBoardScreen(
                      boardId: boards[index]['id'],
                      boardName: boards[index]['name'],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}