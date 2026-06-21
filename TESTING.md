# 🧪 Guia de Testes - AI Music Studio Pro

## Pré-requisitos para Testes

- Flutter 3.0 ou superior
- Dart 3.0 ou superior
- Android Studio / Xcode (conforme o SO)
- Emulador ou Dispositivo Físico

## 1️⃣ Setup Inicial

### Passo 1: Clonar e Configurar
```bash
# Clone o repositório
git clone https://github.com/mesaquetomas910-a11y/Ia-music.git
cd Ia-music

# Instale as dependências
flutter pub get

# Verifique a instalação
flutter doctor

# Format e analyze do código
flutter format .
flutter analyze
```

### Passo 2: Configurar Emulador
```bash
# Para Android
flutter emulators --launch android_emulator

# Para iOS (apenas em Mac)
open -a Simulator
```

## 2️⃣ Testes da UI/UX

### Teste 1: Inicialização do App
```bash
# Execute o app
flutter run

# ✅ Esperado:
# - Tela inicial carrega sem erros
# - AppBar mostra "AI Studio Pro"
# - 4 cards de funcionalidades são exibidos
# - Material Design 3 aplicado
```

### Teste 2: Navegação
```
✅ Clique em "Gravar Música"
   - Deve navegar para RecorderScreen
   - Mostrar botão de gravação circular
   - Contador de tempo em HH:MM:SS
   - Botão voltar funciona

✅ Clique em "Gerar Beat IA"
   - Deve navegar para BeatGeneratorScreen
   - Mostrar seleção de tipo de beat
   - Slider de BPM funcionando
   - Botão de geração habilitado

✅ Clique em "Auto-Tune"
   - Deve navegar para AutoTuneScreen
   - Slider de intensidade funcionando
   - Presets de vozes exibidos
   - Botão de aplicação habilitado

✅ Clique em "Mixer"
   - Deve navegar para MixerScreen
   - 4 faixas de áudio exibidas
   - Controles de volume funcionando
   - Ícone mute/unmute funciona
```

## 3️⃣ Testes de Funcionalidades

### Teste 3: Gravador
```
1. Toque no botão redondo azul
   ✅ Muda para vermelho
   ✅ Inicia o contador de tempo
   ✅ Exibe "Gravando..."

2. Toque novamente para parar
   ✅ Volta ao azul
   ✅ Contador para
   ✅ Exibe mensagem de sucesso (Mock)

3. Botão Cancelar durante gravação
   ✅ Para a gravação
   ✅ Reseta o contador
```

### Teste 4: Gerador de Beat
```
1. Selecione um tipo de beat
   ✅ Chip muda de cor (selecionado)

2. Ajuste o BPM com o slider
   ✅ Valor atualiza em tempo real
   ✅ Range: 60-180 BPM

3. Clique "Gerar Beat"
   ✅ Botão desabilita
   ✅ Spinner aparece
   ✅ Após 3 segundos, exibe SnackBar de sucesso
```

### Teste 5: Auto-Tune
```
1. Ajuste o slider de intensidade
   ✅ Porcentagem atualiza
   ✅ Range: 0-100%

2. Selecione um preset
   ✅ Preset fica visualmente destacado

3. Clique "Aplicar Auto-Tune"
   ✅ Processamento inicia
   ✅ SnackBar mostra resultado com intensidade
```

### Teste 6: Mixer
```
1. Teste cada faixa
   ✅ Slider de volume funciona (0-100%)
   ✅ Porcentagem atualiza
   ✅ Ícone mute/unmute muda

2. Teste mute em uma faixa
   ✅ Slider fica desabilitado
   ✅ Ícone muda para mudo (vermelho)

3. Clique botão de exportação
   ✅ Dialog aparece com confirmação
   ✅ SnackBar de sucesso após "Exportar"
```

## 4️⃣ Testes de Performance

```bash
# Teste com profiler
flutter run --profile

# Verifique:
✅ Nenhum lag ao navegar
✅ Animações suaves (60 FPS)
✅ Nenhuma batida de memória
✅ Sliders respondem instantaneamente
```

## 5️⃣ Testes de Responsividade

```
Teste em diferentes tamanhos de tela:
✅ Emulador padrão (Pixel 4)
✅ Dispositivo grande (Tablet)
✅ Dispositivo pequeno (Nexus 5)

Verifique:
✅ Cards adapta ao tamanho
✅ Texto legível
✅ Botões clicáveis
✅ Sem overflow de layout
```

## 6️⃣ Testes de Release

```bash
# Build debug APK
flutter build apk --debug

# Build release APK (Android)
flutter build apk --release

# Build release IPA (iOS - apenas Mac)
flutter build ios --release

# Tamanho do arquivo gerado:
✅ APK: deve estar < 100MB
✅ IPA: deve estar < 150MB
```

## 7️⃣ Testes de Acessibilidade

```
✅ Navegação por teclado (Tab)
✅ Todos os botões têm labels acessíveis
✅ Contraste de cores adequado
✅ Texto redimensionável no sistema
✅ Compatível com leitores de tela
```

## 📊 Checklist de Teste

- [ ] App inicia sem erros
- [ ] Todas as telas carregam
- [ ] Navegação funciona perfeitamente
- [ ] UI responsiva em todos os tamanhos
- [ ] Botões respondem ao clique
- [ ] Sliders funcionam corretamente
- [ ] Contadores funcionam
- [ ] SnackBars exibem corretamente
- [ ] Sem crashes ou erros
- [ ] Performance adequada
- [ ] Acessibilidade básica ok

## 🐛 Relatório de Bugs

Se encontrar um bug, crie uma issue com:
- Descrição do problema
- Passos para reproduzir
- Comportamento esperado vs. atual
- Versão do Flutter
- Dispositivo/Emulador usado

## 📝 Exemplo de Teste Manual

```
Teste #1: Fluxo Completo
1. Abra o app
2. Vá para Gravador
3. Clique para gravar por 5 segundos
4. Clique para parar
5. Volte ao menu
6. Vá para Gerador de Beat
7. Selecione "Trap" e 140 BPM
8. Clique "Gerar Beat"
9. Volte ao menu
10. Vá para Mixer
11. Ajuste volumes
12. Clique exportar
13. Confirme exportação

✅ Se tudo funcionou sem erros = SUCESSO!
```

## 🎯 Conclusão

Após completar todos esses testes, seu app está pronto para:
- ✅ Desenvolvimento de features reais
- ✅ Integração com Firebase
- ✅ Integração com APIs de IA
- ✅ Deploy em produção
