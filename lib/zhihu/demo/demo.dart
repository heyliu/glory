


//class RandomWordState extends State<RandomWords>{
//  final _suggestions = <WordPair>[];
//  final _saved = new Set<WordPair>();
//  final _biggerFont = TextStyle(fontSize: 18.0);
//
//  @override
//  Widget build(BuildContext context) {
//    return new Scaffold(
//        appBar: new AppBar(
//          title: new Text('Startup Name Generator'),
//          actions: <Widget>[      // 新增代码开始 ...
//            new IconButton(icon: const Icon(Icons.list), onPressed: _pushSaved),
//          ],                      // ... 代码新增结束
//        ),
//        body: _buildSuggestions(),
//    );
//  }
//
// ///推荐列表
//  Widget _buildSuggestions(){
//    return ListView.builder(itemBuilder: (context,i){
//      if(i.isOdd) return Divider();
//      final index = i ~/ 2;
//      if (index >= _suggestions.length) {
//        _suggestions.addAll(generateWordPairs().take(10)); /*4*/
//      }
//      return _buildRow(_suggestions[index]);
//
//    });
//  }
//
//  ///每行的item
//  Widget _buildRow(WordPair pair) {
//    final isAlreadyContain = _saved.contains(pair);
//    final icon = new Icon(isAlreadyContain ? Icons.favorite : Icons.favorite_border,
//      color: isAlreadyContain ? Colors.red : null,
//    );
//
//    return ListTile(
//      title: Text(
//        pair.asPascalCase,
//        style: _biggerFont,
//      ),
//      trailing: icon,
//
//      onTap: (){
//        setState(() {
//          if(isAlreadyContain){
//            _saved.remove(pair);
//          }else{
//            _saved.add(pair);
//          }
//        });
//      }, //onTap
//    );
//  }
//  void _pushSaved() {
//  }
//}
//
//class RandomWords extends StatefulWidget{
//  @override
//  State<StatefulWidget> createState() => RandomWordState();
//}

