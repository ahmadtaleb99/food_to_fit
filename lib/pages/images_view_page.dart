import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_to_fit/models/medTestModel.dart';
import 'package:food_to_fit/widgets/appBarWidget.dart';
import 'package:food_to_fit/widgets/loadingCircularProgress.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../resources/app_constants.dart';

class ImagesViewPage extends StatefulWidget {
  final List<MedicalTestImages>? images;
  final int? initialIndex;

  const ImagesViewPage({Key? key, this.images, this.initialIndex = 0})
      : super(key: key);

  @override
  State<ImagesViewPage> createState() => _ImagesViewPageState();
}

class _ImagesViewPageState extends State<ImagesViewPage> {
  late int _currentIndex = widget.initialIndex!;
  late final _pageController = PageController(initialPage: _currentIndex);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBarWidget().appBarWidget(Text('Photo Preview'.tr(),
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16))) as PreferredSizeWidget?,
        body: Container(
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
              PhotoViewGallery.builder(
                reverse: true,
                scrollPhysics: const BouncingScrollPhysics(),
                builder: _buildItem,
                itemCount: widget.images!.length,
                loadingBuilder: (context, event) => Center(child: Loading()),
                pageController: _pageController,
                onPageChanged: (index) {
                      print(index);
                  setState(() {
                    if(index == widget.images!.length-1 ) {
                      // _pageController.animateToPage(0,
                      //     duration: const Duration(
                      //         milliseconds:
                      //        400),
                      //     curve: Curves.easeInOutCubicEmphasized);
                      _currentIndex = 0;
                    }

                    if ( index == -1)
                      _currentIndex = widget.images!.length-1;


                   else _currentIndex = index;

                  });
                },
              ),
              Positioned(
        bottom: 100,
                left: MediaQuery.of(context).size.width / 2.15,
                child: Row(
                  children: [
                    ...List<Widget>.generate(
                        widget.images!.length,
                            (index) => Padding(
                              padding:
                              EdgeInsets.symmetric(horizontal: 8.0),
                              child:
                              index == _currentIndex
                                  ? SvgPicture.asset(
                                  'assets/images/hollow_cirlce_ic.svg')
                                  : SvgPicture.asset(
                                  'assets/images/solid_circle_ic.svg'),
                            ))
                  ],
                ),
              ),

          ],
        ),
            )));
  }

  PhotoViewGalleryPageOptions _buildItem(BuildContext context, int index) {
    final item = widget.images![index];
    return PhotoViewGalleryPageOptions(
      imageProvider: NetworkImage(ConstAPIUrls.baseURLFiles + item.imagePath!),
      initialScale: PhotoViewComputedScale.contained * (0.9),
      minScale: PhotoViewComputedScale.contained * (0.5),
      maxScale: PhotoViewComputedScale.covered * 4.1,
      heroAttributes: PhotoViewHeroAttributes(tag: item.id.toString()),
    );
  }
}
