import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mnb_mobile/app/modules/primary/presentation/widgets/message_content_widgets.dart';
import 'package:mnb_mobile/app/widgets/base_body_page.dart';
import 'package:mnb_mobile/theme/colors.dart';

// TODO(api): Tidak ada endpoint messaging/conversation di backend (lihat
// api.md). Daftar chat masih memakai data dummy sampai API tersedia.
class MessageContent extends StatelessWidget {
  const MessageContent({super.key});

  static const _messages = [
    MessageChatItemData(
      name: 'Studio Karsa',
      time: '09:41',
      message: 'Halo, revisi layout ruang tamu sudah kami kirim ya.',
      isUnread: true,
    ),
    MessageChatItemData(
      name: 'Nirmana House',
      time: 'Kemarin',
      message: 'Baik, kami jadwalkan meeting lanjutan untuk bahas material.',
      isUnread: false,
    ),
    MessageChatItemData(
      name: 'Atelier Ruang',
      time: 'Senin',
      message: 'Mohon cek invoice terbaru untuk tahap pengembangan desain.',
      isUnread: true,
    ),
    MessageChatItemData(
      name: 'Arsitag Studio',
      time: 'Senin',
      message: 'Terima kasih, file final sudah kami unggah ke proyek Anda.',
      isUnread: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BaseBodyPage(
      children: [
        SliverToBoxAdapter(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Search Designer',
                      hintStyle: Theme.of(context).textTheme.bodyMedium!
                          .copyWith(
                            fontStyle: GoogleFonts.inter().fontStyle,
                            color: ChakraColors.gray400,
                          ),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: ChakraColors.gray500,
                      ),
                      filled: true,
                      fillColor: ChakraColors.white,
                      contentPadding: const EdgeInsets.symmetric(vertical: 14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: ChakraColors.gray200),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: ChakraColors.gray200),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: ChakraColors.black),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ListView.separated(
                    itemCount: _messages.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) =>
                        MessageChatRow(data: _messages[index]),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 12),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
