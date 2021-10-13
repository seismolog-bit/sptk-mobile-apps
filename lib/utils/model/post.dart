

class PostModel {
    PostModel({
        required this.id,
        required this.date,
        required this.slug,
        required this.link,
        required this.status,
        required this.title,
        required this.content,
        required this.yoastHeadJson,
        required this.excerpt,
        required this.author,
        required this.categories,
        required this.tags,
        required this.embedded,
    });

    final int id;
    final DateTime date;
    final String slug;
    final String link;
    final String status;
    final Title title;
    final Content content;
    final YoastHeadJson yoastHeadJson;
    final Content excerpt;
    final int author;
    final List<int> categories;
    final List<dynamic> tags;
    final Embedded embedded;

    factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        id: json["id"],
        date: DateTime.parse(json["date"]),
        slug: json["slug"],
        link: json["link"],
        status: json["status"],
        title: Title.fromJson(json["title"]),
        content: Content.fromJson(json["content"]),
        yoastHeadJson: YoastHeadJson.fromJson(json["yoast_head_json"]),
        excerpt: Content.fromJson(json["excerpt"]),
        author: json["author"],
        categories: List<int>.from(json["categories"].map((x) => x)),
        tags: List<dynamic>.from(json["tags"].map((x) => x)),
        embedded: Embedded.fromJson(json["_embedded"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "date": date.toIso8601String(),
        "slug": slug,
        "link": link,
        "status": status,
        "title": title.toJson(),
        "content": content.toJson(),
        "yoast_head_json": yoastHeadJson.toJson(),
        "excerpt": excerpt.toJson(),
        "author": author,
        "categories": List<dynamic>.from(categories.map((x) => x)),
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "_embedded": embedded.toJson(),
    };
}

class Content {
    Content({
        required this.rendered,
        required this.protected,
    });

    final String rendered;
    final bool protected;

    factory Content.fromJson(Map<String, dynamic> json) => Content(
        rendered: json["rendered"],
        protected: json["protected"],
    );

    Map<String, dynamic> toJson() => {
        "rendered": rendered,
        "protected": protected,
    };
}

class Embedded {
    Embedded({
        required this.author,
        required this.wpFeaturedmedia,
    });

    final List<Author> author;
    final List<WpFeaturedmedia> wpFeaturedmedia;

    factory Embedded.fromJson(Map<String, dynamic> json) => Embedded(
        author: List<Author>.from(json["author"].map((x) => Author.fromJson(x))),
        wpFeaturedmedia: List<WpFeaturedmedia>.from(json["wp:featuredmedia"].map((x) => WpFeaturedmedia.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "author": List<dynamic>.from(author.map((x) => x.toJson())),
        "wp:featuredmedia": List<dynamic>.from(wpFeaturedmedia.map((x) => x.toJson())),
    };
}

class Author {
    Author({
        required this.id,
        required this.name,
        required this.url,
        required this.description,
        required this.link,
        required this.slug,
        required this.avatarUrls,
    });

    final int id;
    final String name;
    final String url;
    final String description;
    final String link;
    final String slug;
    final Map<String, String> avatarUrls;

    factory Author.fromJson(Map<String, dynamic> json) => Author(
        id: json["id"],
        name: json["name"],
        url: json["url"],
        description: json["description"],
        link: json["link"],
        slug: json["slug"],
        avatarUrls: Map.from(json["avatar_urls"]).map((k, v) => MapEntry<String, String>(k, v)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "url": url,
        "description": description,
        "link": link,
        "slug": slug,
        "avatar_urls": Map.from(avatarUrls).map((k, v) => MapEntry<String, dynamic>(k, v)),
    };
}

class WpFeaturedmedia {
    WpFeaturedmedia({
        required this.id,
        required this.date,
        required this.slug,
        required this.type,
        required this.link,
        required this.title,
        required this.caption,
        required this.sourceUrl,
    });

    final int id;
    final DateTime date;
    final String slug;
    final String type;
    final String link;
    final Title title;
    final Title caption;
    final String sourceUrl;

    factory WpFeaturedmedia.fromJson(Map<String, dynamic> json) => WpFeaturedmedia(
        id: json["id"],
        date: DateTime.parse(json["date"]),
        slug: json["slug"],
        type: json["type"],
        link: json["link"],
        title: Title.fromJson(json["title"]),
        caption: Title.fromJson(json["caption"]),
        sourceUrl: json["source_url"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "date": date.toIso8601String(),
        "slug": slug,
        "type": type,
        "link": link,
        "title": title.toJson(),
        "caption": caption.toJson(),
        "source_url": sourceUrl,
    };
}

class Title {
    Title({
        required this.rendered,
    });

    final String rendered;

    factory Title.fromJson(Map<String, dynamic> json) => Title(
        rendered: json["rendered"],
    );

    Map<String, dynamic> toJson() => {
        "rendered": rendered,
    };
}

class YoastHeadJson {
    YoastHeadJson({
        required this.title,
        required this.description,
        required this.ogImage,
    });

    final String title;
    final String description;
    final List<OgImage> ogImage;

    factory YoastHeadJson.fromJson(Map<String, dynamic> json) => YoastHeadJson(
        title: json["twitter_title"],
        description: json["description"],
        ogImage: List<OgImage>.from(json["og_image"].map((x) => OgImage.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "twitter_title": title,
        "description": description,
        "og_image": List<dynamic>.from(ogImage.map((x) => x.toJson())),
    };
}

class OgImage {
    OgImage({
        required this.url,
    });

    final String url;

    factory OgImage.fromJson(Map<String, dynamic> json) => OgImage(
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "url": url,
    };
}
