import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:principal/AudioPlayerObjeto.dart';
import 'AudioPlayerController.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AudioPlayer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  double _tela = 0;

  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    _tela = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('AudioPlayer'),
          ),
          body: TabBarView(
            children: [localAsset(), Container()],
          ),
          bottomNavigationBar: Container(
            color: Colors.blueAccent,
            child: TabBar(
              tabs: [
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Player",
                        style: TextStyle(fontSize: _tela * .03),
                      ),
                      Icon(
                        Icons.play_arrow,
                      ),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.format_list_numbered,
                      ),
                      Text(
                        "Lista",
                        style: TextStyle(fontSize: _tela * .03),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }

  Widget _tab(List<Widget> children) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: children
              .map((w) => Container(child: w, padding: EdgeInsets.all(6.0)))
              .toList(),
        ),
      ),
    );
  }

  Widget localAsset() {
    return Column(
      children: <Widget>[
        StreamBuilder(
          stream: audioController.outDuration,
          builder: (context, AsyncSnapshot<AudioPlayerObjeto> snapshot) {
            if(snapshot.hasData){
            return SingleChildScrollView(
              child: _tab([
                Text(snapshot.data.musicaAtual, style: TextStyle(fontSize: _tela * .05),),
                slider(snapshot.data),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("00:00"),
                    Text(snapshot.data.duration.inMinutes.toString() + ":" + (snapshot.data.duration.inSeconds - (snapshot.data.duration.inMinutes * 60)).toString()),              ],
                ),
                Text("Tempo da música"),
                Text(_retornarTempoMusica(snapshot.data.position), style: TextStyle(fontSize: _tela * 0.05),),
                Divider(),
                acoes(snapshot.data),



              ]),
            );
          }else{
              return Container();
            }
          }
        ),
        Divider(),
        listaMusica("2- Coldplay-Til-Kingdom-Come.mp3"),
        listaMusica("coldplay.mp3"),
        Divider(),
      ],
    );
  }

  Widget listaMusica(String musica){
    print("lista músicas");
    return ListTile(
      title: Text(musica),
      leading: Icon(Icons.music_note),

      onTap: (){
        audioController.trocarMusica(musica);

      },
    );
  }


  String _retornarTempoMusica(Duration position) {
    String segundos = (position.inMinutes >= 1
            ? ((position.inSeconds - position.inMinutes * 60))
            : position.inSeconds)
        .toString();

    if (position.inSeconds < 10) {
      segundos = "0" + segundos;
    }
    return position.inMinutes.toString() + ":" + segundos;
  }

  Widget acoes(AudioPlayerObjeto objeto) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        IconButton(
            iconSize: _tela * .1,
            icon: Icon(Icons.skip_previous),
            onPressed: () {


                audioController.botaoSkipBack();

            }),
        IconButton(
            iconSize: _tela * .2,
            icon: Icon(objeto.play == true
                ? Icons.pause_circle_filled
                : Icons.play_circle_filled),
            onPressed: () {
              audioController.botaoPlayPause();

            }),
        IconButton(
            iconSize: _tela * .1,
            icon: Icon(Icons.skip_next),
            onPressed: () {
             // setState(() {});
            }),
      ],
    );
  }

  Widget slider(AudioPlayerObjeto objeto) {
    return Slider(

        activeColor: Colors.amber,
        onChanged: (newValue) {

            print(newValue);
           audioController.tempoMusica(newValue);
            print(objeto.position.inSeconds.toDouble());

        },
        value: objeto.position.inSeconds.toDouble(),
        min: 0.0,
        max: objeto.duration.inSeconds.toDouble());
  }


}
