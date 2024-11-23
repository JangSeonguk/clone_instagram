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

  Future<void> _fetchAssets() async {
    assets = await PhotoManager.getAssetListRange(
      start: 0,
      end: 20,
    );
  }

  @override
  void initState() {
    super.initState();
    _requestPermission();
    _fetchAssets();
  }

  Future<void> _requestPermission() async {
    final PermissionState permission =
        await PhotoManager.requestPermissionExtend();
    setState(() {
      _hasPermission = permission.isAuth;
    });

    // 권한이 거부된 경우
    if (!permission.isAuth) {
      // 사용자에게 권한이 필요한 이유를 설명
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
    }

    return GridView.builder(
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemBuilder: (_, index) {
        return AssetThumbnail(asset: assets[index]);
      },
      itemCount: assets.length,
    );
  }
}
