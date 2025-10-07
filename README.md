# 🌿 LeafSense - South Sudanese Medicinal Plant Identifier

![LeafSense Logo](assets/logo.png)

## 📖 Description

LeafSense is a mobile deep learning application specifically designed to identify medicinal plants native to South Sudan. More than just plant recognition, the app preserves and shares traditional knowledge by documenting preparation methods, therapeutic uses, and cultural significance of indigenous flora.

### 🎯 Mission
Preserving indigenous knowledge, improving healthcare access, and strengthening communities in South Sudan by leveraging deep learning technology to bridge traditional wisdom with modern innovation.

### 🌍 Context
South Sudan, the world's youngest nation, faces critical healthcare challenges where over 70% of the population relies on traditional medicine as their primary healthcare source. With limited modern health facilities and widespread poverty, communities depend on medicinal plants for treating conditions like malaria, which affects 5.5 million people annually.

However, this invaluable knowledge is under threat due to:
- Disrupted intergenerational knowledge transfer
- Urbanization and modernization
- Lack of written documentation
- Risk of plant misidentification leading to poisoning

### 🚀 Solution
LeafSense addresses these challenges by providing:
- **Offline plant identification** using deep learning
- **Cultural knowledge preservation** with traditional preparation methods
- **Bilingual support** (English and Arabic)
- **Low-resource optimization** for rural areas
- **User-friendly interface** accessible to all literacy levels

## 🔗 GitHub Repository
[https://github.com/yourusername/leafsense-app](https://github.com/yourusername/leafsense-app)

## 🛠️ Environment Setup & Installation

### Prerequisites
- Flutter SDK (3.0.0 or higher)
- Dart SDK (2.17.0 or higher)
- Android Studio / VS Code
- Git

### Installation Steps

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/leafsense-app.git
   cd leafsense-app
   ```

2. **Install Flutter dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure development environment**
   ```bash
   flutter doctor
   ```

4. **Run the application**
   ```bash
   flutter run
   ```

### Dependencies
```yaml
dependencies:
  flutter:
    sdk: flutter
  image_picker: ^0.8.7+5
  flutter/foundation: ^0.0.0
  flutter/services: ^0.0.0
```

### Platform Support
- ✅ Android (API 21+)
- ✅ iOS (12.0+)
- ✅ Web (Progressive Web App)

## 🎨 Design & User Interface

### App Screenshots

#### Onboarding Screens
<div align="center">
  <img src="screenshots/onboarding_1.png" width="250" alt="Welcome Screen"/>
  <img src="screenshots/onboarding_2.png" width="250" alt="Features Screen"/>
</div>

#### Main Application
<div align="center">
  <img src="screenshots/home_screen.png" width="250" alt="Home Screen"/>
  <img src="screenshots/prediction_result.png" width="250" alt="Prediction Results"/>
  <img src="screenshots/history_screen.png" width="250" alt="History Screen"/>
</div>

#### Settings & Accessibility
<div align="center">
  <img src="screenshots/settings_screen.png" width="250" alt="Settings Screen"/>
  <img src="screenshots/arabic_interface.png" width="250" alt="Arabic Interface"/>
</div>

### Design System

#### Color Palette
- **Primary Green**: `#00652E` (RGB: 0, 101, 46)
- **Light Green**: `#F1F8E9` (Background)
- **Dark Theme**: `#121212` (Background), `#1E1E1E` (Cards)
- **Text Colors**: `#212121` (Primary), `#757575` (Secondary)

#### Typography
- **Headers**: 28px, Bold
- **Body Text**: 16px (Adjustable: 12-24px)
- **Captions**: 14px
- **Font Families**: Default, Roboto, Arial, Times New Roman, Courier New

#### Key Features
- 🌙 **Dark/Light Mode Toggle**
- 🔤 **Adjustable Font Sizes** (Accessibility)
- 🌐 **Bilingual Interface** (English/Arabic)
- 📱 **Responsive Design** for various screen sizes

### Figma Mockups
[View Complete Design System](https://figma.com/file/leafsense-design-system)

## 🚀 Deployment Plan

### Phase 1: Development & Testing (Months 1-3)
- ✅ Core app development
- ✅ UI/UX implementation
- ✅ Offline functionality
- 🔄 Deep learning model integration
- 🔄 Comprehensive testing

### Phase 2: Beta Release (Month 4)
- 📱 **Android Beta**: Google Play Console Internal Testing
- 🍎 **iOS Beta**: TestFlight Distribution
- 🌐 **Web Beta**: Firebase Hosting
- 👥 **Target**: 50 beta testers in South Sudan

### Phase 3: Production Release (Month 5)
- 📱 **Google Play Store**: Android release
- 🍎 **Apple App Store**: iOS release
- 🌐 **Progressive Web App**: Offline-capable web version
- 📊 **Analytics**: Firebase Analytics integration

### Phase 4: Distribution & Outreach (Month 6+)
- 🏥 **Healthcare Centers**: Partnership with local clinics
- 🎓 **Educational Institutions**: University and school programs
- 👥 **Community Leaders**: Traditional healers and elders
- 📻 **Media Campaign**: Radio and community outreach

### Technical Infrastructure

#### Hosting & Backend
- **Frontend**: Firebase Hosting (Web), App Stores (Mobile)
- **Analytics**: Firebase Analytics
- **Crash Reporting**: Firebase Crashlytics
- **Performance**: Firebase Performance Monitoring

#### Offline Capabilities
- **Local Storage**: SQLite database for plant information
- **Image Processing**: On-device TensorFlow Lite model
- **Sync**: Background synchronization when online

#### Security & Privacy
- **Data Protection**: Local data encryption
- **Privacy**: No personal data collection
- **Permissions**: Camera access only when needed

### Success Metrics
- 📈 **Downloads**: 10,000+ in first 6 months
- ⭐ **Rating**: 4.5+ stars on app stores
- 🎯 **Accuracy**: 90%+ plant identification accuracy
- 👥 **Engagement**: 70%+ monthly active users
- 🌍 **Reach**: Coverage in all 10 South Sudan states

## 🤝 Contributing

We welcome contributions from developers, botanists, traditional healers, and community members!

### How to Contribute
1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Areas for Contribution
- 🌱 **Plant Database**: Adding new medicinal plants
- 🔬 **ML Model**: Improving identification accuracy
- 🌐 **Localization**: Additional language support
- 📚 **Documentation**: Traditional knowledge documentation
- 🎨 **Design**: UI/UX improvements

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- **Traditional Healers** of South Sudan for sharing their knowledge
- **World Health Organization** for traditional medicine research
- **Flutter Community** for open-source contributions
- **University Supervisors** for academic guidance

## 📞 Contact

**Project Team**
- Email: leafsense@example.com
- GitHub: [@leafsense-team](https://github.com/leafsense-team)

**Academic Institution**
- University of Juba, South Sudan
- Department of Computer Science

---

<div align="center">
  <strong>🌿 Preserving Heritage, Empowering Communities 🌿</strong>
  <br>
  <em>Bridging Traditional Wisdom with Modern Technology</em>
</div>
