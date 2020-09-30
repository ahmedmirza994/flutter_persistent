part of persistent_bottom_nav_bar;

class PersistentBottomNavBar extends StatelessWidget {
  const PersistentBottomNavBar({
    Key key,
    this.selectedIndex,
    this.previousIndex,
    this.iconSize,
    this.backgroundColor,
    this.items,
    this.navBarHeight,
    this.onItemSelected,
    this.decoration,
    this.padding,
    this.confineToSafeArea,
    this.customNavBarWidget,
    this.popScreensOnTapOfSelectedTab,
    this.popAllScreensForTheSelectedTab,
    this.itemAnimationProperties,
    this.hideNavigationBar,
    this.onAnimationComplete,
  }) : super(key: key);

  final int selectedIndex;
  final int previousIndex;
  final double iconSize;
  final Color backgroundColor;
  final List<PersistentBottomNavBarItem> items;
  final ValueChanged<int> onItemSelected;
  final double navBarHeight;
  final NavBarDecoration decoration;
  final NavBarPadding padding;
  final Widget customNavBarWidget;
  final Function(int) popAllScreensForTheSelectedTab;
  final bool popScreensOnTapOfSelectedTab;
  final bool confineToSafeArea;
  final ItemAnimationProperties itemAnimationProperties;
  final bool hideNavigationBar;
  final Function(bool, bool) onAnimationComplete;

  Widget _navBarWidget() => Container(
        decoration: getNavBarDecoration(
          decoration: this.decoration,
          showBorder: false,
          color: this.backgroundColor,
          opacity: items[selectedIndex].opacity,
        ),
        child: ClipRRect(
          borderRadius: this.decoration.borderRadius ?? BorderRadius.zero,
          child: BackdropFilter(
            filter: this.items[this.selectedIndex].filter ?? ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
            child: Container(
              decoration: getNavBarDecoration(
                showOpacity: false,
                decoration: this.decoration,
                color: this.backgroundColor,
                opacity: items[selectedIndex].opacity,
              ),
              child: SafeArea(
                top: false,
                right: false,
                left: false,
                bottom: this.navBarHeight == 0.0 || (this.hideNavigationBar ?? false) ? false : confineToSafeArea ?? true,
                child: getNavBarStyle(),
              ),
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return this.hideNavigationBar == null
        ? _navBarWidget()
        : OffsetAnimation(
            hideNavigationBar: this.hideNavigationBar,
            navBarHeight: this.navBarHeight,
            onAnimationComplete: (isAnimating, isComplete) {
              this.onAnimationComplete(isAnimating, isComplete);
            },
            child: _navBarWidget(),
          );
  }

  PersistentBottomNavBar copyWith(
      {int selectedIndex,
      double iconSize,
      int previousIndex,
      Color backgroundColor,
      Duration animationDuration,
      List<PersistentBottomNavBarItem> items,
      ValueChanged<int> onItemSelected,
      double navBarHeight,
      double horizontalPadding,
      Widget customNavBarWidget,
      Function(int) popAllScreensForTheSelectedTab,
      bool popScreensOnTapOfSelectedTab,
      NavBarDecoration decoration,
      bool confineToSafeArea,
      ItemAnimationProperties itemAnimationProperties,
      Function onAnimationComplete,
      bool hideNavigationBar,
      EdgeInsets padding}) {
    return PersistentBottomNavBar(
        selectedIndex: selectedIndex ?? this.selectedIndex,
        previousIndex: previousIndex ?? this.previousIndex,
        iconSize: iconSize ?? this.iconSize,
        confineToSafeArea: confineToSafeArea ?? this.confineToSafeArea,
        backgroundColor: backgroundColor ?? this.backgroundColor,
        items: items ?? this.items,
        itemAnimationProperties: itemAnimationProperties ?? this.itemAnimationProperties,
        popAllScreensForTheSelectedTab: popAllScreensForTheSelectedTab ?? this.popAllScreensForTheSelectedTab,
        onItemSelected: onItemSelected ?? this.onItemSelected,
        navBarHeight: navBarHeight ?? this.navBarHeight,
        padding: padding ?? this.padding,
        hideNavigationBar: hideNavigationBar ?? this.hideNavigationBar,
        customNavBarWidget: customNavBarWidget ?? this.customNavBarWidget,
        onAnimationComplete: onAnimationComplete ?? this.onAnimationComplete,
        popScreensOnTapOfSelectedTab: popScreensOnTapOfSelectedTab ?? this.popScreensOnTapOfSelectedTab,
        decoration: decoration ?? this.decoration);
  }

  bool opaque(int index) {
    return items == null ? true : !(items[index].opacity < 1.0);
  }

  Widget getNavBarStyle() {
    return BottomNavStyle12(
      items: this.items,
      backgroundColor: this.backgroundColor,
      iconSize: this.iconSize,
      navBarHeight: this.navBarHeight,
      onItemSelected: this.onItemSelected,
      selectedIndex: this.selectedIndex,
      itemAnimationProperties: itemAnimationProperties,
      previousIndex: this.previousIndex,
      popAllScreensForTheSelectedTab: this.popAllScreensForTheSelectedTab,
      popScreensOnTapOfSelectedTab: this.popScreensOnTapOfSelectedTab,
      padding: this.padding,
      decoration: this.decoration,
    );
  }
}
