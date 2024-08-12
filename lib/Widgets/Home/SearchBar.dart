import 'package:cached_network_image/cached_network_image.dart';
import 'package:dantotsu/Functions/Extensions.dart';
import 'package:dantotsu/Screens/Login/LoginScreen.dart';
import 'package:flutter/material.dart';
import '../../Animation/SlideUpAnimation.dart';
import '../../Screens/Settings/SettingsBottomSheet.dart';
import '../../api/Anilist/Anilist.dart';
import 'AvtarWidget.dart';
import 'NotificationBadge.dart';

class MediaSearchBar extends StatelessWidget {
  final AnilistData data;
  final ColorScheme theme;
  final String title ;

  const MediaSearchBar({
    super.key,
    required this.data,
    required this.theme,
    required this.title,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(32, 36.statusBar(), 32, 24),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              },
              child: AbsorbPointer(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: title,
                    hintStyle: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                      color: theme.onSurface,
                    ),
                    suffixIcon: Icon(Icons.search,color: theme.onSurface),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(28),
                      borderSide: BorderSide(
                        color:theme.primaryContainer,
                        width: 1.0,
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.grey.withOpacity(0.2),
                  ),
                  readOnly: true,

                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          data.avatar == null || data.avatar!.isEmpty
              ? AvatarWidget(theme: theme, icon: Icons.settings)
              : SlideUpAnimation(
            child: Stack(
              children: [
                GestureDetector(
                  onTap: () => settingsBottomSheet(context),
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 26.0,
                    backgroundImage: CachedNetworkImageProvider(data.avatar!),
                  ),
                ),
                if (data.unreadNotificationCount > 0)
                  Positioned(
                    right: 0,
                    bottom: -2,
                    child: NotificationBadge(count: data.unreadNotificationCount),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
