
class CategoriesModel {
    CategoriesModel({
        required this.id,
        required this.description,
        required this.link,
        required this.name,
        required this.yoastHeadJson,
    });

    final int id;
    final String description;
    final String link;
    final String name;
    final YoastHeadJson yoastHeadJson;

    factory CategoriesModel.fromJson(Map<String, dynamic> json) => CategoriesModel(
        id: json["id"],
        description: json["description"],
        link: json["link"],
        name: json["name"],
        yoastHeadJson: YoastHeadJson.fromJson(json["yoast_head_json"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "link": link,
        "name": name,
        "yoast_head_json": yoastHeadJson.toJson(),
    };
}

class YoastHeadJson {
    YoastHeadJson({
        required this.twitterImage,
    });

    final String twitterImage;

    factory YoastHeadJson.fromJson(Map<String, dynamic> json) => YoastHeadJson(
        twitterImage: json["twitter_image"],
    );

    Map<String, dynamic> toJson() => {
        "twitter_image": twitterImage,
    };
}
