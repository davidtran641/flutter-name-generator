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
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.list),
              onPressed: _pushSavedItems,
            )
          ],
        ),
        body: _buildSuggestions(context),
      );

  void _pushSavedItems() {
    Navigator.of(context).push(
        MaterialPageRoute<void>(builder: (buildContext) => SavedWords(_saved)));
  }

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
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }
}

class SavedWords extends StatefulWidget {
  final Set<WordPair> savedItems;
  SavedWords(this.savedItems);

  @override
  _SavedWordsState createState() => _SavedWordsState(savedItems);
}

class _SavedWordsState extends State<SavedWords> {
  final Set<WordPair> savedItems;
  _SavedWordsState(this.savedItems);

  @override
  Widget build(BuildContext context) {
    final tiles = savedItems.map((pair) => ListTile(
          title: Text(pair.asPascalCase, style: TextStyle(fontSize: 18)),
        ));
    final divided =
        ListTile.divideTiles(context: context, tiles: tiles).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Suggestions'),
      ),
      body: ListView(
        children: divided,
      ),
    );
  }
}
