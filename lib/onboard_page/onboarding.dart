import 'package:flutter/material.dart';
import 'package:medilink/main.dart';
import 'package:medilink/utils/constants/image_strings.dart';
import 'package:medilink/utils/constants/text_strings.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';



class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingPage> _pages = [
    OnboardingPage(
      image:
          PImage.onBoardingImage1,
      title: PTexts.onBoardingTitle1,
      // highlightedWord: 'wide',
      description:
          PTexts.onBoardingSubTitle1,
      buttonText: 'Get Started',
    ),
    OnboardingPage(
      image:PImage.onBoardingImage2,
      title: PTexts.onBoardingTitle2,
     
      description:PTexts.onBoardingSubTitle2,
      buttonText: 'Next',
    ),
    OnboardingPage(
      image:PImage.onBoardingImage3,
      title: PTexts.onBoardingTitle3,
     
      description:PTexts.onBoardingSubTitle3,
      buttonText: 'Next',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _handleNext() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else if (context.mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const AuthCheckScreen()),
        );
      }else {
      debugPrint('print to home screen');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _pages.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return _buildPage(_pages[index]);
            },
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Column(
              children: [
                // Next Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ElevatedButton(
                    onPressed: _handleNext,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      _pages[_currentPage].buttonText,
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Page Indicator
                SmoothPageIndicator(
                  controller: _pageController,
                  count: _pages.length,
                  effect: const SwapEffect(
                    dotHeight: 6,
                    dotWidth: 6,
                    activeDotColor: Colors.blue,
                    dotColor: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPage(OnboardingPage page) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          SizedBox(height: 60,)
          ,Padding(
            padding: const EdgeInsets.all(8.0),
            child: Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(page.image, fit: BoxFit.cover),
              ),
            ),
          ),
          const SizedBox(height: 30),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: const TextStyle(
                fontSize: 24,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              children: [
                TextSpan(text: page.title),
                
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text(
            page.description,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 100), // Space for bottom buttons
        ],
      ),
    );
  }
}



class OnboardingPage {
  final String image;
  final String title;
  // final String highlightedWord;
  final String description;
  final String buttonText;

  OnboardingPage({
    required this.image,
    required this.title,
    // required this.highlightedWord,
    required this.description,
    required this.buttonText,
  });
}
