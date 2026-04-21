import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mnb_mobile/theme/colors.dart';

class MessageChatItemData {
  const MessageChatItemData({
    required this.name,
    required this.time,
    required this.message,
    required this.isUnread,
  });

  final String name;
  final String time;
  final String message;
  final bool isUnread;
}

class MessageChatRow extends StatelessWidget {
  const MessageChatRow({super.key, required this.data});

  final MessageChatItemData data;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Modular.to.pushNamed('./message-detail', arguments: data),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: data.isUnread ? ChakraColors.yellow50 : ChakraColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: data.isUnread
                ? ChakraColors.yellow200
                : ChakraColors.border,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                image: const DecorationImage(
                  image: AssetImage('assets/png/sitting-room.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          data.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontStyle: GoogleFonts.inter().fontStyle,
                            fontWeight: data.isUnread
                                ? FontWeight.w700
                                : FontWeight.w600,
                            color: ChakraColors.black,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        data.time,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontStyle: GoogleFonts.inter().fontStyle,
                          color: data.isUnread
                              ? ChakraColors.yellow700
                              : ChakraColors.gray500,
                          fontWeight: data.isUnread
                              ? FontWeight.w700
                              : FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    data.message,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontStyle: GoogleFonts.inter().fontStyle,
                      color: data.isUnread
                          ? ChakraColors.black
                          : ChakraColors.gray500,
                      fontWeight: data.isUnread
                          ? FontWeight.w600
                          : FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            if (data.isUnread) ...[
              const SizedBox(width: 12),
              Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: ChakraColors.yellow500,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
