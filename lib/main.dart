// سما الإتقان للتقدير - Flutter (Web / Android / iOS)
// pubspec.yaml dependencies:
//   google_fonts: ^6.2.1
//   url_launcher: ^6.3.0
// For Android add to AndroidManifest.xml <queries>: tel, https, whatsapp (see url_launcher docs).

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

// ======================= الإعدادات (عدّل هنا فقط) =======================
class Cfg {
  static const phone = '0530665606';
  static const whatsapp = '966530665606';
  static const address = 'حي السعادة، 4347 طريق الملك عبد الله، الخرج 16443';
  static const hours = 'السبت إلى الخميس، من 8 صباحاً حتى 5 مساءً';
  static const mapUrl = 'https://maps.app.goo.gl/1JBFjUeKW5nsXAWh9';
  static const waMessage =
      'السلام عليكم، أرغب بالاستفسار عن تقدير أضرار المركبات';
  // حسابات التواصل: أضف مثل ('إنستجرام', 'https://instagram.com/...')
  static const social = <(String, String)>[];
}

class C {
  static const navy = Color(0xFF1F2A8A);
  static const navyD = Color(0xFF141C5E);
  static const ink = Color(0xFF161A3A);
  static const muted = Color(0xFF5A6085);
  static const soft = Color(0xFFEEF1FB);
  static const line = Color(0xFFD9DEEF);
  static const btn = Color(0xFF2F45D0);
  static const accent = Color(0xFFE4572E);
  static const wa = Color(0xFF1FAA59);
  static const onDark = Color(0xFFC9CEF0);
}

Future<void> openUrl(Uri uri) async {
  await launchUrl(uri, mode: LaunchMode.externalApplication);
}

Uri get waUri => Uri.parse(
  'https://api.whatsapp.com/send/?phone=${Cfg.whatsapp}&text=${Uri.encodeComponent(Cfg.waMessage)}&type=phone_number&app_absent=0',
);
Uri get telUri => Uri(scheme: 'tel', path: '+${Cfg.whatsapp}');

void main() => runApp(const SamaApp());

class SamaApp extends StatelessWidget {
  const SamaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'سما الإتقان للتقدير',
      debugShowCheckedModeBanner: false,
      locale: const Locale('ar'),
      builder: (context, child) =>
          Directionality(textDirection: TextDirection.rtl, child: child!),
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: C.navy),
        textTheme: GoogleFonts.ibmPlexSansArabicTextTheme(),
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const HomePage(),
    );
  }
}

// ============================== الشعار ==============================
class LogoPainter extends CustomPainter {
  final Color color;
  const LogoPainter(this.color);

  static const _a = [
    Offset(0, 226),
    Offset(226, 0),
    Offset(453, 226),
    Offset(396, 283),
    Offset(226, 113),
    Offset(113, 226),
    Offset(283, 396),
    Offset(226, 453),
  ];
  static const _b = [
    Offset(0, 396),
    Offset(226, 622),
    Offset(453, 396),
    Offset(226, 170),
    Offset(170, 226),
    Offset(339, 396),
    Offset(226, 509),
    Offset(57, 339),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 453;
    final paint = Paint()..color = color;
    for (final pts in [_a, _b]) {
      final path = Path()..moveTo(pts.first.dx * s, pts.first.dy * s);
      for (final p in pts.skip(1)) {
        path.lineTo(p.dx * s, p.dy * s);
      }
      path.close();
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant LogoPainter old) => old.color != color;
}

class Logo extends StatelessWidget {
  final double height;
  final Color color;
  const Logo({super.key, required this.height, required this.color});

  @override
  Widget build(BuildContext context) => SizedBox(
    width: height * 453 / 622,
    height: height,
    child: CustomPaint(painter: LogoPainter(color)),
  );
}

// ============================== الصفحة ==============================
class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _why = GlobalKey();
  final _how = GlobalKey();
  final _services = GlobalKey();
  final _faq = GlobalKey();
  final _contact = GlobalKey();

  void _go(GlobalKey k) {
    final ctx = k.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 450),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.of(context).size.width >= 760;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: C.wa,
        foregroundColor: Colors.white,
        onPressed: () => openUrl(waUri),
        icon: const Icon(Icons.chat),
        label: const Text(
          'واتساب',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            _Header(
              wide: wide,
              onNav: {
                'لماذا سما الإتقان': () => _go(_why),
                'كيف نعمل': () => _go(_how),
                'خدماتنا': () => _go(_services),
                'أسئلة شائعة': () => _go(_faq),
                'تواصل معنا': () => _go(_contact),
              },
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _Hero(wide: wide, onContact: () => _go(_contact)),
                    _Section(
                      key: _why,
                      title: 'لماذا سما الإتقان؟',
                      subtitle: 'نعمل بوضوح من أول زيارة حتى استلام التقرير.',
                      child: const _Grid(
                        items: [
                          _Item(
                            'تقدير دقيق',
                            'فحص شامل للمركبة وتحديد الأضرار بدقة.',
                          ),
                          _Item(
                            'سرعة في الإنجاز',
                            'مساحة فحص واسعة تستوعب عدداً كبيراً من المركبات.',
                          ),
                          _Item(
                            'تقارير واضحة',
                            'تقرير مفصل يسهّل عليك الإصلاح والمطالبة.',
                          ),
                          _Item('تعامل محترف', 'فريق متخصص يشرح لك كل خطوة.'),
                        ],
                      ),
                    ),
                    _Section(
                      key: _how,
                      soft: true,
                      title: 'كيف نعمل',
                      subtitle: 'أربع خطوات بسيطة.',
                      child: const _Steps(),
                    ),
                    _Section(
                      key: _services,
                      title: 'خدماتنا',
                      subtitle: 'كل ما تحتاجه لتقدير أضرار مركبتك.',
                      child: const _Grid(
                        items: [
                          _Item(
                            'تقدير أضرار المركبات',
                            'تقدير الأضرار الناتجة عن الحوادث.',
                          ),
                          _Item(
                            'الفحص والمعاينة',
                            'معاينة ميدانية وتوثيق كامل للحالة.',
                          ),
                          _Item(
                            'تقارير التقدير',
                            'تقارير مفصلة بتكلفة الإصلاح.',
                          ),
                          _Item(
                            'خدمات التقدير لشركات التأمين',
                            'تعاون مع شركات التأمين والعملاء.',
                          ),
                        ],
                      ),
                    ),
                    _Section(
                      key: _faq,
                      soft: true,
                      title: 'أسئلة شائعة',
                      subtitle: 'أجوبة سريعة قبل زيارتك.',
                      child: const _Faq(),
                    ),
                    _Section(
                      key: _contact,
                      title: 'تواصل معنا',
                      subtitle: 'نسعد بخدمتك.',
                      child: _Contact(wide: wide),
                    ),
                    const _Footer(),
                    const SizedBox(height: 70),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================== أدوات مشتركة ==============================
class _Wrap extends StatelessWidget {
  final Widget child;
  const _Wrap({required this.child});
  @override
  Widget build(BuildContext context) => Center(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 1080),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: child,
      ),
    ),
  );
}

class _Btn extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool outlined;
  final bool onDark;
  const _Btn(
    this.label,
    this.onTap, {
    this.outlined = false,
    this.onDark = false,
  });

  @override
  Widget build(BuildContext context) {
    final fg = outlined ? (onDark ? Colors.white : C.btn) : Colors.white;
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        backgroundColor: outlined ? Colors.transparent : C.btn,
        foregroundColor: fg,
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
          side: outlined
              ? BorderSide(color: onDark ? Colors.white60 : C.btn, width: 2)
              : (onDark
                    ? const BorderSide(color: Colors.white38, width: 2)
                    : BorderSide.none),
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String title, subtitle;
  final Widget child;
  final bool soft;
  const _Section({
    super.key,
    required this.title,
    required this.subtitle,
    required this.child,
    this.soft = false,
  });

  @override
  Widget build(BuildContext context) {
    final narrow = MediaQuery.of(context).size.width < 760;
    return Container(
      width: double.infinity,
      color: soft ? C.soft : Colors.white,
      padding: EdgeInsets.symmetric(vertical: narrow ? 44 : 64),
      child: _Wrap(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: C.navy,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              subtitle,
              style: const TextStyle(color: C.muted, fontSize: 16),
            ),
            const SizedBox(height: 28),
            child,
          ],
        ),
      ),
    );
  }
}

// ============================== الهيدر ==============================
class _Header extends StatelessWidget {
  final bool wide;
  final Map<String, VoidCallback> onNav;
  const _Header({required this.wide, required this.onNav});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: C.line)),
      ),
      child: _Wrap(
        child: SizedBox(
          height: 64,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Logo(height: 38, color: C.navy),
                  SizedBox(width: 10),
                  Text(
                    'سما الإتقان للتقدير',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: C.navy,
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
              if (wide)
                Row(
                  children: [
                    for (final e in onNav.entries)
                      Padding(
                        padding: const EdgeInsetsDirectional.only(end: 22),
                        child: InkWell(
                          onTap: e.value,
                          child: Text(
                            e.key,
                            style: const TextStyle(
                              color: C.muted,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              _Btn('واتساب', () => openUrl(waUri)),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================== الهيرو ==============================
class _Hero extends StatelessWidget {
  final bool wide;
  final VoidCallback onContact;
  const _Hero({required this.wide, required this.onContact});

  @override
  Widget build(BuildContext context) {
    final text = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'تقدير أضرار المركبات بدقة وسرعة',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            height: 1.35,
            fontSize: wide ? 46 : 30,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'نفحص مركبتك، ونحدد الأضرار، ونسلمك تقريراً واضحاً تعتمد عليه في الإصلاح والمطالبات.',
          style: TextStyle(color: C.onDark, fontSize: 17, height: 1.8),
        ),
        const SizedBox(height: 28),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            _Btn('تواصل عبر واتساب', () => openUrl(waUri), onDark: true),
            _Btn(
              'موقعنا وأوقات الدوام',
              onContact,
              outlined: true,
              onDark: true,
            ),
          ],
        ),
      ],
    );

    final plate = Container(
      padding: const EdgeInsets.symmetric(vertical: 34, horizontal: 26),
      decoration: BoxDecoration(
        color: C.navy,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white24, width: 2),
      ),
      child: const Column(
        children: [
          Logo(height: 100, color: Colors.white),
          SizedBox(height: 12),
          Text(
            'شركة سما الإتقان للتقدير',
            style: TextStyle(
              color: Colors.white,
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Sama Al Itqan Valuing Company',
            textDirection: TextDirection.ltr,
            style: TextStyle(color: C.onDark, fontSize: 15),
          ),
        ],
      ),
    );

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: C.navyD,
        border: Border(bottom: BorderSide(color: C.accent, width: 10)),
      ),
      padding: EdgeInsets.fromLTRB(0, wide ? 72 : 44, 0, wide ? 84 : 56),
      child: _Wrap(
        child: wide
            ? Row(
                children: [
                  Expanded(flex: 5, child: text),
                  const SizedBox(width: 40),
                  Expanded(flex: 4, child: plate),
                ],
              )
            : Column(children: [text, const SizedBox(height: 32), plate]),
      ),
    );
  }
}

// ============================== الشبكة والعناصر ==============================
class _Item {
  final String title, body;
  const _Item(this.title, this.body);
}

class _Grid extends StatelessWidget {
  final List<_Item> items;
  const _Grid({required this.items});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final cols = c.maxWidth >= 900 ? 4 : (c.maxWidth >= 540 ? 2 : 1);
        const gap = 16.0;
        final w = (c.maxWidth - gap * (cols - 1)) / cols;
        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: [
            for (final it in items)
              SizedBox(
                width: w,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 6,
                  ),
                  decoration: const BoxDecoration(
                    border: BorderDirectional(
                      start: BorderSide(color: C.navy, width: 4),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        it.title,
                        style: const TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        it.body,
                        style: const TextStyle(
                          color: C.muted,
                          fontSize: 15.5,
                          height: 1.7,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

class _Steps extends StatelessWidget {
  const _Steps();

  static const _data = [
    ('استقبال المركبة', 'تدخل مركبتك إلى منطقة الفحص.'),
    ('الفحص', 'معاينة الأضرار وتوثيقها بالصور.'),
    ('التقدير', 'حساب تكلفة الإصلاح بشكل مفصل.'),
    ('التقرير', 'تستلم التقرير النهائي.'),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final cols = c.maxWidth >= 900 ? 4 : (c.maxWidth >= 540 ? 2 : 1);
        const gap = 16.0;
        final w = (c.maxWidth - gap * (cols - 1)) / cols;
        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: [
            for (var i = 0; i < _data.length; i++)
              SizedBox(
                width: w,
                child: Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: C.line),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 17,
                        backgroundColor: C.navy,
                        child: Text(
                          '${i + 1}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _data[i].$1,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        _data[i].$2,
                        style: const TextStyle(color: C.muted, fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

// ============================== الأسئلة الشائعة ==============================
class _Faq extends StatelessWidget {
  const _Faq();

  Widget _q(String q, Widget a) => Theme(
    data: ThemeData(dividerColor: Colors.transparent),
    child: Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: C.line)),
      ),
      child: ExpansionTile(
        tilePadding: EdgeInsets.zero,
        childrenPadding: const EdgeInsets.only(bottom: 14),
        expandedAlignment: Alignment.centerRight,
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        title: Text(q, style: const TextStyle(fontWeight: FontWeight.bold)),
        children: [a],
      ),
    ),
  );

  Text _t(String s) =>
      Text(s, style: const TextStyle(color: C.muted, height: 1.8));

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _q(
          'ماذا أحضر معي؟',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _t(
                '1. خطاب طلب التقدير من (المرور، الشرطة، الدفاع المدني، المحكمة)، وفي حوادث نجم يكفي رسالة نجم النصية.',
              ),
              const SizedBox(height: 6),
              _t('2. رخصة سير المركبة (الاستمارة) أو برنت من المرور.'),
            ],
          ),
        ),
        _q(
          'كم تستغرق عملية التقدير؟',
          _t(
            'تختلف المدة حسب حجم الأضرار، وسنخبرك بالوقت المتوقع عند الاستقبال.',
          ),
        ),
        _q(
          'هل أحتاج موعداً مسبقاً؟',
          _t('تواصل معنا عبر واتساب أو الاتصال لمعرفة أنسب وقت للزيارة.'),
        ),
      ],
    );
  }
}

// ============================== التواصل ==============================
class _Contact extends StatelessWidget {
  final bool wide;
  const _Contact({required this.wide});

  Widget _card(String title, List<Widget> body, List<Widget> actions) =>
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: C.line),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: C.navy,
              ),
            ),
            const SizedBox(height: 10),
            ...body,
            const SizedBox(height: 14),
            Wrap(spacing: 10, runSpacing: 10, children: actions),
          ],
        ),
      );

  Text _line(String s) => Text(
    s,
    style: const TextStyle(color: C.muted, height: 1.9, fontSize: 16),
  );

  @override
  Widget build(BuildContext context) {
    final main = _card(
      'الموقع وأوقات الدوام',
      [
        _line('العنوان: ${Cfg.address}'),
        _line('أوقات الدوام: ${Cfg.hours}'),
        _line('الهاتف: ${Cfg.phone}'),
      ],
      [
        _Btn('واتساب', () => openUrl(waUri)),
        _Btn('اتصال', () => openUrl(telUri), outlined: true),
        _Btn('الاتجاهات', () => openUrl(Uri.parse(Cfg.mapUrl)), outlined: true),
      ],
    );

    if (Cfg.social.isEmpty) return main;

    final social = _card(
      'تابعنا',
      [_line('حساباتنا على وسائل التواصل الاجتماعي.')],
      [
        for (final s in Cfg.social)
          _Btn(s.$1, () => openUrl(Uri.parse(s.$2)), outlined: true),
      ],
    );

    return wide
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: main),
              const SizedBox(width: 24),
              Expanded(child: social),
            ],
          )
        : Column(children: [main, const SizedBox(height: 24), social]);
  }
}

// ============================== الفوتر ==============================
class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: C.navyD,
      padding: const EdgeInsets.symmetric(vertical: 28),
      child: const _Wrap(
        child: Wrap(
          alignment: WrapAlignment.spaceBetween,
          runSpacing: 8,
          spacing: 12,
          children: [
            Text(
              '© 2026 شركة سما الإتقان للتقدير',
              style: TextStyle(color: C.onDark, fontSize: 14.5),
            ),
            Text(
              'Sama Al Itqan Valuing Company',
              textDirection: TextDirection.ltr,
              style: TextStyle(color: C.onDark, fontSize: 14.5),
            ),
          ],
        ),
      ),
    );
  }
}
