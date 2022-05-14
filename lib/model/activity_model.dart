enum ActivityStatus { ongoing, done }

class Activity {
  String id;
  String name;
  String image;
  String city;
  double price;
  ActivityStatus status;

  Activity({
    required this.id,
    required this.name,
    required this.city,
    required this.image,
    required this.price,
    this.status = ActivityStatus.ongoing,
  });

  Activity.fromJson(Map<String, dynamic> json)
      : id = json['_id'].toString(),
        name = json['name'].toString(),
        city = json['city'].toString(),
        image = json['image'].toString(),
        price = json['price'].toDouble(),
        status =
            json['status'] == 0 ? ActivityStatus.ongoing : ActivityStatus.done;

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'image': image,
      'city': city,
      'price': price,
      'status': status == ActivityStatus.ongoing ? 0 : 1
    };
  }
}
