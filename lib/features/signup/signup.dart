import 'package:flutter/material.dart';
import 'package:quiz/features/categories/categories.dart';
import 'package:quiz/features/home/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  String onlineId = "quizzy";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: CircleAvatar(
                radius: 50,
                backgroundImage:
                    NetworkImage('https://robohash.org/$onlineId.png'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _controller,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Name is mandatory";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          label: Text("Name"),
                          border: OutlineInputBorder(),
                          hintText: "Please enter your name"),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: TextFormField(
                        onChanged: (value) {
                          setState(() {
                            onlineId = value;
                          });
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Online Id is mandatory";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            label: Text("Online Id"),
                            border: OutlineInputBorder(),
                            hintText:
                                "How would you like to be called? ex: #simple_brilliant"),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    minimumSize: Size(MediaQuery.of(context).size.width, 50)),
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    final SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    await prefs.setStringList("user",
                        [_controller.text, onlineId, UniqueKey().toString()]);
                    // ignore: use_build_context_synchronously
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SelectCategory(),
                      ),
                    );
                  }
                },
                icon: const Icon(Icons.arrow_forward),
                label: const Text("Lets go!"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
