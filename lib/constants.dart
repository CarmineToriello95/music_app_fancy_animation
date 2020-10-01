import 'models/album.dart';

const String heroTagAppBar = 'app_bar';
const String heroTagImageSection = 'image_section';
const String heroTagBodySection = 'body_section';

const List<Album> hardCodedAlbums = [
  const Album(
    id: 0,
    author: 'Led Zeppelin',
    title: 'Led Zeppelin',
    year: '1969',
    coverPath: 'assets/images/led_zeppelin.jpg',
    images: [
      'assets/images/led_zeppelin.jpg',
      'assets/images/led_zeppelin.jpg',
      'assets/images/led_zeppelin.jpg'
    ],
    genres: ['hard rock', 'blues rock', 'folk rock'],
    trackList: [
      Track(name: 'Track 1', duration: '00:32'),
      Track(name: 'Track 2', duration: '00:26'),
      Track(name: 'Track 3', duration: '00:30'),
      Track(name: 'Track 4', duration: '00:34'),
      Track(name: 'Track 5', duration: '00:26'),
      Track(name: 'Track6', duration: '00:28'),
    ],
    mainDescription:
        'Led Zeppelin is the debut album by English rock band Led Zeppelin.',
    moreDescription:
        'It was released on 12 January 1969 in the United States and on 31 March in the United Kingdom by Atlantic Records.',
  ),
  const Album(
    id: 1,
    author: 'David Bowie',
    title: 'Heroes',
    year: '1973',
    coverPath: 'assets/images/david_bowie.jpg',
    images: [
      'assets/images/david_bowie.jpg',
      'assets/images/david_bowie_4.jpg',
      'assets/images/david_bowie_2.jpg',
      'assets/images/david_bowie_3.jpg',
      
    ],
    genres: ['art rock', 'electronic', 'art pop'],
    trackList: [
      Track(name: 'Beauty and the Beast', duration: '00:32'),
      Track(name: 'Joe the Lion', duration: '00:26'),
      Track(name: 'Heroes', duration: '00:30'),
      Track(name: 'Sons of the Silent Age', duration: '00:34'),
      Track(name: 'Blackout', duration: '00:26'),
      Track(name: 'V-2 Schneider', duration: '00:28'),
    ],
    mainDescription:
        'Heroes is the 12th studio album by English singer-songwriter David Bowie, released on 14 October 1977 by RCA Records.',
    moreDescription:
        'It was the second instalment of his \"Berlin Trilogy\" recorded with producers Brian Eno.',
  ),
  const Album(
    id: 2,
    author: 'David Bowie',
    title: 'Heroes',
    year: '1973',
    coverPath: 'assets/images/david_bowie.jpg',
    images: [
      'assets/images/david_bowie.jpg',
      'assets/images/david_bowie_4.jpg',
      'assets/images/david_bowie_2.jpg',
      'assets/images/david_bowie_3.jpg'
    ],
    genres: ['art rock', 'electronic', 'art pop'],
    trackList: [
      Track(name: 'Beauty and the Beast', duration: '00:32'),
      Track(name: 'Joe the Lion', duration: '00:26'),
      Track(name: 'Heroes', duration: '00:30'),
      Track(name: 'Sons of the Silent Age', duration: '00:34'),
      Track(name: 'Blackout', duration: '00:26'),
      Track(name: 'V-2 Schneider', duration: '00:28'),
    ],
    mainDescription:
        'Heroes is the 12th studio album by English singer-songwriter David Bowie, released on 14 October 1977 by RCA Records.',
    moreDescription:
        'It was the second instalment of his \"Berlin Trilogy\" recorded with producers Brian Eno.',
  ),
  const Album(
    id: 3,
    author: 'David Bowie',
    title: 'Heroes',
    year: '1973',
    coverPath: 'assets/images/david_bowie.jpg',
    images: [
      'assets/images/david_bowie.jpg',
      'assets/images/david_bowie_4.jpg',
      'assets/images/david_bowie_2.jpg',
      'assets/images/david_bowie_3.jpg'
    ],
    genres: ['art rock', 'electronic', 'art pop'],
    trackList: [
      Track(name: 'Beauty and the Beast', duration: '00:32'),
      Track(name: 'Joe the Lion', duration: '00:26'),
      Track(name: 'Heroes', duration: '00:30'),
      Track(name: 'Sons of the Silent Age', duration: '00:34'),
      Track(name: 'Blackout', duration: '00:26'),
      Track(name: 'V-2 Schneider', duration: '00:28'),
    ],
    mainDescription:
        'Heroes is the 12th studio album by English singer-songwriter David Bowie, released on 14 October 1977 by RCA Records.',
    moreDescription:
        'It was the second instalment of his \"Berlin Trilogy\" recorded with producers Brian Eno.',
  ),
  const Album(
    id: 4,
    author: 'David Bowie',
    title: 'Heroes',
    year: '1973',
    coverPath: 'assets/images/david_bowie.jpg',
    images: [
      'assets/images/david_bowie.jpg',
      'assets/images/david_bowie_4.jpg',
      'assets/images/david_bowie_2.jpg',
      'assets/images/david_bowie_3.jpg'
    ],
    genres: ['art rock', 'electronic', 'art pop'],
    trackList: [
      Track(name: 'Beauty and the Beast', duration: '00:32'),
      Track(name: 'Joe the Lion', duration: '00:26'),
      Track(name: 'Heroes', duration: '00:30'),
      Track(name: 'Sons of the Silent Age', duration: '00:34'),
      Track(name: 'Blackout', duration: '00:26'),
      Track(name: 'V-2 Schneider', duration: '00:28'),
    ],
    mainDescription:
        'Heroes is the 12th studio album by English singer-songwriter David Bowie, released on 14 October 1977 by RCA Records.',
    moreDescription:
        'It was the second instalment of his \"Berlin Trilogy\" recorded with producers Brian Eno.',
  ),
  const Album(
    id: 5,
    author: 'David Bowie',
    title: 'Heroes',
    year: '1973',
    coverPath: 'assets/images/david_bowie.jpg',
    images: [
      'assets/images/david_bowie.jpg',
      'assets/images/david_bowie_4.jpg',
      'assets/images/david_bowie_2.jpg',
      'assets/images/david_bowie_3.jpg'
    ],
    genres: ['art rock', 'electronic', 'art pop'],
    trackList: [
      Track(name: 'Beauty and the Beast', duration: '00:32'),
      Track(name: 'Joe the Lion', duration: '00:26'),
      Track(name: 'Heroes', duration: '00:30'),
      Track(name: 'Sons of the Silent Age', duration: '00:34'),
      Track(name: 'Blackout', duration: '00:26'),
      Track(name: 'V-2 Schneider', duration: '00:28'),
    ],
    mainDescription:
        'Heroes is the 12th studio album by English singer-songwriter David Bowie, released on 14 October 1977 by RCA Records.',
    moreDescription:
        'It was the second instalment of his \"Berlin Trilogy\" recorded with producers Brian Eno.',
  )
];
