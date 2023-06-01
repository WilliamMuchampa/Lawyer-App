class Load {
  final String? image;
  final String? title;
  final String? timePosted;

  Load({
    required this.image,
    required this.title,
    required this.timePosted,
  });

  factory Load.fromJson(Map<String, dynamic>? json) {
    return Load(
      image: json?["image"],
      title: json?["title"],
      timePosted: json?["timePosted"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "image": image,
      "title": title,
      "timePosted": timePosted,
    };
  }
}
