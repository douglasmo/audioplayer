

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioPlayerObjeto {
  AudioPlayer _advancedPlayer;
  AudioCache _audioCache;
  String _localFilePath;
  double _sliderVal;
  Duration _duration;
  Duration _position;
  String _tempoMusica = "";
  bool _play = false;
  String _musicaAtual = "";


  AudioPlayerObjeto(this._advancedPlayer, this._audioCache, this._localFilePath,
      this._duration, this._position, this._tempoMusica, this._play,
      this._musicaAtual);



  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is AudioPlayerObjeto &&
              runtimeType == other.runtimeType &&
              _advancedPlayer == other._advancedPlayer &&
              _audioCache == other._audioCache &&
              _localFilePath == other._localFilePath &&
              _duration == other._duration &&
              _position == other._position &&
              _tempoMusica == other._tempoMusica &&
              _play == other._play &&
              _musicaAtual == other._musicaAtual;

  @override
  int get hashCode =>
      _advancedPlayer.hashCode ^
      _audioCache.hashCode ^
      _localFilePath.hashCode ^
      _duration.hashCode ^
      _position.hashCode ^
      _tempoMusica.hashCode ^
      _play.hashCode ^
      _musicaAtual.hashCode;

  AudioPlayer get advancedPlayer => _advancedPlayer;

  set advancedPlayer(AudioPlayer value) {
    _advancedPlayer = value;
  }


  double get sliderVal => _sliderVal;

  set sliderVal(double value) {
    _sliderVal = value;
  }

  AudioCache get audioCache => _audioCache;

  set audioCache(AudioCache value){
    _audioCache = value;
  }

  get localFilePath => _localFilePath;

  set localFilePath(String value) {
    _localFilePath = value;
  }



  Duration get duration => _duration;

  set duration(Duration value) {
    _duration = value;
  }

  Duration get position => _position;

  set position(Duration value) {
    _position = value;
  }

  String get tempoMusica => _tempoMusica;

  set tempoMusica(String value) {
    _tempoMusica = value;
  }

  bool get play => _play;

  set play(bool value) {
    _play = value;
  }

  String get musicaAtual => _musicaAtual;

  set musicaAtual(String value) {
    _musicaAtual = value;
  }


}