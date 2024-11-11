import 'package:baby_stamp/constants/common_size.dart';
import 'package:baby_stamp/constants/screen_size.dart';
import 'package:baby_stamp/widget/rounded_avatar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProfileBody extends StatefulWidget {
  const ProfileBody({super.key});

  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  SelectedTab _selectedTab = SelectedTab.left;
  double _leftImagesPageMargin = 0;
  double _rightImagesPageMargin = screenSize.width;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomScrollView(
        slivers: [
          SliverList(
              delegate: SliverChildListDelegate([
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.all(commonGap),
                  child: RoundedAvatar(
                    size: 80,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: commonGap),
                    child: Table(
                      children: [
                        TableRow(children: [
                          _valueText("122"),
                          _valueText("122"),
                          _valueText("122"),
                        ]),
                        TableRow(children: [
                          _labelText("Post"),
                          _labelText("Followers"),
                          _labelText("Following"),
                        ])
                      ],
                    ),
                  ),
                )
              ],
            ),
            _username(),
            _userBio(),
            _editProfileBtn(),
            _tabButtons(),
            _selectedIndicator(),
          ])),
          _imagesPager(),
        ],
      ),
    );
  }

  Text _valueText(String value) => Text(
        value,
        textAlign: TextAlign.center,
        style: const TextStyle(fontWeight: FontWeight.bold),
      );

  Text _labelText(String value) => Text(
        value,
        textAlign: TextAlign.center,
        style: const TextStyle(fontWeight: FontWeight.w300, fontSize: 11),
      );

  SliverToBoxAdapter _imagesPager() {
    return SliverToBoxAdapter(
      child: Stack(children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          transform: Matrix4.translationValues(_leftImagesPageMargin, 0, 0),
          curve: Curves.fastOutSlowIn,
          child: _images(0),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          transform: Matrix4.translationValues(_rightImagesPageMargin, 0, 0),
          curve: Curves.fastOutSlowIn,
          child: _images(30),
        ),
      ]),
    );
  }

  GridView _images(int addIndex) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 3,
      childAspectRatio: 1,
      physics: const NeverScrollableScrollPhysics(),
      children: List.generate(
        30,
        (index) => CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: "https://picsum.photos/id/${index + addIndex}/100/100"),
      ),
    );
  }

  Widget _selectedIndicator() {
    return AnimatedContainer(
      alignment: _selectedTab == SelectedTab.left
          ? Alignment.centerLeft
          : Alignment.centerRight,
      curve: Curves.fastOutSlowIn,
      duration: const Duration(milliseconds: 300),
      child: Container(
        width: screenSize.width / 2,
        height: 3,
        color: Colors.black,
      ),
    );
  }

  void _updateSelectedTab(SelectedTab selectedTab) {
    setState(() {
      _selectedTab = selectedTab;
      switch (selectedTab) {
        case SelectedTab.left:
          _leftImagesPageMargin = 0;
          _rightImagesPageMargin = screenSize.width;
          break;
        case SelectedTab.right:
          _leftImagesPageMargin = -screenSize.width;
          _rightImagesPageMargin = 0;
          break;
      }
    });
  }

  Row _tabButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: IconButton(
            onPressed: () => _updateSelectedTab(SelectedTab.left),
            icon: Icon(
              Icons.grid_on_rounded,
              color:
                  _selectedTab == SelectedTab.left ? Colors.black : Colors.grey,
              size: 30,
            ),
          ),
        ),
        Expanded(
          child: IconButton(
            onPressed: () => _updateSelectedTab(SelectedTab.right),
            icon: Icon(
              Icons.save_alt_rounded,
              color: _selectedTab == SelectedTab.right
                  ? Colors.black
                  : Colors.grey,
              size: 30,
            ),
          ),
        )
      ],
    );
  }
}

Padding _editProfileBtn() {
  return Padding(
    padding: const EdgeInsets.symmetric(
        horizontal: commonGap, vertical: commonXxsGap),
    child: SizedBox(
      height: 30,
      child: OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.black),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
        child: const Text(
          "Edit Profile",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
    ),
  );
}

Widget _username() {
  return const Padding(
    padding: EdgeInsets.symmetric(horizontal: commonGap),
    child: Text(
      'This is my username',
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
  );
}

Widget _userBio() {
  return const Padding(
    padding: EdgeInsets.symmetric(horizontal: commonGap),
    child: Text(
      'This is what i believe!!',
      style: TextStyle(fontWeight: FontWeight.w400),
    ),
  );
}

enum SelectedTab { left, right }
