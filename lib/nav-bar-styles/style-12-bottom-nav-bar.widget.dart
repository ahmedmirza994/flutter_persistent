part of persistent_bottom_nav_bar;

class BottomNavStyle12 extends StatefulWidget {
  final int selectedIndex;
  final int previousIndex;
  final double iconSize;
  final Color backgroundColor;
  final bool showElevation;
  final Duration animationDuration;
  final List<PersistentBottomNavBarItem> items;
  final ValueChanged<int> onItemSelected;
  final double navBarHeight;
  final NavBarPadding padding;
  final Function(int) popAllScreensForTheSelectedTab;
  final bool popScreensOnTapOfSelectedTab;
  final ItemAnimationProperties itemAnimationProperties;
  final NavBarDecoration decoration;

  BottomNavStyle12({
    Key key,
    this.selectedIndex,
    this.previousIndex,
    this.showElevation = false,
    this.iconSize,
    this.backgroundColor,
    this.itemAnimationProperties,
    this.decoration,
    this.popScreensOnTapOfSelectedTab,
    this.animationDuration = const Duration(milliseconds: 1000),
    this.navBarHeight = 0.0,
    @required this.items,
    this.onItemSelected,
    this.padding,
    this.popAllScreensForTheSelectedTab,
  });

  @override
  _BottomNavStyle12State createState() => _BottomNavStyle12State();
}

class _BottomNavStyle12State extends State<BottomNavStyle12> {
  int _lastSelectedIndex;
  int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _lastSelectedIndex = 0;
    _selectedIndex = 0;
  }

  Widget _buildItem(PersistentBottomNavBarItem item, bool isSelected) {
    return Container(
      alignment: Alignment.center,
      height: kBottomNavigationBarHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Flexible(
            child: IconTheme(
              data: IconThemeData(
                size: 26.0,
                color: isSelected ? item.activeColor : item.inactiveColor,
              ),
              child: item.icon,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.selectedIndex != _selectedIndex) {
      _lastSelectedIndex = _selectedIndex;
      _selectedIndex = widget.selectedIndex;
    }
    return Container(
      width: double.infinity,
      color: Colors.white,
      height: kBottomNavigationBarHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: widget.items.map((item) {
          var index = widget.items.indexOf(item);
          return Flexible(
            child: GestureDetector(
              onTap: () {
                if (widget.items[index].onPressed != null) {
                  widget.items[index].onPressed();
                } else {
                  if (index != _selectedIndex) {
                    _lastSelectedIndex = _selectedIndex;
                    _selectedIndex = index;
                  } else if (widget.previousIndex == index) {
                    widget.popAllScreensForTheSelectedTab(index);
                  }
                  widget.onItemSelected(index);
                }
              },
              child: _buildItem(item, widget.selectedIndex == index),
            ),
          );
        }).toList(),
      ),
    );
  }
}
