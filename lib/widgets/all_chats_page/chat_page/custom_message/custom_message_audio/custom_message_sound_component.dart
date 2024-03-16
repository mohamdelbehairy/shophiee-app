import 'dart:async';

import 'package:app/cubit/update_message_audio_playing/update_message_audio_playing_cubit.dart';
import 'package:app/models/message_model.dart';
import 'package:app/models/users_model.dart';
import 'package:app/widgets/all_chats_page/chat_page/custom_message/custom_message_audio/custom_message_audio_icon.dart';
import 'package:app/widgets/all_chats_page/chat_page/custom_message/custom_message_audio/custom_message_sound_details.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomMessageSoundComponent extends StatefulWidget {
  const CustomMessageSoundComponent(
      {super.key,
      required this.user,
      required this.size,
      required this.message});
  final UserModel user;
  final Size size;
  final MessageModel message;

  @override
  State<CustomMessageSoundComponent> createState() =>
      _CustomMessageSoundComponentState();
}

class _CustomMessageSoundComponentState
    extends State<CustomMessageSoundComponent> {
  late AudioPlayer audioPlayer;
  bool isPlaying = false;

  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();

    audioPlayerStateChanged();
    audioPlayerDurationChanged();
    audioPlayerPositionChanged();
    audioPlayerComplete();
    computeAndPrintDuration();
  }

  @override
  Widget build(BuildContext context) {
    var updateMessageAudioPlaying =
        context.read<UpdateMessageAudioPlayingCubit>();
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(
              top: widget.message.messageSoundPlaying == false
                  ? widget.size.width * .03
                  : 0.0),
          child: CustomMessageAudioIcon(
              size: widget.size,
              message: widget.message,
              icon: isPlaying ? FontAwesomeIcons.pause : FontAwesomeIcons.play,
              onTap: () async {
                await updateMessageAudioPlaying.updateMessageAudioPlaying(
                    friendID: widget.user.userID,
                    messageID: widget.message.messageID);
                if (isPlaying) {
                  await audioPlayer.pause();
                  setState(() {
                    isPlaying = false;
                  });
                } else {
                  if (audioPlayer.state == PlayerState.playing) {
                    await audioPlayer.stop();
                  }
                  audioPlayer.onPlayerComplete.listen((event) {
                    setState(() {
                      isPlaying = false;
                    });
                  });
                  await audioPlayer
                      .play(UrlSource(widget.message.messageSound!));
                  setState(() {
                    isPlaying = true;
                  });
                }
              }),
        ),
        CustomMessageSoudDetails(
            size: widget.size,
            duration: duration,
            position: position,
            message: widget.message,
            audioPlayer: audioPlayer)
      ],
    );
  }

  StreamSubscription<PlayerState> audioPlayerStateChanged() {
    return audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });
  }

  void audioPlayerDurationChanged() {
    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });
  }

  void audioPlayerPositionChanged() {
    audioPlayer.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
  }

  StreamSubscription<void> audioPlayerComplete() {
    return audioPlayer.onPlayerComplete.listen((event) {
      setState(() {
        isPlaying = false;
        position = Duration.zero;
      });
    });
  }

  void computeAndPrintDuration() async {
    await audioPlayer.setSource(UrlSource(widget.message.messageSound!));

    await audioPlayer.getDuration();
  }
}
