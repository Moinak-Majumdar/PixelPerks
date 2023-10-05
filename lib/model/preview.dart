class PreviewImage {
  const PreviewImage({
    required this.id,
    required this.web340,
    required this.fromSafeSource,
    this.cdn,
    this.web640,
  });

  final int id;
  final String web340;
  final bool fromSafeSource;
  final String? cdn, web640;
}

class PreviewImageServer {
  const PreviewImageServer({required this.images, required this.itemCount});
  final List<PreviewImage> images;
  final int itemCount;

  factory PreviewImageServer.fromJson(Map<String, dynamic> json,
      {required bool fromSafeSource}) {
    final List<PreviewImage> data = [];
    final int itemCount = json['items'] as int;

    for (final elm in json['collection']) {
      data.add(
        PreviewImage(
            id: elm['id'] as int,
            // not using in this app.
            // cdn: elm['cdn'],
            web340: elm['web340'],
            fromSafeSource: fromSafeSource
            // web640: elm['web640'],
            ),
      );
    }

    return PreviewImageServer(images: data, itemCount: itemCount);
  }
}
