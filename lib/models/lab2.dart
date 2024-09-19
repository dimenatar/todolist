import 'dart:convert';
import 'package:http/http.dart' as http;

const String link = "https://bible-api.com/?random=verse";

Future<Quote> fetchQuote() async {
  final url = Uri.parse(link);
  final response = await http.get(url);

  //print(response.body);

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return Quote.fromJson(data);
  } else {
    throw Exception('Failed to load quote');
  }
}

class Quote {
  final String content;
  final int chapter;
  final int? verse;

  Quote({required this.content, required this.chapter, this.verse});

  @override
  String toString() {
    return "content $content, chapter $chapter, verse $verse";
  }

  Map<String, dynamic> toJson() =>
  {
    'content': content,
    'chapter': chapter,
    'verse': verse ?? 0,
  };

  factory Quote.fromJson(Map<String, dynamic> json) 
  {
    if (json.containsKey('verses')) {
      Map<String, dynamic> verses = json['verses'][0];
      return Quote(
        content: json['text'] as String,
        chapter: verses['chapter'] as int,
        verse: verses['verse'] as int?,
      );
    }
    else return Quote(content: json['content'], chapter: json['chapter'], verse: json['verse']);
  }
}

class Lab2{
  static proceed() async
  {
try {
    final quote = await fetchQuote();
    print('Quote: ${quote.content}');
    print('Chapter: ${quote.chapter}');
    if (quote.verse != null)
    {
      print('Verse: ${quote.verse}');
    }
    
  } catch (error) {
    print(error);
  }
  }
}