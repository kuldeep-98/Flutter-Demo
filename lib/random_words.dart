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
    return ListTile(title: Text(pair.asPascalCase,style: TextStyle(fontSize: 18),),);
  }

  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar( 
        title:Text('WordPair Generator')
      ),
      body: _buildList(),
    );
  }
}