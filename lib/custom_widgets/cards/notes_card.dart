import 'package:req_sys_finale/core/constants/color_constants.dart';
import 'package:req_sys_finale/features/notes/models/note.dart';
import 'package:flutter/material.dart';

class NotesCard extends StatelessWidget {
  final Note note;
  const NotesCard({
    super.key,
    required this.note,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey)),
      child: Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(note.title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14)),
              ],
            ),
            trailing: PopupMenuButton<int>(
              itemBuilder: (BuildContext context) => [
                buildPopUpOption(
                  title: 'Comment',
                  icon: Icons.comment,
                  onTap: () {},
                ),
                buildPopUpOption(
                  title: 'Edit Note',
                  icon: Icons.edit,
                  onTap: () {},
                ),
                buildPopUpOption(
                    title: 'Delete', icon: Icons.delete, onTap: () {}),
              ],
              icon: const Icon(Icons.more_vert),
            ),
          ),
          const Divider(
            color: Colors.grey,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              RichText(
                text: TextSpan(children: [
                  const TextSpan(
                      text: 'Date:  ',
                      style: TextStyle(fontSize: 12, color: Colors.black)),
                  TextSpan(
                      text: note.dateAdded.toString(),
                      style:
                          TextStyle(fontSize: 12, color: Pallete.primaryColor)),
                ]),
              ),
              const SizedBox(height: 4),
              Text(note.content,
                  style: const TextStyle(color: Colors.white, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }

  dynamic buildPopUpOption({
    required String title,
    required IconData icon,
    required void Function() onTap,
  }) {
    return PopupMenuItem<int>(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, color: Colors.black54),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
