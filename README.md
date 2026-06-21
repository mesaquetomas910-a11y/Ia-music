# AI Music Studio Pro

Aplicativo Flutter completo para criação e edição de música com inteligência artificial.

## 🎵 Funcionalidades

- **Gravador de Música** - Grave suas músicas em alta qualidade
- **Gerador de Beat IA** - Gere beats automáticos com IA (Hip Hop, Trap, Eletrônico, etc)
- **Auto-Tune** - Afine sua voz automaticamente com diferentes presets
- **Mixer** - Misture múltiplos áudios profissionalmente
- **Exportação** - Exporte seus projetos em alta qualidade

## 🛠️ Tecnologias

### Frontend
- **Flutter 3.0+** - Framework UI
- **Material Design 3** - Design System

### Backend
- **Firebase** - Backend as a Service
- **Cloud Firestore** - Banco de dados em tempo real
- **Firebase Storage** - Armazenamento de arquivos

### IA e ML
- **OpenAI API** - Geração de beats e processamento de áudio
- **TensorFlow Lite** - Auto-tune e processamento de voz local
- **FFmpeg** - Processamento e mistura de áudio

## 📁 Estrutura do Projeto

```
lib/
├── main.dart                 # Arquivo principal
├── screens/
│   ├── home.dart            # Tela inicial
│   ├── recorder.dart        # Gravador de música
│   ├── beat_generator.dart  # Gerador de beats
│   ├── auto_tune.dart       # Auto-tune
│   └── mixer.dart           # Mixer
├── services/
│   ├── firebase_service.dart  # Integração Firebase
│   ├── audio_service.dart     # Serviço de áudio
│   └── ai_service.dart        # Serviço de IA
└── widgets/
    ├── record_button.dart   # Botão de gravação
    └── player_widget.dart   # Player de áudio
```

## 🚀 Como Começar

### Pré-requisitos
- Flutter 3.0 ou superior
- Dart 3.0 ou superior
- Conta Firebase
- Chave API da OpenAI (opcional, para geração avançada)

### Instalação

1. Clone o repositório:
```bash
git clone https://github.com/mesaquetomas910-a11y/Ia-music.git
cd Ia-music
```

2. Instale as dependências:
```bash
flutter pub get
```

3. Configure o Firebase:
```bash
flutterfire configure
```

4. Execute o aplicativo:
```bash
flutter run
```

## 📝 Configuração do Firebase

1. Crie um projeto no [Firebase Console](https://console.firebase.google.com)
2. Adicione um app Flutter
3. Baixe o arquivo de configura��ão
4. Execute `flutterfire configure`

## 🔌 Integração de APIs

### OpenAI API
Adicione sua chave no arquivo `.env`:
```
OPENAI_API_KEY=your_key_here
```

### TensorFlow Lite
Os modelos estão em `assets/models/`

## 📦 Dependências Principais

- `record` - Gravação de áudio
- `audioplayers` - Reprodução de áudio
- `firebase_core` - Firebase core
- `cloud_firestore` - Firestore
- `firebase_storage` - Storage
- `google_generative_ai` - OpenAI integration
- `tflite_flutter` - TensorFlow Lite
- `ffmpeg_kit_flutter` - FFmpeg integration

## 🎯 Roadmap

- [ ] Sincronização em tempo real de projetos
- [ ] Efeitos de áudio avançados
- [ ] Biblioteca de samples
- [ ] Colaboração em tempo real
- [ ] Exportação em múltiplos formatos
- [ ] Suporte para VST plugins
- [ ] Mobile app versão web
- [ ] Integração com outras DAWs

## 📄 Licença

MIT License - veja LICENSE.md para mais detalhes

## 👨‍💻 Autor

[mesaquetomas910-a11y](https://github.com/mesaquetomas910-a11y)

## 🤝 Contribuindo

Contribuições são bem-vindas! Sinta-se livre para abrir issues e pull requests.

## 📞 Suporte

Para suporte, abra uma issue no GitHub ou entre em contato através de [mesaquetomas910@gmail.com](mailto:mesaquetomas910@gmail.com)
