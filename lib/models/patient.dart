
class Patient {
    String firstName;
    String lastName;
    int age;
    String photo;
    String conditions;
    String read;


    Patient({
        this.firstName,
        this.lastName,
        this.age,
        this.photo,
        this.conditions,
        this.read
    });

    factory Patient.fromJson(Map<String, dynamic> json) {
      return Patient(
        firstName: json["first_name"],
        lastName: json["last_name"],
        age: json["age"],
        photo:json["photo"],
        conditions:json["conditions"],
        read: json['_seen']
    );
    } 
}
