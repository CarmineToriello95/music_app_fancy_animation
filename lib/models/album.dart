class Album {
  final int id;
  final String author;
  final String title;
  final String coverPath;
  final List<String> genres;
  final List<String> images;
  final List<Track> trackList;
  final String mainDescription;
  final String moreDescription;

  const Album(
      {this.id,
      this.author,
      this.title,
      this.coverPath,
      this.genres,
      this.images,
      this.trackList,
      this.mainDescription,
      this.moreDescription});
}

class Track {
  final String name;
  final String duration;

  const Track({this.name, this.duration});
}
