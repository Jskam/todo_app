import 'package:flutter/material.dart';
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
            child: Container(
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
                  weight: FontWeight.bold,
                ),
                subtitle: AppText(
                  size: 16,
                  text: subtitle,
                  weight: FontWeight.w300,
                  maxLines: 2,
                  overflow: true,
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.touch_app),
                  onPressed: () {},
                ),
              ),
            ),
          ),
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 120,
            child: CircleAvatar(
              radius: 105,
              backgroundColor: Colors.green[700],
              child: AppText(
                size: 34,
                text: '25:00',
                color: Colors.white,
                weight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 90),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.1),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: IconButton(
                    onPressed: () {},
                    iconSize: 40,
                    icon: const Icon(
                      Icons.pause,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.1),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: IconButton(
                    onPressed: () {},
                    iconSize: 40,
                    icon: const Icon(
                      Icons.play_circle_outline_rounded,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.1),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: IconButton(
                    onPressed: () {},
                    iconSize: 40,
                    icon: const Icon(
                      Icons.replay_outlined,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
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
            weight: FontWeight.bold,
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
