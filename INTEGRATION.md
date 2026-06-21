# 🔧 Guia de Integração - Firebase & OpenAI

## Parte 1: Integração com Firebase

### 1.1 Criar Projeto Firebase

1. **Acesse [Firebase Console](https://console.firebase.google.com)**
2. **Clique em "Criar Projeto"**
   - Nome: `AI Music Studio`
   - Localização: Selecione sua região
   - Google Analytics: Desabilite por enquanto
3. **Clique em "Criar Projeto"** e aguarde

### 1.2 Configurar Firebase no Flutter

```bash
# 1. Instale o Firebase CLI
npm install -g firebase-tools

# 2. Faça login
firebase login

# 3. Configure o Flutter Firebase
flutterfire configure

# 4. Selecione seu projeto quando solicitado
# 5. Selecione as plataformas: Android, iOS, Web
```

### 1.3 Ativar Serviços Firebase

**No Firebase Console:**

#### a) Autenticação
```
1. Vá para "Build" > "Authentication"
2. Clique em "Começar"
3. Selecione "Email/Password"
4. Clique em "Ativar"
5. Salve
```

#### b) Firestore Database
```
1. Vá para "Build" > "Firestore Database"
2. Clique em "Criar Banco de Dados"
3. Localização: Selecione sua região
4. Modo de segurança: Selecione "Iniciar no modo de teste"
5. Clique em "Criar"
```

#### c) Storage
```
1. Vá para "Build" > "Storage"
2. Clique em "Começar"
3. Localização: Selecione sua região (mesmo da Firestore)
4. Regras: Modo de teste por enquanto
5. Clique em "Criar"
```

### 1.4 Configurar Regras de Segurança

**Para Firestore (test mode primeiro, depois configure):**
```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /recordings/{document=**} {
      allow read: if request.auth != null;
      allow write: if request.auth != null && request.auth.uid == request.resource.data.userId;
    }
    match /users/{userId} {
      allow read: if request.auth != null && request.auth.uid == userId;
      allow write: if request.auth != null && request.auth.uid == userId;
    }
  }
}
```

**Para Storage:**
```
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    match /recordings/{userId}/{document=**} {
      allow read: if request.auth != null && request.auth.uid == userId;
      allow write: if request.auth != null && request.auth.uid == userId;
    }
  }
}
```

### 1.5 Integração no Código

**Atualizar `lib/main.dart`:**
```dart
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
```

**Atualizar `lib/services/firebase_service.dart`:**
```dart
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadAudio(String filePath, String fileName) async {
    try {
      final file = File(filePath);
      final ref = _storage.ref('recordings/$fileName');
      await ref.putFile(file);
      return await ref.getDownloadURL();
    } catch (e) {
      throw Exception('Failed to upload audio: $e');
    }
  }

  Future<void> saveRecording(Map<String, dynamic> recordingData) async {
    try {
      await _firestore.collection('recordings').add({
        ...recordingData,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to save recording: $e');
    }
  }
}
```

---

## Parte 2: Integração com OpenAI API

### 2.1 Obter Chave da API OpenAI

1. **Acesse [OpenAI Platform](https://platform.openai.com)**
2. **Crie uma conta ou faça login**
3. **Vá para "API keys"**
4. **Clique em "Create new secret key"**
5. **Copie e guarde em local seguro**

### 2.2 Configurar Variáveis de Ambiente

**Crie arquivo `.env`:**
```
OPENAI_API_KEY=sk-your-key-here
OPENAI_ORG_ID=org-xxx
```

**Instale pacote flutter_dotenv:**
```bash
flutter pub add flutter_dotenv
```

**Adicione em `pubspec.yaml`:**
```yaml
flutter:
  assets:
    - .env
```

### 2.3 Integração no Código

**Atualizar `lib/main.dart`:**
```dart
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  // ... resto do código
}
```

**Atualizar `lib/services/ai_service.dart`:**
```dart
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AIService {
  late final GenerativeModel _model;

  AIService() {
    final apiKey = dotenv.env['OPENAI_API_KEY'];
    _model = GenerativeModel(
      model: 'gemini-pro',
      apiKey: apiKey!,
    );
  }

  Future<String> generateBeat({
    required String beatType,
    required double bpm,
    required Duration duration,
  }) async {
    try {
      final prompt = '''
      Generate a music prompt for a $beatType beat at $bpm BPM 
      lasting ${duration.inSeconds} seconds.
      ''';
      
      final response = await _model.generateContent(
        [Content.text(prompt)],
      );
      
      return response.text ?? '';
    } catch (e) {
      throw Exception('Failed to generate beat: $e');
    }
  }
}
```

---

## Parte 3: Testar Integração

### 3.1 Teste de Autenticação
```dart
import 'package:firebase_auth/firebase_auth.dart';

// Criar conta
await FirebaseAuth.instance.createUserWithEmailAndPassword(
  email: 'test@example.com',
  password: 'password123',
);

// Fazer login
await FirebaseAuth.instance.signInWithEmailAndPassword(
  email: 'test@example.com',
  password: 'password123',
);

// Obter usuário atual
User? user = FirebaseAuth.instance.currentUser;
print(user?.uid);
```

### 3.2 Teste de Upload
```dart
final firebaseService = FirebaseService();
final path = await firebaseService.uploadAudio(
  '/path/to/audio.wav',
  'test_recording.wav',
);
print('Upload URL: $path');
```

### 3.3 Teste de IA
```dart
final aiService = AIService();
final beat = await aiService.generateBeat(
  beatType: 'Hip Hop',
  bpm: 120,
  duration: Duration(seconds: 30),
);
print('Generated beat: $beat');
```

---

## Parte 4: Configuração de Produção

### 4.1 Variáveis de Ambiente
```bash
# .env.production
OPENAI_API_KEY=sk-prod-key
FIREBASE_PROJECT_ID=prod-project-id
DEBUG_MODE=false
```

### 4.2 Build para Produção

**Android:**
```bash
flutter build apk --release
flutter build appbundle --release
```

**iOS:**
```bash
flutter build ios --release
```

**Web:**
```bash
flutter build web --release
```

---

## 🐛 Troubleshooting

### Erro: "Firebase not initialized"
```dart
// Certifique-se que Firebase está inicializado no main
await Firebase.initializeApp();
```

### Erro: "API key not found"
```dart
// Verifique se .env está no pubspec.yaml
// e se dotenv.load() é chamado antes de usar
```

### Erro: "Permission denied" no Firestore
```javascript
// Use regras mais permissivas para testes
match /recordings/{document=**} {
  allow read, write;
}
```

### Erro: "Quota exceeded" na OpenAI
- Verifique seu plano na OpenAI
- Monitore uso em https://platform.openai.com/usage

---

## 📋 Checklist de Integração

- [ ] Projeto Firebase criado
- [ ] Firebase CLI instalado
- [ ] `flutterfire configure` executado
- [ ] Autenticação habilitada
- [ ] Firestore criado
- [ ] Storage criado
- [ ] Regras de segurança configuradas
- [ ] OpenAI API key obtida
- [ ] `.env` criado com chaves
- [ ] `firebase_core` inicializado em main.dart
- [ ] `dotenv` carregado
- [ ] Testes de integração passando
- [ ] Build de produção funcionando

---

## 📚 Referências

- [Firebase Documentation](https://firebase.google.com/docs)
- [FlutterFire](https://firebase.flutter.dev)
- [OpenAI API Docs](https://platform.openai.com/docs)
- [Google Generative AI](https://ai.google.dev/)
