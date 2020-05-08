class Article {
    String articleName;
    String topic;
    String description;
    String video;
    String videoLink;

    Article({
        this.topic,
        this.description,
        this.video,
        this.videoLink,
        this.articleName
    });

    factory Article.fromJson(Map<String, dynamic> json) {
      return Article(
        articleName: json["article_name"],
        topic: json["topic"],
        description: json["description"],
        videoLink: json["video_url"],
        video:json["video"],
        
    );
    } 
}