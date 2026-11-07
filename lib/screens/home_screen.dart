import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'guide_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<PlatformFile> _pickedFiles = const [];

  static const _muted = Color(0xFF94A0B8);
  static const _panel = Color(0xFF111A2B);
  static const _line = Color(0xFF202B40);
  static const _violet = Color(0xFF8C72FF);
  static const _mint = Color(0xFF41D9C2);

  Future<void> _pickFiles() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        withData: false,
      );
      if (!mounted || result == null) return;
      setState(() => _pickedFiles = result.files);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('تم اختيار ${result.files.length} ملف محليًا')),
      );
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تعذّر فتح الملفات. حاول مرة أخرى.')),
      );
    }
  }

  void _showPrototypeMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('الاتصال والنقل بين الأجهزة ما زالا ضمن التطوير.'),
      ),
    );
  }

  void _openGuide() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => const GuideScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 14, 20, 32),
                sliver: SliverList.list(
                  children: [
                    _buildHeader(),
                    const SizedBox(height: 24),
                    _buildHero(),
                    const SizedBox(height: 18),
                    _buildActions(),
                    if (_pickedFiles.isNotEmpty) ...[
                      const SizedBox(height: 18),
                      _buildPickedFiles(),
                    ],
                    const SizedBox(height: 28),
                    _buildWorkflow(),
                    const SizedBox(height: 26),
                    _buildFeatureHighlights(),
                    const SizedBox(height: 26),
                    _buildGuideCard(),
                    const SizedBox(height: 28),
                    _buildSectionHeader('نشاط النقل', 'عرض الكل'),
                    const SizedBox(height: 10),
                    _buildEmptyActivity(),
                    const SizedBox(height: 20),
                    _buildConnectionNote(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: _violet.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: _violet.withValues(alpha: 0.3)),
          ),
          child: const Icon(Icons.bolt_rounded, color: _violet, size: 28),
        ),
        const SizedBox(width: 12),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'AFNOVA',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.2,
              ),
            ),
            SizedBox(height: 2),
            Text('أرسلها بسرعة. ببساطة.',
                style: TextStyle(color: _muted, fontSize: 12)),
          ],
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
          decoration: BoxDecoration(
            color: const Color(0xFFFFC36B).withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
                color: const Color(0xFFFFC36B).withValues(alpha: 0.22)),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.construction_rounded,
                  size: 13, color: Color(0xFFFFC36B)),
              SizedBox(width: 5),
              Text('نموذج أولي',
                  style: TextStyle(
                      color: Color(0xFFFFD493),
                      fontSize: 10,
                      fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHero() {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        gradient: const LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [Color(0xFF252052), Color(0xFF151A36), Color(0xFF101829)],
        ),
        border: Border.all(color: _violet.withValues(alpha: 0.25)),
      ),
      child: Stack(
        children: [
          Positioned(
            left: -8,
            top: 2,
            child: Icon(Icons.bolt_rounded,
                size: 92, color: Colors.white.withValues(alpha: 0.045)),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: _mint.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.swap_horiz_rounded, size: 14, color: _mint),
                    SizedBox(width: 6),
                    Text('Android ↔ Android',
                        style: TextStyle(
                            color: _mint,
                            fontSize: 11,
                            fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              const Text(
                'ملفاتك.\nمن جهاز لجهاز.',
                style: TextStyle(
                    fontSize: 30,
                    height: 1.12,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5),
              ),
              const SizedBox(height: 10),
              const Text(
                'اختر ما تريد مشاركته وتعرّف على تجربة النقل التي نبنيها.',
                style: TextStyle(
                    color: Color(0xFFB4BED0), fontSize: 13, height: 1.65),
              ),
              const SizedBox(height: 20),
              FilledButton.icon(
                onPressed: _pickFiles,
                icon: const Icon(Icons.add_to_drive_rounded, size: 18),
                label: const Text('اختر ملفات'),
                style: FilledButton.styleFrom(
                  backgroundColor: _violet,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 14),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActions() {
    return Row(
      children: [
        Expanded(
          child: _ActionCard(
            icon: Icons.call_received_rounded,
            color: _mint,
            title: 'استقبال ملفات',
            subtitle: 'قيد التطوير',
            onTap: _showPrototypeMessage,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _ActionCard(
            icon: Icons.qr_code_2_rounded,
            color: const Color(0xFFFFC36B),
            title: 'رمز جهازي',
            subtitle: 'قريبًا',
            onTap: _showPrototypeMessage,
          ),
        ),
      ],
    );
  }

  Widget _buildWorkflow() {
    const steps = [
      (Icons.folder_open_rounded, 'اختر', 'ملفاتك'),
      (Icons.send_rounded, 'أرسل', 'طلب النقل'),
      (Icons.verified_user_outlined, 'اقبل', 'على الجهاز الآخر'),
      (Icons.bolt_rounded, 'انقل', 'مباشرةً'),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('من الاختيار إلى الوصول', 'المسار المخطط'),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          decoration: BoxDecoration(
            color: _panel,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: _line),
          ),
          child: Row(
            children: [
              for (var index = 0; index < steps.length; index++) ...[
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          color: (index == 0 ? _violet : _mint)
                              .withValues(alpha: 0.12),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(steps[index].$1,
                            size: 19, color: index == 0 ? _violet : _mint),
                      ),
                      const SizedBox(height: 8),
                      Text(steps[index].$2,
                          style: const TextStyle(
                              fontSize: 11, fontWeight: FontWeight.w700)),
                      const SizedBox(height: 3),
                      Text(steps[index].$3,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: _muted, fontSize: 9)),
                    ],
                  ),
                ),
                if (index < steps.length - 1)
                  const Icon(Icons.chevron_left_rounded,
                      color: Color(0xFF47536B), size: 17),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureHighlights() {
    const features = [
      _FeatureData(Icons.restart_alt_rounded, 'استكمال ذكي',
          'يكمل من موضع التوقف بعد الانقطاع.'),
      _FeatureData(Icons.account_tree_outlined, 'مجلدات كاملة',
          'يحافظ على ترتيب الملفات وبنيتها.'),
      _FeatureData(Icons.groups_2_outlined, 'إرسال جماعي',
          'متابعة حالة كل مستلم بشكل مستقل.'),
      _FeatureData(Icons.speed_rounded, 'متابعة النقل',
          'سرعة النقل والتقدم والحجم المتبقي.'),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('ميزات في خارطة الطريق',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
        const SizedBox(height: 5),
        const Text('هذه القدرات مخططة ولم تُفعّل في النموذج الأولي بعد.',
            style: TextStyle(color: _muted, fontSize: 11)),
        const SizedBox(height: 12),
        SizedBox(
          height: 146,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: features.length,
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemBuilder: (context, index) =>
                _FeatureCard(data: features[index]),
          ),
        ),
      ],
    );
  }

  Widget _buildGuideCard() {
    return Material(
      color: _panel,
      borderRadius: BorderRadius.circular(22),
      child: InkWell(
        onTap: _openGuide,
        borderRadius: BorderRadius.circular(22),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: _violet.withValues(alpha: 0.25)),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(13),
                child: Container(
                  width: 86,
                  height: 112,
                  color: const Color(0xFFF8F5EB),
                  padding: const EdgeInsets.all(3),
                  child: Image.asset(
                    'assets/guide/afnova-guide-1.jpg',
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) =>
                        const Icon(Icons.menu_book_rounded, color: _violet),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('دليل AFNOVA المصوّر',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w700)),
                    SizedBox(height: 6),
                    Text(
                        'الفكرة، خطوات النقل، المزايا، وخارطة التطوير في أربع صفحات.',
                        style: TextStyle(
                            color: _muted, fontSize: 11, height: 1.55)),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text('افتح الدليل',
                            style: TextStyle(
                                color: Color(0xFFD8D0FF),
                                fontWeight: FontWeight.w700,
                                fontSize: 12)),
                        SizedBox(width: 5),
                        Icon(Icons.arrow_back_rounded,
                            color: _violet, size: 16),
                      ],
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

  Widget _buildPickedFiles() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: _panel,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: _line)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.attach_file_rounded, size: 18, color: _violet),
              const SizedBox(width: 8),
              Text('الملفات المختارة (${_pickedFiles.length})',
                  style: const TextStyle(fontWeight: FontWeight.w700)),
              const Spacer(),
              TextButton(onPressed: _pickFiles, child: const Text('تعديل')),
            ],
          ),
          const Divider(color: _line, height: 16),
          ..._pickedFiles.take(4).map((file) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 7),
                child: Row(
                  children: [
                    const Icon(Icons.insert_drive_file_outlined,
                        size: 18, color: _muted),
                    const SizedBox(width: 10),
                    Expanded(
                        child: Text(file.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 13))),
                    Text(_formatBytes(file.size),
                        style: const TextStyle(color: _muted, fontSize: 11)),
                  ],
                ),
              )),
          if (_pickedFiles.length > 4)
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text('و ${_pickedFiles.length - 4} ملفات أخرى',
                  style: const TextStyle(color: _muted, fontSize: 12)),
            ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: _showPrototypeMessage,
              icon: const Icon(Icons.send_rounded, size: 17),
              label: const Text('إرسال — غير مفعّل بعد'),
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFFD5CEFF),
                side: BorderSide(color: _violet.withValues(alpha: 0.55)),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13)),
                padding: const EdgeInsets.symmetric(vertical: 13),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, String action) {
    return Row(
      children: [
        Text(title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
        const Spacer(),
        Text(action, style: const TextStyle(color: _violet, fontSize: 11)),
      ],
    );
  }

  Widget _buildEmptyActivity() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: BoxDecoration(
          color: _panel,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: _line)),
      child: const Column(
        children: [
          Icon(Icons.swap_horiz_rounded, color: Color(0xFFA5B2C8), size: 28),
          SizedBox(height: 10),
          Text('لا توجد عمليات نقل بعد',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
          SizedBox(height: 5),
          Text('ستظهر عمليات الإرسال والاستقبال هنا عند اكتمال ميزة النقل.',
              textAlign: TextAlign.center,
              style: TextStyle(color: _muted, fontSize: 11, height: 1.5)),
        ],
      ),
    );
  }

  Widget _buildConnectionNote() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFF101F29),
        borderRadius: BorderRadius.circular(17),
        border: Border.all(color: _mint.withValues(alpha: 0.16)),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline_rounded, color: _mint, size: 19),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'تنبيه النموذج الأولي',
              style: TextStyle(
                  fontWeight: FontWeight.w700, fontSize: 12, height: 1.5),
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            flex: 3,
            child: Text(
              'اختيار الملفات والدليل المصوّر يعملان محليًا. الاتصال، القبول/الرفض، والتشفير والنقل الفعلي قيد التنفيذ.',
              style: TextStyle(color: _muted, fontSize: 10, height: 1.6),
            ),
          ),
        ],
      ),
    );
  }

  String _formatBytes(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(0)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }
}

class _ActionCard extends StatelessWidget {
  const _ActionCard(
      {required this.icon,
      required this.color,
      required this.title,
      required this.subtitle,
      required this.onTap});

  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFF111A2B),
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFF202B40))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: color, size: 23),
              const SizedBox(height: 15),
              Text(title,
                  style: const TextStyle(
                      fontSize: 13, fontWeight: FontWeight.w700)),
              const SizedBox(height: 4),
              Text(subtitle,
                  style:
                      const TextStyle(color: Color(0xFF94A0B8), fontSize: 11)),
            ],
          ),
        ),
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  const _FeatureCard({required this.data});

  final _FeatureData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 158,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _HomeScreenState._panel,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _HomeScreenState._line),
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
                      color: Color(0xFF94A0B8), fontSize: 10, height: 1.5))),
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

class _FeatureData {
  const _FeatureData(this.icon, this.title, this.description);

  final IconData icon;
  final String title;
  final String description;
}
