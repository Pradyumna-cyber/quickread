import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FullNewsPage extends StatelessWidget {
  final Map<String, dynamic> news;

  const FullNewsPage({Key? key, required this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(news['title'] ?? ''),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            if (news['urlToImage'] != null)
              Image.network(
                news['urlToImage'],
                fit: BoxFit.cover,
                width: double.infinity,
                height: 200,
              ),
            Text(news['title']),
            Text(news['description']),
            SizedBox(height: 10),
            Text(
              news['content'] ?? '',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20),

            SizedBox(height: 20),
            TextButton.icon(
              onPressed: () async {
                launch(news['url']);
                // if (newsUrl != null && newsUrl.isNotEmpty) {
                //   if (await canLaunch(newsUrl)) {
                //     launch(news['url']);
                //   } else {
                //     print('Could not launch $newsUrl');
                //   }
                // } else {
                //   print('Invalid URL');
                // }
              },
              icon: Icon(Icons.open_in_browser),
              label: Text('Read Full Article'),
            ),
          ],
        ),
      ),
    );
  }
}
