import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:finalex/utils/moor_database.dart';
import 'package:finalex/utils/hero_http.dart';
import 'package:finalex/models/hero.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider(create: (_) => Database()),
          Provider(create: (_) => HeroHttp())
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          debugShowCheckedModeBanner: false,
          home: MyHomePage(),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<HeroClass> heroes = List();
  bool searched = false;
  Icon visibleIcon = Icon(Icons.search);
  Widget searchBar = Text('Barra de búsqueda');
  int _selectedIndex;

  @override
  void initState() {
    _selectedIndex = 0;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // print('Searched?' + searched.toString());
    // if (searched) {
    //   // _search(,this.context);
    // }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: searchBar,
        actions: <Widget>[
          IconButton(
            icon: visibleIcon,
            onPressed: () {
              setState(() {
                if (this.visibleIcon.icon == Icons.search) {
                  this.visibleIcon = Icon(Icons.cancel);
                  this.searchBar = TextField(
                    textInputAction: TextInputAction.search,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                    onSubmitted: (String text) {
                      _search(text, context);
                    },
                  );
                } else {
                  this.visibleIcon = Icon(Icons.search);
                  this.searchBar = Text('Barra de búsqueda');
                  //Listamos los datos por defecto

                }
              });
            },
          )
        ],
      ),
      body: _buildBody(context),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueAccent,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            title: Text('Favourite'),
          ),
        ],
      ),
    );
  }

  Future _search(String text, BuildContext context) async {
    final httpHero = Provider.of<HeroHttp>(context, listen: false);
    print("Busqueda init");
    // setState(() {
    //   searched = true;
    // });
    List<HeroClass> searchTemp = await httpHero.findHeroClass(text);
    print("After getList");
    setState(() {
      heroes = searchTemp;
      print('setState-list');
    });
    print("Countries size init: " + heroes.length.toString());
  }

  Widget _buildBody(BuildContext context) {
    final database = Provider.of<Database>(context);

    if (_selectedIndex == 0) {
      return Column(
        children: [
          SizedBox(height: 8.0),
          Expanded(child: _HeroClassList(heroes: heroes, database: database))
        ],
      );
    } else {
      return StreamBuilder(
          stream: database.watchAllHeroes,
          builder: (context, AsyncSnapshot<List<HeroDB>> snapshot) {
            final heroesDB = snapshot.data ?? List();

            if (heroesDB.length == 0)
              return Center(
                child: Text('Sin favoritos'),
              );
            return _FavouriteList(favourites: heroesDB, database: database);
          });
    }
  }

  Widget _buildStatCard(String title, int number, Color color) {
    return Container(
      height: MediaQuery.of(context).size.height / 4,
      width: MediaQuery.of(context).size.width / 3,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: color,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
                color: Colors.white,
                fontSize:
                    MediaQuery.of(context).size.width >= 400 ? 20.0 : 15.0),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            number.toString(),
            style: TextStyle(
                color: Colors.white,
                fontSize:
                    MediaQuery.of(context).size.width >= 400 ? 20.0 : 15.0,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _HeroClassList extends StatelessWidget {
  final List<HeroClass> heroes;
  final Database database;

  _HeroClassList({Key key, this.heroes, this.database}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: heroes.length,
      itemBuilder: (context, index) {
        return _buildRow(heroes[index], context);
      },
    );
  }

  Widget _buildRow(HeroClass heroclass, BuildContext context) {
    final heroclassDB = HeroDB(
        id: heroclass.id,
        name: heroclass.name,
        intelligence: heroclass.intelligence,
        power: heroclass.power,
        speed: heroclass.speed,
        image: heroclass.image);

    return StreamBuilder(
        stream: database.getHero(heroclassDB.name),
        builder: (context, AsyncSnapshot<HeroDB> snapshot) {
          final snapshotDB = snapshot.data ?? null;
          return Container(
              height: 470,
              child: Card(
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 2.0,
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(heroclass.name,
                                textAlign: TextAlign.center),
                          ),
                          Expanded(child: Image.network(heroclass.image)),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                                "Intelligence " + heroclass.intelligence,
                                textAlign: TextAlign.center),
                          ),
                          Expanded(
                            child: FittedBox(
                              child: Slider(
                                value: double.tryParse(
                                            heroclass.intelligence) !=
                                        null
                                    ? double.tryParse(heroclass.intelligence)
                                    : 0,
                                min: 0,
                                max: 100,
                                onChanged: (value) => {},
                                label: "Intelligence",
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(children: <Widget>[
                        Expanded(
                          child: Text("Power " + heroclass.power,
                              textAlign: TextAlign.center),
                        ),
                        Expanded(
                            child: FittedBox(
                                child: Slider(
                          value: double.tryParse(heroclass.power) != null
                              ? double.tryParse(heroclass.power)
                              : 0,
                          min: 0,
                          max: 200,
                          onChanged: (value) => {},
                          label: "Power",
                        )))
                      ]),
                      Row(children: <Widget>[
                        Expanded(
                          child: Text("Speed " + heroclass.speed,
                              textAlign: TextAlign.center),
                        ),
                        Expanded(
                            child: FittedBox(
                          child: Slider(
                            value: double.tryParse(heroclass.speed) != null
                                ? double.tryParse(heroclass.speed)
                                : 0,
                            min: 0,
                            max: 200,
                            onChanged: (value) => {},
                            label: "Speed",
                          ),
                        ))
                      ]),
                      Row(
                        children: <Widget>[
                          Expanded(
                              child: IconButton(
                            icon: Icon(snapshotDB == null
                                ? Icons.favorite_border
                                : Icons.favorite),
                            onPressed: () {
                              database
                                  .addHero(heroclassDB)
                                  .then((value) => Scaffold.of(context)
                                      .showSnackBar(SnackBar(
                                          content: Text(heroclass.name +
                                              ' registrado como favorito'))))
                                  .catchError((e) => Scaffold.of(context)
                                      .showSnackBar(SnackBar(
                                          content: Text(
                                              'Elemento ya se encuentra en la lista de favoritos'))));
                            },
                          )),
                        ],
                      ),
                    ],
                  )));
        });
  }
}

class _FavouriteList extends StatelessWidget {
  final List<HeroDB> favourites;
  final Database database;

  _FavouriteList({Key key, this.favourites, this.database}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: favourites.length,
      itemBuilder: (context, index) {
        return _buildRow(favourites[index], context);
      },
    );
  }

  Widget _buildRow(HeroDB heroclass, BuildContext context) {
    return Container(
        height: 470,
        child: Card(
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            elevation: 2.0,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(heroclass.name, textAlign: TextAlign.center),
                    ),
                    Expanded(child: Image.network(heroclass.image)),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text("Intelligence " + heroclass.intelligence,
                          textAlign: TextAlign.center),
                    ),
                    Expanded(
                      child: FittedBox(
                        child: Slider(
                          value: double.tryParse(heroclass.intelligence) != null
                              ? double.tryParse(heroclass.intelligence)
                              : 0,
                          min: 0,
                          max: 100,
                          onChanged: (value) => {},
                          label: "Intelligence",
                        ),
                      ),
                    ),
                  ],
                ),
                Row(children: <Widget>[
                  Expanded(
                    child: Text("Power " + heroclass.power,
                        textAlign: TextAlign.center),
                  ),
                  Expanded(
                      child: FittedBox(
                          child: Slider(
                    value: double.tryParse(heroclass.power) != null
                        ? double.tryParse(heroclass.power)
                        : 0,
                    min: 0,
                    max: 200,
                    onChanged: (value) => {},
                    label: "Power",
                  )))
                ]),
                Row(children: <Widget>[
                  Expanded(
                    child: Text("Speed " + heroclass.speed,
                        textAlign: TextAlign.center),
                  ),
                  Expanded(
                      child: FittedBox(
                    child: Slider(
                      value: double.tryParse(heroclass.speed) != null
                          ? double.tryParse(heroclass.speed)
                          : 0,
                      min: 0,
                      max: 200,
                      onChanged: (value) => {},
                      label: "Speed",
                    ),
                  ))
                ]),
                Row(
                  children: <Widget>[
                    Expanded(
                        child: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        print("Borrando de la BD");
                        database
                            .deleteHero(heroclass)
                            .then((value) => Scaffold.of(context).showSnackBar(
                                SnackBar(
                                    content: Text('Se elimina ' +
                                        heroclass.name +
                                        ' de favoritos'))))
                            .catchError((e) => Scaffold.of(context)
                                .showSnackBar(SnackBar(
                                    content: Text(
                                        'Error, nose pudo eliminar de la lista de favoritos'))));
                      },
                    ))
                  ],
                ),
              ],
            )));
  }
}
