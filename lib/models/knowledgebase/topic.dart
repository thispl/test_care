class Topic {
  String topic;
  bool isPremium;
  String image;

  Topic({this.topic, this.isPremium, this.image});

  factory Topic.fromJson(Map<String, dynamic> json) {
    return Topic(
        topic: json["topic"],
        isPremium: json["is_premium"] == 1 ? true : false,
        image: json["image"]);
  }
}
