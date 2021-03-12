import 'package:flutter/material.dart';
import "package:english_words/english_words.dart";

class RandomWords extends StatefulWidget{
  @override 
  RandomWordsState createState() =>RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  final _randomWordPair = <WordPair>[];
  final _savedWordPair = Set<WordPair>();
  Widget _buildList(){
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemBuilder: (context,item){
        if(item.isOdd)  return Divider(); 

        final index = item ~/ 2;

        if(index>=_randomWordPair.length){
          _randomWordPair.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_randomWordPair[index]);
      },
    );
  }

  Widget _buildRow(WordPair pair){
    final alreadySaved = _savedWordPair.contains(pair);

    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: TextStyle(fontSize: 18),
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite:Icons.favorite_border,
        color: alreadySaved?Colors.red:null,
      ),
      onTap: () {
        setState(() {
          if(alreadySaved){
            _savedWordPair.remove(pair);
          }else{
            _savedWordPair.add(pair);
          }
        });
      },
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context){
          final Iterable<ListTile> tiles = _savedWordPair.map((WordPair pair) {
            return ListTile(title: Text(pair.asPascalCase, style: TextStyle(fontSize: 16),), );
          });
          final List<Widget> devided = ListTile.divideTiles(tiles: tiles,context:context).toList();
          return Scaffold(
            appBar: AppBar(
              title: Text('Saved WordPairs'),
            ),
            body: ListView(children: devided,),
          );
        }
      )
    );
  }

  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar( 
        title:Text('WordPair Generator'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.list),
            onPressed: _pushSaved,
          )
        ],
      ),
      body: _buildList(),
    );
  }
}