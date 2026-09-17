# Flutter With Backend 🚀

Application mobile développée avec **Flutter** dans le cadre d'un projet d'apprentissage de la **Clean Architecture**, de la consommation d'API REST, de l'authentification Firebase, de la gestion d'état avec BLoC et de la persistance locale avec Hive.

L'application permet de consulter des actualités provenant de **NewsAPI**, de rechercher des articles, de consulter les sources disponibles, de gérer l'authentification des utilisateurs et de consulter les données précédemment récupérées même lorsque le réseau est indisponible.

---

## 📱 Fonctionnalités

### 🔐 Authentification

L'application utilise **Firebase Authentication** pour gérer les utilisateurs.

Fonctionnalités disponibles :

* Création de compte
* Connexion
* Déconnexion
* Consultation du profil utilisateur
* Récupération de l'adresse e-mail de l'utilisateur connecté
* Conservation sécurisée du token d'authentification
* Redirection automatique selon l'état d'authentification
* Protection des routes nécessitant une authentification

Les informations sensibles liées à l'authentification sont conservées avec `FlutterSecureStorage`.

---

### 📰 Actualités

L'application utilise **NewsAPI** pour récupérer les actualités.

Fonctionnalités :

* 📰 Top Headlines
* 🔎 Recherche d'articles
* 🌍 Consultation de toutes les actualités
* 🗂️ Consultation des sources
* 📄 Pagination
* 🔄 Actualisation des données
* ⏳ Gestion de l'état de chargement
* ❌ Gestion des erreurs réseau
* 💾 Mise en cache locale

Les requêtes HTTP sont effectuées avec **Dio**.

---

## 🌐 Gestion des erreurs réseau

Les erreurs réseau sont interceptées au niveau de la couche Data/Repository.

Les erreurs Dio telles que :

* absence de connexion Internet ;
* timeout de connexion ;
* timeout de réception ;
* erreur HTTP ;
* serveur indisponible ;

sont transformées en messages compréhensibles pour l'utilisateur.

Exemples de messages :

```text
Impossible de se connecter à Internet.

La connexion a pris trop de temps.

Le serveur a rencontré un problème.

Une erreur réseau est survenue.
```

Le BLoC expose ensuite un état d'erreur permettant à l'interface d'afficher le message à l'utilisateur, notamment via un `SnackBar` ou un état d'erreur dédié.

---

# 💾 Mode hors-ligne

L'application utilise **Hive CE** comme cache local.

Les données récupérées depuis NewsAPI sont enregistrées localement après une récupération réussie.

Le fonctionnement est le suivant :

```text
                    ┌─────────────────┐
                    │    Utilisateur  │
                    └────────┬────────┘
                             │
                             ▼
                    ┌─────────────────┐
                    │      BLoC       │
                    └────────┬────────┘
                             │
                             ▼
                    ┌─────────────────┐
                    │   Repository    │
                    └────────┬────────┘
                             │
                    ┌────────┴────────┐
                    │                 │
                    ▼                 ▼
              ┌───────────┐     ┌───────────┐
              │ NewsAPI   │     │    Hive   │
              │   Dio     │     │   Cache   │
              └─────┬─────┘     └─────┬─────┘
                    │                 │
                    │ succès          │ fallback
                    ▼                 ▼
              ┌──────────────────────────┐
              │     ArticleEntity        │
              └────────────┬─────────────┘
                           │
                           ▼
                          UI
```

### Lorsque Internet fonctionne

```text
NewsAPI
   ↓
RemoteDataSource
   ↓
ArticleRepository
   ↓
Sauvegarde Hive
   ↓
ArticleEntity
   ↓
BLoC
   ↓
UI
```

### Lorsque Internet est indisponible

```text
NewsAPI
   ↓
Erreur réseau
   ↓
ArticleRepository
   ↓
Lecture du cache Hive
   ↓
ArticleLocalModel
   ↓
ArticleEntity
   ↓
BLoC
   ↓
UI
```

Ainsi, les dernières données disponibles peuvent continuer à être affichées lorsque l'API n'est pas accessible.

Si aucune donnée locale n'est disponible, l'application affiche un message d'erreur à l'utilisateur.

---

## 🗃️ Organisation des données Hive

Les données locales sont séparées dans plusieurs boxes :

```text
Hive
│
├── articles
├── headlines
└── sources
```

Les modèles locaux utilisent des `TypeAdapter` Hive afin de permettre leur sérialisation et leur désérialisation.

Exemple :

```dart
@HiveType(typeId: 1)
class SourceLocalModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;
}
```

Les adapters sont générés avec `build_runner`.

---

# 🏗️ Architecture

Le projet suit les principes de la **Clean Architecture**.

```text
lib/
│
├── core/
│   ├── errors/
│   ├── network/
│   ├── storage/
│   └── ...
│
├── features/
│   │
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

---

## 🔄 Flux de données

```text
UI
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
 ├───────────────┐
 ▼               ▼
Remote          Local
DataSource      DataSource
 │               │
 ▼               ▼
Dio             Hive
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

Cette séparation permet de maintenir une séparation claire entre :

* présentation ;
* logique métier ;
* accès aux données ;
* API distante ;
* stockage local.

---

# 🧠 Gestion d'état avec BLoC

La gestion d'état est assurée par **flutter_bloc**.

Le cycle principal est :

```text
Event
  ↓
BLoC
  ↓
UseCase
  ↓
Repository
  ↓
DataSource
  ↓
Result
  ↓
State
  ↓
UI
```

Les états prennent notamment en compte :

```text
Initial
Loading
Success
Error
```

Les erreurs réseau sont remontées au BLoC afin d'être affichées dans l'interface utilisateur.

---

# 🌐 API NewsAPI

L'application utilise l'API REST de NewsAPI.

Base URL :

```text
https://newsapi.org/v2/
```

Endpoints utilisés selon les fonctionnalités :

```text
/top-headlines
/everything
/top-headlines/sources
```

La communication HTTP est réalisée avec Dio.

---

# 🔑 Configuration de NewsAPI

Une clé API NewsAPI est nécessaire pour utiliser les fonctionnalités d'actualités.

Vous pouvez obtenir une clé depuis le site officiel de NewsAPI :

[NewsAPI](https://newsapi.org/?utm_source=chatgpt.com)

### ⚠️ Sécurité

Ne commitez jamais votre clé API dans Git :

```dart
apiKey: 'ma-cle-secrete'
```

Utilisez plutôt le mécanisme de configuration prévu par votre environnement et assurez-vous que les fichiers contenant des secrets ne sont pas versionnés.

---

# 🔥 Configuration Firebase

Le projet utilise Firebase Authentication.

Avant de lancer l'application, créez/configurez un projet Firebase et ajoutez l'application Android et/ou iOS correspondante.

### Android

Ajouter :

```text
android/app/google-services.json
```

### iOS

Ajouter :

```text
ios/Runner/GoogleService-Info.plist
```

Vérifiez également que le package/application ID configuré dans Firebase correspond à celui de l'application Flutter.

Dans Firebase Console, activez le fournisseur :

```text
Authentication
    ↓
Sign-in method
    ↓
Email/Password
```

Les fichiers Firebase contenant des informations spécifiques à votre projet ne doivent pas être remplacés par ceux d'un autre environnement.

---

# 🔒 Stockage sécurisé

Les informations sensibles liées à l'authentification ne sont pas destinées à être stockées dans Hive.

Le projet utilise `FlutterSecureStorage` pour les informations sensibles telles que le token.

Exemple :

```dart
const storage = FlutterSecureStorage();

await storage.write(
  key: 'access_token',
  value: token,
);
```

Lecture :

```dart
final token = await storage.read(
  key: 'access_token',
);
```

---

# 🔑 Authentification et token HTTP

Le client Dio peut utiliser un interceptor afin d'ajouter automatiquement le token d'authentification aux requêtes nécessitant une authentification.

Le principe est :

```text
Firebase Authentication
        ↓
      Token
        ↓
FlutterSecureStorage
        ↓
     Dio Interceptor
        ↓
Authorization Header
        ↓
       API
```

Cela évite de répéter manuellement l'ajout du token dans chaque requête.

---

# 🧭 Navigation

La navigation est gérée avec **GoRouter**.

Principales routes :

```text
/
├── /login
├── /register
├── /headlines
├── /all-news
├── /sources
└── /profil
```

La navigation prend en compte l'état d'authentification lorsque cela est nécessaire.

---

# 🧪 Tests

Le projet contient des tests unitaires utilisant :

* `flutter_test`
* `Mockito`

Les tests couvrent notamment la couche Repository/DataSource.

Exemples de scénarios testés :

### Repository

```text
✓ retourne les articles provenant de la source distante
✓ retourne une liste vide lorsque l'API ne retourne aucun article
✓ gère les erreurs de la source distante
✓ récupère les données du cache lorsque le réseau échoue
✓ utilise la source locale en mode hors-ligne
```

### Test du mode hors-ligne

Le scénario suivant est notamment vérifié :

```text
RemoteDataSource
      │
      └── erreur réseau
             ↓
       LocalDataSource
             ↓
       données Hive
             ↓
       ArticleEntity
```

Cela permet de vérifier que les données déjà mises en cache peuvent être utilisées lorsque l'API distante n'est plus disponible.

### Lancer les tests

```bash
flutter test
```

### Générer les mocks Mockito

```bash
dart run build_runner build --delete-conflicting-outputs
```

### Mode automatique

```bash
dart run build_runner watch --delete-conflicting-outputs
```

---

# 📦 Installation

## 1. Cloner le projet

```bash
git clone https://github.com/ikader37/flutter_with_backend.git
```

Puis :

```bash
cd flutter_with_backend
```

## 2. Installer les dépendances

```bash
flutter pub get
```

## 3. Vérifier Flutter

```bash
flutter doctor
```

## 4. Configurer Firebase

Ajouter les fichiers Firebase correspondant à votre application :

```text
android/app/google-services.json
ios/Runner/GoogleService-Info.plist
```

## 5. Configurer NewsAPI

Ajouter la clé API selon le mécanisme de configuration utilisé par votre environnement.

## 6. Générer le code

```bash
dart run build_runner build --delete-conflicting-outputs
```

## 7. Lancer l'application

```bash
flutter run
```

---

# 🛠️ Technologies utilisées

| Technologie             | Utilisation                 |
| ----------------------- | --------------------------- |
| Flutter                 | Framework mobile            |
| Dart                    | Langage                     |
| BLoC                    | Gestion d'état              |
| Clean Architecture      | Organisation du projet      |
| Firebase Authentication | Authentification            |
| Dio                     | Communication HTTP          |
| NewsAPI                 | API d'actualités            |
| Hive CE                 | Cache et persistance locale |
| Flutter Secure Storage  | Stockage sécurisé           |
| GoRouter                | Navigation                  |
| Mockito                 | Mocking pour les tests      |
| Flutter Test            | Tests unitaires             |

---

# 🎯 Objectifs pédagogiques

Ce projet permet de mettre en pratique :

* Clean Architecture ;
* principes SOLID ;
* séparation Data / Domain / Presentation ;
* injection de dépendances ;
* gestion d'état avec BLoC ;
* consommation d'une API REST ;
* gestion des erreurs réseau ;
* authentification Firebase ;
* stockage sécurisé ;
* persistance locale avec Hive ;
* stratégie de cache et mode hors-ligne ;
* navigation avec GoRouter ;
* tests unitaires ;
* mocks avec Mockito.

---

# 📋 Prérequis

Avant de lancer le projet, installer :

* Flutter SDK ;
* Dart SDK ;
* Android Studio ou Xcode ;
* un émulateur Android ou un appareil physique ;
* un projet Firebase configuré ;
* une clé NewsAPI.

---

# 👨‍💻 Auteur

**Abdoul Kader IKADER**

Projet Flutter personnel / pédagogique.

GitHub :

[ikader37](https://github.com/ikader37?utm_source=chatgpt.com)

Repository :

[flutter_with_backend](https://github.com/ikader37/flutter_with_backend?utm_source=chatgpt.com)

---

## 📄 Licence

Ce projet est principalement destiné à un usage pédagogique et expérimental.
