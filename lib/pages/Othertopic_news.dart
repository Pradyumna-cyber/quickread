import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:quickread/pages/othernews.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MaterialApp(
    home: OtherNewstopic(),
  ));
}

class OtherNewstopic extends StatefulWidget {
  const OtherNewstopic({Key? key}) : super(key: key);

  @override
  _OtherNewstopicState createState() => _OtherNewstopicState();
}

class _OtherNewstopicState extends State<OtherNewstopic> {
  late List<dynamic> _teslaNews = [];
  late List<dynamic> _appleNews = [];
  late List<dynamic> _USNews = [];
  late List<dynamic> _TechNews = [];

  @override
  void initState() {
    super.initState();
    _fetchTeslaNews();
    _fetchAppleNews();
    _fetchUSNews();
    _fetchtechcrunchNews();
  }

  Future<void> _fetchTeslaNews() async {
    String apiKey = '141b96c61b214ef7a62dafaff0256704'; // Replace this with your News API key
    String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    String lastMonthDate = DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(const Duration(days: 30)));

    // Tesla news API URL
    String teslaApiUrl = 'https://newsapi.org/v2/everything?q=tesla&from=$lastMonthDate&to=$currentDate&sortBy=publishedAt&apiKey=$apiKey';

    try {
      final http.Response response = await http.get(Uri.parse(teslaApiUrl));
      if (response.statusCode == 200) {
        setState(() {
          _teslaNews = json.decode(response.body)['articles'];
        });
      } else {
        throw Exception('Failed to load Tesla news');
      }
    } catch (e) {
      print('Error fetching Tesla news: $e');
    }
  }

  Future<void> _fetchAppleNews() async {
    String apiKey = '141b96c61b214ef7a62dafaff0256704'; // Replace this with your News API key
    String yesterdayDate = DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(const Duration(days: 1)));

    // Apple news API URL
    String appleApiUrl = 'https://newsapi.org/v2/everything?q=apple&from=$yesterdayDate&to=$yesterdayDate&sortBy=popularity&apiKey=$apiKey';

    try {
      final http.Response response = await http.get(Uri.parse(appleApiUrl));
      if (response.statusCode == 200) {
        setState(() {
          _appleNews = json.decode(response.body)['articles'];
        });
      } else {
        throw Exception('Failed to load Apple news');
      }
    } catch (e) {
      print('Error fetching Apple news: $e');
    }
  }
  Future<void> _fetchUSNews() async {

    // Apple news API URL
    String usApiUrl = 'https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=141b96c61b214ef7a62dafaff0256704';

    try {
      final http.Response response = await http.get(Uri.parse(usApiUrl));
      if (response.statusCode == 200) {
        setState(() {
          _USNews = json.decode(response.body)['articles'];
        });
      } else {
        throw Exception('Failed to load US headlines');
      }
    } catch (e) {
      print('Error fetching US headlines: $e');
    }
  }
  Future<void> _fetchtechcrunchNews() async {

    // Apple news API URL
    String usApiUrl = 'https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=141b96c61b214ef7a62dafaff0256704';

    try {
      final http.Response response = await http.get(Uri.parse(usApiUrl));
      if (response.statusCode == 200) {
        setState(() {
          _TechNews = json.decode(response.body)['articles'];
        });
      } else {
        throw Exception('Failed to load Tech headlines');
      }
    } catch (e) {
      print('Error fetching Tech headlines: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News Topics'),
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewsList(
                    newsList: _teslaNews,
                    category: 'Tesla',
                  ),
                ),
              );
            },
            child: Card(
              margin: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Row(
                  children: [
                   Image.asset('images/tesla.png',width: 36,height: 36,),
                    const Text('Tesla News'),
                  ],
                ), // Display the category
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewsList(
                    newsList: _appleNews,
                    category: 'Apple',
                  ),
                ),
              );
            },
            child: Card(
              margin: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Row(
                  children: [
                    Image.asset('images/apple-logo.png',width: 36,height: 36,),
                    const Text('Apple News'),
                  ],
                ), // Display the category
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewsList(
                    newsList: _USNews,
                    category: 'business',
                  ),
                ),
              );
            },
            child: Card(
              margin: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Row(
                  children: [
                    Image.asset('images/apple-logo.png',width: 36,height: 36,),
                    const Text('US Headliness'),
                  ],
                ), // Display the category
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewsList(
                    newsList: _TechNews,
                    category: 'techcrunch',
                  ),
                ),
              );
            },
            child: Card(
              margin: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Row(
                  children: [
                    Image.asset('images/apple-logo.png',width: 36,height: 36,),
                    const Text('Tech Headliness'),
                  ],
                ), // Display the category
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => startup(

                  ),
                ),
              );
            },
            child: Card(
              margin: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Row(
                  children: [
                    // Image.asset('images/apple-logo.png',width: 36,height: 36,),
                    const Text('Startup News'),
                  ],
                ), // Display the category
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NewsList extends StatelessWidget {
  final List<dynamic> newsList;
  final String category;

  const NewsList({Key? key, required this.newsList, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Filter out null or empty news items
    List validNewsList = newsList.where((news) => news['urlToImage'] != null).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('$category News'),
      ),
      body: validNewsList.isEmpty
          ? const Center(child: Text('No news available', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)))
          : ListView.builder(
        itemCount: validNewsList.length,
        itemBuilder: (context, index) {
          Map<String, dynamic> news = validNewsList[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewsDetails(news: news),
                ),
              );
            },
            child: Card(
              margin: const EdgeInsets.all(8.0),
              elevation: 5, // Add elevation for shadow effect
              child: ListTile(
                title: Image.network(
                  news['urlToImage'],
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 200,
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    news['title'] ?? '',
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class NewsDetails extends StatelessWidget {
  final Map<String, dynamic> news;

  const NewsDetails({Key? key, required this.news}) : super(key: key);

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
            const SizedBox(height: 10),
            Text(
              news['title'] ?? '',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              news['description'] ?? '',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            Text(
              news['content'] ?? '',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            TextButton.icon(
              onPressed: () {
                // Open the URL in a browser
                launch(news['url']);
              },
              icon: const Icon(Icons.open_in_browser),
              label: const Text('Read Full Article', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
