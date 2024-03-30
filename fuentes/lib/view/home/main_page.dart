import 'package:agenda_isapre/main.dart';
import 'package:agenda_isapre/view/task/task_finaliced_listview.dart';
import 'package:agenda_isapre/view/task/task_form_page.dart';
import 'package:agenda_isapre/view/task/task_listview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}


class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  
  List<Widget> bodyWidget = [
    const TaskListView(),
    const TaskFinalicedListView(),
  ];


  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final theme = Theme.of(context).colorScheme;
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.inversePrimary, //Theme.of(context).colorScheme.inversePrimary,
        title: Text(localizations.taskForDo, style: TextStyle(fontSize: 28.sp),),
      ),      
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: bodyWidget[_currentIndex],
      ), //TaskListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => const TaskFormPage()));
        },
        tooltip: localizations.addDetail,
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int newIndex){
          setState(() {
            _currentIndex = newIndex;
          });
        },
        items: [
          BottomNavigationBarItem(
            label: localizations.all,
            icon: const Icon(Icons.list)
          ),
          BottomNavigationBarItem(
            label: localizations.finalized,
            icon: const Icon(Icons.done)
          )
          ],
      ),
    );
  }
}
