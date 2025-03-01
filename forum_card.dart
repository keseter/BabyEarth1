import 'package:flutter/material.dart';

class ForumCard extends StatelessWidget {
  final String title;
  final String subject;
  final VoidCallback onDelete; // Function to delete post

  // Accepts title and subject as parameters passed from the SocialPage
  const ForumCard({
    super.key,
    required this.title,
    required this.subject,
    required this.onDelete, // Accept delete function
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 380,
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title and Delete Button Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: onDelete, // Call delete function
              ),
            ],
          ),

          // Line Separator
          SizedBox(height: 8),
          Container(height: 1, width: double.infinity, color: Colors.grey[300]),
          SizedBox(height: 8),

          // Subject Section
          Text(
            subject,
            style: TextStyle(fontSize: 14, color: Colors.grey[700]),
          ),

          // Line Separator
          SizedBox(height: 8),
          Container(height: 1, width: double.infinity, color: Colors.grey[300]),

          SizedBox(height: 8),

          // Actions Row (Like, Comment, Share)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Icon(Icons.thumb_up_alt_outlined, color: Colors.grey[600]),
                  SizedBox(width: 5),
                  Text("Like", style: TextStyle(color: Colors.grey[600])),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.comment_outlined, color: Colors.grey[600]),
                  SizedBox(width: 5),
                  Text("Comment", style: TextStyle(color: Colors.grey[600])),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.share_outlined, color: Colors.grey[600]),
                  SizedBox(width: 5),
                  Text("Share", style: TextStyle(color: Colors.grey[600])),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
