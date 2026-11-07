import 'package:flutter/material.dart';

class GuideScreen extends StatefulWidget {
  const GuideScreen({super.key});

  @override
  State<GuideScreen> createState() => _GuideScreenState();
}

class _GuideScreenState extends State<GuideScreen> {
  static const _pages = [
    _GuidePage(
      asset: 'assets/guide/afnova-guide-1.jpg',
      title: 'فكرة AFNOVA',
      subtitle: 'نقل الملفات والمجلدات بين أجهزة Android عبر الإنترنت.',
    ),
    _GuidePage(
      asset: 'assets/guide/afnova-guide-2.jpg',
      title: 'كيف يعمل النقل؟',
      subtitle: 'اختيار الملفات، طلب النقل، موافقة المستلم، ثم الإرسال.',
    ),
    _GuidePage(
      asset: 'assets/guide/afnova-guide-3.jpg',
      title: 'نقل ذكي وجماعي',
      subtitle: 'استكمال النقل والمجلدات والإرسال لعدة أشخاص ضمن الخطة.',
    ),
    _GuidePage(
      asset: 'assets/guide/afnova-guide-4.jpg',
      title: 'خارطة الطريق',
      subtitle: 'المراحل والاختبارات والتقنيات المستهدفة للمشروع.',
    ),
  ];

  late final PageController _controller;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _goTo(int page) {
    if (page < 0 || page >= _pages.length) return;
    _controller.animateToPage(
      page,
      duration: const Duration(milliseconds: 260),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final page = _pages[_currentPage];

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFF080D19),
        appBar: AppBar(
          title: const Text('دليل AFNOVA المصوّر'),
          backgroundColor: const Color(0xFF080D19),
          surfaceTintColor: Colors.transparent,
        ),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 14),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            page.title,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            page.subtitle,
                            style: const TextStyle(
                              color: Color(0xFF9BA8BE),
                              fontSize: 12,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 11,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF8C72FF).withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${_currentPage + 1} / ${_pages.length}',
                        style: const TextStyle(
                          color: Color(0xFFD8D0FF),
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: _pages.length,
                  onPageChanged: (index) =>
                      setState(() => _currentPage = index),
                  itemBuilder: (context, index) {
                    final item = _pages[index];
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8F5EB),
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.2),
                              blurRadius: 18,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: LayoutBuilder(
                            builder: (context, constraints) =>
                                InteractiveViewer(
                              minScale: 1,
                              maxScale: 4,
                              boundaryMargin: const EdgeInsets.all(24),
                              child: Image.asset(
                                item.asset,
                                width: constraints.maxWidth,
                                height: constraints.maxHeight,
                                fit: BoxFit.contain,
                                semanticLabel: item.title,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Center(
                                  child: Text('تعذّر تحميل صفحة الدليل'),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 4, 20, 16),
                child: Row(
                  children: [
                    OutlinedButton.icon(
                      onPressed: _currentPage == 0
                          ? null
                          : () => _goTo(_currentPage - 1),
                      icon: const Icon(Icons.arrow_forward_rounded, size: 18),
                      label: const Text('السابق'),
                    ),
                    const Spacer(),
                    Row(
                      children: List.generate(
                        _pages.length,
                        (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 180),
                          margin: const EdgeInsets.symmetric(horizontal: 3),
                          width: index == _currentPage ? 18 : 7,
                          height: 7,
                          decoration: BoxDecoration(
                            color: index == _currentPage
                                ? const Color(0xFF8C72FF)
                                : const Color(0xFF39445A),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    OutlinedButton.icon(
                      onPressed: _currentPage == _pages.length - 1
                          ? null
                          : () => _goTo(_currentPage + 1),
                      icon: const Icon(Icons.arrow_back_rounded, size: 18),
                      label: const Text('التالي'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GuidePage {
  const _GuidePage({
    required this.asset,
    required this.title,
    required this.subtitle,
  });

  final String asset;
  final String title;
  final String subtitle;
}
