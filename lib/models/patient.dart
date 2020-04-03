
class Patient {
    String firstName;
    String lastName;
    String conditions;
    String status;
    String reportDate;
    int read;


    Patient({
        this.firstName,
        this.lastName,
        this.conditions,
        this.status,
        this.reportDate,
        this.read
    });

    factory Patient.fromJson(Map<String, dynamic> json) {
      return Patient(
        firstName: json["patient_first_name"],
        lastName: json["patient_last_name"],
        conditions:json["conditions"],
        status: json["status"],
        reportDate: json["report_date"],
        read: json['_read']
    );
    } 
}
