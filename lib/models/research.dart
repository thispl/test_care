
import 'dart:ffi';

class Research {
  String projectId;
  String projectName;
  String percentOfCompletion;
  String startDate;
  String endDate;
  String status;


    Research({
      this.projectId,
        this.projectName,
        this.percentOfCompletion,
        this.startDate,
        this.endDate,
        this.status,
    });

    factory Research.fromJson(Map<String, dynamic> json) {
      return Research(
        projectId: json["project_id"],
        projectName: json["title"],
        percentOfCompletion: (json['percentage_of_completion'].round()).toString(),
        startDate: json["start_date"],
        endDate:json["end_date"],
        status: json["status"],
    );
    } 
}
