import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/Model/NewsModel.dart';

class NewsController extends GetxController {
  RxBool isLoading = false.obs;
  String country = 'in';
  String language = 'en';
  String apiKey = 'pub_5000780216d8deb17f00cbb6b863c57dc4088';
  RxList<NewsModel> trendingNewsList = <NewsModel>[].obs;
  RxList<NewsModel> newsForYouList = <NewsModel>[].obs;
  RxList<NewsModel> feedNewsList = <NewsModel>[].obs;
  String nextPage = '';
  RxBool hasMore = true.obs;

  @override
  void onInit() {
    super.onInit();
    getTrendingNews();
    getNewsForYou();
    getFeedNews();
  }

  Future<void> getTrendingNews() async {
    isLoading.value = true;
    String baseURL = "https://newsdata.io/api/1/latest?apikey=$apiKey&size=10&language=$language";
    try {
      var response = await http.get(Uri.parse(baseURL));
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        var articles = body['results'];

        for (var news in articles) {
          bool isDuplicate = trendingNewsList.any((e) => e.title == news['title']) ||
              newsForYouList.any((e) => e.title == news['title']) ||
              feedNewsList.any((e) => e.title == news['title']);

          if (!isDuplicate) {
            trendingNewsList.add(NewsModel.fromJson(news));
          }
        }
      } else {
        print("Something went wrong in Trending news");
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getNewsForYou() async {
    isLoading.value = true;
    String baseURL = "https://newsdata.io/api/1/news?apikey=$apiKey&size=10&country=$country&language=$language"; // Customize your query as needed
    try {
      var response = await http.get(Uri.parse(baseURL));
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        var articles = body['results'];

        for (var news in articles) {
          bool isDuplicate = newsForYouList.any((e) => e.title == news['title']) ||
              trendingNewsList.any((e) => e.title == news['title']) ||
              feedNewsList.any((e) => e.title == news['title']);

          if (!isDuplicate) {
            newsForYouList.add(NewsModel.fromJson(news));
          }
        }
      } else {
        print("Something went wrong in News for You");
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getFeedNews() async {
    if (isLoading.value || !hasMore.value) return;

    isLoading.value = true;
    String baseURL = nextPage.isEmpty
        ? "https://newsdata.io/api/1/news?apikey=$apiKey&size=10&language=$language"
        : "https://newsdata.io/api/1/news?apikey=$apiKey&size=10&language=$language&page=$nextPage";
    try {
      var response = await http.get(Uri.parse(baseURL));
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        var articles = body['results'];

        for (var news in articles) {
          bool isDuplicate = feedNewsList.any((e) => e.title == news['title']);

          if (!isDuplicate) {
            feedNewsList.add(NewsModel.fromJson(news));
            print('added');
          }
        }
        nextPage = body['nextPage'] ?? '';
        if (articles.isEmpty || nextPage.isEmpty) {
          hasMore.value = false;
        }

      } else {
        print("Something went wrong in Feed news");
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      isLoading.value = false;
      print(feedNewsList);
    }
  }
}
