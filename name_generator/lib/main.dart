import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      MaterialApp(title: 'Startup Name Generator', home: RandomWords());
}

class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _saved = Set<WordPair>();

  final textStyle = const TextStyle(fontSize: 18);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Startup Name Generator'),
        ),
        body: _buildSuggestions(context),
      );

  Widget _buildSuggestions(BuildContext context) => ListView.builder(
      padding: EdgeInsets.all(16.0),
      itemBuilder: (context, index) => _buildListViewRow(context, index));

  Widget _buildListViewRow(BuildContext context, int index) {
    if (index.isOdd) {
      return Divider();
    }
    final itemIndex = index ~/ 2;
    if (itemIndex >= _suggestions.length) {
      _suggestions.addAll(generateWordPairs().take(10));
    }
    return _buildRow(context, _suggestions[itemIndex]);
  }

  Widget _buildRow(BuildContext context, WordPair pair) {
    var alreadySaved = _saved.contains(pair);

    return ListTile(
      title: Text(pair.asPascalCase, style: textStyle),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.redAccent : null,
      ),
    );
  }
}
