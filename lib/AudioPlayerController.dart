import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:principal/AudioPlayerObjeto.dart';
import 'package:rxdart/rxdart.dart';


class AudioPlayerController extends BlocBase{

  //BLOC duration
  BehaviorSubject<AudioPlayerObjeto> durB = new BehaviorSubject<AudioPlayerObjeto>();

  Stream<AudioPlayerObjeto> get outDuration => durB.stream;
  Sink<AudioPlayerObjeto> get inDuration => durB.sink;
  //Fim bloc duration
  AudioPlayer advancedPlayer = new AudioPlayer();

  AudioPlayerObjeto audioObjeto;


  AudioPlayerController(){
    audioObjeto = new AudioPlayerObjeto(advancedPlayer,
        new AudioCache(fixedPlayer: advancedPlayer), "",
        new Duration(), new Duration(),
        "", false, "");


    print("Aqui!");

    audioObjeto.advancedPlayer.onDurationChanged.listen((Duration d){
      audioObjeto.duration = d;
      inDuration.add(audioObjeto);
    });

    audioObjeto.advancedPlayer.onAudioPositionChanged.listen((Duration  p){
      audioObjeto.position = p;

      inDuration.add(audioObjeto);


    });


    print("Aqui fim!");

    audioObjeto.musicaAtual = "coldplay.mp3";
    inDuration.add(audioObjeto);
  }

  botaoPlayPause(){
    if (audioObjeto.play) {
      audioObjeto.play = false;
      audioObjeto.advancedPlayer.pause();
    } else {
      audioObjeto.play = true;

      audioObjeto.audioCache.play(audioObjeto.musicaAtual);
    }
    inDuration.add(audioObjeto);

  }
  botaoSkipBack(){
    audioObjeto.advancedPlayer.stop();
    audioObjeto.advancedPlayer.play(audioController.audioObjeto.musicaAtual);
    inDuration.add(audioObjeto);

  }

  trocarMusica(String musica){
    audioObjeto.musicaAtual = musica;
    print(musica);


    //advancedPlayer.setUrl("2- Coldplay-Til-Kingdom-Come.mp3");
    audioObjeto.audioCache.play(audioObjeto.musicaAtual);
    audioObjeto.play = true;
    inDuration.add(audioObjeto);
  }

  tempoMusica(double newValue) {

    Duration newDuration = Duration(seconds: newValue.toInt());

    audioObjeto.advancedPlayer.seek(newDuration);


    audioObjeto.tempoMusica = newValue.toStringAsFixed(0);
    audioObjeto.advancedPlayer.resume();
    audioObjeto.play = true;
    inDuration.add(audioObjeto);
    print(newValue.toInt());
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }

}

AudioPlayerController audioController = new AudioPlayerController();