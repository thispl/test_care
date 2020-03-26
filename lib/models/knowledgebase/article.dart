class Article {
    String articleName;
    String topic;
    String description;
    String video;

    Article({
        this.topic,
        this.description,
        this.video,
        this.articleName
    });

    factory Article.fromJson(Map<String, dynamic> json) {
      return Article(
        articleName: json["article_name"],
        topic: json["topic"],
        description: json["description"],
        video:json["video"]
    );
    } 
}