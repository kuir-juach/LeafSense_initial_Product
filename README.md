# LeafSense - South Sudanese Medicinal Plant Identifier

## Description

LeafSense is a mobile deep learning application specifically designed to identify medicinal plants native to South Sudan. More than just plant recognition, the app preserves and shares traditional knowledge by documenting preparation methods, therapeutic uses, and cultural significance of indigenous flora.

### My Mission
Preserving indigenous knowledge, improving healthcare access, and strengthening communities in South Sudan by leveraging deep learning technology to bridge traditional wisdom with modern innovation.

### Context
South Sudan, the world's youngest nation, faces critical healthcare challenges where over 70% of the population relies on traditional medicine as their primary healthcare source. With limited modern health facilities and widespread poverty, communities depend on medicinal plants for treating conditions like malaria, which affects 5.5 million people annually.

However, this invaluable knowledge is under threat due to:
- Disrupted intergenerational knowledge transfer
- Urbanization and modernization
- Lack of written documentation
- Risk of plant misidentification leading to poisoning

### Solution
LeafSense addresses these challenges by providing:
- **Offline plant identification** using deep learning
- **Cultural knowledge preservation** with traditional preparation methods
- **Bilingual support** (English and Arabic)
- **Low-resource optimization** for rural areas
- **User-friendly interface** accessible to all literacy levels

## GitHub Repository


## Environment Setup & Installation

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
- Android (API 21+)
- iOS (12.0+)
- Web (Progressive Web App)

## Design & User Interface

### App Screenshots

#### Onboarding Screens
<div align="center">
  <img src="https://github.com/kuir-juach/LeafSense_initial_Product/blob/master/Screenshot%202025-10-07%20193835.png?raw=true"/>
  <img src="https://github.com/kuir-juach/LeafSense_initial_Product/blob/master/Screenshot%202025-10-07%20193852.png?raw=true" width="250" alt="Features Screen"/>
</div>

#### Main Application
<div align="center">
  <img src="https://github.com/kuir-juach/LeafSense_initial_Product/blob/master/Screenshot%202025-10-07%20193911.png?raw=true" width="250" alt="Home Screen"/>
  <img src="https://github.com/kuir-juach/LeafSense_initial_Product/blob/master/Screenshot%202025-10-07%20200241.png?raw=true" width="250" alt="Prediction Results"/>
  <img src="https://github.com/kuir-juach/LeafSense_initial_Product/blob/master/Screenshot%202025-10-07%20200204.png?raw=true" width="250" alt="History Screen"/>
</div>

#### Settings & Accessibility
<div align="center">
  <img src="https://github.com/kuir-juach/LeafSense_initial_Product/blob/master/Screenshot%202025-10-07%20194629.png?raw=true" width="250" alt="Settings Screen"/>
  <img src="https://github.com/kuir-juach/LeafSense_initial_Product/blob/master/Screenshot%202025-10-07%20200241.png?raw=true

" width="250" alt="Arabic Interface"/>
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





## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.


## 📞 Contact

**Contributor**
- Email: k.thuch@alustudent.com
- Name: Kuir Thuch


---

<div align="center">
  <strong>🌿 Preserving Heritage, Empowering Communities 🌿</strong>
  <br>
  <em>Bridging Traditional Wisdom with Modern Technology</em>
</div>
