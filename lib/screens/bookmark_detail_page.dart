import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/hadith_models.dart';
import '../utils/apps_colors.dart';

class BookmarkDetailPage extends StatefulWidget {
  final BookmarkEntry entry;

  const BookmarkDetailPage({
    super.key,
    required this.entry,
  });

  @override
  State<BookmarkDetailPage> createState() => _BookmarkDetailPageState();
}

class _BookmarkDetailPageState extends State<BookmarkDetailPage> {
  late bool _isBookmarked;

  @override
  void initState() {
    super.initState();
    _isBookmarked = true; // by definition this page is opened from a bookmark
  }

  @override
  Widget build(BuildContext context) {
    final s = widget.entry.summary;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close),
          color: AppColors.textPrimary,
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.bookmark,
              color: _isBookmarked ? AppColors.info : AppColors.textLight,
            ),
            onPressed: _toggleBookmark,
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${s.bookName} : ${s.hadithNumber}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Chapter #${s.chapterNumber}',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                s.grade,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.getHadithColor(s.grade),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Bookmarked on ${DateFormat('d MMMM, h:mm a').format(widget.entry.createdAt)}',
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.textLight,
                ),
              ),
              const SizedBox(height: 20),
              // The full hadith texts will usually be loaded from backend
              // using widget.entry.hadithId. For now this is a placeholder.
              Text(
                'Full hadith details will be loaded using hadith_id ${widget.entry.hadithId}.',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _toggleBookmark() async {
    setState(() {
      _isBookmarked = !_isBookmarked;
    });
    // TODO: call backend to delete this bookmark using widget.entry.bookmarkId
  }
}


