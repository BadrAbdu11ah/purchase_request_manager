# 📱 Purchase Request Manager - Full Stack Project

<div align="center">

![Build Status](https://img.shields.io/badge/build-passing-brightgreen)
![Flutter](https://img.shields.io/badge/Flutter-3.8+-blue)
![Dart](https://img.shields.io/badge/Dart-3.8+-green)
![Laravel](https://img.shields.io/badge/Laravel-12.0+-red)
![License](https://img.shields.io/badge/license-MIT-purple)
![Platform](https://img.shields.io/badge/platform-Android%20%7C%20iOS-lightgrey)
![Backend API](https://img.shields.io/badge/Backend-Available-green)

> نظام إدارة طلبات الشراء الكامل - Flutter Frontend + Laravel API Backend

---

## 🔗 أجزاء المشروع

| الجزء | التقنية | المسار | الوصف |
|------|--------|-------|-------|
| **Frontend** 📱 | Flutter/Dart | `C:\Users\HP\StudioProjects\purchase_request_manager` | تطبيق الجوال الكامل |
| **Backend** 🛒 | Laravel 12 | [purchase-request-api](https://github.com/BadrAbdu11ah/purchase-request-api) | API RESTful متقدمة |

---

## 📌 ملاحظة مهمة
هذا المشروع جزء من **نظام إدارة طلبات الشراء الكامل**. تأكد من تثبيت وتشغيل **Backend API** أولاً قبل تشغيل التطبيق!

[الميزات](#-الميزات) • [التقنيات](#-التقنيات-المستخدمة) • [التثبيت](#-التثبيت) • [المعمارية](#-المعمارية) • [الكود](#-هيكل-المشروع) • [Backend](#-backend-api)

</div>

---

## 📸 لقطات الشاشة

<div align="center">
  <table>
    <tr>
      <td><img src="./assets/screenshots/screenshot1.png" width="250" alt="الشاشة الأولى"/></td>
      <td><img src="./assets/screenshots/screenshot2.png" width="250" alt="الشاشة الثانية"/></td>
      <td><img src="./assets/screenshots/screenshot3.png" width="250" alt="الشاشة الثالثة"/></td>
    </tr>
  </table>
  
  > أضيف لقطات الشاشة في مجلد `assets/screenshots/`
</div>

---

## 🚀 نبذة عن المشروع

**Purchase Request Manager** تطبيق متقدم لإدارة طلبات الشراء يجمع بين أفضل الممارسات في تطوير تطبيقات الجوال. تم بناؤه باستخدام معمارية نظيفة وقابلة للتوسع مع التركيز على الأداء والأمان وتجربة المستخدم.

### المميزات الرئيسية ✨
- ✅ **نظام الطلبات المتقدم** - إنشاء وتتبع وإدارة طلبات الشراء
- ✅ **المصادقة الآمنة** - تخزين آمن للبيانات باستخدام Secure Storage
- ✅ **إدارة الفئات والمنتجات** - تصنيف وتنظيم المنتجات بكفاءة
- ✅ **التحقق من الاتصال** - معالجة ذكية لحالات عدم الاتصال
- ✅ **معمارية نظيفة** - كود منظم وسهل الصيانة والتطوير
- ✅ **دعم نمطي** - دعم الأنماط المختلفة (Light/Dark)
- ✅ **أداء عالي** - تحسين الأداء والذاكرة

---

## 🛠 التقنيات المستخدمة

<div align="center">

| الفئة | التقنية | الوصف |
|------|--------|-------|
| **Framework** | ![Flutter](https://img.shields.io/badge/Flutter-3.8+-blue) | إطار عمل متعدد المنصات |
| **اللغة** | ![Dart](https://img.shields.io/badge/Dart-3.8+-green) | لغة البرمجة الأساسية |
| **إدارة الحالة** | ![GetX](https://img.shields.io/badge/GetX-4.7+-orange) | إدارة حالة متقدمة وـ Routing |
| **البرمجة الوظيفية** | ![Dartz](https://img.shields.io/badge/Dartz-0.10+-purple) | Functional Programming |
| **الشبكة** | ![HTTP](https://img.shields.io/badge/HTTP-1.5+-blue) | طلبات HTTP RESTful |
| **الأمان** | ![Flutter Secure Storage](https://img.shields.io/badge/Secure%20Storage-9.2+-red) | تخزين آمن للبيانات الحساسة |
| **الاتصالية** | ![Connection Checker](https://img.shields.io/badge/Connection%20Checker-2.7+-green) | التحقق من حالة الاتصال |

</div>

---

## 🏗 المعمارية

```
نمط MVVM + Clean Architecture
├── Presentation Layer (UI)
│   ├── Pages / Screens
│   └── Widgets / Components
├── Domain Layer (Business Logic)
│   ├── Entities
│   ├── Repositories (Interfaces)
│   └── Use Cases
└── Data Layer (Data Sources)
    ├── Models
    ├── API Services
    └── Local Storage
```

### المميزات المعمارية:
- 🎯 **Separation of Concerns** - فصل واضح بين الطبقات
- 🔄 **Dependency Injection** - الحقن التلقائي للاعتماديات عبر GetX
- 🧪 **قابلية الاختبار** - تصميم يسهل كتابة الاختبارات
- 📦 **قابلية إعادة الاستخدام** - مكونات قابلة للتوسع

---

## 📂 هيكل المشروع

```
lib/
├── main.dart                          # نقطة الدخول الرئيسية
├── app_route.dart                     # تعريف المسارات والـ Navigation
├── app/
│   └── app_binding.dart               # حقن الاعتماديات
├── constant/
│   ├── api_endpoints.dart             # نقاط نهاية API
│   └── app_route.dart                 # ثوابت المسارات
├── core/
│   ├── class/                         # الفئات الأساسية المشتركة
│   └── function/                      # الدوال المساعدة
├── features/                          # الميزات الرئيسية
│   ├── admin/                         # ميزات المسؤول
│   ├── auth/                          # نظام المصادقة
│   └── user/                          # ميزات المستخدم
├── model/                             # نماذج البيانات
│   ├── category_model.dart
│   ├── product_model.dart
│   ├── user_model.dart
│   └── order/
├── services/                          # الخدمات
│   ├── api_service.dart               # خدمة API
│   └── order_service.dart             # خدمة الطلبات
└── test/                              # الاختبارات

```

---

## 📋 المتطلبات

- **Flutter**: 3.8.1 أو أحدث
- **Dart**: 3.8 أو أحدث
- **Android**: API Level 21+
- **iOS**: 12.0+

---

## ⚠️ قبل البدء - تثبيت Backend

تأكد من تثبيت وتشغيل Backend API أولاً:

```bash
# استنساخ مشروع Backend
git clone https://github.com/BadrAbdu11ah/purchase-request-api.git
cd purchase-request-api
composer install
cp .env.example .env
php artisan key:generate
php artisan migrate
php artisan serve
```

سيعمل Backend على: `http://localhost:8000`

---

## 📥 التثبيت والتشغيل - Frontend

### 1️⃣ استنساخ المشروع
```bash
git clone https://github.com/BadrAbdu11ah/purchase_request_manager.git
cd purchase_request_manager
```

### 2️⃣ تثبيت الاعتماديات
```bash
flutter pub get
```

### 3️⃣ تشغيل التطبيق
```bash
# تشغيل عام
flutter run

# تشغيل مع نمط محدد
flutter run --release
```

### 4️⃣ بناء APK/IPA
```bash
# بناء APK (Android)
flutter build apk --release

# بناء IPA (iOS)
flutter build ios --release
```

---

## 🔧 الإعدادات والمتغيرات

### ملف `pubspec.yaml`
```yaml
environment:
  sdk: ^3.8.1

dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  dartz: ^0.10.1                    # Functional Programming
  flutter_secure_storage: ^9.2.4    # التخزين الآمن
  http: ^1.5.0                      # طلبات HTTP
  internet_connection_checker_plus: ^2.7.2  # فحص الاتصال
  get: ^4.7.2                       # إدارة الحالة و Routing
```

---

## 🔐 الأمان

- ✅ **Secure Storage** - تخزين آمن للتوكنات والبيانات الحساسة
- ✅ **HTTPS Only** - اتصالات آمنة مع الخادم
- ✅ **Input Validation** - التحقق من المدخلات
- ✅ **Error Handling** - معالجة آمنة للأخطاء

---

## 📡 التكامل مع API

التطبيق يدعم التكامل السلس مع API RESTful:

```dart
// مثال على استدعاء API
final response = await apiService.getOrders();
```

تحديث نقاط النهاية في: `lib/constant/api_endpoints.dart`

---

## 🧪 الاختبارات

```bash
# تشغيل جميع الاختبارات
flutter test

# تشغيل اختبار محدد
flutter test test/widget_test.dart

# الاختبارات مع التغطية
flutter test --coverage
```

---

## 📊 النسخ والبيانات

- **النسخة الحالية**: 1.0.0
- **الحالة**: في التطوير النشط
- **آخر تحديث**: 2024

---

## 🤝 المساهمة

نرحب بالمساهمات! يرجى:

1. Fork المشروع
2. إنشاء فرع للميزة الجديدة (`git checkout -b feature/AmazingFeature`)
3. Commit التغييرات (`git commit -m 'Add some AmazingFeature'`)
4. Push إلى الفرع (`git push origin feature/AmazingFeature`)
5. فتح Pull Request

---

## 📝 الترخيص

هذا المشروع مرخص تحت رخصة MIT - انظر ملف [LICENSE](LICENSE) للمزيد من التفاصيل.

---

## 🌐 Backend API

للمزيد من المعلومات عن Backend API:

👉 **[اضغط هنا لرؤية توثيق Backend](https://github.com/BadrAbdu11ah/purchase-request-api)**

---

## 📧 التواصل

لأي استفسارات أو اقتراحات:

- 📬 البريد الإلكتروني: Badrhaje2@gmail.com
- 💼 LinkedIn: [Badr Haje](https://www.linkedin.com/in/badr-haje-21073a39b)
- 🐙 GitHub Frontend: [purchase_request_manager](https://github.com/BadrAbdu11ah/purchase_request_manager)
- 🐙 GitHub Backend: [purchase-request-api](https://github.com/BadrAbdu11ah/purchase-request-api)

---

## 🙏 شكر وتقدير

شكر خاص لمجتمع Flutter والمشاريع مفتوحة المصدر التي استخدمناها.

---

<div align="center">

**⭐ إذا أعجبك المشروع، لا تنسَ إضافة نجمة!**

[Back to top ⬆️](#-purchase-request-manager)

</div>
