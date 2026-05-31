import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mnb_mobile/app/modules/primary/presentation/widgets/message_content_widgets.dart';
import 'package:mnb_mobile/theme/colors.dart';

// TODO(api): Tidak ada endpoint messaging/conversation di backend (lihat
// api.md). Halaman chat masih memakai data dummy sampai API tersedia.
class MessageDetailPage extends StatelessWidget {
  const MessageDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final data = Modular.args.data as MessageChatItemData?;
    final chat =
        data ??
        const MessageChatItemData(
          name: 'Studio Karsa',
          time: '09:41',
          message: 'Halo, revisi layout ruang tamu sudah kami kirim ya.',
          isUnread: false,
        );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          chat.name,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
            fontStyle: GoogleFonts.inter().fontStyle,
            fontWeight: FontWeight.w700,
            color: ChakraColors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: ChakraColors.gray100,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      chat.message,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontStyle: GoogleFonts.inter().fontStyle,
                        color: ChakraColors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  chat.time,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontStyle: GoogleFonts.inter().fontStyle,
                    color: ChakraColors.gray500,
                  ),
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: ChakraColors.black,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      'Baik, saya cek dulu dan akan kasih feedback hari ini.',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontStyle: GoogleFonts.inter().fontStyle,
                        color: ChakraColors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SafeArea(
            top: false,
            minimum: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Type a message',
                      hintStyle: Theme.of(context).textTheme.bodyMedium!
                          .copyWith(
                            fontStyle: GoogleFonts.inter().fontStyle,
                            color: ChakraColors.gray400,
                          ),
                      filled: true,
                      fillColor: ChakraColors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide(color: ChakraColors.gray200),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide(color: ChakraColors.gray200),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: ChakraColors.black,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(Icons.send, color: ChakraColors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
