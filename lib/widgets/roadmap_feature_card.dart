import 'package:flutter/material.dart';

import '../models/roadmap_feature.dart';

class RoadmapFeatureCard extends StatelessWidget {
  const RoadmapFeatureCard({required this.data, super.key});

  final RoadmapFeature data;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 158,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF111A2B),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFF202B40)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(data.icon, color: const Color(0xFF8C72FF), size: 22),
          const SizedBox(height: 12),
          Text(data.title,
              style:
                  const TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
          const SizedBox(height: 5),
          Expanded(
            child: Text(data.description,
                style: const TextStyle(
                    color: Color(0xFF94A0B8), fontSize: 10, height: 1.5)),
          ),
          const Text('ضمن الخطة',
              style: TextStyle(
                  color: Color(0xFFFFD493),
                  fontSize: 9,
                  fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
