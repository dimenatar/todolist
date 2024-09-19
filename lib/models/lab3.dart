import 'lab2.dart';
import 'saveLoad.dart';

class Lab3{
  static void proceed() async{
    Quote first = await fetchQuote();
    Quote second = await fetchQuote();

    PreferencesIO preferences = PreferencesIO();
    NewFileIO file = NewFileIO();
    SqliteIO sql = SqliteIO();

    List<Quote> quotes = [first, second];

    preferences.save(quotes);

    final pQuotes = await preferences.load();
    print(pQuotes);

    file.save(quotes);

    final fQuotes = await file.load();

    print(fQuotes);

    sql.save(quotes);

    final sQuotes = await sql.load();

    print(sQuotes);

    print('completed');
    
  }
}