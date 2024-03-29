import 'package:flutter/material.dart';

enum BottomNav {
  home,
  feed,
  map,
  chat,
  setting;
}

extension BottomNavEx on BottomNav {
  String get label {
    switch (this) {
      case BottomNav.home:
        return "홈";
      case BottomNav.feed:
        return "피드";
      case BottomNav.map:
        return "지도";
      case BottomNav.chat:
        return "채팅";
      case BottomNav.setting:
        return "세팅";
    }
  }

  IconData get icon {
    switch (this) {
      case BottomNav.home:
        return Icons.home_outlined;
      case BottomNav.feed:
        return Icons.photo_album_outlined;
      case BottomNav.map:
        return Icons.map_outlined;
      case BottomNav.chat:
        return Icons.chat_bubble_outline;
      case BottomNav.setting:
        return Icons.settings_outlined;
    }
  }

  IconData get activeIcon {
    switch (this) {
      case BottomNav.home:
        return Icons.home;
      case BottomNav.feed:
        return Icons.photo_album;
      case BottomNav.map:
        return Icons.map;
      case BottomNav.chat:
        return Icons.chat_bubble;
      case BottomNav.setting:
        return Icons.settings;
    }
  }
}
