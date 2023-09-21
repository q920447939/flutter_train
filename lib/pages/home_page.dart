import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _imageUrls = [
    'https://swiper.com.cn/demo/indexsample/images/1.jpg?v=wf',
    'https://img2.woyaogexing.com/2023/09/21/b6360547deff023b77895eba53f261fc.jpg',
    'https://img2.woyaogexing.com/2023/09/21/8f92f263d2250741f40635e4f083b15a.png'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
              height: 160,
              child: Swiper(
                itemCount: _imageUrls.length,
                autoplay: true,
                itemBuilder: (BuildContext context, int index) {
                  return Image.network(
                    _imageUrls[index],
                    fit: BoxFit.fill,
                  );
                },
                pagination: const SwiperPagination(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
