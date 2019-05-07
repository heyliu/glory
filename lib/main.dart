import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Welcome to Flutter'),
          actions: createActions(),
        ),
        body: Center(
          //child: Text('Hello World'),
          child: RandomWords(),
        ),
      ),
    );
  }


  List<Widget> createActions(){
    List<String> actions =["act1", "act2", "act3"];
    return actions.map((text) => Center(child : Text(text)))
        .toList();
  }
}



class RandomWordState extends State<RandomWords>{
  final _suggestions = <WordPair>[];
  final _saved = new Set<WordPair>();
  final _biggerFont = TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(

    );

    //return _buildSuggestions();
  }


  Widget _buildSuggestions(){
    return ListView.builder(itemBuilder: (context,i){
      if(i.isOdd) return Divider();
      final index = i ~/ 2;
      if (index >= _suggestions.length) {
        _suggestions.addAll(generateWordPairs().take(10)); /*4*/
      }

      return _buildRow(_suggestions[index]);

    });
  }

  Widget _buildRow(WordPair pair) {
    final isAlreadyContain = _saved.contains(pair);
    final icon = new Icon(isAlreadyContain ? Icons.favorite : Icons.favorite_border,
      color: isAlreadyContain ? Colors.red : null,
    );

    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: icon,

      onTap: (){
        setState(() {
          if(isAlreadyContain){
            _saved.remove(pair);
          }else{
            _saved.add(pair);
          }
        });
      }, //onTap
    );
  }

  
}

class RandomWords extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => RandomWordState();
}