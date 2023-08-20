import 'package:flutter/material.dart';
import 'package:webtoon_app/models/webtoon.dart';
import 'package:webtoon_app/services/api_service.dart';
import 'package:webtoon_app/widget/webtoon_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final Future<List<WebtoonModel>> webtoons = ApiService().getTodaysToons();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 5,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Today's Webtoon",
          style: TextStyle(
            fontSize: 24,
          ),
        ),
      ),
      body: FutureBuilder(
        future: webtoons,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Expanded(child: makeListView(snapshot))
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  ListView makeListView(AsyncSnapshot<List<WebtoonModel>> snapshot) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data!.length,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      itemBuilder: (context, index) {
        var webtoon = snapshot.data![index];
        return Webtoon(
          title: webtoon.title,
          thumb: webtoon.thumb,
          id: webtoon.id,
        );
      },
      separatorBuilder: (context, index) => const SizedBox(width: 40),
    );
  }
}
