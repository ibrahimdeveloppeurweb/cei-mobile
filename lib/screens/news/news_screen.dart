import 'package:cei_mobile/core/constants/assets_constants.dart';
import 'package:cei_mobile/core/theme/app_colors.dart';
import 'package:cei_mobile/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  // Sample news data
  final List<NewsItem> newsItems = [
    NewsItem(
      title: "Révision de la liste électorale prolongée",
      date: "15 avril 2025",
      description: "La révision de la liste électorale a été prolongée jusqu'au 30 juin 2025. Profitez de cette opportunité pour vous inscrire.",
      imageUrl: AssetConstants.news1,
      isImportant: true,
    ),
    NewsItem(
      title: "Ouverture de nouveaux centres d'enrôlement",
      date: "10 avril 2025",
      description: "10 nouveaux centres d'enrôlement ont été ouverts dans la région de Gagnoa pour faciliter l'inscription des électeurs.",
      imageUrl:  AssetConstants.news2,
      isImportant: false,
    ),
    NewsItem(
      title: "Formation des agents électoraux",
      date: "5 avril 2025",
      description: "Une session de formation des agents électoraux a débuté ce lundi dans toutes les régions du pays.",
      imageUrl:  AssetConstants.news1,
      isImportant: false,
    ),
    NewsItem(
      title: "Mise à jour de l'application",
      date: "1 avril 2025",
      description: "Une nouvelle version de l'application est disponible avec des fonctionnalités améliorées pour faciliter votre processus d'enrôlement.",
      imageUrl:  AssetConstants.news2,
      isImportant: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Actualités"),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none,
                color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Featured news banner
            _buildFeaturedNews(),

            // News categories
            _buildCategories(),

            // Latest news
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text("Dernières actualités", style: AppTextStyles.h4),
            ),

            // News list
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: newsItems.length,
              itemBuilder: (context, index) {
                return _buildNewsCard(newsItems[index]);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturedNews() {
    return Container(
      height: 200,
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.primary.withOpacity(0.1),
        image: const DecorationImage(
          image: AssetImage("assets/images/featured.jpg"),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black26,
            BlendMode.darken,
          ),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withOpacity(0.8),
                    Colors.transparent,
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.accent,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      "IMPORTANT",
                      style: AppTextStyles.caption.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Révision de la liste électorale prolongée jusqu'au 30 juin",
                    style: AppTextStyles.h4.copyWith(color: Colors.white),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "15 avril 2025",
                    style: AppTextStyles.caption.copyWith(color: Colors.white70),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategories() {
    final categories = ["Tout", "Élections", "Enrôlement", "CEI", "Formation"];

    return Container(
      height: 40,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) {
          final isSelected = index == 0;
          return Container(
            margin: const EdgeInsets.only(right: 8),
            child: Chip(
              backgroundColor: isSelected ? AppColors.primary : Colors.grey.shade200,
              label: Text(
                categories[index],
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black87,
                  fontSize: 12,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildNewsCard(NewsItem news) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 0.1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // News image
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            child: Image.asset(
              news.imageUrl,
              height: 140,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          // News content
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (news.isImportant)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      color: AppColors.accent,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      "IMPORTANT",
                      style: AppTextStyles.caption.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                Text(
                  news.title,
                  style: AppTextStyles.h4,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: 4),

                Text(
                  news.date,
                  style: AppTextStyles.caption,
                ),

                const SizedBox(height: 8),

                Text(
                  news.description,
                  style: AppTextStyles.body2,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: 12),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Lire plus",
                        style: TextStyle(color: AppColors.primary),
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.share, size: 20),
                          color: Colors.grey,
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: const Icon(Icons.bookmark_border, size: 20),
                          color: Colors.grey,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Model class
class NewsItem {
  final String title;
  final String date;
  final String description;
  final String imageUrl;
  final bool isImportant;

  NewsItem({
    required this.title,
    required this.date,
    required this.description,
    required this.imageUrl,
    required this.isImportant,
  });
}

