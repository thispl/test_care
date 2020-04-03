
class Research {
  String projectId;
    String projectName;
    String startDate;
    String dueDate;
    String status;


    Research({
      this.projectId,
        this.projectName,
        this.startDate,
        this.dueDate,
        this.status,
    });

    factory Research.fromJson(Map<String, dynamic> json) {
      return Research(
        projectId: json["id"],
        projectName: json["title"],
        startDate: json["startDate"],
        dueDate:json["dueDate"],
        status: json["status"],
    );
    } 
}
