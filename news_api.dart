import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';

// API used: https://newsapi.org/

class NewsAPI extends StatefulWidget {
  const NewsAPI({Key? key}) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsAPI> {
  List<dynamic> _articles = [];
  bool _isLoading = true;
  final String apiKey =
      '021971797f1343cda4947901772a302c'; // API key from https://newsapi.org/

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  Future<void> fetchNews() async {
    final response = await http.get(
      Uri.parse(
          'https://newsapi.org/v2/top-headlines?country=us&apiKey=$apiKey'),
    );

    if (response.statusCode == 200) {
      setState(() {
        _articles = json.decode(response.body)['articles'];
        _isLoading = false;
      });
    } else {
      throw Exception('Failed to load news');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Earth News',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 30, 107, 240))),
        backgroundColor: const Color.fromARGB(255, 30, 28, 152),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _articles.map((article) {
                  return Container(
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 21, 71, 222)),
                    width: 300, // Set a fixed width for each news card
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    child: Card(
                      color: const Color.fromARGB(255, 15, 87, 242),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (article['urlToImage'] != null)
                            Image.network(
                              article['urlToImage'],
                              fit: BoxFit.cover,
                              height: 150, // Set a fixed height for images
                              width: double.infinity,
                            ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () async {
                                final url = article['url'];
                                if (await canLaunchUrl(Uri.parse(url))) {
                                  await launchUrl(Uri.parse(url),
                                      mode: LaunchMode.externalApplication);
                                } else {
                                  throw 'Could not launch $url';
                                }
                              },
                              child: Text(
                                article['title'],
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: const Color.fromARGB(255, 255, 255,
                                      255), // Change title color to indicate it's clickable
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
    );
  }
}
