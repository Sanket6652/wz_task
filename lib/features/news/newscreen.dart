import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_project_template/controllers/news_controller.dart';

import 'artical_card.dart';
// import 'package:flutter_project_template/features/news_detail_screen.dart';
// import 'package:flutter_project_template/features/news_search_screen.dart';
// import 'package:flutter_project_template/widgets/news_card.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  // Using GetX LazyPut to initialize the controller only when it's needed
  final NewsController newsController = Get.put(NewsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => _showSearchDialog(context),
          ),
        ],
      ),
      body: Obx(() {
        // Handle different states with GetX Obx for reactive UI updates
        switch (newsController.status) {
          case NewsStatus.initial:
            return const Center(child: Text('Initialize news...'));
          case NewsStatus.loading:
            if (newsController.newsList.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }
            return _buildNewsList();
          case NewsStatus.loaded:
            return _buildNewsList();
          case NewsStatus.error:
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${newsController.errorMessage}'),
                  const SizedBox(height: 16),
                ],
              ),
            );
        }
      }),
    );
  }

  Widget _buildNewsList() {
    return RefreshIndicator(
      onRefresh: newsController.refreshNews,
      child: Obx(
        () => ListView.builder(
          itemCount: newsController.newsList.length +
              (newsController.hasMoreData ? 1 : 0),
          itemBuilder: (context, index) {
            // If we've reached the end of the current data and have more to load
            if (index == newsController.newsList.length &&
                newsController.hasMoreData) {
              // Load more data when reaching the end
              newsController.loadMoreNews();
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(),
                ),
              );
            }

            // Regular news item
            if (index < newsController.newsList.length) {
              final newsItem = newsController.newsList[index];
              // return
              return ArticleCard(
                article: newsController.newsList[index],
                onTap: () {
                  print("data");
                },
              );
            }

            return null;
          },
        ),
      ),
    );
  }

  void _navigateToNewsDetail(String newsId) {
    // Use GetX navigation
    // Get.to(() => NewsDetailScreen(newsId: newsId));
  }

  void _showSearchDialog(BuildContext context) {
    final controller = TextEditingController();
    Get.dialog(
      AlertDialog(
        title: const Text('Search News'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: 'Enter search term',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              if (controller.text.isNotEmpty) {
                // Get.to(() => NewsSearchScreen(searchTerm: controller.text));
              }
            },
            child: const Text('Search'),
          ),
        ],
      ),
    );
  }
}
