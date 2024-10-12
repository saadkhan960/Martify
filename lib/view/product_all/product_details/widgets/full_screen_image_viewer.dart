import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:martify/utils/constants/color.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class FullScreenImageViewer extends StatefulWidget {
  const FullScreenImageViewer({
    super.key,
    required this.images,
    required this.initialIndex,
    required this.isNetworkImage,
  });

  final List<String> images;
  final int initialIndex;
  final bool isNetworkImage;

  @override
  FullScreenImageViewerState createState() => FullScreenImageViewerState();
}

class FullScreenImageViewerState extends State<FullScreenImageViewer> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          PhotoViewGallery.builder(
            pageController: _pageController,
            itemCount: widget.images.length,
            onPageChanged: (index) {
              setState(() {});
            },
            builder: (context, index) {
              return PhotoViewGalleryPageOptions(
                imageProvider: widget.isNetworkImage
                    ? CachedNetworkImageProvider(widget.images[index])
                    : AssetImage(widget.images[index]) as ImageProvider,
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.covered * 2,
              );
            },
            scrollPhysics: const BouncingScrollPhysics(),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(
              child: DotsIndicator(
                dotsCount: widget.images.length,
                position:
                    (_pageController.hasClients && _pageController.page != null)
                        ? _pageController.page!.round().toInt()
                        : widget.initialIndex.toInt(),
                decorator: const DotsDecorator(
                  size: Size(8.0, 8.0),
                  activeSize: Size(10.0, 10.0),
                  activeColor: MAppColors.primary,
                  color: MAppColors.grey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
