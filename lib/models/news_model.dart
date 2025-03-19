class NewsModel {
  String status;
  int totalResults;
  List<NewsResult> results;

  NewsModel({
    required this.status,
    required this.totalResults,
    required this.results,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      status: json['status'],
      totalResults: json['totalResults'],
      results: (json['results'] as List)
          .map((resultJson) => NewsResult.fromJson(resultJson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'totalResults': totalResults,
      'results': results.map((result) => result.toJson()).toList(),
    };
  }
}

class NewsResult {
  String articleId;
  String title;
  String link;
  List<String>? keywords;
  List<String>? creator;
  String? videoUrl;
  String? description;
  String? content;
  String pubDate;
  String pubDateTZ;
  String? imageUrl;
  String sourceId;
  int sourcePriority;
  String sourceName;
  String sourceUrl;
  String sourceIcon;
  String language;
  List<String> country;
  List<String> category;
  bool duplicate;

  NewsResult({
    required this.articleId,
    required this.title,
    required this.link,
    this.keywords,
    this.creator,
    this.videoUrl,
    this.description,
    this.content,
    required this.pubDate,
    required this.pubDateTZ,
    this.imageUrl,
    required this.sourceId,
    required this.sourcePriority,
    required this.sourceName,
    required this.sourceUrl,
    required this.sourceIcon,
    required this.language,
    required this.country,
    required this.category,
    required this.duplicate,
  });

  factory NewsResult.fromJson(Map<String, dynamic> json) {
    return NewsResult(
      articleId: json['article_id'] ?? '',
      title: json['title']  ?? '',
      link: json['link']  ?? '',
      keywords: json['keywords'] != null 
          ? List<String>.from(json['keywords']) 
          : null,
      creator: json['creator'] != null 
          ? List<String>.from(json['creator']) 
          : null,
      videoUrl: json['video_url'] ?? '',
      description: json['description'] ?? '',
      content: json['content'] ?? '',
      pubDate: json['pubDate'] ?? '',
      pubDateTZ: json['pubDateTZ'] ?? '',
      imageUrl: json['image_url'] ?? '',
      sourceId: json['source_id'] ?? '',
      sourcePriority: json['source_priority'] ?? '',
      sourceName: json['source_name'] ?? '',
      sourceUrl: json['source_url'] ?? '',
      sourceIcon: json['source_icon'] ?? '',
      language: json['language'],
      country: List<String>.from(json['country']),
      category: List<String>.from(json['category']),
      duplicate: json['duplicate'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'article_id': articleId,
      'title': title,
      'link': link,
      'keywords': keywords,
      'creator': creator,
      'video_url': videoUrl,
      'description': description,
      'content': content,
      'pubDate': pubDate,
      'pubDateTZ': pubDateTZ,
      'image_url': imageUrl,
      'source_id': sourceId,
      'source_priority': sourcePriority,
      'source_name': sourceName,
      'source_url': sourceUrl,
      'source_icon': sourceIcon,
      'language': language,
      'country': country,
      'category': category,
      'duplicate': duplicate,
    };
  }
}