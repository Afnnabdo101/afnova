import 'package:flutter/material.dart';

class ProjectIllustrationGallery extends StatelessWidget {
  const ProjectIllustrationGallery({super.key});

  static const _illustrations = [
    _Illustration(
      asset: 'assets/illustrations/transfer-capabilities.jpg',
      keyName: 'capabilities-illustration',
      title: 'المجلدات والإرسال الجماعي',
      description: 'تصور لميزات ضمن خارطة التطوير.',
    ),
    _Illustration(
      asset: 'assets/illustrations/privacy-concept.jpg',
      keyName: 'privacy-illustration',
      title: 'الخصوصية هدف تصميم',
      description: 'رسم مفاهيمي، وليس ضمانًا أمنيًا منفذًا.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('صور فكرة المشروع',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
        const SizedBox(height: 5),
        const Text('رسوم توضيحية للمفهوم، وليست لقطات شاشة للميزات.',
            style: TextStyle(color: Color(0xFF94A0B8), fontSize: 11)),
        const SizedBox(height: 12),
        SizedBox(
          height: 190,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: _illustrations.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final illustration = _illustrations[index];
              return TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: 1),
                duration: Duration(milliseconds: 420 + index * 120),
                curve: Curves.easeOutCubic,
                builder: (context, value, child) => Opacity(
                  opacity: value,
                  child: Transform.translate(
                    offset: Offset(0, 10 * (1 - value)),
                    child: child,
                  ),
                ),
                child: _IllustrationCard(data: illustration),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _IllustrationCard extends StatelessWidget {
  const _IllustrationCard({required this.data});

  final _Illustration data;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 274,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: const Color(0xFF111A2B),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFF202B40)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image.asset(
              data.asset,
              key: ValueKey(data.keyName),
              width: double.infinity,
              fit: BoxFit.cover,
              semanticLabel: data.title,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data.title,
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w700)),
                const SizedBox(height: 3),
                Text(data.description,
                    style: const TextStyle(
                        color: Color(0xFF94A0B8), fontSize: 10)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Illustration {
  const _Illustration({
    required this.asset,
    required this.keyName,
    required this.title,
    required this.description,
  });

  final String asset;
  final String keyName;
  final String title;
  final String description;
}
