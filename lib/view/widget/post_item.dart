import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:demo_app/data/model/post_model.dart';
import 'package:demo_app/utils/datetime_utils.dart';
import 'package:demo_app/utils/high_light_text_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PostItemWidget extends StatelessWidget {
  final Content post;
  final bool isSubWidget;

  const PostItemWidget({
    super.key,
    required this.post,
    this.isSubWidget = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      child: Column(
        children: [
          Container(
            margin:
                EdgeInsets.symmetric(horizontal: isSubWidget ? 12 : 0),
            decoration: isSubWidget
                ? const BoxDecoration(
                    border: Border(
                      right: BorderSide(
                        color: Colors.black12,
                        width: 1,
                      ),
                      top: BorderSide(
                        color: Colors.black12,
                        width: 1,
                      ),
                      left: BorderSide(
                        color: Colors.black12,
                        width: 1,
                      ),
                    ),
                  )
                : null,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                _PostHeader(
                  post: post,
                  isSubWidget: isSubWidget,
                ),
                _PostDescription(
                  content: post.content ?? '',
                  placeName: post.placeName ?? '',
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
          // child ?? _PostMedia(isVideoMedia: isVideo),
          post.postShare != null
              ? PostItemWidget(
                  post: post.postShare!,
                  isSubWidget: true,
                )
              : const SizedBox.shrink(),
          if (!isSubWidget)
            _PostMedia(
              post: post,
              isSubWidget: isSubWidget,
            ),
          if (!isSubWidget) const _PostAction(),
        ],
      ),
    );
  }
}

class _PostMedia extends StatelessWidget {
  final Content post;
  final bool isSubWidget;

  const _PostMedia({
    super.key,
    required this.post,
    required this.isSubWidget,
  });

  @override
  Widget build(BuildContext context) {
    final postShare = post.postShare;
    final url = postShare?.url ?? post.url;
    final contentType = postShare?.contentType ?? post.contentType;

    if ((url ?? []).isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        contentType == 1
            ? _VideoItem(
                post: post,
                url: url?[0] ?? '',
              )
            : _ImageSlider(
                imagesUrl: url!,
                post: post,
              ),
        // const _VideoItem(),
      ],
    );
  }
}

class _PostHeader extends StatelessWidget {
  final Content post;
  final bool isSubWidget;

  const _PostHeader({
    super.key,
    required this.post,
    required this.isSubWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _PostHeaderAvatar(
            post: post,
            isSubWidget: isSubWidget,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 8,
                vertical: isSubWidget ? 0 : 5,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    post.fullName ?? 'Người dùng SmartTravel',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                          post.createdAt != null
                              ? DateTimeUtils.displayTimeSocial(
                                  post.createdAt ?? 0)
                              : '',
                          style: const TextStyle(
                              fontSize: 16, color: Colors.black)),
                      const SizedBox(width: 4),
                      Container(
                        height: 3,
                        width: 3,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.black38),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.language,
                        color: Colors.black38,
                        size: 16,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
          if (!isSubWidget) const Icon(Icons.more_horiz, color: Colors.black38),
        ],
      ),
    );
  }
}

class _PostHeaderAvatar extends StatelessWidget {
  final Content post;
  final bool isSubWidget;

  const _PostHeaderAvatar({
    super.key,
    required this.post,
    required this.isSubWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            margin: const EdgeInsets.only(bottom: 10),
            height: isSubWidget ? 36 : 48,
            width: isSubWidget ? 36 : 48,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: CachedNetworkImage(
              imageUrl: post.imageProfile ?? '',
              width: isSubWidget ? 36 : 48,
              height: isSubWidget ? 36 : 48,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 1,
                    color: Colors.transparent,
                  ),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              placeholder: (context, url) => const SizedBox(),
              errorWidget: (context, url, error) => const SizedBox(),
              fadeInCurve: Curves.linear,
              fadeInDuration: const Duration(milliseconds: 0),
              fadeOutCurve: Curves.linear,
              fadeOutDuration: const Duration(milliseconds: 0),
            )),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            width: 16,
            height: 16,
            decoration: const BoxDecoration(
              color: Colors.pink,
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 10,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _PostDescription extends StatelessWidget {
  final String content;
  final String placeName;

  const _PostDescription({
    super.key,
    required this.content,
    required this.placeName,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (content.isNotEmpty)
            HighlightTextBase(
              text: content,
            ),
          const SizedBox(height: 8),
          Container(
            height: 26,
            padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.sizeOf(context).width - 24,
            ),
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(26),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  color: Colors.blue,
                  size: 16,
                ),
                const SizedBox(width: 4),
                Flexible(
                  child: Text(
                    placeName ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
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

class _VideoItem extends ConsumerStatefulWidget {
  final Content post;
  final String url;

  const _VideoItem({
    required this.post,
    required this.url,
  });

  @override
  _VideoItemState createState() => _VideoItemState();
}

class _VideoItemState extends ConsumerState<_VideoItem> {
  late VideoPlayerController _controller;
  late YoutubePlayerController _youtubeController;

  bool _isYoutubeUrl(String url) {
    final youtubeRegex = RegExp(
      r'^(https?:\/\/)?(www\.)?(youtube\.com|youtu\.be)\/.+$',
    );
    return youtubeRegex.hasMatch(url);
  }

  @override
  void initState() {
    if (_isYoutubeUrl(widget.url)) {
      _youtubeController = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(widget.url)!,
        flags: const YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
        ),
      );
    } else {
      _controller = VideoPlayerController.networkUrl(
        Uri.parse(
          widget.url,
        ),
      )..initialize().then((_) => setState(() {}));
    }
    super.initState();
  }

  @override
  void dispose() {
    if (_isYoutubeUrl(widget.url)) {
      _youtubeController.dispose();
    } else {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        VisibilityDetector(
          key: Key(widget.url),
          onVisibilityChanged: (visibilityInfo) {
            if (visibilityInfo.visibleFraction > 0.5) {
              // Bắt đầu phát video nếu hiển thị > 50% trên màn hình
              if (_isYoutubeUrl(widget.url)) {
                _youtubeController.play();
              } else {
                _controller.play();
              }
            } else {
              // Tạm dừng hoặc giải phóng tài nguyên video
              if (_isYoutubeUrl(widget.url)) {
                _youtubeController.pause();
              } else {
                _controller.pause();
              }
            }
          },
          child: Material(
            color: Colors.black,
            child: AspectRatio(
              aspectRatio: 414 / 247,
              child: _isYoutubeUrl(widget.url)
                  ? YoutubePlayer(
                      controller: _youtubeController,
                      aspectRatio: 1,
                      showVideoProgressIndicator: true,
                      progressColors: const ProgressBarColors(
                        playedColor: Colors.red,
                        handleColor: Colors.redAccent,
                      ),
                    )
                  : _controller.value.isInitialized
                      ? VisibilityDetector(
                          key: UniqueKey(),
                          onVisibilityChanged: (visibilityInfo) {
                            var visiblePercentage =
                                visibilityInfo.visibleFraction;
                            if (visiblePercentage == 1) {
                              _controller.play();
                              setState(() {});
                            } else {
                              _controller.pause();
                              setState(() {});
                            }
                          },
                          child: Container(
                            color: Colors.black,
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: SizedBox(
                                width: _controller.value.size.width,
                                height: _controller.value.size.height,
                                child: Stack(
                                  children: [
                                    VideoPlayer(_controller),
                                    // if (!_controller.value.isPlaying)
                                    //   Positioned.fill(
                                    //     child: Container(
                                    //       color: Colors.black.withOpacity(.5),
                                    //       alignment: Alignment.center,
                                    //       child: const Icon(
                                    //         Icons.play_arrow_rounded,
                                    //         size: 80,
                                    //         color: Colors.white,
                                    //       ),
                                    //     ),
                                    //   ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      : const Center(child: CircularProgressIndicator()),
            ),
          ),
        ),
        _PostCountAction(
          post: widget.post,
        ),
      ],
    );
  }
}

class _ImageSlider extends ConsumerStatefulWidget {
  final Content post;
  final List<String> imagesUrl;

  const _ImageSlider({
    required this.imagesUrl,
    required this.post,
  });

  @override
  _ImageSliderState createState() => _ImageSliderState();
}

class _ImageSliderState extends ConsumerState<_ImageSlider> {
  final controller = CarouselSliderController();
  int current = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.imagesUrl.isEmpty) {
      return const SizedBox.shrink();
    }

    final indicatorSliderWidget = (widget.imagesUrl).length >= 2
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              widget.imagesUrl.length > 5 ? 5 : widget.imagesUrl.length,
              (index) {
                int total = widget.imagesUrl.length;

                int adjustedIndex;
                if (total <= 5) {
                  adjustedIndex = index;
                } else {
                  if (current <= 2) {
                    adjustedIndex = index;
                  } else if (current >= total - 3) {
                    adjustedIndex = total - 5 + index;
                  } else {
                    adjustedIndex = current - 2 + index;
                  }
                }

                int distance = (current - adjustedIndex).abs();
                double size = 8.0 - (distance * 2).clamp(0, 6);

                return Container(
                  width: size,
                  height: size,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          current == adjustedIndex ? Colors.pink : Colors.grey),
                );
              },
            ),
          )
        : null;

    return Column(
      children: [
        Material(
          color: Colors.black,
          child: Stack(
            children: [
              CarouselSlider(
                carouselController: controller,
                items: widget.imagesUrl
                    .map(
                      (item) => CachedNetworkImage(
                        memCacheWidth: MediaQuery.sizeOf(context).width.toInt(),
                        // memCacheHeight: 300,
                        imageUrl: item,
                        placeholder: (context, url) => const SizedBox(),
                        errorWidget: (context, url, error) => const SizedBox(),
                      ),
                    )
                    .toList(),
                options: CarouselOptions(
                  autoPlay: false,
                  viewportFraction: 1.0,
                  enlargeCenterPage: true,
                  enableInfiniteScroll: false,
                  onPageChanged: (index, reason) {
                    setState(() {
                      current = index;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
        _PostCountAction(
          post: widget.post,
          child: indicatorSliderWidget,
        ),
      ],
    );
  }
}

class _PostCountAction extends StatelessWidget {
  final Content post;
  final Widget? child;

  const _PostCountAction({super.key, required this.post, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(
                Icons.favorite,
                color: Colors.pink,
                size: 16,
              ),
              const SizedBox(width: 4),
              SizedBox(
                width: 30,
                child: Text(
                  post.likeCount.toString(),
                ),
              ),
            ],
          ),
          child ?? const SizedBox.shrink(),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    post.commentCount.toString(),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  const Text(
                    'bình luận',
                  ),
                ],
              ),
              const SizedBox(
                width: 4,
              ),
              Container(
                height: 4,
                width: 4,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black12,
                ),
              ),
              const SizedBox(
                width: 4,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    post.shareCount.toString(),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  const Text(
                    'lượt chia sẻ',
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PostAction extends StatelessWidget {
  const _PostAction({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.black12)
        )
      ),
      child: const Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 46,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite_outline,
                    color: Colors.grey,
                    size: 18,
                  ),
                  SizedBox(width: 4),
                  Text(
                    "Thích",
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              height: 46,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.message,
                    color: Colors.grey,
                    size: 18,
                  ),
                  SizedBox(width: 4),
                  Text(
                    "Bình luận",
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              height: 46,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.share,
                    color: Colors.grey,
                    size: 18,
                  ),
                  SizedBox(width: 4),
                  Text(
                    "Chia sẻ",
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
