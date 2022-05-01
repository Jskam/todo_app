import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/screens/pomodoro/pomodoro_model.dart';
import 'package:todo_app/widgets/app_text.dart';

class PomodoroScreen extends StatelessWidget {
  const PomodoroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const subtitle =
        'Это детище Франческо Чирилло, итальянского студента из 80-х, который искал способ сконцентрироваться на учёбе, для чего утащил с кухни таймер в виде помидорки. \n\nСуть техники очень простая:\n — Выбрать задачу, над которой хочешь работать.\n — Поставить таймер на 25 минут.\n — Усиленно работать над этой задачей 25 минут.\n — После — сделать перерыв в 5 минут.\n — Потом — снова сосредоточенно работать 25 минут.\n\nПосле 4-х «помидорных» циклов — сделать большой перерыв в 15-30 минут.\n\nНамылить, смыть, повторить.\n\nКроме таймера (сойдёт и кухонный, как у автора методики) пригодится бумага и ручка, чтобы отмечать проделанные помидорки. Прогрессы, чек-листы, закрытие гештальтов — вот это вот всё, потому что люди любят чекать :)\n\nНа тот же листочек можно записать блуждающую мысль, которая пришла во время рабочего интервала. Или задачку, которая всплыла в памяти. А заодно — пометить те самые отвлекающие факторы: бесконечные уведомления, перерывы на чай или почтовый ящик. Это и будут разрушительные паттерны поведения, которые мешают истинной продуктивности.\n\nНу и главное — по умолчанию ты должен работать в тихом месте, где будет минимум отвлекающих факторов (опенспейсы для этого плохо годятся, но ведь есть наушники и статусы «не беспокоить!»).';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Colors.green[700],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => _showSimpleModalDialog(context, subtitle),
            child: const _PomodoroInfoTile(subtitle: subtitle),
          ),
          const _TimerWidget(),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class _TimerWidget extends StatelessWidget {
  const _TimerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<PomodoroModel>();
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.green[600],
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
            border: Border.all(color: Colors.white, width: 3),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.3),
                blurRadius: 3,
                offset: const Offset(3, 3),
                spreadRadius: 3,
              )
            ],
          ),
          padding: const EdgeInsets.symmetric(vertical: 40),
          margin: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 10),
              CircularCountDownTimer(
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.width / 2,
                duration: 1500,
                fillColor: Colors.white,
                ringColor: Colors.white.withOpacity(.4),
                isReverse: true,
                onComplete: () {
                  FlutterRingtonePlayer.playAlarm(looping: true);
                  _showDialog(context);
                },
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                ),
                backgroundColor: Colors.green[700],
                autoStart: false,
                controller: model.countDownController,
              ),
              const SizedBox(height: 70),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _TimerButton(
                    icon: Icons.replay_outlined,
                    function: model.onRestartButton,
                  ),
                  _TimerButton(
                    icon: !model.isPaused
                        ? Icons.pause
                        : Icons.play_arrow_rounded,
                    function: model.onPauseAndPlayButton,
                  ),
                ],
              ),
            ],
          ),
        ),
        Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: AppText(
              size: 28,
              text: 'Work',
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }

  _showDialog(BuildContext context) {
    final model = context.read<PomodoroModel>();
    return showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text('Time is over!'),
          titleTextStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 22,
          ),
          actions: [
            MaterialButton(
              color: Colors.green[700],
              onPressed: () {
                FlutterRingtonePlayer.stop();
                model.onRestartButton();
                Navigator.of(context).pop();
              },
              child: AppText(
                size: 16,
                text: 'Close',
                color: Colors.white,
              ),
            ),
          ],
          content: AppText(
            size: 20,
            text: 'Nice Work! So Now You Can Relax :)',
          ),
        );
      },
    );
  }
}

class _PomodoroInfoTile extends StatelessWidget {
  const _PomodoroInfoTile({
    Key? key,
    required this.subtitle,
  }) : super(key: key);

  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
      padding: const EdgeInsets.all(2),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: ListTile(
        leading: const Icon(
          Icons.emoji_objects,
          size: 34,
          color: Colors.orange,
        ),
        minLeadingWidth: 0,
        title: AppText(
          size: 18,
          text: 'Кратко о Помодоро',
          fweight: FontWeight.bold,
        ),
        subtitle: AppText(
          size: 16,
          text: subtitle,
          fweight: FontWeight.w300,
          maxLines: 2,
          overflow: true,
        ),
      ),
    );
  }
}

class _TimerButton extends StatelessWidget {
  const _TimerButton({
    Key? key,
    required this.icon,
    required this.function,
  }) : super(key: key);

  final IconData icon;
  final VoidCallback function;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: IconButton(
        onPressed: function,
        iconSize: 40,
        icon: Icon(
          icon,
          color: Colors.green[700],
        ),
      ),
    );
  }
}

_showSimpleModalDialog(context, String subtitle) {
  showGeneralDialog(
    context: context,
    barrierDismissible: false,
    transitionDuration: const Duration(
      milliseconds: 300,
    ),
    pageBuilder: (_, __, ___) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(
              Icons.close,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: AppText(
            size: 20,
            text: 'Кратко о Технике Помодоро',
            fweight: FontWeight.bold,
          ),
          elevation: 0.0,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset('assets/images/tomato.jpg'),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: AppText(size: 18, text: subtitle),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
