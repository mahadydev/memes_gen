import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:memes_app/app/features/meme_details/meme_details_screen.dart';
import 'package:provider/provider.dart';

import '../../providers/meme_provider.dart';

class MemeHomeScreen extends StatefulWidget {
  const MemeHomeScreen({super.key});

  @override
  State<MemeHomeScreen> createState() => _MemeHomeScreenState();
}

class _MemeHomeScreenState extends State<MemeHomeScreen> {
  @override
  void initState() {
    Provider.of<MemeProvider>(context, listen: false).fetchMemes();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Memes'),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56.0),
          child: TextField(
            decoration: const InputDecoration(
              hintText: 'Search Memes',
              prefixIcon: Icon(Icons.search),
            ),
            onChanged: (text) => provider.searchText = text,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: provider.filteredMemes.length,
        itemBuilder: (context, index) {
          final meme = provider.filteredMemes[index];
          return ListTile(
            leading: Hero(
              tag: meme.url,
              child: CachedNetworkImage(
                imageUrl: meme.url,
                height: 50,
                width: 50,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                placeholder: (context, url) => Image.asset('assets/meme.png'),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            title: Text(meme.name),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MemeDetailsScreen(meme: meme),
              ),
            ),
          );
        },
      ),
    );
  }
}
