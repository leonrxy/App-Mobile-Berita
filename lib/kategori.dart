import 'dart:math';

import 'package:flutter/material.dart';

class Kategori extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {'name': 'Technology', 'icon': Icons.computer},
    {'name': 'Sports', 'icon': Icons.sports_soccer},
    {'name': 'Politics', 'icon': Icons.gavel},
    {'name': 'Entertainment', 'icon': Icons.movie},
    {'name': 'Food', 'icon': Icons.fastfood},
    {'name': 'Travel', 'icon': Icons.flight},
    {'name': 'Fashion', 'icon': Icons.shopping_bag},
    {'name': 'Health', 'icon': Icons.favorite},
    {'name': 'Education', 'icon': Icons.school},
    {'name': 'Business', 'icon': Icons.business},
    {'name': 'Science', 'icon': Icons.science},
    {'name': 'Environment', 'icon': Icons.eco},
    {'name': 'Art', 'icon': Icons.palette},
    {'name': 'Music', 'icon': Icons.music_note},
    {'name': 'Books', 'icon': Icons.menu_book},
    {'name': 'Gaming', 'icon': Icons.sports_esports},
    {'name': 'Fitness', 'icon': Icons.fitness_center},
    {'name': 'Pets', 'icon': Icons.pets},
    {'name': 'Movies', 'icon': Icons.local_movies},
    {'name': 'Weather', 'icon': Icons.wb_sunny},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Kategori',
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: GridView.count(
        crossAxisCount: 4,
        children: List.generate(categories.length, (index) {
          // Generate a bright color for each container
          final randomColor =
              Color((Random().nextDouble() * 0xFFFFFF).toInt() << 0)
                  .withOpacity(1.0);
          final brightColor = randomColor.computeLuminance() > 0.5
              ? randomColor
              : randomColor.withOpacity(0.5);
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Material(
                elevation: 4, // Set the elevation to a value greater than 0
                shape: CircleBorder(),
                clipBehavior: Clip.antiAlias,
                color: Colors.transparent,
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: brightColor,
                  ),
                  child: Icon(categories[index]['icon']),
                ),
              ),
              SizedBox(height: 8),
              Text(categories[index]['name'],
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  )),
            ],
          );
        }),
      ),
    );
  }
}
