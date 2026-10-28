import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

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
        SnackBar(
            content: Text(
                'تم اختيار ${result.files.length} ملف — النقل الشبكي قيد التطوير')),
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
          content: Text('ميزة الاتصال والاستقبال ستُضاف في المرحلة التالية.')),
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
                    const SizedBox(height: 28),
                    _buildHero(),
                    const SizedBox(height: 20),
                    _buildActions(),
                    if (_pickedFiles.isNotEmpty) ...[
                      const SizedBox(height: 20),
                      _buildPickedFiles(),
                    ],
                    const SizedBox(height: 30),
                    _buildSectionHeader('نشاط النقل', 'عرض الكل'),
                    const SizedBox(height: 12),
                    _buildEmptyActivity(),
                    const SizedBox(height: 28),
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
            Text('AFNOVA',
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.2)),
            SizedBox(height: 2),
            Text('أرسلها بطريقتك',
                style: TextStyle(color: _muted, fontSize: 12)),
          ],
        ),
        const Spacer(),
        IconButton(
          onPressed: _showPrototypeMessage,
          tooltip: 'الإشعارات',
          icon: const Icon(Icons.notifications_none_rounded,
              color: Color(0xFFD5DAE6)),
        ),
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFF26344A),
            border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
          ),
          child: const Icon(Icons.person_outline_rounded,
              size: 20, color: Color(0xFFE5E9F4)),
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
                    Icon(Icons.wifi_tethering_rounded, size: 14, color: _mint),
                    SizedBox(width: 6),
                    Text('نقل مباشر، أينما كنت',
                        style: TextStyle(
                            color: _mint,
                            fontSize: 11,
                            fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              const Text(
                'ملفاتك.\nبلا حدود.',
                style: TextStyle(
                    fontSize: 32,
                    height: 1.12,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5),
              ),
              const SizedBox(height: 10),
              const Text(
                'أرسل الملفات الكبيرة مباشرةً\nمن جهازك إلى أجهزتهم.',
                style: TextStyle(
                    color: Color(0xFFB4BED0), fontSize: 14, height: 1.6),
              ),
              const SizedBox(height: 22),
              FilledButton.icon(
                onPressed: _pickFiles,
                icon: const Icon(Icons.arrow_upward_rounded, size: 18),
                label: const Text('اختر ملفات للإرسال'),
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
            subtitle: 'أدخل رمز المرسل',
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
              label: const Text('اختيار المستلم — قريبًا'),
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
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
        const Spacer(),
        TextButton(
            onPressed: _showPrototypeMessage,
            child: Text(action,
                style: const TextStyle(color: _violet, fontSize: 12))),
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
      child: Column(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
                color: const Color(0xFF202943),
                borderRadius: BorderRadius.circular(18)),
            child: const Icon(Icons.swap_horiz_rounded,
                color: Color(0xFFA5B2C8), size: 27),
          ),
          const SizedBox(height: 12),
          const Text('لا توجد عمليات نقل بعد',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
          const SizedBox(height: 5),
          const Text('ستظهر ملفاتك المُرسلة والمُستقبلة هنا',
              style: TextStyle(color: _muted, fontSize: 12)),
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
          Icon(Icons.lock_outline_rounded, color: _mint, size: 19),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'خصوصيتك أولًا',
              style: TextStyle(
                  fontWeight: FontWeight.w700, fontSize: 13, height: 1.5),
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            flex: 3,
            child: Text(
              'واجهة النموذج الأولي فقط؛ النقل المشفّر المباشر سيُنفّذ ضمن المرحلة التالية.',
              style: TextStyle(color: _muted, fontSize: 11, height: 1.6),
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
              const SizedBox(height: 16),
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
