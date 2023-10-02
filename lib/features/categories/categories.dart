import 'package:flutter/material.dart';
import 'package:quiz/core/const.dart';
import 'package:quiz/core/utils.dart';
import 'package:quiz/features/leader_board/leader_board.dart';

class SelectCategory extends StatelessWidget {
  const SelectCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Category"),
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 2),
          itemBuilder: (context, index) => Card(
            margin: const EdgeInsets.all(5),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LeaderBoard(),
                  ),
                );
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Icon(
                      getIconMapping(Categories.values[index]),
                      size: 40,
                    ),
                  ),
                  Text(
                    Categories.values[index].name.toUpperCase(),
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ),
          itemCount: Categories.values.length,
        ),
      ),
    );
  }
}
