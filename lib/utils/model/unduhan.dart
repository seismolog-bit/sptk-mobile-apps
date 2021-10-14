
class UnduhanModel {
    UnduhanModel({
        required this.menus,
        required this.data,
    });

    final String menus;
    final List<Datum> data;

    factory UnduhanModel.fromJson(Map<String, dynamic> json) => UnduhanModel(
        menus: json["menus"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "menus": menus,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    Datum({
        required this.title,
        required this.url,
        required this.icon,
    });

    final String title;
    final String url;
    final String icon;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        title: json["title"],
        url: json["url"],
        icon: json["icon"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "url": url,
        "icon": icon,
    };
}
