# 🚀 Quick Start Guide - Desenvolvimento Rápido

## ⚡ Setup em 5 Minutos

### 1. Clone e Configure
```bash
# Clone o repositório
git clone https://github.com/mesaquetomas910-a11y/Ia-music.git
cd Ia-music

# Instale dependências
flutter pub get

# Verifique Flutter
flutter doctor
```

### 2. Configure Arquivo .env
```bash
# Copie o template
cp .env.example .env

# Edite com suas credenciais
nano .env
# ou
code .env
```

**Adicione:**
```
OPENAI_API_KEY=sua_chave_aqui
FIREBASE_PROJECT_ID=seu_projeto_aqui
DEBUG_MODE=true
```

### 3. Execute o App
```bash
# No emulador/dispositivo
flutter run

# Com output verbose
flutter run -v

# Em release mode (otimizado)
flutter run --release
```

---

## 📱 Estrutura do Projeto

```
Ia-music/
├── lib/
│   ├── main.dart                    # Entry point
│   ├── screens/                     # Telas da app
│   │   ├── home.dart               
│   │   ├── recorder.dart           
│   │   ├── beat_generator.dart     
│   │   ├── auto_tune.dart          
│   │   ├── mixer.dart              
│   │   └── export.dart             
│   ├── services/                    # Lógica de negócio
│   │   ├── audio_service.dart      
│   │   ├── firebase_service.dart   
│   │   └── ai_service.dart         
│   ├── widgets/                     # Componentes reutilizáveis
│   │   ├── record_button.dart      
│   │   └── player_widget.dart      
│   └── models/                      # Modelos de dados (criar)
├── test/                            # Testes
│   ├── widget_test.dart            
│   ├── screens/                    
│   ├── services/                   
│   └── integration_test/           
├── android/                         # Código Android nativo
├── ios/                             # Código iOS nativo
├── pubspec.yaml                     # Dependências
├── .env.example                     # Template de env
└── README.md                        # Documentação
```

---

## 🔨 Comandos Úteis

### Desenvolvimento
```bash
# Hot reload (atualizar sem reinicar)
flutter run
# Pressione 'r' no terminal

# Hot restart (reiniciar app mantendo estado)
# Pressione 'R' no terminal

# Limpar cache
flutter clean

# Reinstalar dependências
flutter pub get

# Verificar análise de código
flutter analyze

# Formatar código
flutter format .
```

### Testes
```bash
# Rodar todos os testes
flutter test

# Rodar teste específico
flutter test test/screens/home_test.dart

# Com cobertura
flutter test --coverage

# Teste de integração
flutter test integration_test/
```

### Build
```bash
# APK Debug
flutter build apk --debug

# APK Release
flutter build apk --release

# iOS
flutter build ios --release

# Web
flutter build web --release
```

---

## 🎯 Workflow Típico

### 1. Criar Nova Feature
```bash
# Crie um branch
git checkout -b feature/minha-feature

# Crie os arquivos necessários
# - Screen em lib/screens/
# - Service em lib/services/ (se necessário)
# - Testes em test/

# Teste localmente
flutter test
flutter run

# Commit
git add .
git commit -m "feat: adicionar minha feature"

# Push
git push origin feature/minha-feature
```

### 2. Debug de Problemas
```bash
# Verbose mode
flutter run -v

# Device logs
flutter logs

# Debugger interativo
flutter attach

# Devtools (interface gráfica)
flutter pub global activate devtools
devtools
```

### 3. Performance
```bash
# Profiling
flutter run --profile

# Verificar FPS
# No app: pressione 'P'

# Memory profiling
dart devtools
```

---

## 📁 Adicionar Novas Dependências

```bash
# Adicionar pacote
flutter pub add nome_do_pacote

# Remover pacote
flutter pub remove nome_do_pacote

# Atualizar dependências
flutter pub upgrade

# Listar pacotes
flutter pub outdated
```

---

## 🐛 Debug Tips

### Widget não aparece?
```dart
// Use Debugger
debugPrint('Widget renderizado');

// Use DevTools
// Abra: http://localhost:9100 (padrão)
```

### Performance lenta?
```dart
// Use Profiler
flutter run --profile

// Verifique FPS (pressione 'P' durante execução)
```

### Estado inconsistente?
```dart
// Hot restart (pressione 'R') ao invés de hot reload
// Isso reinicializa o estado
```

### Erro de compilação?
```bash
# Limpe e recompile
flutter clean
flutter pub get
flutter run
```

---

## 📊 Checklist Antes de Commitar

- [ ] Código formatado (`flutter format .`)
- [ ] Sem erros de análise (`flutter analyze`)
- [ ] Testes passando (`flutter test`)
- [ ] Nenhum `debugPrint()` ou `TODO` esquecido
- [ ] Commits com mensagens claras
- [ ] Branch atualizado com main

---

## 🔗 Links Úteis

| Recurso | Link |
|---------|------|
| Flutter Docs | https://flutter.dev/docs |
| Dart Docs | https://dart.dev/guides |
| Firebase Docs | https://firebase.flutter.dev |
| OpenAI API | https://platform.openai.com/docs |
| Material Design 3 | https://m3.material.io |
| DevTools | http://localhost:9100 |

---

## 💡 Dicas Produtivas

### 1. Use Snippets no VS Code
Crie `.vscode/flutter.code-snippets`:
```json
{
  "Flutter StatefulWidget": {
    "prefix": "fstateful",
    "body": [
      "import 'package:flutter/material.dart';",
      "",
      "class ${1:MyWidget} extends StatefulWidget {",
      "  const ${1:MyWidget}({Key? key}) : super(key: key);",
      "",
      "  @override",
      "  State<${1:MyWidget}> createState() => _${1:MyWidget}State();",
      "}",
      "",
      "class _${1:MyWidget}State extends State<${1:MyWidget}> {",
      "  @override",
      "  Widget build(BuildContext context) {",
      "    return Scaffold(",
      "      appBar: AppBar(title: const Text('${1:MyWidget}')),",
      "      body: Center(child: Text('${1:MyWidget}')),",
      "    );",
      "  }",
      "}"
    ]
  }
}
```

### 2. Organize Imports
Adicione em `pubspec.yaml`:
```yaml
dev_dependencies:
  import_sorter: ^4.6.0
```

Execute:
```bash
dart pub global run import_sorter:main
```

### 3. Pre-commit Hooks
Crie `.git/hooks/pre-commit`:
```bash
#!/bin/bash
flutter format .
flutter analyze
flutter test
```

---

## 📞 Suporte & Ajuda

- 📖 Leia a documentação em `README.md`
- 🧪 Veja exemplos em `test/`
- 🔧 Configure em `INTEGRATION.md`
- 📝 Teste em `TESTING.md`
- 🤝 Contribua em `CONTRIBUTING.md`

**Pronto para começar! 🚀**
