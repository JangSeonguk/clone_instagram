import 'package:baby_stamp/widget/asset_thumbnail.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

class MyGallery extends StatefulWidget {
  const MyGallery({super.key});

  @override
  State<MyGallery> createState() => _MyGalleryState();
}

class _MyGalleryState extends State<MyGallery> {
  bool _hasPermission = false;
  List<AssetEntity> assets = [];

  final int _pageSize = 20;
  bool _isLoading = false;
  bool _hasMore = true;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _requestPermission();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 100) {
      _fetchAssets();
    }
  }

  Future<void> _fetchAssets() async {
    if (_isLoading || !_hasMore) return;

    setState(() {
      _isLoading = true;
    });

    final fetchedAssets = await PhotoManager.getAssetListRange(
      start: assets.length,
      end: assets.length + _pageSize,
    );

    setState(() {
      assets.addAll(fetchedAssets);
      _isLoading = false;
      _hasMore = fetchedAssets.length >= _pageSize;
    });
  }

  Future<void> _requestPermission() async {
    final PermissionState permission =
        await PhotoManager.requestPermissionExtend();
    if (permission.isAuth) {
      setState(() {
        _hasPermission = true;
      });
      _fetchAssets();
    } else {
      // 권한 거부 시 처리
      setState(() {
        _hasPermission = false;
      });
      if (mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('권한이 필요합니다'),
            content: const Text('갤러리 접근을 위해 권한이 필요합니다.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  PhotoManager.openSetting();
                },
                child: const Text('설정으로 이동'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('취소'),
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_hasPermission) {
      return const Center(
        child: Text('갤러리 접근 권한이 필요합니다'),
      );
    } else {
      return Stack(
        children: [
          GridView.builder(
            controller: _scrollController,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemBuilder: (_, index) {
              if (index < assets.length) {
                return AssetThumbnail(asset: assets[index]);
              } else if (_hasMore) {
                return const Center(child: CircularProgressIndicator());
              }
              return null;
            },
            itemCount: _hasMore ? assets.length + 1 : assets.length,
          ),
          if (_isLoading)
            const Positioned(
              bottom: 16,
              left: 0,
              right: 0,
              child: Center(child: CircularProgressIndicator()),
            ),
        ],
      );
    }
  }
}
