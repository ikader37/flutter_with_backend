# Flutter With Backend 🚀

Application mobile développée avec **Flutter** dans le cadre d'un projet d'apprentissage de l'architecture logicielle, de la consommation d'API REST, de l'authentification Firebase et de la persistance locale.

L'application permet notamment de consulter des actualités provenant d'une API distante, de gérer l'authentification des utilisateurs et de conserver certaines données localement afin d'améliorer l'expérience utilisateur.

---

## 📱 Présentation

**Flutter With Backend** est une application Flutter organisée autour d'une architecture modulaire et maintenable.

Le projet met en œuvre plusieurs concepts importants du développement Flutter moderne :

* 📰 Consommation d'une API REST d'actualités
* 🔐 Authentification avec Firebase
* 💾 Stockage local avec Hive
* 🌐 Communication HTTP avec Dio
* 🧠 Gestion d'état avec BLoC
* 🏗️ Clean Architecture
* 🧭 Navigation avec GoRouter
* 🧪 Tests unitaires
* 🔒 Stockage sécurisé des informations d'authentification
* 📱 Interface adaptée aux différentes tailles d'écran

---

## ✨ Fonctionnalités

### 🔐 Authentification

L'application permet à l'utilisateur de :

* créer un compte ;
* se connecter ;
* se déconnecter ;
* récupérer les informations de son compte ;
* consulter son profil ;
* conserver son état d'authentification ;
* accéder automatiquement à l'application lorsqu'une session valide existe.

L'authentification repose sur **Firebase Authentication**.

---

### 📰 Actualités

L'application récupère les actualités depuis une API REST.

Les fonctionnalités principales sont :

* affichage des actualités principales ;
* recherche d'articles ;
* consultation de toutes les actualités ;
* consultation des sources ;
* pagination ;
* gestion des états `loading`, `success` et `error`.

Les requêtes HTTP sont réalisées avec **Dio**.

---

### 💾 Persistance locale

**Hive** est utilisé pour conserver localement certaines données récupérées depuis l'API.

L'objectif est notamment de permettre :

* la consultation de données déjà récupérées ;
* la réduction des appels réseau inutiles ;
* une meilleure expérience en cas de connexion instable ;
* la séparation entre les données distantes et les données locales.

---

## 🏗️ Architecture

Le projet suit une approche basée sur la **Clean Architecture**.

L'organisation générale peut être représentée ainsi :

```text
lib/
│
├── core/
│   ├── network/
│   ├── storage/
│   ├── errors/
│   └── ...
│
├── features/
│   ├── auth/
│   │   ├── data/
│   │   │   ├── datasource/
│   │   │   ├── models/
│   │   │   └── repositories/
│   │   │
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   ├── repositories/
│   │   │   └── usecases/
│   │   │
│   │   └── presentation/
│   │       ├── bloc/
│   │       ├── pages/
│   │       └── widgets/
│   │
│   └── news/
│       ├── data/
│       │   ├── datasource/
│       │   ├── models/
│       │   └── repositories/
│       │
│       ├── domain/
│       │   ├── entities/
│       │   ├── repositories/
│       │   └── usecases/
│       │
│       └── presentation/
│           ├── bloc/
│           ├── pages/
│           └── widgets/
│
└── main.dart
```

### Principe de fonctionnement

```text
             ┌──────────────────┐
             │   Presentation   │
             │  Pages / Widgets │
             └────────┬─────────┘
                      │
                      ▼
             ┌──────────────────┐
             │       BLoC       │
             │  Events/States   │
             └────────┬─────────┘
                      │
                      ▼
             ┌──────────────────┐
             │     UseCases     │
             └────────┬─────────┘
                      │
                      ▼
             ┌──────────────────┐
             │   Repository     │
             │    Interface     │
             └────────┬─────────┘
                      │
              ┌───────┴────────┐
              ▼                ▼
       ┌─────────────┐  ┌─────────────┐
       │ Remote Data │  │ Local Data  │
       │    Source   │  │    Source   │
       └──────┬──────┘  └──────┬──────┘
              │                │
              ▼                ▼
          ┌───────┐         ┌───────┐
          │ Dio   │         │ Hive  │
          └───────┘         └───────┘
```

Cette séparation permet de limiter le couplage entre l'interface utilisateur, la logique métier et les sources de données.

---

## 🧠 Gestion d'état avec BLoC

Le projet utilise **BLoC** pour gérer les états de l'application.

Par exemple, la fonctionnalité des actualités peut suivre le cycle :

```text
User Action
     │
     ▼
   Event
     │
     ▼
    BLoC
     │
     ▼
  UseCase
     │
     ▼
 Repository
     │
 ┌───┴───────────┐
 ▼               ▼
API             Hive
 │               │
 └───────┬───────┘
         ▼
       State
         │
         ▼
       UI
```

Les états permettent notamment de gérer :

```text
Initial
Loading
Success
Error
```

---

## 🌐 API

L'application utilise une API REST pour récupérer les actualités.

Les appels sont réalisés avec `Dio`.

Exemple de configuration :

```dart
final dio = Dio(
  BaseOptions(
    baseUrl: 'https://newsapi.org/v2/',
  ),
);
```

Les requêtes peuvent notamment être utilisées pour récupérer :

* les principales actualités ;
* toutes les actualités ;
* les sources disponibles.

> ⚠️ La clé API ne doit jamais être commitée directement dans le dépôt Git.

Il est recommandé d'utiliser une variable d'environnement, un fichier de configuration non versionné ou un mécanisme sécurisé adapté à l'environnement de déploiement.

---

## 🔐 Firebase Authentication

Firebase Authentication est utilisé pour gérer les comptes utilisateurs.

Le projet prend notamment en charge :

```text
Register
   │
   ▼
Firebase Authentication
   │
   ▼
User authenticated
   │
   ▼
Application
```

Les informations nécessaires à la session peuvent également être conservées de manière sécurisée.

---

## 🔒 Stockage sécurisé

Les informations sensibles liées à l'authentification ne doivent pas être stockées directement dans Hive ou dans des préférences classiques.

Le projet peut utiliser `FlutterSecureStorage` pour conserver les informations sensibles.

Exemple :

```dart
const storage = FlutterSecureStorage();

await storage.write(
  key: 'access_token',
  value: token,
);
```

Puis :

```dart
final token = await storage.read(
  key: 'access_token',
);
```

---

## 💾 Hive

Hive est utilisé comme solution de stockage local.

Les données peuvent être séparées selon leur fonctionnalité :

```text
Hive
│
├── headlines
├── all
└── sources
```

Cette séparation permet d'avoir un cache local indépendant pour les différentes catégories d'actualités.

---

## 🧭 Navigation

La navigation est réalisée avec **GoRouter**.

Les principales destinations de l'application sont organisées autour de pages telles que :

```text
/
├── login
├── register
├── profile
├── headlines
├── all
└── sources
```

La navigation permet également de protéger certaines routes en fonction de l'état d'authentification de l'utilisateur.

---

## 🛠️ Technologies utilisées

| Technologie            | Utilisation                    |
| ---------------------- | ------------------------------ |
| Flutter                | Framework mobile               |
| Dart                   | Langage                        |
| BLoC                   | Gestion d'état                 |
| Firebase Auth          | Authentification               |
| Dio                    | Client HTTP                    |
| Hive                   | Base de données locale / cache |
| Flutter Secure Storage | Stockage sécurisé              |
| GoRouter               | Navigation                     |
| Mockito                | Tests et mocks                 |
| Flutter Test           | Tests unitaires                |

---

## 📦 Installation

### 1. Cloner le projet

```bash
git clone https://github.com/ikader37/flutter_with_backen.git
```

Puis :

```bash
cd flutter_with_backen
```

---

### 2. Installer les dépendances

```bash
flutter pub get
```

---

### 3. Vérifier l'environnement Flutter

```bash
flutter doctor
```

Vérifiez que Flutter, Android Studio/Xcode et les outils nécessaires sont correctement configurés.

---

### 4. Configurer Firebase

Le projet nécessite une configuration Firebase.

Pour Android, ajouter le fichier :

```text
android/app/google-services.json
```

Pour iOS :

```text
ios/Runner/GoogleService-Info.plist
```

Puis vérifier que Firebase est correctement initialisé dans l'application.

> Ne publiez pas de fichiers contenant des secrets ou des credentials sensibles dans un dépôt public.

---

### 5. Configurer la clé News API

Si l'application utilise NewsAPI, configurez votre clé API selon le mécanisme de configuration prévu par le projet.

Exemple :

```text
NEWS_API_KEY=xxxxxxxxxxxxxxxx
```

Évitez de placer directement la clé dans le code source.

---

## ▶️ Lancer l'application

Pour lancer l'application sur un appareil ou un émulateur :

```bash
flutter run
```

Pour vérifier les appareils disponibles :

```bash
flutter devices
```

---

## 🧪 Tests

Le projet contient des tests permettant notamment de vérifier les composants de la couche Data.

Pour lancer tous les tests :

```bash
flutter test
```

Pour lancer un fichier de test spécifique :

```bash
flutter test test/remote_articles_test.dart
```

Pour générer les fichiers Mockito lorsque le projet utilise la génération de mocks :

```bash
dart run build_runner build --delete-conflicting-outputs
```

---

## 🔄 Génération de code

Lorsque le projet utilise des générateurs Dart, exécuter :

```bash
dart run build_runner build --delete-conflicting-outputs
```

Pour travailler en mode automatique :

```bash
dart run build_runner watch --delete-conflicting-outputs
```

---

## 📂 Flux de données

Lorsqu'un utilisateur demande des actualités :

```text
UI
 │
 ▼
NewsBloc
 │
 ▼
TopHeadlinesUseCase
 │
 ▼
ArticleRepository
 │
 ▼
Local / Remote DataSource
 │
 ├───────────────┐
 ▼               ▼
Hive            Dio
 │               │
 │          News API
 │               │
 └───────┬───────┘
         ▼
       Entity
         │
         ▼
       BLoC
         │
         ▼
         UI
```

L'utilisation d'une source locale et d'une source distante permet de mettre en place progressivement une stratégie de cache.

---

## 🎯 Objectifs pédagogiques

Ce projet a notamment pour objectif de mettre en pratique :

* la Clean Architecture ;
* les principes SOLID ;
* l'injection de dépendances ;
* la séparation Data / Domain / Presentation ;
* la gestion d'état avec BLoC ;
* la consommation d'une API REST ;
* l'authentification Firebase ;
* la persistance locale avec Hive ;
* le stockage sécurisé ;
* la navigation déclarative avec GoRouter ;
* les tests unitaires et les mocks.

---


---

## 📌 Prérequis

Avant de lancer le projet, il est recommandé d'avoir :

* Flutter installé ;
* Dart installé ;
* Android Studio ou Xcode ;
* un émulateur ou un appareil physique ;
* un projet Firebase configuré ;
* une clé API NewsAPI valide.

---

## 👨‍💻 Auteur

**Abdoul Kader IKADER**

Projet Flutter personnel / pédagogique.

GitHub :

[https://github.com/ikader37](https://github.com/ikader37?utm_source=chatgpt.com)

Dépôt du projet :

[flutter_with_backen](https://github.com/ikader37/flutter_with_backen.git?utm_source=chatgpt.com)

---

## 📄 Licence

Ce projet est destiné principalement à un usage pédagogique et expérimental.

La licence peut être adaptée selon les besoins du projet.
