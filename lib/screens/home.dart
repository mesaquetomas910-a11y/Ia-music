import 'package:flutter/material.dart';
import 'recorder.dart';
import 'beat_generator.dart';
import 'auto_tune.dart';
import 'mixer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Studio Pro'),
        elevation: 0,
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildFeatureCard(
            context,
            icon: Icons.mic,
            title: 'Gravar Música',
            description: 'Grave sua música com alta qualidade',
            color: Colors.blue,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RecorderScreen()),
              );
            },
          ),
          const SizedBox(height: 12),
          _buildFeatureCard(
            context,
            icon: Icons.music_note,
            title: 'Gerar Beat IA',
            description: 'Gere beats incríveis com IA',
            color: Colors.purple,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const BeatGeneratorScreen()),
              );
            },
          ),
          const SizedBox(height: 12),
          _buildFeatureCard(
            context,
            icon: Icons.tune,
            title: 'Auto-Tune',
            description: 'Afine sua voz automaticamente',
            color: Colors.orange,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AutoTuneScreen()),
              );
            },
          ),
          const SizedBox(height: 12),
          _buildFeatureCard(
            context,
            icon: Icons.apps,
            title: 'Mixer',
            description: 'Misture múltiplos áudios profissionalmente',
            color: Colors.green,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MixerScreen()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        leading: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 28),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text(description),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
