import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _items = [];
  final GlobalKey<AnimatedListState> _key = GlobalKey();

  void _addItem() {
    _items.insert(0, "Item ${_items.length + 1}");
    _key.currentState!.insertItem(
      0,
      duration: Duration(seconds: 1),
    );
  }

  void _removeItem(int index) {
    _key.currentState!.removeItem(index, (_, animation) {
      return SizeTransition(
        sizeFactor: animation,
        child: Card(
          margin: EdgeInsets.all(10),
          color: Colors.red,
          child: ListTile(
            title: Text("Deleted", style: TextStyle(fontSize: 24)),
          ),
        ),
      );
    }, duration: Duration(milliseconds: 300));
    _items.removeAt(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Animated List"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          IconButton(
            onPressed: _addItem,
            icon: Icon(Icons.add),
          ),
          Expanded(
              child: AnimatedList(
            key: _key,
            initialItemCount: 0,
            padding: EdgeInsets.all(10),
            itemBuilder: (context, index, animation) {
              return SizeTransition(
                //key: UniqueKey(),
                sizeFactor: animation,
                child: Card(
                  margin: EdgeInsets.all(10),
                  color: Colors.orangeAccent,
                  child: ListTile(
                    title: Text(
                      _items[index],
                      style: TextStyle(fontSize: 24),
                    ),
                    trailing: IconButton(
                        onPressed: () {
                          _removeItem(index);
                        },
                        icon: Icon(Icons.delete)),
                  ),
                ),
              );
            },
          ))
        ],
      ),
    );
  }
}
