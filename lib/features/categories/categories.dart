import 'package:flutter/material.dart';
import 'package:quiz/features/home/home.dart';
import 'package:quiz/features/leader_board/leader_board.dart';
import 'package:quiz/repo/api_client.dart';
import 'package:quiz/shared/model/category.dart';

class SelectCategory extends StatefulWidget {
  const SelectCategory({super.key});

  @override
  State<SelectCategory> createState() => _SelectCategoryState();
}

class _SelectCategoryState extends State<SelectCategory> {
  late Future<List<Category>> categories;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Category"),
      ),
      body: FutureBuilder<List<Category>>(
        future: ApiClient.fetchCategories(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return Container(
              margin: const EdgeInsets.all(10),
              child: ListView.builder(
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(8),
                  child: ListTile(
                    title: Text(
                      snapshot.data![index].name,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Home(
                          category: snapshot.data![index],
                        ),
                      ),
                    ),
                  ),
                ),
                itemCount: snapshot.data!.length,
              ),
            );
          }
        },
      ),
    );
  }
}
