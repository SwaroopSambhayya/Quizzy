import 'package:flutter/material.dart';
import 'package:quiz/core/const.dart';

class LeaderBoard extends StatelessWidget {
  const LeaderBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: const Text("Leader Board"),
            stretch: true,
            expandedHeight: 225,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Padding(
                padding: const EdgeInsets.all(25.0).copyWith(bottom: 10),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RankDP(
                      gradients: silverConstants,
                      onlineId: 'swaroop',
                    ),
                    RankDP(gradients: goldenConstants, onlineId: 'ganesh'),
                    RankDP(gradients: bronzeConstants, onlineId: 'ramesh')
                  ],
                ),
              ),
            ),
          ),
          SliverList.builder(
            itemBuilder: (context, index) => ListTile(
              leading: RankDP(
                gradients: tileGradients,
                onlineId: "swaroop",
                tileMode: true,
              ),
              title: const Text('Swaroop S'),
              subtitle: const Text('#swaroop'),
              trailing: const Text('400pt'),
            ),
            itemCount: 10,
          )
        ],
      ),
    );
  }
}

class RankDP extends StatelessWidget {
  final List<Color> gradients;
  final String onlineId;
  final bool tileMode;
  const RankDP(
      {super.key,
      required this.gradients,
      required this.onlineId,
      this.tileMode = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (!tileMode)
          Text(
            gradients == goldenConstants
                ? "1"
                : gradients == silverConstants
                    ? "2"
                    : "3",
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        Container(
          padding:
              tileMode ? const EdgeInsets.all(2.5) : const EdgeInsets.all(5),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(colors: gradients),
          ),
          child: CircleAvatar(
            radius: tileMode
                ? 20
                : gradients == goldenConstants
                    ? 45
                    : 35,
            backgroundImage: NetworkImage('https://robohash.org/$onlineId.png'),
          ),
        ),
        if (!tileMode)
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              "#$onlineId",
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          )
      ],
    );
  }
}
