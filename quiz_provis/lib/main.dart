import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PROVIS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF0D6E84),
        scaffoldBackgroundColor: const Color(0xFFF0F1F5),
        fontFamily: 'Roboto',
      ),
      initialRoute: '/',
      routes: {
        '/' : (context) => const QuizScreen(),
        '/main': (context) => const MainScreen(),
        '/elearning': (context) => const ELearningScreen(),
        '/mentalhealth': (context) => const MentalHealthScreen(),
        '/akademik': (context) => const AkademikScreen(),
        '/keuangan': (context) => const KeuanganScreen(),
        '/sosial' : (context) => const HomeScreen(),
        '/task' : (context) => const TaskScreen(),
        '/chat' : (context) => const MessageScreen(),
        '/notification' : (context) => const NotificationScreen(),
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentIndex = 2; // Start with home selected
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Top section with search bar and profile
            _buildTopSection(),
            
            // Time and PROVIS header
            _buildHeaderSection(),
            
            // Main carousel section
            Expanded(
              child: Column(
                children: [
                  // Main content carousel
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      onPageChanged: (index) {
                        setState(() {
                          _currentPage = index;
                        });
                      },
                      itemCount: 5, // Number of carousel items
                      itemBuilder: (context, index) {
                        return _buildCarouselItem();
                      },
                    ),
                  ),
                  
                  // Page indicator
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (_pageController.page! > 0) {
                              _pageController.previousPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            }
                          },
                          child: const Text(
                            '<',
                            style: TextStyle(fontSize: 24, color: Color(0xFF8BC09E)),
                          ),
                        ),
                        ...List.generate(
                          5,
                          (index) => Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _currentPage == index
                                  ? const Color(0xFF8BC09E)
                                  : Colors.grey.shade300,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (_pageController.page! < 4) {
                              _pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            }
                          },
                          child: const Text(
                            '>',
                            style: TextStyle(fontSize: 24, color: Color(0xFF8BC09E)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            // Tugas section
            _buildTugasSection(),
            
            // Feature tiles
            _buildFeatureTiles(),
            
            // Bottom space for bottom nav
            const SizedBox(height: 10),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  // Top section with search bar and profile
  Widget _buildTopSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                children: [
                  Icon(Icons.search, color: Colors.grey.shade400),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search',
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.grey.shade400),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 16),
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xFF8BC09E),
              borderRadius: BorderRadius.circular(25),
            ),
            child: const Icon(Icons.person, color: Colors.white),
          ),
        ],
      ),
    );
  }

  // Header with time and PROVIS
  Widget _buildHeaderSection() {
    return Container(
      height: 80,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                '09.30',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '12.00',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Text(
            'PROVIS',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  // Main carousel item
  Widget _buildCarouselItem() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Top blue section
          Container(
            height: 180,
            decoration: const BoxDecoration(
              color: Color(0xFF0D6E84),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
          ),
          // Content section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Lorem Ipsum',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer condimentum sapien sit amet nulla hendrerit, in pulvinar dolor laoreet.',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Tugas section
  Widget _buildTugasSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.check_box, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Tugas Provis 1',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  'Day, DD-MM-YYY',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: Colors.grey, size: 30),
        ],
      ),
    );
  }

  // Feature tiles
  Widget _buildFeatureTiles() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildFeatureTile(
            icon: Icons.menu_book,
            title: 'E-Learning',
            route: '/elearning',
            color: const Color(0xFF0D6E84),
          ),
          _buildFeatureTile(
            icon: Icons.favorite,
            title: 'Mental\nHealth',
            route: '/mentalhealth',
            color: const Color(0xFF0D6E84),
          ),
          _buildFeatureTile(
            icon: Icons.school,
            title: 'Akademik',
            route: '/akademik',
            color: const Color(0xFF0D6E84),
          ),
          _buildFeatureTile(
            icon: Icons.account_balance_wallet,
            title: 'Keuangan',
            route: '/keuangan',
            color: const Color(0xFF0D6E84),
          ),
        ],
      ),
    );
  }

  // Single feature tile
  Widget _buildFeatureTile({
    required IconData icon,
    required String title,
    required String route,
    required Color color,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 40,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  // Bottom navigation
  Widget _buildBottomNavigation() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF8BC09E),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _bottomNavItem(Icons.people, 0, context),
          _bottomNavItem(Icons.calendar_today, 1, context),
          _buildHomeButton(),
          _bottomNavItem(Icons.mail, 3, context),
          _bottomNavItem(Icons.folder, 4, context),
        ],
      ),
    );
  }

  // Home button (center button in bottom nav)
  Widget _buildHomeButton() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = 2;
        });
      },
      child: Container(
        width: 60,
        height: 60,
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: const Color(0xFF0D6E84),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: const Icon(
          Icons.home,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }

  // Bottom nav item
  Widget _bottomNavItem(IconData icon, int index, BuildContext context) {
  return GestureDetector(
    onTap: () {
      switch (index) {
        case 0:
          Navigator.pushNamed(context, '/sosial');
          break;
        case 1:
          Navigator.pushNamed(context, '/task');
          break;
        case 3:
          Navigator.pushNamed(context, '/chat');
          break;
        case 4:
          Navigator.pushNamed(context, '/notification');
          break;
      }
    },
    child: Icon(icon, size: 30),
  );
}

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

class ELearningScreen extends StatelessWidget {
  const ELearningScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D6E84),
        title: Row(
          children: const [
            Icon(Icons.menu_book),
            SizedBox(width: 10),
            Text('E-LEARNING'),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Recent Course',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          _buildCourseItem(context),
          
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'My Course',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          _buildCourseItem(context),
        ],
      ),
    );
  }

  Widget _buildCourseItem(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Top blue section
          Container(
            height: 150,
            decoration: const BoxDecoration(
              color: Color(0xFF0D6E84),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
          ),
          // Course title
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Lorem Ipsum',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MentalHealthScreen extends StatelessWidget {
  const MentalHealthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Top section with header
          Container(
            padding: const EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 20),
            color: const Color(0xFF0D6E84),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    Icon(Icons.favorite, color: Colors.white, size: 30),
                    SizedBox(width: 10),
                    Text(
                      'MENTAL\nHEALTH',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'INFO',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white24,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'CONTACT',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.search, color: Colors.white),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Main content
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildMentalHealthArticle(),
                const SizedBox(height: 16),
                _buildMentalHealthListItem(),
                const SizedBox(height: 16),
                _buildMentalHealthListItem(),
                const SizedBox(height: 16),
                _buildMentalHealthListItem(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMentalHealthArticle() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Top blue section
          Container(
            height: 180,
            decoration: const BoxDecoration(
              color: Color(0xFF0D6E84),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Lorem Ipsum',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer condimentum sapien sit amet nulla hendrerit, in pulvinar dolor laoreet.',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMentalHealthListItem() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: const BoxDecoration(
              color: Color(0xFF0D6E84),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Lorem Ipsum',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer condimentum sapien sit amet nulla hendrerit, in pulvinar dolor laoreet.',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
    );
  }
}

class AkademikScreen extends StatelessWidget {
  const AkademikScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Top section with header
          Container(
            padding: const EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 20),
            color: const Color(0xFF0D6E84),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    Icon(Icons.school, color: Colors.white, size: 30),
                    SizedBox(width: 10),
                    Text(
                      'AKADEMIK',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'MAIN',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white24,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'HISTORY',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Academic stats
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: const Color(0xFF8BC09E),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'SKS',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '68',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: const Color(0xFF0D6E84),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'IPK',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '3.51',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: const Color(0xFFA43B3B),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Semester',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '3',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Grade distribution graph
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'GRAFIK',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  // Here would be the actual chart implementation
                ),
              ],
            ),
          ),
          
          // GPA trend
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'TREN',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  // Here would be the actual chart implementation
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class KeuanganScreen extends StatelessWidget {
  const KeuanganScreen ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F7),
      body: Column(
        children: [
          // Tab navigation
                    Container(
            padding: const EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 20),
            color: const Color(0xFF0D6E84),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    Icon(Icons.account_balance_wallet_outlined, size: 32),
                    SizedBox(width: 10),
                    Text(
                       "FINANCE",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'INFO',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white24,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        "INSIGHT",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Balance
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              children: [
                const Icon(Icons.account_balance_wallet_outlined, size: 32),
                const SizedBox(width: 16),
                const Text(
                  "RP 500.000,00",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          
          // Action buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Row(
              children: [
                Expanded(
                  child: _buildActionButton(
                    label: "TOP UP",
                    icon: Icons.add,
                    onTap: () {},
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildActionButton(
                    label: "PAY",
                    icon: Icons.arrow_upward,
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Row(
              children: [
                Expanded(
                  child: _buildActionButton(
                    label: "REQUEST",
                    icon: Icons.arrow_downward,
                    onTap: () {},
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildActionButton(
                    label: "QR CODE",
                    icon: Icons.qr_code,
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ),
          
          // Checks/Transactions
          const Padding(
            padding: EdgeInsets.fromLTRB(24, 32, 24, 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "CHECK",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          
          // Subscription item
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: _buildTransactionItem(
              icon: 'N',
              title: "NetFlash Subscription",
              amount: "RP 45.000,00",
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: _buildTransactionItem(
              icon: '▶',
              title: "Membership KT",
              amount: "RP 90.000,00",
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildActionButton({
    required String label,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, size: 28),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildTransactionItem({
    required String icon,
    required String title,
    required String amount,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.black, width: 2),
            ),
            child: Center(
              child: Text(
                icon,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  amount,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // App bar
          Container(
            color: const Color(0xFF0B6E8F),
            padding: const EdgeInsets.only(top: 40, left: 16, right: 16, bottom: 8),
            child: Row(
              children: [
                // Logo
                SizedBox(
                  height: 40,
                  child: Row(
                    children: [
                      const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 30,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'SOSIAL',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                // Search icon
                const Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 30,
                ),
              ],
            ),
          ),
          
          // Tab bar
          Container(
            color: const Color(0xFF0B6E8F),
            child: Row(
              children: [
                // PHOTO Tab - Selected
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'PHOTO',
                    style: TextStyle(
                      color: Color(0xFF0B6E8F),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                
                // REELS Tab - Unselected
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  child: const Text(
                    'REELS',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Content - Timeline
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: const [
                PostWidget(username: "loremtimus"),
                SizedBox(height: 8),
                PostWidget(username: "loremtimus", showAddButton: true),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PostWidget extends StatelessWidget {
  final String username;
  final bool showAddButton;
  
  const PostWidget({
    Key? key,
    required this.username,
    this.showAddButton = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User info
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                // Profile picture
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.green[300],
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.person,
                      color: const Color(0xFF0B6E8F),
                      size: 24,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                // Username
                Text(
                  username,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          
          // Post content
          Container(
            height: 300,
            width: double.infinity,
            color: Colors.green[300],
            child: showAddButton 
                ? Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0B6E8F),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                    ),
                  )
                : null,
          ),
        ],
      ),
    );
  }
}

class TaskScreen extends StatelessWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0d7e96),
        title: Row(
          children: [
            const Icon(Icons.calendar_today, color: Colors.white),
            const SizedBox(width: 10),
            const Text('TASK'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Date selector
          Container(
            color: const Color(0xFF0d7e96),
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('24 AUG \'25', style: TextStyle(color: Colors.white70)),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: const Text(
                    'TUE, 25 AUG \'25',
                    style: TextStyle(
                      color: Color(0xFF0d7e96),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Text('WED, 26 AU', style: TextStyle(color: Colors.white70)),
              ],
            ),
          ),
          
          // Hello section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            child: const Text(
              'Hello, Lorem',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          
          // Tasks list
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                buildTaskItem(
                  'Pemrograman Visual Piranti Bergerak',
                  '09.30 - 12.00',
                  'Kelas Reguler',
                  true,
                ),
                buildTaskItem(
                  'Analisis Desain Algoritma',
                  '15.30 - 18.00',
                  'Kelas Reguler',
                  false,
                ),
                buildTaskItem(
                  'Tugas Praktikum 2 DPBO',
                  '23.59',
                  'Tugas',
                  false,
                ),
                buildTaskItem(
                  'Tugas Provis 1',
                  '23.59',
                  'Tugas',
                  false,
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF0d7e96),
        child: const Icon(Icons.add_task),
        onPressed: () {},
      ),
    );
  }

  Widget buildTaskItem(String title, String time, String type, bool isCompleted) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: isCompleted ? Colors.green : Colors.transparent,
                border: Border.all(color: Colors.green),
                shape: BoxShape.circle,
              ),
              child: isCompleted ? const Icon(Icons.check, size: 16, color: Colors.white) : null,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    time,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    type,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade700,
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

class MessageScreen extends StatelessWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F7),
      body: Column(
        children: [
          // Header with MESSAGE title
          Container(
            color: const Color(0xFF006E90),
            padding: const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 0),
            child: Row(
              children: [
                // Mail icon
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: const Icon(
                    Icons.email,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
                const Text(
                  'MESSAGE',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          
          // Tab bar
          Container(
            color: const Color(0xFF006E90),
            child: Row(
              children: [
                // CHAT tab (active)
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  decoration: const BoxDecoration(
                    color: Color(0xFFF2F2F7),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'CHAT',
                    style: TextStyle(
                      color: Color(0xFF006E90),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                
                // GROUP tab
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: const Text(
                      'GROUP',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                
                // Search icon
                Container(
                  padding: const EdgeInsets.all(15),
                  child: const Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
          
          // Chat list
          Expanded(
            child: ListView.builder(
              itemCount: 7,
              itemBuilder: (context, index) {
                return _buildChatItem(
                  number: index == 1 ? '19238489598473593' : '2304724',
                );
              },
            ),
          ),
        ],
      ),
      
      // FAB for new message
      floatingActionButton: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          color: const Color(0xFF006E90),
          borderRadius: BorderRadius.circular(35),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 40,
        ),
      ),
    );
  }

  Widget _buildChatItem({required String number}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        children: [
          // Profile picture
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: const Color(0xFF9AD5B0),
              borderRadius: BorderRadius.circular(40),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Center(
              child: Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                  color: Color(0xFF006E90),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          
          const SizedBox(width: 15),
          
          // Chat info
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Chat number
              Text(
                number,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              
              const SizedBox(height: 5),
              
              // Status with green dot
              Row(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    margin: const EdgeInsets.only(right: 5),
                    decoration: const BoxDecoration(
                      color: Color(0xFF9AD5B0),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const Text(
                    'Lorem Ipsum',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class NotificationScreen extends StatelessWidget {
  const NotificationScreen ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // App Bar
          Container(
            color: const Color(0xFF0A6E8A),
            padding: const EdgeInsets.only(top: 40, bottom: 10),
            child: Row(
              children: [
                const SizedBox(width: 30),
                Row(
                  children: [
                    const Icon(
                      Icons.check_box_outline_blank,
                      color: Colors.white,
                      size: 40,
                    ),
                    Container(
                      width: 12,
                      height: 12,
                      margin: const EdgeInsets.only(left: 20, top: 20),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 15),
                    const Text(
                      'NOTIFIKASI',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                const Text(
                  'ARCHIVE',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 30),
                const Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 35,
                ),
                const SizedBox(width: 20),
              ],
            ),
          ),
          
          // Sub Menu
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                color: const Color(0xFFF2F2F6),
                width: double.infinity,
                height: MediaQuery.of(context).size.height - 100,
              ),
              Positioned(
                top: -20,
                left: 30,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 15,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Text(
                    'UNREAD',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0A6E8A),
                    ),
                  ),
                ),
              ),
              
              // Notification List
              Positioned(
                top: 30,
                left: 0,
                right: 0,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      // First notification
                      _buildNotificationItem(
                        icon: Icons.email,
                        title: 'Lorem Ipsum',
                        subtitle: 'Dolor sit amet',
                      ),
                      const SizedBox(height: 15),
                      
                      // Second notification
                      _buildNotificationItem(
                        icon: Icons.favorite_border,
                        title: 'Lorem Ipsum',
                        subtitle: 'Lorem ipsum dolor sit amet, consectetur...',
                        iconWithPlus: true,
                      ),
                      const SizedBox(height: 15),
                      
                      // Third notification
                      _buildNotificationItem(
                        icon: Icons.people_outline,
                        title: 'Lorem Ipsum',
                        subtitle: 'Dolor sit amet',
                        customIcon: true,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildNotificationItem({
    required IconData icon,
    required String title,
    required String subtitle,
    bool iconWithPlus = false,
    bool customIcon = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        leading: Container(
          width: 60,
          height: 60,
          decoration: const BoxDecoration(
            color: Color(0xFF0A6E8A),
            shape: BoxShape.circle,
          ),
          child: customIcon 
              ? const Center(
                  child: Icon(
                    Icons.people_outline,
                    color: Colors.white,
                    size: 30,
                  ),
                )
              : Stack(
                  children: [
                    Center(
                      child: Icon(
                        icon,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    if (iconWithPlus)
                      Positioned(
                        right: 12,
                        bottom: 12,
                        child: Container(
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xFF0A6E8A),
                              width: 2,
                            ),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.add,
                              color: Color(0xFF0A6E8A),
                              size: 10,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              '99:99',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            const SizedBox(width: 10),
            const Icon(
              Icons.chevron_right,
              color: Colors.grey,
              size: 30,
            ),
          ],
        ),
      ),
    );
  }
}

class QuizScreen extends StatelessWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey[100],
        child: Stack(
          children: [

            
            // Main Content
            SafeArea(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Title
                    const Text(
                      'Quiz 1',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0B6E8F),
                      ),
                    ),
                    const Text(
                      'Kelompok 15',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0B6E8F),
                      ),
                    ),
                    const Text(
                      'Muhammad Akhtar Rizki Ramadha',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0B6E8F),
                      ),
                    ),
                    const Text(
                      'Hanif Ahmad Syauqi',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0B6E8F),
                      ),
                    ),
                    const SizedBox(height: 24),
                    
                    // Navigation Options
                    _buildNavigationButton('Main screen', context),
                    const SizedBox(height: 12),
                    _buildNavigationButton('Mental health screen', context),
                    const SizedBox(height: 12),
                    _buildNavigationButton('Akademik screen', context),
                    const SizedBox(height: 12),
                    _buildNavigationButton('Keuangan screen', context),
                    const SizedBox(height: 12),
                    _buildNavigationButton('Sosial screen', context),
                    const SizedBox(height: 12),
                    _buildNavigationButton('Task screen', context),
                    const SizedBox(height: 12),
                    _buildNavigationButton('Message screen', context),
                    const SizedBox(height: 12),
                    _buildNavigationButton('Notification screen', context),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildNavigationButton(String title, BuildContext context) {
  return ElevatedButton(
    onPressed: () {
      switch (title) {
        case 'Main screen':
          Navigator.pushNamed(context, '/main');
          break;
        case 'Mental health screen':
          Navigator.pushNamed(context, '/mentalhealth');
          break;
        case 'Akademik screen':
          Navigator.pushNamed(context, '/akademik');
          break;
        case 'Keuangan screen':
          Navigator.pushNamed(context, '/keuangan');
          break;
        case 'Sosial screen':
          Navigator.pushNamed(context, '/sosial');
          break;
        case 'Task screen':
          Navigator.pushNamed(context, '/task');
          break;
        case 'Message screen':
          Navigator.pushNamed(context, '/chat');
          break;
        case 'Notification screen':
          Navigator.pushNamed(context, '/notification');
          break;
      }
    },
    child: Text(title),
  );
  }
}