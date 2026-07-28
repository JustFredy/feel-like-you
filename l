<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Sentirte Como Tú — Capítulo I</title>
  <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,400;0,700;0,900;1,400;1,700&family=Space+Grotesk:wght@300;400;500;600&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
  <style>
    :root {
      --bg: #000000;
      --fg: #ffffff;
      --muted: #777777;
      --card-bg: rgba(255, 255, 255, 0.96);
      --card-text: #0a0a0a;
      --card-muted: #666666;
      --border: #e0e0e0;
    }

    * { box-sizing: border-box; margin: 0; padding: 0; }

    body {
      background-color: var(--bg);
      color: var(--fg);
      font-family: 'Space Grotesk', sans-serif;
      display: flex;
      justify-content: center;
      align-items: center;
      min-height: 100vh;
      padding: 20px;
      text-align: center;
      overflow-x: hidden;
      position: relative;
    }

    /* Canvas de ondas cebra */
    canvas#zebraCanvas {
      position: fixed;
      inset: 0;
      width: 100%;
      height: 100%;
      z-index: 0;
    }

    /* Tarjeta principal */
    .card {
      background: var(--card-bg);
      border-radius: 3px;
      padding: 48px 40px 40px;
      max-width: 400px;
      width: 100%;
      box-shadow: 0 30px 80px rgba(0, 0, 0, 0.6);
      z-index: 10;
      position: relative;
      color: var(--card-text);
      opacity: 0;
      transform: translateY(24px);
      transition: opacity 0.9s ease, transform 0.9s ease;
    }

    .card.visible {
      opacity: 1;
      transform: translateY(0);
    }

    .card.tilt-ready {
      transition: transform 0.18s ease-out;
    }

    /* Capítulo */
    .chapter {
      font-family: 'Space Grotesk', sans-serif;
      font-size: 0.65rem;
      font-weight: 500;
      letter-spacing: 5px;
      text-transform: uppercase;
      color: var(--card-muted);
      margin-bottom: 32px;
      opacity: 0;
      transform: translateY(6px);
      transition: opacity 0.5s ease, transform 0.5s ease;
    }

    .chapter.visible {
      opacity: 1;
      transform: translateY(0);
    }

    /* Texto narrativo */
    .narrative {
      font-family: 'Playfair Display', serif;
      font-size: 1.15rem;
      line-height: 1.85;
      color: #333;
      min-height: 50px;
      margin-bottom: 28px;
    }

    .cursor {
      display: inline-block;
      width: 1.5px;
      height: 1.1em;
      background: var(--card-text);
      margin-left: 1px;
      vertical-align: text-bottom;
      animation: blink 0.7s step-end infinite;
    }

    @keyframes blink {
      0%, 50% { opacity: 1; }
      51%, 100% { opacity: 0; }
    }

    /* Separador minimalista */
    .divider {
      width: 24px;
      height: 1px;
      background: var(--border);
      margin: 0 auto 24px;
      opacity: 0;
      transition: opacity 0.5s ease;
    }

    .divider.visible { opacity: 1; }

    /* Chat */
    .chat {
      display: flex;
      flex-direction: column;
      gap: 8px;
      margin-bottom: 24px;
      opacity: 0;
      transition: opacity 0.4s ease;
    }

    .chat.visible { opacity: 1; }

    .chat-timestamp {
      font-size: 0.65rem;
      color: var(--card-muted);
      text-align: center;
      margin-bottom: 6px;
      letter-spacing: 1px;
      opacity: 0;
      transition: opacity 0.4s ease;
    }

    .chat-timestamp.visible { opacity: 1; }

    .bubble {
      max-width: 78%;
      padding: 10px 16px;
      border-radius: 14px;
      font-size: 0.88rem;
      line-height: 1.5;
      opacity: 0;
      transform: translateY(8px) scale(0.96);
      transition: opacity 0.35s ease, transform 0.35s ease;
    }

    .bubble.visible {
      opacity: 1;
      transform: translateY(0) scale(1);
    }

    .bubble-left {
      background: #1a1a1a;
      color: #ffffff;
      align-self: flex-start;
      border-bottom-left-radius: 4px;
      margin-left: 4px;
    }

    .bubble-right {
      background: #f5f5f5;
      color: #1a1a1a;
      align-self: flex-end;
      border-bottom-right-radius: 4px;
      margin-right: 4px;
      font-weight: 400;
    }

    /* Sticker dentro del bubble */
    .sticker-wrap {
      display: flex;
      align-items: center;
      justify-content: center;
      width: 64px;
      height: 64px;
      background: #2a2a2a;
      border-radius: 6px;
    }

    .sticker-wrap i {
      font-size: 1.6rem;
      color: #ffffff;
      animation: heartbeat 2.5s ease-in-out infinite;
    }

    @keyframes heartbeat {
      0%, 100% { transform: scale(1); }
      15% { transform: scale(1.12); }
      30% { transform: scale(1); }
      45% { transform: scale(1.08); }
      60% { transform: scale(1); }
    }

    /* Indicador de escritura */
    .typing-indicator {
      display: flex;
      gap: 4px;
      padding: 10px 16px;
      align-self: flex-end;
      margin-right: 4px;
      background: #f5f5f5;
      border-radius: 14px;
      border-bottom-right-radius: 4px;
      opacity: 0;
      transform: translateY(8px) scale(0.96);
      transition: opacity 0.3s ease, transform 0.3s ease;
    }

    .typing-indicator.visible {
      opacity: 1;
      transform: translateY(0) scale(1);
    }

    .typing-indicator span {
      width: 5px;
      height: 5px;
      background: #aaa;
      border-radius: 50%;
      animation: typingDot 1.4s ease-in-out infinite;
    }

    .typing-indicator span:nth-child(2) { animation-delay: 0.2s; }
    .typing-indicator span:nth-child(3) { animation-delay: 0.4s; }

    @keyframes typingDot {
      0%, 60%, 100% { opacity: 0.3; transform: translateY(0); }
      30% { opacity: 1; transform: translateY(-3px); }
    }

    /* Reflexión */
    .reflection {
      font-family: 'Playfair Display', serif;
      font-style: italic;
      font-size: 0.95rem;
      color: var(--card-muted);
      line-height: 1.7;
      margin-bottom: 32px;
      opacity: 0;
      transform: translateY(6px);
      transition: opacity 0.6s ease, transform 0.6s ease;
    }

    .reflection.visible {
      opacity: 1;
      transform: translateY(0);
    }

    /* Botón */
    .btn {
      background: var(--card-text);
      color: var(--card-bg);
      border: none;
      padding: 13px 32px;
      font-size: 0.82rem;
      font-weight: 500;
      font-family: 'Space Grotesk', sans-serif;
      letter-spacing: 1.5px;
      border-radius: 2px;
      cursor: pointer;
      transition: all 0.25s ease;
      opacity: 0;
      transform: translateY(8px);
      pointer-events: none;
      text-transform: uppercase;
    }

    .btn.visible {
      opacity: 1;
      transform: translateY(0);
      pointer-events: auto;
    }

    .btn:hover {
      background: #333;
      letter-spacing: 2px;
    }

    .btn:active {
      transform: scale(0.97);
    }

    .btn:focus-visible {
      outline: 2px solid var(--card-muted);
      outline-offset: 3px;
    }

    /* Overlay */
    .overlay {
      position: fixed;
      inset: 0;
      background: rgba(0, 0, 0, 0.65);
      z-index: 50;
      opacity: 0;
      pointer-events: none;
      transition: opacity 0.4s ease;
    }

    .overlay.visible {
      opacity: 1;
      pointer-events: auto;
    }

    /* Panel de pista */
    .clue-panel {
      position: fixed;
      bottom: 0;
      left: 50%;
      transform: translateX(-50%) translateY(100%);
      background: #0a0a0a;
      border-radius: 3px 3px 0 0;
      padding: 32px 28px 40px;
      max-width: 400px;
      width: 92%;
      z-index: 100;
      transition: transform 0.5s cubic-bezier(0.16, 1, 0.3, 1);
    }

    .clue-panel.visible {
      transform: translateX(-50%) translateY(0);
    }

    .clue-header {
      font-size: 0.65rem;
      letter-spacing: 4px;
      text-transform: uppercase;
      color: #555;
      margin-bottom: 16px;
    }

    .clue-text {
      color: #ffffff;
      font-family: 'Playfair Display', serif;
      font-size: 1.1rem;
      line-height: 1.7;
    }

    .clue-close {
      position: absolute;
      top: 14px;
      right: 14px;
      background: none;
      border: 1px solid #333;
      color: #555;
      cursor: pointer;
      width: 28px;
      height: 28px;
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 0.75rem;
      transition: all 0.2s;
    }

    .clue-close:hover {
      color: #fff;
      border-color: #666;
    }

    .clue-close:focus-visible {
      outline: 2px solid #555;
      outline-offset: 2px;
    }

    /* Responsive */
    @media (max-width: 480px) {
      .card { padding: 36px 24px 32px; }
      .narrative { font-size: 1.05rem; }
      .bubble { font-size: 0.84rem; }
      .sticker-wrap { width: 52px; height: 52px; }
      .sticker-wrap i { font-size: 1.3rem; }
    }

    /* Movimiento reducido */
    @media (prefers-reduced-motion: reduce) {
      *, *::before, *::after {
        animation-duration: 0.01ms !important;
        animation-iteration-count: 1 !important;
        transition-duration: 0.15s !important;
      }
      .card { opacity: 1; transform: none; }
    }
  </style>
</head>
<body>

  <canvas id="zebraCanvas" aria-hidden="true"></canvas>
  <div class="overlay" id="overlay"></div>

  <main class="card" id="card">
    <div class="chapter" id="chapter">24 de junio</div>
    <div class="narrative" id="narrative" aria-live="polite"></div>
    <div class="divider" id="divider"></div>
    <div class="chat" id="chat">
      <div class="chat-timestamp" id="timestamp">24 de junio · 11:42 PM</div>
      <div class="bubble bubble-left" id="bubbleSticker">
        <div class="sticker-wrap">
          <i class="fas fa-heart"></i>
        </div>
      </div>
      <div class="typing-indicator" id="typingIndicator">
        <span></span><span></span><span></span>
      </div>
      <div class="bubble bubble-right" id="bubbleReply">
        ¿No me extrañas? Jajajaja
      </div>
    </div>
    <div class="reflection" id="reflection">
      Y en ese "jajajaja" se escondía todo lo que no se atrevía a decir.
    </div>
    <button class="btn" id="mainBtn" aria-label="Descubrir la primera pista">Descubrir pista</button>
  </main>

  <aside class="clue-panel" id="cluePanel" role="dialog" aria-label="Pista revelada" aria-hidden="true">
    <button class="clue-close" id="clueClose" aria-label="Cerrar pista">
      <i class="fas fa-times"></i>
    </button>
    <div class="clue-header">Primera pista</div>
    <div class="clue-text" id="clueText"></div>
  </aside>

  <script>
    // ========================================
    // Ondas cebra — canvas animado
    // ========================================
    const canvas = document.getElementById('zebraCanvas');
    const ctx = canvas.getContext('2d');

    function resizeCanvas() {
      canvas.width = window.innerWidth;
      canvas.height = window.innerHeight;
    }
    window.addEventListener('resize', resizeCanvas);
    resizeCanvas();

    function drawZebra(timestamp) {
      const w = canvas.width;
      const h = canvas.height;

      // Fondo negro
      ctx.fillStyle = '#000000';
      ctx.fillRect(0, 0, w, h);

      const numBands = 16;
      const bandH = h / numBands;
      const amp = 14;
      const freq = 0.004;
      const speed = 0.00025;

      // Calcula la posición Y de una onda en una coordenada x y banda dada
      function waveY(x, band) {
        return band * bandH
          + Math.sin(timestamp * speed + x * freq + band * 0.9) * amp
          + Math.sin(timestamp * speed * 0.6 + x * freq * 1.8 + band * 1.3) * amp * 0.35;
      }

      // Dibujar bandas blancas (índices pares)
      for (let i = 0; i < numBands; i += 2) {
        ctx.beginPath();
        // Borde superior de la banda
        ctx.moveTo(0, waveY(0, i));
        for (let x = 0; x <= w; x += 3) {
          ctx.lineTo(x, waveY(x, i));
        }
        // Borde inferior (reverso para cerrar la forma)
        for (let x = w; x >= 0; x -= 3) {
          ctx.lineTo(x, waveY(x, i + 1));
        }
        ctx.closePath();
        ctx.fillStyle = '#ffffff';
        ctx.fill();
      }

      requestAnimationFrame(drawZebra);
    }

    requestAnimationFrame(drawZebra);

    // ========================================
    // Referencias al DOM
    // ========================================
    const card = document.getElementById('card');
    const chapterEl = document.getElementById('chapter');
    const narrativeEl = document.getElementById('narrative');
    const dividerEl = document.getElementById('divider');
    const chatEl = document.getElementById('chat');
    const timestampEl = document.getElementById('timestamp');
    const bubbleSticker = document.getElementById('bubbleSticker');
    const typingIndicator = document.getElementById('typingIndicator');
    const bubbleReply = document.getElementById('bubbleReply');
    const reflectionEl = document.getElementById('reflection');
    const btnEl = document.getElementById('mainBtn');
    const cluePanel = document.getElementById('cluePanel');
    const clueText = document.getElementById('clueText');
    const clueClose = document.getElementById('clueClose');
    const overlayEl = document.getElementById('overlay');

    // ========================================
    // Estado
    // ========================================
    let isTyping = false;
    let typeTimer = null;
    const reducedMotion = window.matchMedia('(prefers-reduced-motion: reduce)').matches;

    // ========================================
    // Aparición de la tarjeta
    // ========================================
    setTimeout(() => {
      card.classList.add('visible');
    }, 250);

    setTimeout(() => {
      chapterEl.classList.add('visible');
    }, 800);

    setTimeout(() => {
      startNarrative();
    }, 1100);

    // Activar tilt después de la aparición
    setTimeout(() => {
      card.classList.add('tilt-ready');
    }, 2000);

    // ========================================
    // Efecto máquina de escribir
    // ========================================
    function typeText(text, el, callback) {
      isTyping = true;
      el.innerHTML = '';

      if (reducedMotion) {
        el.textContent = text;
        isTyping = false;
        if (callback) callback();
        return;
      }

      let idx = 0;
      const cursor = document.createElement('span');
      cursor.className = 'cursor';

      function type() {
        if (idx < text.length) {
          el.innerHTML = text.substring(0, idx + 1);
          el.appendChild(cursor);
          idx++;
          typeTimer = setTimeout(type, 32);
        } else {
          isTyping = false;
          if (callback) callback();
        }
      }
      type();
    }

    // Clic para saltar la animación
    narrativeEl.addEventListener('click', () => {
      if (isTyping) {
        clearTimeout(typeTimer);
        narrativeEl.textContent = 'No fue un día cualquiera. Fue el día en que un sticker cambió el rumbo de algo que no sabías que estaba esperando.';
        isTyping = false;
        showChatSequence();
      }
    });

    // ========================================
    // Secuencia narrativa
    // ========================================
    function startNarrative() {
      typeText(
        'No fue un día cualquiera. Fue el día en que un sticker cambió el rumbo de algo que no sabías que estaba esperando.',
        narrativeEl,
        showChatSequence
      );
    }

    function showChatSequence() {
      // Mostrar separador
      setTimeout(() => {
        dividerEl.classList.add('visible');
      }, 300);

      // Mostrar sección de chat
      setTimeout(() => {
        chatEl.classList.add('visible');
        timestampEl.classList.add('visible');
      }, 500);

      // Sticker bubble
      setTimeout(() => {
        bubbleSticker.classList.add('visible');
      }, 800);

      // Indicador de escritura
      setTimeout(() => {
        typingIndicator.classList.add('visible');
      }, 1600);

      // Ocultar indicador, mostrar respuesta
      setTimeout(() => {
        typingIndicator.classList.remove('visible');
        typingIndicator.style.display = 'none';
        bubbleReply.classList.add('visible');
      }, 2800);

      // Reflexión
      setTimeout(() => {
        reflectionEl.classList.add('visible');
      }, 3600);

      // Botón
      setTimeout(() => {
        btnEl.classList.add('visible');
      }, 4400);
    }

    // ========================================
    // Botón principal — revelar pista
    // ========================================
    btnEl.addEventListener('click', () => {
      // *** CAMBIA ESTE TEXTO PARA PERSONALIZAR LA PISTA ***
      showClue('Tu primera pista está donde siempre empieza tu día. Mira con atención.');
    });

    // ========================================
    // Panel de pista
    // ========================================
    function showClue(text) {
      clueText.textContent = text;
      cluePanel.classList.add('visible');
      cluePanel.setAttribute('aria-hidden', 'false');
      overlayEl.classList.add('visible');
      clueClose.focus();
    }

    function hideClue() {
      cluePanel.classList.remove('visible');
      cluePanel.setAttribute('aria-hidden', 'true');
      overlayEl.classList.remove('visible');
    }

    clueClose.addEventListener('click', hideClue);
    overlayEl.addEventListener('click', hideClue);

    document.addEventListener('keydown', (e) => {
      if (e.key === 'Escape' && cluePanel.classList.contains('visible')) {
        hideClue();
      }
    });

    // ========================================
    // Tilt 3D sutil de la tarjeta
    // ========================================
    card.addEventListener('mousemove', (e) => {
      if (!card.classList.contains('tilt-ready')) return;
      const rect = card.getBoundingClientRect();
      const x = e.clientX - rect.left;
      const y = e.clientY - rect.top;
      const cx = rect.width / 2;
      const cy = rect.height / 2;
      const rx = ((y - cy) / cy) * -2;
      const ry = ((x - cx) / cx) * 2;
      card.style.transform = 'perspective(800px) rotateX(' + rx + 'deg) rotateY(' + ry + 'deg)';
    });

    card.addEventListener('mouseleave', () => {
      if (!card.classList.contains('tilt-ready')) return;
      card.style.transform = 'perspective(800px) rotateX(0) rotateY(0)';
    });
  </script>
</body>
</html>
