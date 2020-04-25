
class Patient {
    String firstName;
    String lastName;
    String patientId;
    String status;
    String reportDate;
    String report;
    int read;


    Patient({
        this.firstName,
        this.lastName,
        this.patientId,
        this.status,
        this.reportDate,
        this.report,
        this.read
    });

    factory Patient.fromJson(Map<String, dynamic> json) {
      return Patient(
        firstName: json["patient_first_name"],
        lastName: json["patient_last_name"],
        patientId:json["name"],
        status: json["status"],
        reportDate: json["report_date"],
        report: json["report"],
        read: json['_read']
    );
    } 
}
