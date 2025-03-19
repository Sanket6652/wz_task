import 'package:get/get.dart';
import 'package:flutter_project_template/services/network_service.dart';
import 'package:flutter_project_template/models/news_model.dart';
import 'package:flutter_project_template/utils/log_handler_util.dart';

enum NewsStatus { initial, loading, loaded, error }

class NewsController extends GetxController {
  // Dependencies
  final NetworkService _networkService = NetworkService();

  // Observable state variables
  final RxList<NewsResult> _newsList = <NewsResult>[].obs;
  final Rx<NewsStatus> _status = NewsStatus.initial.obs;
  final RxString _errorMessage = ''.obs;
  final RxInt _currentPage = 1.obs;
  final RxBool _hasMoreData = true.obs;

  // Getters
  List<NewsResult> get newsList => _newsList;
  NewsStatus get status => _status.value;
  String get errorMessage => _errorMessage.value;
  bool get hasMoreData => _hasMoreData.value;
  bool get isLoading => _status.value == NewsStatus.loading;

  // Initialize controller
  @override
  void onInit() {
    super.onInit();
    fetchNews();
  }

  // Fetch news data
  Future<void> fetchNews({bool refresh = false}) async {
    if (refresh) {
      _currentPage.value = 1;
      _hasMoreData.value = true;
      _newsList.clear();
    }

    // Don't fetch if we're already loading or have no more data
    if (_status.value == NewsStatus.loading ||
        (!refresh && !_hasMoreData.value)) {
      return;
    }

    _status.value = NewsStatus.loading;

    try {
      final response = await _networkService
          .get('latest?apikey=pub_752375487f07f1ed3b83df04c4f07ca6c8d5c');

      if (response.success) {
        final data = response.body;

        // Parse the news data
        if (data['results'] == null) {
          throw Exception("Missing or null 'results' field in response");
        }
        print(data['results']);
        List<NewsResult> fetchedNews = (data['results'] as List)
            .map((item) => NewsResult.fromJson(item))
            .toList();

        // Check if we've reached the end of available data
        if (fetchedNews.isEmpty) {
          _hasMoreData.value = false;
        } else {
          _currentPage.value++;
          _newsList.addAll(fetchedNews);
        }

        _status.value = NewsStatus.loaded;
      } else {
        _status.value = NewsStatus.error;
        _errorMessage.value = 'Failed to fetch news: ${response.error}';
        LogHandlerUtil.e(_errorMessage.value);
      }
    } catch (e) {
      _status.value = NewsStatus.error;
      _errorMessage.value = 'An error occurred: $e';
      LogHandlerUtil.e(_errorMessage.value);
    }
  }

  // Refresh news data
  Future<void> refreshNews() async {
    await fetchNews(refresh: true);
  }

  // Load more news (pagination)
  Future<void> loadMoreNews() async {
    if (_status.value != NewsStatus.loading && _hasMoreData.value) {
      await fetchNews();
    }
  }

  // Get news details by ID
  Future<NewsModel?> getNewsDetails(String newsId) async {
    try {
      _status.value = NewsStatus.loading;

      final response = await _networkService.get('/news/$newsId');

      if (response.success) {
        final newsData = response.body;
        _status.value = NewsStatus.loaded;
        return NewsModel.fromJson(newsData);
      } else {
        _status.value = NewsStatus.error;
        _errorMessage.value = 'Failed to fetch news details: ${response.error}';
        LogHandlerUtil.e(_errorMessage.value);
        return null;
      }
    } catch (e) {
      _status.value = NewsStatus.error;
      _errorMessage.value = 'An error occurred: $e';
      LogHandlerUtil.e(_errorMessage.value);
      return null;
    }
  }

  // Search news by term
  Future<List<NewsModel>> searchNews(String searchTerm) async {
    try {
      _status.value = NewsStatus.loading;

      final response =
          await _networkService.get('/news/search?term=$searchTerm');

      if (response.success) {
        final data = response.body;
        List<NewsModel> searchResults = (data['data'] as List)
            .map((item) => NewsModel.fromJson(item))
            .toList();

        _status.value = NewsStatus.loaded;
        return searchResults;
      } else {
        _status.value = NewsStatus.error;
        _errorMessage.value = 'Failed to search news: ${response.error}';
        LogHandlerUtil.e(_errorMessage.value);
        return [];
      }
    } catch (e) {
      _status.value = NewsStatus.error;
      _errorMessage.value = 'An error occurred: $e';
      LogHandlerUtil.e(_errorMessage.value);
      return [];
    }
  }
}
