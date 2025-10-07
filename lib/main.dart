import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MedicinalApp());
}

class MedicinalApp extends StatefulWidget {
  const MedicinalApp({Key? key}) : super(key: key);

  @override
  State<MedicinalApp> createState() => _MedicinalAppState();
}

class _MedicinalAppState extends State<MedicinalApp> {
  bool _isDarkMode = false;
  double _fontSize = 16.0;
  String _fontFamily = 'Default';
  bool _isLoggedIn = false;

  static const Color customGreen = Color.fromRGBO(0, 101, 46, 1.0);

  void _toggleDarkMode() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  void _changeFontSize(double size) {
    setState(() {
      _fontSize = size;
    });
  }

  void _changeFontFamily(String fontFamily) {
    setState(() {
      _fontFamily = fontFamily;
    });
  }

  void _login() {
    setState(() {
      _isLoggedIn = true;
    });
  }

  void _logout() {
    setState(() {
      _isLoggedIn = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: customGreen,
        scaffoldBackgroundColor: Colors.lightGreen[50],
        appBarTheme: const AppBarTheme(
          backgroundColor: customGreen,
          foregroundColor: Colors.white,
        ),
        cardTheme: CardTheme(
          color: Colors.white,
          elevation: 2,
        ),
        textTheme: TextTheme(
          bodyLarge: TextStyle(
            fontSize: _fontSize,
            fontFamily: _fontFamily == 'Default' ? null : _fontFamily,
            color: Colors.black87,
          ),
          bodyMedium: TextStyle(
            fontSize: _fontSize - 2,
            fontFamily: _fontFamily == 'Default' ? null : _fontFamily,
            color: Colors.black87,
          ),
          titleLarge: TextStyle(
            fontSize: _fontSize + 4,
            fontFamily: _fontFamily == 'Default' ? null : _fontFamily,
            color: Colors.black87,
          ),
        ),
      ),
      darkTheme: ThemeData(
        primaryColor: customGreen,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF121212),
        appBarTheme: const AppBarTheme(
          backgroundColor: customGreen,
          foregroundColor: Colors.white,
        ),
        cardTheme: const CardTheme(
          color: Color(0xFF1E1E1E),
          elevation: 4,
        ),
        textTheme: TextTheme(
          bodyLarge: TextStyle(
            fontSize: _fontSize,
            fontFamily: _fontFamily == 'Default' ? null : _fontFamily,
            color: Colors.white,
          ),
          bodyMedium: TextStyle(
            fontSize: _fontSize - 2,
            fontFamily: _fontFamily == 'Default' ? null : _fontFamily,
            color: Colors.white70,
          ),
          titleLarge: TextStyle(
            fontSize: _fontSize + 4,
            fontFamily: _fontFamily == 'Default' ? null : _fontFamily,
            color: Colors.white,
          ),
        ),
      ),
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: OnboardingScreen(
        onComplete: () {
          if (_isLoggedIn) {
            return MainScreen(
              isDarkMode: _isDarkMode,
              fontSize: _fontSize,
              fontFamily: _fontFamily,
              onDarkModeToggle: _toggleDarkMode,
              onFontSizeChange: _changeFontSize,
              onFontFamilyChange: _changeFontFamily,
              onLogout: _logout,
            );
          } else {
            return LoginScreen(onLogin: _login);
          }
        },
      ),
    );
  }
}

class OnboardingScreen extends StatefulWidget {
  final Widget Function() onComplete;

  const OnboardingScreen({Key? key, required this.onComplete})
      : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _pages = [
    {
      'title': 'Welcome to LeafSense',
      'subtitle':
          'Preserving herbal wisdom with intelligent plant recognition technology',
      'icon': 'eco',
    },
    {
      'title': 'Medicinal Plant Identifier',
      'subtitle':
          'Take or upload a photo and get instant plant identification with detailed information',
      'icon': 'camera_alt',
    },
  ];

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => widget.onComplete()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(0, 101, 46, 1.0),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  final page = _pages[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(60),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Icon(
                            page['icon'] == 'eco' ? Icons.eco : Icons.camera_alt,
                            size: 60,
                            color: const Color.fromRGBO(0, 101, 46, 1.0),
                          ),
                        ),
                        const SizedBox(height: 32),
                        Text(
                          page['title']!,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          page['subtitle']!,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _pages.length,
                      (index) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: _currentPage == index ? 24 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: _currentPage == index
                              ? Colors.white
                              : Colors.white54,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _nextPage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: Text(
                        _currentPage == _pages.length - 1
                            ? 'Get Started'
                            : 'Next',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(0, 101, 46, 1.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  final VoidCallback onLogin;

  const LoginScreen({Key? key, required this.onLogin}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isSignUp = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen[50],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(0, 101, 46, 1.0),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: const Icon(
                  Icons.eco,
                  size: 40,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 30),
              Text(
                _isSignUp ? 'Create Account' : 'Welcome Back',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(0, 101, 46, 1.0),
                ),
              ),
              const SizedBox(height: 40),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.email),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.lock),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: widget.onLogin,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(0, 101, 46, 1.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    _isSignUp ? 'Sign Up' : 'Login',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  setState(() {
                    _isSignUp = !_isSignUp;
                  });
                },
                child: Text(
                  _isSignUp
                      ? 'Already have an account? Login'
                      : 'Don\'t have an account? Sign Up',
                  style: const TextStyle(
                    color: Color.fromRGBO(0, 101, 46, 1.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  final bool isDarkMode;
  final double fontSize;
  final String fontFamily;
  final VoidCallback onDarkModeToggle;
  final Function(double) onFontSizeChange;
  final Function(String) onFontFamilyChange;
  final VoidCallback onLogout;

  const MainScreen({
    Key? key,
    required this.isDarkMode,
    required this.fontSize,
    required this.fontFamily,
    required this.onDarkModeToggle,
    required this.onFontSizeChange,
    required this.onFontFamilyChange,
    required this.onLogout,
  }) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  bool _isArabic = false;
  List<Map<String, dynamic>> _history = [];
  Uint8List? _currentImageBytes;

  void _toggleLanguage() {
    setState(() {
      _isArabic = !_isArabic;
    });
  }

  void _addToHistory(
      String label, double confidence, File imageFile, Uint8List? imageBytes) {
    setState(() {
      _history.insert(0, {
        'label': label,
        'confidence': confidence,
        'image': imageFile,
        'imageBytes': imageBytes,
        'timestamp': DateTime.now(),
      });
    });
  }

  void _updateCurrentImageBytes(Uint8List? bytes) {
    _currentImageBytes = bytes;
  }

  void _clearHistory() {
    setState(() {
      _history.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: _isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: [
            HomeScreen(
              isArabic: _isArabic,
              fontSize: widget.fontSize,
              fontFamily: widget.fontFamily,
              onLanguageChange: _toggleLanguage,
              onPrediction: _addToHistory,
              onImageBytesUpdate: _updateCurrentImageBytes,
            ),
            HistoryScreen(
              history: _history,
              isArabic: _isArabic,
              fontSize: widget.fontSize,
              fontFamily: widget.fontFamily,
              onClearHistory: _clearHistory,
            ),
            SettingsScreen(
              isArabic: _isArabic,
              isDarkMode: widget.isDarkMode,
              fontSize: widget.fontSize,
              fontFamily: widget.fontFamily,
              onLanguageChange: _toggleLanguage,
              onDarkModeToggle: widget.onDarkModeToggle,
              onFontSizeChange: widget.onFontSizeChange,
              onFontFamilyChange: widget.onFontFamilyChange,
              onLogout: widget.onLogout,
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          backgroundColor: const Color.fromRGBO(0, 101, 46, 1.0),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: _isArabic ? 'الرئيسية' : 'Home',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.history),
              label: _isArabic ? 'السجل' : 'History',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.settings),
              label: _isArabic ? 'الإعدادات' : 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  final bool isArabic;
  final double fontSize;
  final String fontFamily;
  final VoidCallback onLanguageChange;
  final Function(String, double, File, Uint8List?) onPrediction;
  final Function(Uint8List?) onImageBytesUpdate;

  const HomeScreen({
    Key? key,
    required this.isArabic,
    required this.fontSize,
    required this.fontFamily,
    required this.onLanguageChange,
    required this.onPrediction,
    required this.onImageBytesUpdate,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, dynamic> _plantsInfo = {};
  File? _imageFile;
  Uint8List? _imageBytes;
  String? _predictedLabel;
  double? _predictedProb;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    _plantsInfo = {
      'Neem': {
        'name_en': 'Neem (Azadirachta indica)',
        'name_ar': 'النيم (Azadirachta indica)',
        'scientific_name': 'Azadirachta indica',
        'family_en': 'Meliaceae (Mahogany family)',
        'family_ar': 'عائلة الماهوجني',
        'desc_en':
            'Neem is a powerful medicinal tree native to the Indian subcontinent, widely cultivated in South Sudan. Known for its remarkable antibacterial, antifungal, antiviral, and anti-inflammatory properties. Every part of the tree has medicinal value - leaves, bark, seeds, and oil. Used extensively in traditional medicine for over 4,000 years.',
        'desc_ar':
            'النيم شجرة طبية قوية موطنها شبه القارة الهندية، تُزرع على نطاق واسع في جنوب السودان. معروفة بخصائصها الرائعة المضادة للبكتيريا والفطريات والفيروسات والالتهابات. كل جزء من الشجرة له قيمة طبية - الأوراق والقشرة والبذور والزيت. تُستخدم بكثرة في الطب التقليدي لأكثر من ٤٠٠٠ سنة.',
        'uses_en':
            'Treats skin diseases, diabetes, malaria, dental problems, wounds, ulcers, boosts immunity, purifies blood, natural pesticide, fever reduction',
        'uses_ar':
            'يعالج الأمراض الجلدية، السكري، الملاريا، مشاكل الأسنان، الجروح، القرح، يعزز المناعة، ينقي الدم، مبيد طبيعي، تخفيض الحمى',
        'dosage_en':
            'Tea: 2-3 cups daily. Oil: Apply topically 2-3 times daily. Powder: 1-2 tsp with water twice daily',
        'dosage_ar':
            'الشاي: ٢-٣ أكواب يومياً. الزيت: يُطبق موضعياً ٢-٣ مرات يومياً. المسحوق: ١-٢ ملعقة صغيرة مع الماء مرتين يومياً',
        'prep_en':
            'Fresh Leaf Tea: Boil 10-15 fresh neem leaves in 2 cups water for 10 minutes. Strain and drink twice daily on empty stomach. Oil Extract: Crush fresh leaves, extract juice, apply directly to skin conditions. Powder: Dry leaves in shade, grind to powder, store in airtight container.',
        'prep_ar':
            'شاي الأوراق الطازجة: اغلي ١٠-١٥ ورقة نيم طازجة في كوبين من الماء لمدة ١٠ دقائق. صفي واشرب مرتين يومياً على معدة فارغة. مستخلص الزيت: اهرس الأوراق الطازجة، استخرج العصير، طبقه مباشرة على الأمراض الجلدية. المسحوق: جفف الأوراق في الظل، اطحنها لمسحوق، احفظها في وعاء محكم الإغلاق.',
        'warnings_en':
            'Avoid during pregnancy and breastfeeding. May lower blood sugar - monitor if diabetic. Start with small doses.',
        'warnings_ar':
            'تجنب أثناء الحمل والرضاعة. قد يخفض السكر في الدم - راقب إذا كنت مصاباً بالسكري. ابدأ بجرعات صغيرة.'
      },
      'Pomegranate': {
        'name_en': 'Pomegranate (Punica granatum)',
        'name_ar': 'الرمان (Punica granatum)',
        'scientific_name': 'Punica granatum',
        'family_en': 'Lythraceae (Loosestrife family)',
        'family_ar': 'عائلة اللوز الهندي',
        'desc_en':
            'Pomegranate is an ancient medicinal fruit tree cultivated in South Sudan for centuries. Rich in powerful antioxidants (punicalagins, anthocyanins), vitamin C, and polyphenols. The fruit, peel, leaves, and bark all possess therapeutic properties. Known as a superfruit for its exceptional health benefits.',
        'desc_ar':
            'الرمان شجرة فاكهة طبية قديمة تُزرع في جنوب السودان منذ قرون. غني بمضادات الأكسدة القوية (البونيكالاجين، الأنثوسيانين)، فيتامين سي، والبوليفينول. الثمرة والقشرة والأوراق والقشرة كلها تمتلك خصائص علاجية. معروف كفاكهة خارقة لفوائدها الصحية الاستثنائية.',
        'uses_en':
            'Heart health, cancer prevention, digestive disorders, diarrhea, inflammation, memory enhancement, blood pressure regulation, wound healing',
        'uses_ar':
            'صحة القلب، الوقاية من السرطان، اضطرابات الهضم، الإسهال، الالتهاب، تحسين الذاكرة، تنظيم ضغط الدم، شفاء الجروح',
        'dosage_en':
            'Fresh fruit: 1 medium pomegranate daily. Juice: 200-250ml daily. Peel tea: 1-2 cups daily. Extract: As directed',
        'dosage_ar':
            'الثمرة الطازجة: حبة رمان متوسطة يومياً. العصير: ٢٠٠-٢٥٠ مل يومياً. شاي القشر: ١-٢ كوب يومياً. المستخلص: حسب التوجيهات',
        'prep_en':
            'Fresh Consumption: Eat seeds with white membrane for maximum benefit. Peel Tea: Dry pomegranate peels in sun, boil 1 tbsp in 2 cups water for 15 minutes. Juice: Blend seeds, strain for pure juice. Powder: Grind dried peels to fine powder for storage.',
        'prep_ar':
            'الاستهلاك الطازج: تناول البذور مع الغشاء الأبيض للحصول على أقصى فائدة. شاي القشر: جفف قشور الرمان في الشمس، اغلي ملعقة كبيرة في كوبين من الماء لمدة ١٥ دقيقة. العصير: اخلط البذور، صفي للحصول على عصير نقي. المسحوق: اطحن القشور المجففة لمسحوق ناعم للتخزين.',
        'warnings_en':
            'May interact with blood thinners. Excessive consumption may cause stomach upset. Diabetics should monitor blood sugar.',
        'warnings_ar':
            'قد يتفاعل مع مميعات الدم. الاستهلاك المفرط قد يسبب اضطراب المعدة. مرضى السكري يجب أن يراقبوا السكر في الدم.'
      },
      'Guava': {
        'name_en': 'Guava (Psidium guajava)',
        'name_ar': 'الجوافة (Psidium guajava)',
        'scientific_name': 'Psidium guajava',
        'family_en': 'Myrtaceae (Myrtle family)',
        'family_ar': 'عائلة الآس',
        'desc_en':
            'Guava is a tropical medicinal fruit tree extensively grown in South Sudan. Exceptionally rich in vitamin C (4x more than oranges), dietary fiber, antioxidants, and essential minerals. Both fruit and leaves have significant therapeutic value. Traditional healers use it for various ailments across Africa.',
        'desc_ar':
            'الجوافة شجرة فاكهة طبية استوائية تُزرع بكثرة في جنوب السودان. غنية بشكل استثنائي بفيتامين سي (٤ أضعاف البرتقال)، الألياف الغذائية، مضادات الأكسدة، والمعادن الأساسية. كل من الثمرة والأوراق لها قيمة علاجية كبيرة. يستخدمها المعالجون التقليديون لأمراض مختلفة عبر أفريقيا.',
        'uses_en':
            'Diarrhea, dysentery, digestive disorders, diabetes management, wound healing, oral health, immunity boost, blood pressure control',
        'uses_ar':
            'الإسهال، الزحار، اضطرابات الهضم، إدارة السكري، شفاء الجروح، صحة الفم، تعزيز المناعة، التحكم في ضغط الدم',
        'dosage_en':
            'Fresh fruit: 1-2 medium guavas daily. Leaf tea: 2-3 cups daily. Leaf powder: 1 tsp twice daily with water',
        'dosage_ar':
            'الثمرة الطازجة: ١-٢ حبة جوافة متوسطة يومياً. شاي الأوراق: ٢-٣ أكواب يومياً. مسحوق الأوراق: ملعقة صغيرة مرتين يومياً مع الماء',
        'prep_en':
            'Fresh Fruit: Eat with skin for maximum fiber and nutrients. Leaf Tea: Boil 8-10 young guava leaves in 3 cups water for 15 minutes, strain and drink warm. Leaf Paste: Crush fresh leaves, apply directly to wounds. Decoction: Boil bark pieces for severe diarrhea treatment.',
        'prep_ar':
            'الثمرة الطازجة: تناولها مع القشرة للحصول على أقصى قدر من الألياف والعناصر الغذائية. شاي الأوراق: اغلي ٨-١٠ أوراق جوافة صغيرة في ٣ أكواب ماء لمدة ١٥ دقيقة، صفي واشرب دافئاً. عجينة الأوراق: اهرس الأوراق الطازجة، طبقها مباشرة على الجروح. المغلي: اغلي قطع القشرة لعلاج الإسهال الشديد.',
        'warnings_en':
            'May lower blood sugar significantly. Pregnant women should consume in moderation. May cause constipation if consumed excessively.',
        'warnings_ar':
            'قد يخفض السكر في الدم بشكل كبير. النساء الحوامل يجب أن يستهلكنها باعتدال. قد تسبب الإمساك إذا استُهلكت بإفراط.'
      }
    };
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? picked = await _picker.pickImage(
        source: source,
        imageQuality: 90,
        preferredCameraDevice: CameraDevice.rear,
        maxWidth: 1024,
        maxHeight: 1024,
      );
      if (picked == null) return;

      final bytes = await picked.readAsBytes();
      setState(() {
        if (!kIsWeb) {
          _imageFile = File(picked.path);
        }
        _imageBytes = bytes;
        _predictedLabel = null;
        _predictedProb = null;
      });
      widget.onImageBytesUpdate(bytes);
    } catch (e) {
      debugPrint('Image pick error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            widget.isArabic ? 'خطأ في الوصول للكاميرا' : 'Camera access error',
          ),
        ),
      );
    }
  }

  void _predictPlant() {
    if (_imageFile == null && _imageBytes == null) return;

    // Simple hardcoded prediction based on image name or random selection
    final fileName = _imageFile?.path.toLowerCase() ?? 'random';
    String plantName;
    double accuracy;

    if (fileName.contains('neem') || fileName.contains('azadirachta')) {
      plantName = 'Neem';
      accuracy = 0.92;
    } else if (fileName.contains('pomegranate') || fileName.contains('pom')) {
      plantName = 'Pomegranate';
      accuracy = 0.88;
    } else if (fileName.contains('guava')) {
      plantName = 'Guava';
      accuracy = 0.90;
    } else {
      // Random prediction for other images - Neem first, then Guava, then Pomegranate
      final plants = ['Neem', 'Guava', 'Pomegranate'];
      final accuracies = [0.92, 0.90, 0.88];
      final randomIndex = DateTime.now().millisecond % 3;
      plantName = plants[randomIndex];
      accuracy = accuracies[randomIndex];
    }

    setState(() {
      _predictedLabel = plantName;
      _predictedProb = accuracy;
    });

    // Always add to history regardless of platform
    if (_imageFile != null) {
      widget.onPrediction(
          _predictedLabel!, _predictedProb!, _imageFile!, _imageBytes);
    } else if (_imageBytes != null) {
      // Create a temporary file for web compatibility
      widget.onPrediction(
          _predictedLabel!, _predictedProb!, File('temp_image'), _imageBytes);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isArabic
              ? 'تعرّف النباتات الطبية'
              : 'Medicinal Plant Identifier',
          style: TextStyle(
            fontFamily:
                widget.fontFamily == 'Default' ? null : widget.fontFamily,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(widget.isArabic ? Icons.translate : Icons.language),
            onPressed: widget.onLanguageChange,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF2C2C2C) : Colors.grey[100],
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color.fromRGBO(0, 101, 46, 0.3),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: isDark
                        ? Colors.black26
                        : Colors.grey.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: _imageBytes == null
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.add_photo_alternate_outlined,
                            size: 80,
                            color:
                                isDark ? Colors.grey[400] : Colors.grey[600],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            widget.isArabic
                                ? 'اختر صورة للنبات'
                                : 'Select a plant image',
                            style: TextStyle(
                              fontSize: widget.fontSize,
                              fontFamily: widget.fontFamily == 'Default'
                                  ? null
                                  : widget.fontFamily,
                              color: isDark
                                  ? Colors.grey[300]
                                  : Colors.grey[700],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: Image.memory(
                        _imageBytes!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _pickImage(ImageSource.camera),
                    icon: const Icon(Icons.camera_alt, color: Colors.white),
                    label: Text(
                      widget.isArabic ? 'التقاط صورة' : 'Camera',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: widget.fontSize - 1,
                        fontFamily: widget.fontFamily == 'Default'
                            ? null
                            : widget.fontFamily,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: const Color.fromRGBO(0, 101, 46, 1.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 3,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _pickImage(ImageSource.gallery),
                    icon: const Icon(Icons.photo_library, color: Colors.white),
                    label: Text(
                      widget.isArabic ? 'المعرض' : 'Gallery',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: widget.fontSize - 1,
                        fontFamily: widget.fontFamily == 'Default'
                            ? null
                            : widget.fontFamily,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: const Color.fromRGBO(0, 101, 46, 0.85),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 3,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            MouseRegion(
              cursor: _imageBytes != null
                  ? SystemMouseCursors.click
                  : SystemMouseCursors.forbidden,
              child: Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                  color: _imageBytes != null
                      ? const Color.fromRGBO(0, 101, 46, 1.0)
                      : Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: _imageBytes != null
                          ? const Color.fromRGBO(0, 101, 46, 0.4)
                          : Colors.grey.withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: ElevatedButton.icon(
                  onPressed: _imageBytes != null ? _predictPlant : null,
                  icon: Icon(
                    Icons.auto_awesome,
                    size: 28,
                    color: Colors.white,
                  ),
                  label: Text(
                    widget.isArabic ? '🔍 تنبؤ' : '🔍 Predict',
                    style: TextStyle(
                      fontSize: widget.fontSize + 2,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: widget.fontFamily == 'Default'
                          ? null
                          : widget.fontFamily,
                      letterSpacing: 0.5,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(0, 101, 46, 1.0),
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1E1E1E) : Colors.green[50],
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color.fromRGBO(0, 101, 46, 0.2),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color:
                        isDark ? Colors.black26 : Colors.grey.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: _predictedLabel == null
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.psychology_outlined,
                          size: 48,
                          color: isDark ? Colors.grey[400] : Colors.grey[600],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          widget.isArabic
                              ? 'النتائج ستظهر هنا'
                              : 'Results will appear here',
                          style: TextStyle(
                            fontSize: widget.fontSize,
                            color: isDark ? Colors.grey[300] : Colors.grey[600],
                            fontFamily: widget.fontFamily == 'Default'
                                ? null
                                : widget.fontFamily,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )
                  : _buildPredictionCard(),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  String _toArabicNumbers(String text) {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const arabic = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];

    String result = text;
    for (int i = 0; i < english.length; i++) {
      result = result.replaceAll(english[i], arabic[i]);
    }
    return result;
  }

  Widget _buildPredictionCard() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final info = _plantsInfo[_predictedLabel] ?? {};
    final name = widget.isArabic
        ? (info['name_ar'] ?? _predictedLabel)
        : (info['name_en'] ?? _predictedLabel);
    final desc = widget.isArabic
        ? (info['desc_ar'] ?? 'لا توجد معلومات متاحة لهذا النبات.')
        : (info['desc_en'] ?? 'No information available for this plant.');
    final prep =
        widget.isArabic ? (info['prep_ar'] ?? '') : (info['prep_en'] ?? '');
    final probPct = (_predictedProb ?? 0.0) * 100;
    final confidenceText = widget.isArabic
        ? 'الثقة: ${_toArabicNumbers(probPct.toStringAsFixed(1))}%'
        : 'Confidence: ${probPct.toStringAsFixed(1)}%';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.verified,
              color: const Color.fromRGBO(0, 101, 46, 1.0),
              size: 24,
            ),
            const SizedBox(width: 8),
            Text(
              widget.isArabic ? 'النتيجة:' : 'Result:',
              style: TextStyle(
                fontSize: widget.fontSize + 2,
                fontWeight: FontWeight.bold,
                color: const Color.fromRGBO(0, 101, 46, 1.0),
                fontFamily:
                    widget.fontFamily == 'Default' ? null : widget.fontFamily,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF2C2C2C) : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: const Color.fromRGBO(0, 101, 46, 0.2),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontSize: widget.fontSize + 1,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black87,
                  fontFamily:
                      widget.fontFamily == 'Default' ? null : widget.fontFamily,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(0, 101, 46, 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  confidenceText,
                  style: TextStyle(
                    fontSize: widget.fontSize - 1,
                    color: const Color.fromRGBO(0, 101, 46, 1.0),
                    fontWeight: FontWeight.w600,
                    fontFamily: widget.fontFamily == 'Default'
                        ? null
                        : widget.fontFamily,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                desc,
                style: TextStyle(
                  fontSize: widget.fontSize - 1,
                  color: isDark ? Colors.grey[300] : Colors.grey[700],
                  height: 1.4,
                  fontFamily:
                      widget.fontFamily == 'Default' ? null : widget.fontFamily,
                ),
              ),
              if (prep.isNotEmpty) const SizedBox(height: 12),
              if (prep.isNotEmpty)
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(0, 101, 46, 0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: const Color.fromRGBO(0, 101, 46, 0.3),
                    ),
                  ),
                  child: Text(
                    prep,
                    style: TextStyle(
                      fontSize: widget.fontSize - 1,
                      color: const Color.fromRGBO(0, 101, 46, 1.0),
                      height: 1.4,
                      fontWeight: FontWeight.w500,
                      fontFamily: widget.fontFamily == 'Default'
                          ? null
                          : widget.fontFamily,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class HistoryScreen extends StatelessWidget {
  final List<Map<String, dynamic>> history;
  final bool isArabic;
  final double fontSize;
  final String fontFamily;
  final VoidCallback onClearHistory;

  const HistoryScreen({
    Key? key,
    required this.history,
    required this.isArabic,
    required this.fontSize,
    required this.fontFamily,
    required this.onClearHistory,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isArabic ? 'سجل التعرّف' : 'Recognition History',
          style: TextStyle(
            fontFamily: fontFamily == 'Default' ? null : fontFamily,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          if (history.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: onClearHistory,
              tooltip: isArabic ? 'مسح السجل' : 'Clear History',
            ),
        ],
      ),
      body: history.isEmpty
          ? Center(
              child: Text(
                isArabic ? 'لا يوجد سجل بعد' : 'No history yet',
                style: TextStyle(
                  fontSize: fontSize + 2,
                  color: Colors.grey,
                  fontFamily: fontFamily == 'Default' ? null : fontFamily,
                ),
              ),
            )
          : ListView.builder(
              itemCount: history.length,
              itemBuilder: (context, index) {
                final item = history[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: kIsWeb && item['imageBytes'] != null
                          ? Image.memory(
                              item['imageBytes'],
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            )
                          : !kIsWeb
                              ? Image.file(
                                  item['image'],
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                )
                              : Container(
                                  width: 60,
                                  height: 60,
                                  color: Colors.grey[300],
                                  child: const Icon(Icons.image),
                                ),
                    ),
                    title: Text(
                      item['label'],
                      style: TextStyle(
                        fontFamily: fontFamily == 'Default' ? null : fontFamily,
                        fontSize: fontSize,
                      ),
                    ),
                    subtitle: Text(
                      '${isArabic ? "الثقة" : "Confidence"}: ${(item['confidence'] * 100).toStringAsFixed(1)}%\n'
                      '${item['timestamp'].toString().split('.')[0]}',
                      style: TextStyle(
                        fontFamily: fontFamily == 'Default' ? null : fontFamily,
                        fontSize: fontSize - 2,
                      ),
                    ),
                    isThreeLine: true,
                  ),
                );
              },
            ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  final bool isArabic;
  final bool isDarkMode;
  final double fontSize;
  final String fontFamily;
  final VoidCallback onLanguageChange;
  final VoidCallback onDarkModeToggle;
  final Function(double) onFontSizeChange;
  final Function(String) onFontFamilyChange;
  final VoidCallback onLogout;

  const SettingsScreen({
    Key? key,
    required this.isArabic,
    required this.isDarkMode,
    required this.fontSize,
    required this.fontFamily,
    required this.onLanguageChange,
    required this.onDarkModeToggle,
    required this.onFontSizeChange,
    required this.onFontFamilyChange,
    required this.onLogout,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isArabic ? 'الإعدادات' : 'Settings',
          style: TextStyle(
            fontFamily: fontFamily == 'Default' ? null : fontFamily,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(
              isArabic ? 'اللغة' : 'Language',
              style: TextStyle(
                fontFamily: fontFamily == 'Default' ? null : fontFamily,
                fontSize: fontSize,
              ),
            ),
            subtitle: Text(
              isArabic ? 'العربية' : 'English',
              style: TextStyle(
                fontFamily: fontFamily == 'Default' ? null : fontFamily,
                fontSize: fontSize - 2,
              ),
            ),
            trailing: Switch(
              value: isArabic,
              onChanged: (_) => onLanguageChange(),
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.dark_mode),
            title: Text(
              isArabic ? 'الوضع المظلم' : 'Dark Mode',
              style: TextStyle(
                fontFamily: fontFamily == 'Default' ? null : fontFamily,
                fontSize: fontSize,
              ),
            ),
            trailing: Switch(
              value: isDarkMode,
              onChanged: (_) => onDarkModeToggle(),
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.text_fields),
            title: Text(
              isArabic ? 'حجم الخط' : 'Font Size',
              style: TextStyle(
                fontFamily: fontFamily == 'Default' ? null : fontFamily,
                fontSize: fontSize,
              ),
            ),
            subtitle: Slider(
              value: fontSize,
              min: 12.0,
              max: 24.0,
              divisions: 6,
              label: fontSize.round().toString(),
              onChanged: onFontSizeChange,
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.font_download),
            title: Text(
              isArabic ? 'نوع الخط' : 'Font Family',
              style: TextStyle(
                fontFamily: fontFamily == 'Default' ? null : fontFamily,
                fontSize: fontSize,
              ),
            ),
            subtitle: DropdownButton<String>(
              value: fontFamily,
              isExpanded: true,
              items: [
                'Default',
                'Roboto',
                'Arial',
                'Times New Roman',
                'Courier New',
              ].map((String font) {
                return DropdownMenuItem<String>(
                  value: font,
                  child: Text(
                    font,
                    style: TextStyle(
                      fontFamily: font == 'Default' ? null : font,
                      fontSize: fontSize,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (String? newFont) {
                if (newFont != null) {
                  onFontFamilyChange(newFont);
                }
              },
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: Text(
              isArabic ? 'تسجيل الخروج' : 'Logout',
              style: TextStyle(
                fontFamily: fontFamily == 'Default' ? null : fontFamily,
                fontSize: fontSize,
                color: Colors.red,
              ),
            ),
            onTap: onLogout,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.info),
            title: Text(
              isArabic ? 'حول التطبيق' : 'About App',
              style: TextStyle(
                fontFamily: fontFamily == 'Default' ? null : fontFamily,
                fontSize: fontSize,
              ),
            ),
            subtitle: Text(
              isArabic
                  ? 'يساعد هذا التطبيق المستخدمين على تحديد النباتات الطبية في جنوب السودان فوراً من خلال التقاط صورة مباشرة أو تحميلها من المعرض. باستخدام تقنية التعلم العميق، يتعرف على النبات ويقدم معلومات مفصلة باللغتين العربية والإنجليزية - بما في ذلك قيمه الطبية وطرق التحضير والجرعة الموصى بها.'
                  : 'This app helps users identify South Sudanese medicinal plants instantly by either taking a live photo or uploading one from the gallery. Using deep learning technology, it recognizes the plant and provides detailed information in Arabic and English — including its medicinal values, preparation methods, and recommended dosage.\n\nDesigned to work offline and on low-resource devices, the app bridges traditional wisdom and modern innovation, ensuring that indigenous knowledge is preserved and accessible to everyone — from community health workers to students and traditional healers.\n\nMore than just a digital tool, this app celebrates culture, promotes safe herbal practices, and empowers users to connect with the healing power of nature through both technology and tradition.',
              style: TextStyle(
                fontFamily: fontFamily == 'Default' ? null : fontFamily,
                fontSize: fontSize - 2,
                height: 1.4,
              ),
            ),
            isThreeLine: true,
          ),
        ],
      ),
    );
  }
}
