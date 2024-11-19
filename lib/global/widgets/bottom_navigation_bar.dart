import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'bottom_navigation_provider.dart'; 

class GlobaleBottomNavigationBar extends StatelessWidget {
   GlobaleBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final provider = Provider.of<BottomNavigationProvider>(context);

    return Container(
      margin: EdgeInsets.all(size.width * 0.05),
      height: size.height * 0.08,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ListView.builder(
        itemCount: IconOfList.length,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.025),
        itemBuilder: (_, index) => InkWell(
          onTap: () {
            provider.updateIndex(index);
          },
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Tooltip(
                message: 'Page ${index + 1}',
                child: Icon(
                  IconOfList[index],
                  size: size.width * 0.076,
                  color: index == provider.currentIndex ? Colors.amber : Colors.black38,
                ),
              ),
              SizedBox(height: size.width * 0.03),
              AnimatedContainer(
                duration: const Duration(milliseconds: 1000),
                curve: Curves.fastLinearToSlowEaseIn,
                margin: EdgeInsets.only(
                  bottom: index == provider.currentIndex ? size.height * 0.002 : 0,
                ),
                height: index == provider.currentIndex ? size.height * 0.008 : 0,
                width: size.width * 0.2,
                decoration: BoxDecoration(
                  color: Colors.amberAccent,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final List<IconData> IconOfList = [
    Icons.person,
    Icons.graphic_eq,
    Icons.map,
    Icons.settings,
  ];
}
