import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:quickread/pages/card_swipe.dart';
import '../classes/Article.dart';
import 'Othertopic_news.dart';
import 'fullnewspage.dart';
import 'profilepage.dart'; // Import Profile page file
// import 'package:location/location.dart';

Map map = {} as Map;
Map map1 = {} as Map;
List list = [];
List list2 = [];
List list3=[];
String? selectedCategory;
String? selectcountry;
List<dynamic>? res;
List<String> countries = [
  "Argentina", "Australia", "Austria", "Belgium", "Brazil", "Bulgaria",
  "Canada", "China", "Colombia", "Cuba", "Czech Republic", "Egypt", "France",
  "Germany", "Greece", "Hong Kong", "Hungary", "India", "Indonesia", "Ireland",
  "Israel", "Italy", "Japan", "Latvia", "Lithuania", "Malaysia", "Mexico",
  "Morocco", "Netherlands", "New Zealand", "Nigeria", "Norway", "Philippines",
  "Poland", "Portugal", "Romania", "Russia", "Saudi Arabia", "Serbia",
  "Singapore", "Slovakia", "Slovenia", "South Africa", "South Korea", "Sweden",
  "Switzerland", "Taiwan", "Thailand", "Turkey", "UAE", "Ukraine",
  "United Kingdom", "United States", "Venuzuela",
];

Map<String, String> countryCode = {
  "Argentina": "ar", "Australia": "au", "Austria": "at", "Belgium": "be",
  "Brazil": "br", "Bulgaria": "bg", "Canada": "ca", "China": "cn",
  "Colombia": "co", "Cuba": "cu", "Czech Republic": "cz", "Egypt": "eg",
  "France": "fr", "Germany": "de", "Greece": "gr", "Hong Kong": "hk",
  "Hungary": "hu", "India": "in", "Indonesia": "id", "Ireland": "ie",
  "Israel": "il", "Italy": "it", "Japan": "jp", "Latvia": "lv",
  "Lithuania": "lt", "Malaysia": "my", "Mexico": "mx", "Morocco": "ma",
  "Netherlands": "nl", "New Zealand": "nz", "Nigeria": "ng", "Norway": "no",
  "Philippines": "ph", "Poland": "pl", "Portugal": "pt", "Romania": "ro",
  "Russia": "ru", "Saudi Arabia": "sa", "Serbia": "rs", "Singapore": "sg",
  "Slovakia": "sk", "Slovenia": "si", "South Africa": "za",
  "South Korea": "kr", "Sweden": "se", "Switzerland": "ch", "Taiwan": "tw",
  "Thailand": "th", "Turkey": "tr", "UAE": "ae", "Ukraine": "ua",
  "United Kingdom": "gb", "United States": "us", "Venuzuela": "ve",
};


void navigateToProfile(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const Profile()),
  );
}

void naviagatetoNews(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const OtherNewstopic()),
  );
}

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  late bool isConnected = false;
  String? selectedCountry;
  late Future<void> _fetchData;
  late Future<void> _fetchNews;

  @override
  void initState() {
    super.initState();
    selectedCountry = 'in';
    _fetchData = _apicall(country: 'in',category: selectedCategory);
    _fetchNews = _fetchTrendingNews();
    checkInternetConnectivity().then((connected) {
      setState(() {
        isConnected = connected;
        if (isConnected) {
          Fluttertoast.showToast(
            msg: 'Welcome back!', // Your toast message
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          _apicall(); // Load data when connected
        }
      });
    });

    Connectivity().onConnectivityChanged.listen((result) {
      setState(() {
        isConnected = result != ConnectivityResult.none;
        if (isConnected) {
          Fluttertoast.showToast(
            msg: 'Connection established!', // Your toast message
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          _apicall(); // Load data when connected
        } else {
          // Reset data when disconnected
          setState(() {
            list.clear();
          });
        }
      });
    });
  }
  Future<bool> checkInternetConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  Future<void> _apicall({String? country, String? category}) async {
    String apiKey = '141b96c61b214ef7a62dafaff0256704';
    String apiUrl = 'https://newsapi.org/v2/top-headlines?apiKey=$apiKey';
    if (country != null) {
      apiUrl += '&country=$country';
    }
    if (category != null) {
      apiUrl += '&category=$category';
    }

    final http.Response resp = await http.get(Uri.parse(apiUrl));
    if (resp.statusCode == 200) {
      setState(() {
        list = json.decode(resp.body)['articles'];
        selectedCategory = category; // Update selected category
        selectcountry = country; // Update selected country
      });
    }
  }

  Future<void> _fetchTrendingNews() async {
    http.Response resp = await http.get(Uri.parse(
        'https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=141b96c61b214ef7a62dafaff0256704'));
    if (resp.statusCode == 200) {
      setState(() {
        list2 = json.decode(resp.body)['articles'];
      });
    }
  }


  Future<void> _fetchotheregioNews(String countryCode) async {
    String apiKey = 'YOUR_API_KEY'; // Replace with your API key
    String apiUrl = 'https://newsapi.org/v2/top-headlines?country=$countryCode&apiKey=$apiKey';

    final http.Response resp = await http.get(Uri.parse(apiUrl));
    if (resp.statusCode == 200) {
      setState(() {
        list3 = json.decode(resp.body)['articles'];
      });
    }
  }



  DateTime dateTime = DateTime.now();
  String greetingmsg() {
    var now = DateTime.now();
    int hour = now.hour;
    if (hour < 12) {
      return "Good Morning";
    } else if (hour < 17) {
      return "Good Afternoon";
    } else {
      return "Good Evening";
    }
  }



  String country = '';
  final ConnectivityController _connectivityController = Get.put(ConnectivityController());

  @override
  Widget build(BuildContext context) {
    String greetingMessage = greetingmsg();
    String imagePath = '';
    if (greetingMessage.contains('Morning')) {
      imagePath = 'images/mor.jpg';
    } else if (greetingMessage.contains('Afternoon')) {
      imagePath = 'images/afternoon.jpg';
    } else {
      imagePath = 'images/eve.jpg';
    }


    return Scaffold(
      backgroundColor: Color(0xFFE8E8E8),
      body: isConnected ?
      SafeArea(
        bottom: true,
        child: Stack(children: [
          if (!isConnected)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: Obx(() {
                    if (_connectivityController.isConnected.value) {
                      return Image.asset('images/connected.png',width: 200,height: 200,);
                    } else {
                      return Image.asset('images/disconnected.png');
                    }
                  }),
                ),
              ),
            ),
          Column(
            children: [
              Stack(
                children: [
                  Image.asset(
                      imagePath,
                      width: double.infinity,
                      height: 180,
                      fit: BoxFit.cover,
                    ),

                  Container(
                    width: double.infinity,
                    height: 170,
                    color: Colors.black
                        .withOpacity(0.2), // Semi-transparent overlay color
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                greetingmsg(),
                                style: const TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white, // Text color
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "News",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 21,
                                        color: Colors.black),
                                  ),
                                  // Adding some space between the text widgets
                                  Text(
                                    DateFormat('MMMM d').format(DateTime.now()),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 27,
                                        color: Colors.grey.shade600),
                                  ),
                                ],
                              )

                              ),
                        ),
                        IconButton(
                          onPressed: () {
                            // Show dialog with list of countries
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Select Country'),
                                  contentPadding: EdgeInsets.zero,
                                  content: Container(
                                    width: MediaQuery.of(context).size.width * 0.8,
                                    child: ListView.builder(
                                      itemCount: countries.length,
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                          title: Text(countries[index]),
                                          onTap: () {
                                            // Close dialog and fetch news for selected country
                                            Navigator.pop(context);
                                            _apicall(country: countryCode[countries[index]], category: selectedCategory);
                                          },



                                        );
                                      },
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          icon: Image.asset('images/countries.png',width: 40,height: 40,),
                        ),


                        IconButton(
                            onPressed: () {
                              // open filetrs
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Dialog(
                                    insetAnimationCurve: Curves.elasticOut,
                                    clipBehavior: Clip.antiAlias,
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              _apicall(
                                                  category: 'entertainment');
                                              Navigator.pop(context);
                                            },
                                            child: const Text("Entertainment"),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              _apicall(category: 'business');
                                              Navigator.pop(context);
                                            },
                                            child: const Text("Business"),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              _apicall(category: 'health');
                                              Navigator.pop(context);
                                            },
                                            child: const Text("Health"),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              _apicall(category: 'science');
                                              Navigator.pop(context);
                                            },
                                            child: const Text("Science"),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              _apicall(category: 'sports');
                                              Navigator.pop(context);
                                            },
                                            child: const Text("Sports"),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              _apicall(category: 'technology');
                                              Navigator.pop(context);
                                            },
                                            child: const Text("Technology"),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                         icon: Icon(
                           Icons.local_fire_department_sharp,
                           size: 40,
                           color: Colors.deepOrange[600],
                         ),
                          ),

                      ],
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Card(
                            child: TextButton(
                              onPressed: () {
                                _apicall(category: 'entertainment',country: selectedCountry);
                              },
                              style: ButtonStyle(
                                textStyle: MaterialStateProperty.all<TextStyle>(
                                  TextStyle(
                                    decoration: selectedCategory == 'entertainment'
                                        ? TextDecoration.underline
                                        : TextDecoration.none,
                                    decorationStyle: selectedCategory == 'entertainment'
                                        ? TextDecorationStyle.solid
                                        : TextDecorationStyle.double,
                                    fontSize: selectedCategory == 'entertainment' ? 18 : 16,
                                  ),
                                ),
                              ),
                              child: const Text("Entertainment"),
                            ),
                          ),
                          Card(
                            child: TextButton(
                              onPressed: () {
                                _apicall(category: 'business',country: selectedCountry);
                              },
                              style: ButtonStyle(
                                textStyle: MaterialStateProperty.all<TextStyle>(
                                  TextStyle(
                                    decoration: selectedCategory == 'business'
                                        ? TextDecoration.underline
                                        : TextDecoration.none,
                                    decorationStyle:
                                        selectedCategory == 'business'
                                            ? TextDecorationStyle.dashed
                                            : TextDecorationStyle.solid,
                                    fontSize:
                                        selectedCategory == 'business' ? 18 : 16,
                                  ),
                                ),
                              ),
                              child: const Text("Business"),
                            ),
                          ),
                          Card(
                            child: TextButton(
                              onPressed: () {
                                _apicall(category: 'health',country: selectedCountry);
                              },
                              style: ButtonStyle(
                                textStyle: MaterialStateProperty.all<TextStyle>(
                                  TextStyle(
                                    decoration: selectedCategory == 'health'
                                        ? TextDecoration.underline
                                        : TextDecoration.none,
                                    decorationStyle: selectedCategory == 'health'
                                        ? TextDecorationStyle.dashed
                                        : TextDecorationStyle.solid,
                                    fontSize:
                                        selectedCategory == 'health' ? 18 : 16,
                                  ),
                                ),
                              ),
                              child: const Text("Health"),
                            ),
                          ),
                          Card(
                            child: TextButton(
                              onPressed: () {
                                _apicall(category: 'science',country: selectedCountry);
                              },
                              style: ButtonStyle(
                                textStyle: MaterialStateProperty.all<TextStyle>(
                                  TextStyle(
                                    decoration: selectedCategory == 'science'
                                        ? TextDecoration.underline
                                        : TextDecoration.none,
                                    decorationStyle: selectedCategory == 'science'
                                        ? TextDecorationStyle.dashed
                                        : TextDecorationStyle.solid,
                                    fontSize:
                                        selectedCategory == 'science' ? 18 : 16,
                                  ),
                                ),
                              ),
                              child: const Text("Science"),
                            ),
                          ),
                          Card(
                            child: TextButton(
                              onPressed: () {
                                _apicall(category: 'sports',country: selectedCountry);
                              },
                              style: ButtonStyle(
                                textStyle: MaterialStateProperty.all<TextStyle>(
                                  TextStyle(
                                    decoration: selectedCategory == 'sports'
                                        ? TextDecoration.underline
                                        : TextDecoration.none,
                                    decorationStyle: selectedCategory == 'sports'
                                        ? TextDecorationStyle.dashed
                                        : TextDecorationStyle.solid,
                                    fontSize:
                                        selectedCategory == 'sports' ? 18 : 16,
                                  ),
                                ),
                              ),
                              child: const Text("Sports"),
                            ),
                          ),
                          Card(
                            child: TextButton(
                              onPressed: () {
                                _apicall(category: 'technology',country: selectedCountry);
                              },
                              style: ButtonStyle(
                                textStyle: MaterialStateProperty.all<TextStyle>(
                                  TextStyle(
                                    decoration: selectedCategory == 'technology'
                                        ? TextDecoration.underline
                                        : TextDecoration.none,
                                    decorationStyle:
                                        selectedCategory == 'technology'
                                            ? TextDecorationStyle.dashed
                                            : TextDecorationStyle.solid,
                                    fontSize: selectedCategory == 'technology'
                                        ? 18
                                        : 16,
                                  ),
                                ),
                              ),
                              child: const Text("Technology"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                // Added Expanded here
                child: FutureBuilder<void>(
                  future: _fetchData,
                  builder:
                      (BuildContext context, AsyncSnapshot<void> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return LiquidPullToRefresh(
                        animSpeedFactor: 4,
                        color: Colors.deepOrange[600],
                        onRefresh: () => _apicall(category: selectedCategory),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: list.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(7.0),
                              child: Card(
                                color: Colors.white,
                                clipBehavior: Clip.antiAlias,
                                child: Column(
                                  children: [
                                    ListTile(
                                      leading: Container(
                                        width: 100,
                                        height: 100,
                                        child: Image.network(
                                          list[index]['urlToImage'] ?? '',
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return  Center(
                                                child:
                                                Image.asset('images/error-404.png'),
                                                // Text(
                                                //     'Image failed to load 😢')

                                            );
                                          },
                                        ),
                                      ),
                                      title: TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  FullNewsPage(
                                                      news: list[index]),
                                            ),
                                          );
                                        },
                                        child: Text(
                                          list[index]['title'] ?? '',
                                          style: const TextStyle(
                                            color: Colors.blue,
                                            decoration: TextDecoration.none,
                                          ),
                                        ),
                                      ),
                                      subtitle: Text(
                                        list[index]['description'] ?? '',
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }
                  },
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                child: SafeArea(
                  bottom: true,
                  child: GNav(
                    tabBackgroundColor: Colors.white70,
                    gap: 8,
                    tabs: [
                      const GButton(
                        icon: Icons.home,
                        text: "Home",
                      ),
                      GButton(
                        onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>  const livetv()),
                          );
                        },
                        icon: Icons.video_file_rounded,
                        text: 'Video News',
                        backgroundColor: Colors.orange.shade300,
                      ),
                      GButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const OtherNewstopic()),
                          );
                        },
                        icon: Icons.insert_drive_file_outlined,
                        text: 'News',
                      ),
                      GButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Profile()),
                          );
                        },
                        icon: Icons.person_pin,
                        text: 'Profile',
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ]),
      ):
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/disconnected.png',
              fit: BoxFit.cover,
              width:200,
              height: 200,
            ),
            const SizedBox(height: 20),
            const Text(
              'No Internet Connection 😢',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
