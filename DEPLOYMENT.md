# 📦 Deployment Guide - Publicar seu App

## Parte 1: Prepare o Build

### 1.1 Versionamento
**Edite `pubspec.yaml`:**
```yaml
version: 1.0.0+1
# formato: major.minor.patch+buildNumber
```

**Significado:**
- `1.0.0` = versão pública
- `+1` = build number (incrementa com cada release)

### 1.2 Icons e Splash Screen

**Instale flutter_launcher_icons:**
```bash
flutter pub add dev:flutter_launcher_icons
```

**Crie `pubspec.yaml`:**
```yaml
flutter_icons:
  ios: true
  android: true
  image_path: "assets/images/app_icon.png"
  adaptive_icon_background: "#ffffff"
  adaptive_icon_foreground: "assets/images/app_icon_foreground.png"
```

**Execute:**
```bash
flutter pub run flutter_launcher_icons:main
```

---

## Parte 2: Deploy Android

### 2.1 Criar Keystore

```bash
keytool -genkey -v -keystore ~/android_keystore.jks \
  -keyalg RSA -keysize 2048 -validity 10000 \
  -alias android_key
```

**Salve em local seguro! Você precisará disso para updates futuros.**

### 2.2 Configurar Gradle

**Crie `android/key.properties`:**
```properties
storePassword=sua_senha
keyPassword=sua_senha_chave
keyAlias=android_key
storeFile=/path/to/android_keystore.jks
```

**Edite `android/app/build.gradle`:**
```gradle
android {
    signingConfigs {
        release {
            keyAlias keystoreProperties['keyAlias']
            keyPassword keystoreProperties['keyPassword']
            storeFile file(keystoreProperties['storeFile'])
            storePassword keystoreProperties['storePassword']
        }
    }
    buildTypes {
        release {
            signingConfig signingConfigs.release
        }
    }
}
```

### 2.3 Build APK/AAB

**APK (para testes):**
```bash
flutter build apk --release
# Saída: build/app/outputs/flutter-app.apk
```

**AAB (para Google Play - recomendado):**
```bash
flutter build appbundle --release
# Saída: build/app/outputs/app-release.aab
```

### 2.4 Upload na Google Play

1. **Crie conta Google Play Developer** ($25 taxa única)
2. **Vá para [Google Play Console](https://play.google.com/console)**
3. **Clique em "Criar App"**
   - Nome: AI Music Studio
   - Idioma padrão: Português (Brasil)
   - Tipo: App
4. **Preencha informações obrigatórias:**
   - Descrição curta (80 caracteres)
   - Descrição completa (4000 caracteres)
   - Screenshots (5-8 imagens)
   - Ícone de app (512x512 PNG)
   - Banner (1024x500 PNG)

5. **Vá para "Lançamentos" > "Produção"**
6. **Clique em "Criar novo lançamento"**
7. **Upload do AAB:**
   - Arraste `build/app/outputs/app-release.aab`
8. **Preencha notas de versão**
9. **Revise e publique**

**Tempo de revisão:** 2-4 horas

---

## Parte 3: Deploy iOS

### 3.1 Pré-requisitos

- Mac com Xcode
- Conta Apple Developer ($99/ano)
- Certificados gerados

### 3.2 Gerar Certificados

```bash
# Abra Xcode
open ios/Runner.xcworkspace

# Na barra lateral:
# 1. Selecione "Runner"
# 2. Vá para "Signing & Capabilities"
# 3. Selecione seu Team
# 4. Xcode gerará certificados automaticamente
```

### 3.3 Build IPA

```bash
# Build para produção
flutter build ios --release

# Ou use Xcode
open ios/Runner.xcworkspace
# Product > Archive

# Então: Distribute App > App Store Connect > Upload
```

### 3.4 Upload na App Store

1. **Vá para [App Store Connect](https://appstoreconnect.apple.com)**
2. **Clique em "Meus Apps"**
3. **Clique em "+"** e selecione "Novo App"
4. **Preencha informações:**
   - Nome: AI Music Studio
   - Identificador do pacote: com.example.iamusic
   - SKU: Qualquer código único
   - Acesso: Selecione acesso apropriado

5. **Preencha "Informações da App":**
   - Categoria: Música
   - Descrição
   - Palavras-chave (5-10)
   - URL de suporte
   - URL de política de privacidade

6. **Preencha "Preço e Distribuição"**

7. **Compile e faça upload:**
   - Versão: 1.0
   - Build: Selecione seu IPA
   - Notas de lançamento

8. **Submeta para revisão**

**Tempo de revisão:** 24-48 horas

---

## Parte 4: Deploy Web

### 4.1 Build Web

```bash
flutter build web --release
# Saída: build/web/
```

### 4.2 Deploy na Firebase Hosting

```bash
# Instale Firebase CLI
npm install -g firebase-tools

# Login
firebase login

# Initialize
firebase init hosting

# Configure para "build/web"

# Deploy
firebase deploy --only hosting
```

**URL gerada:** `seu-projeto.firebaseapp.com`

### 4.3 Deploy em Outras Plataformas

**Netlify:**
```bash
# Instale Netlify CLI
npm install -g netlify-cli

# Deploy
netlify deploy --prod --dir=build/web
```

**Vercel:**
```bash
# Instale Vercel CLI
npm install -g vercel

# Deploy
vercel deploy --prod build/web
```

---

## Parte 5: GitHub Actions (CI/CD)

### 5.1 Criar Workflow

**Crie `.github/workflows/build.yml`:**
```yaml
name: Build and Deploy

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  build:
    runs-on: ubuntu-latest
    
    steps:
      - uses: actions/checkout@v3
      
      - name: Setup Flutter
        uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.13.0'
      
      - name: Get dependencies
        run: flutter pub get
      
      - name: Format
        run: flutter format --set-exit-if-changed .
      
      - name: Analyze
        run: flutter analyze
      
      - name: Run tests
        run: flutter test
      
      - name: Build APK
        run: flutter build apk --release
      
      - name: Upload APK
        uses: actions/upload-artifact@v2
        with:
          name: app-release.apk
          path: build/app/outputs/flutter-app.apk
```

### 5.2 Setup Secrets

**Em GitHub:**
1. Vá para "Settings" > "Secrets and variables"
2. Clique em "New repository secret"
3. Adicione:
   - `KEYSTORE_BASE64` (sua keystore em base64)
   - `KEYSTORE_PASSWORD`
   - `KEY_PASSWORD`

---

## 📋 Checklist de Release

- [ ] Versão incrementada em `pubspec.yaml`
- [ ] Assets e icons atualizados
- [ ] Testes passando (`flutter test`)
- [ ] Build sem erros (`flutter analyze`)
- [ ] Screenshots e descrições prontos
- [ ] Privacy policy definida
- [ ] App icons validados (512x512)
- [ ] TestFlight/Beta testing completo
- [ ] Notas de lançamento preparadas
- [ ] Backup de chaves/certificados

---

## 🔐 Segurança em Produção

### Antes de Publicar:
```dart
// Remova debug logs
debugPrint('...'); // ❌ REMOVER
print('...'); // ❌ REMOVER

// Verifique variáveis de ambiente
const String apiKey = 'sk-...'; // ❌ NUNCA hardcode!
// Use: dotenv.env['API_KEY']

// Configure segurança Firebase
// Revise .env para não ter secrets
// Git ignore .env arquivo
```

### Obfuscação (Android):
```bash
flutter build apk --release --obfuscate --split-debug-info=/tmp/debug-symbols
```

---

## 📊 Monitorar Depois do Launch

### Analytics
```bash
# Firebase Console
# Dashboard > Analytics

# Ver:
# - DAU (Daily Active Users)
# - Retenção
# - Crashes
# - Performance
```

### Crashes
```bash
# Firebase Console
# Quality > Crashes & ANRs

# Configure alertas
# Settings > Alerts
```

---

## 🔄 Update Strategy

### Versão Patch (1.0.1)
- Bug fixes
- Performance improvements

### Versão Minor (1.1.0)
- Novas features
- Melhorias significativas

### Versão Major (2.0.0)
- Redesign
- API breaking changes

**Release cycle recomendado:** 2 semanas

---

## 💡 Tips & Tricks

1. **Sempre teste em beta primeiro**
2. **Mantenha changelog atualizado**
3. **Não incremente versão sem release**
4. **Backup de certificados em local seguro**
5. **Monitore crashes após launch**
6. **Responda reviews com respeito**

---

**Seu app está pronto para o mundo! 🌍**
