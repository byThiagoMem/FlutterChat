import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ChatConversationTile extends StatelessWidget {
  const ChatConversationTile({
    super.key,
    required this.isMe,
    required this.name,
    required this.message,
    required this.hour,
    this.onLongPress,
  });

  final bool isMe;
  final String name;
  final String message;
  final DateTime hour;
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    var primaryColor = Theme.of(context).primaryColor;

    var backgroundColor = isMe ? primaryColor : Colors.grey[300];
    var nameColor = isMe ? Colors.white : primaryColor;
    var messageColor = isMe ? Colors.white : Colors.black87;
    var hourColor = isMe ? Colors.white : Colors.black;

    var format = DateFormat('dd MMM hh:MM', 'pt_BR');

    return InkWell(
      onLongPress: onLongPress,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: backgroundColor,
        ),
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isMe ? 'Você' : name,
                style: GoogleFonts.sourceSansPro(
                  fontSize: 14,
                  color: nameColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      message,
                      style: GoogleFonts.sourceSansPro(
                        color: messageColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    format.format(hour),
                    style: GoogleFonts.sourceSansPro(
                      color: hourColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
