class FullImage {
  const FullImage({
    required this.id,
    this.cdn,
    required this.web340,
    this.tags,
    this.web640,
    required this.image,
    required this.imageSize,
    required this.likes,
    required this.views,
    required this.downloads,
    required this.owner,
    required this.ownerDp,
    required this.imgName,
  });

  final int id, imageSize, likes, downloads, views;
  final String image, owner, ownerDp, web340, imgName;
  final String? cdn, web640, tags;
}

class FullImageServer {
  const FullImageServer({required this.detailed});
  final FullImage detailed;

  factory FullImageServer.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> data = json['fullImage'];
    final splitters = data['cdn'].split('/') as List<String>;

    return FullImageServer(
      detailed: FullImage(
        id: data['id'] as int,
        image: data['image'],
        web340: data['web340'],
        imgName: splitters.last,
        // tags: data['tags'],
        imageSize: data['imageSize'],
        likes: data['likes'],
        views: data['view'],
        downloads: data['downloads'],
        owner: data['owner'],
        ownerDp: data['ownerDp'],
      ),
    );
  }
}
