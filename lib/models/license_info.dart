class LicenseInfo{
  String title;
  String description;

  LicenseInfo({
    this.title,
    this.description
  });

  factory LicenseInfo.fromJson(Map<String, dynamic> json) {
      return LicenseInfo(
        title: json["title"],
        description: json["description"],
    );
    } 
}