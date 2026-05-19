# VIBE DIGITAL — ESPECIFICAÇÃO DE DESIGN COMPLETA
> Design Chief + Vibe Design Agent — Documento de implementação

---

## SEÇÃO 1 — NAV/HEADER

### Conceito Visual
Navbar com glassmorphism sutil — não o blur genérico com borda branca, mas uma camada `bg-[#09090B]/80` com `backdrop-blur-xl` e uma linha inferior gerada por gradiente horizontal `#8B5CF6 → transparent → #6366F1` com apenas 1px de altura e 40% de opacity. O logo usa tratamento tipográfico onde "Vibe" está em weight 700 e cor `#FFFFFF` e "Digital" aparece em `#8B5CF6` — sem separação de linha, tudo inline. Os links de menu têm underline animado que cresce do centro para as bordas no hover.

### Layout Desktop
```
<nav class="fixed top-0 left-0 right-0 z-50 bg-[#09090B]/80 backdrop-blur-xl border-b border-[#27272A]/50">
  <div class="max-w-7xl mx-auto px-6 h-16 flex items-center justify-between">
    <!-- Logo -->
    <a href="#" class="flex items-center gap-2">
      <!-- SVG mark + texto -->
    </a>
    <!-- Links centrais -->
    <ul class="hidden lg:flex items-center gap-8">
      <!-- 4 links -->
    </ul>
    <!-- CTA + hamburger -->
    <div class="flex items-center gap-4">
      <button class="hidden lg:block ...">Fale Conosco</button>
      <button class="lg:hidden ..."><!-- hamburger SVG --></button>
    </div>
  </div>
  <!-- Linha gradiente inferior -->
  <div class="absolute bottom-0 left-0 right-0 h-px bg-gradient-to-r from-transparent via-[#8B5CF6]/40 to-transparent"></div>
</nav>
```

### Layout Mobile (375px)
Hamburger icon (3 linhas → X animado com rotate 45deg) abre um sidebar que desliza da direita com `transform: translateX(100%) → translateX(0)` e `transition: transform 0.35s cubic-bezier(0.4, 0, 0.2, 1)`. Overlay escuro `bg-[#09090B]/70 backdrop-blur-sm` cobre o restante da tela. Sidebar: `w-72 h-full bg-[#18181B] border-l border-[#27272A]`. Links no sidebar com padding `py-4 px-6`, font-size `text-lg`, com linha divisória `border-b border-[#27272A]/50` entre cada item. CTA button no final do sidebar com width full.

### Componentes Específicos

**Logo:**
```html
<a href="#" class="flex items-center gap-2.5 group">
  <!-- Mark: quadrado com canto cortado e gradiente roxo -->
  <div class="relative w-8 h-8 flex-shrink-0">
    <svg viewBox="0 0 32 32" fill="none" xmlns="http://www.w3.org/2000/svg" class="w-8 h-8">
      <defs>
        <linearGradient id="logo-grad" x1="0" y1="0" x2="32" y2="32" gradientUnits="userSpaceOnUse">
          <stop offset="0%" stop-color="#8B5CF6"/>
          <stop offset="100%" stop-color="#6366F1"/>
        </linearGradient>
      </defs>
      <!-- Forma: retângulo com canto superior direito cortado -->
      <path d="M4 4 H24 L28 8 V28 H4 Z" fill="url(#logo-grad)" opacity="0.15"/>
      <path d="M4 4 H24 L28 8 V28 H4 Z" stroke="url(#logo-grad)" stroke-width="1.5" fill="none"/>
      <!-- Letra V estilizada dentro -->
      <path d="M10 11 L16 21 L22 11" stroke="url(#logo-grad)" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round" fill="none"/>
    </svg>
  </div>
  <!-- Texto -->
  <span class="text-xl leading-none">
    <span class="font-bold text-white tracking-tight">Vibe</span>
    <span class="font-semibold text-[#8B5CF6] tracking-tight">Digital</span>
  </span>
</a>
```

**Links de navegação:**
```html
<li>
  <a href="#servicos"
     class="relative text-sm font-medium text-[#A1A1AA] hover:text-white transition-colors duration-200 py-1 group">
    Serviços
    <!-- Underline animado -->
    <span class="absolute bottom-0 left-1/2 -translate-x-1/2 h-px w-0 bg-gradient-to-r from-[#8B5CF6] to-[#6366F1]
                 group-hover:w-full transition-all duration-300 ease-out"></span>
  </a>
</li>
```

**CTA Button (header):**
```html
<button class="relative px-5 py-2 text-sm font-semibold text-white overflow-hidden rounded-lg
               bg-gradient-to-r from-[#8B5CF6] to-[#6366F1]
               hover:shadow-[0_0_20px_rgba(139,92,246,0.4)] transition-shadow duration-300
               before:absolute before:inset-0 before:bg-white/10 before:opacity-0 hover:before:opacity-100 before:transition-opacity">
  Fale Conosco
</button>
```

**Hamburger (mobile):**
```html
<button id="menu-toggle" class="lg:hidden relative w-10 h-10 flex flex-col justify-center items-center gap-1.5 rounded-lg hover:bg-[#27272A] transition-colors">
  <span class="hamburger-line w-5 h-0.5 bg-white transition-all duration-300 origin-center"></span>
  <span class="hamburger-line w-5 h-0.5 bg-white transition-all duration-300 origin-center"></span>
  <span class="hamburger-line w-5 h-0.5 bg-white transition-all duration-300 origin-center"></span>
</button>
```

### Animações & Interações
```javascript
// Hamburger → X animation
const toggle = document.getElementById('menu-toggle');
const lines = toggle.querySelectorAll('.hamburger-line');
const sidebar = document.getElementById('mobile-sidebar');
const overlay = document.getElementById('sidebar-overlay');

toggle.addEventListener('click', () => {
  const isOpen = sidebar.classList.contains('translate-x-0');
  if (isOpen) {
    sidebar.classList.replace('translate-x-0', 'translate-x-full');
    overlay.classList.add('opacity-0', 'pointer-events-none');
    lines[0].style.transform = '';
    lines[1].style.opacity = '1';
    lines[2].style.transform = '';
  } else {
    sidebar.classList.replace('translate-x-full', 'translate-x-0');
    overlay.classList.remove('opacity-0', 'pointer-events-none');
    lines[0].style.transform = 'translateY(8px) rotate(45deg)';
    lines[1].style.opacity = '0';
    lines[2].style.transform = 'translateY(-8px) rotate(-45deg)';
  }
});

// Navbar blur on scroll
window.addEventListener('scroll', () => {
  const nav = document.querySelector('nav');
  if (window.scrollY > 20) {
    nav.classList.add('shadow-[0_1px_0_rgba(39,39,42,0.8)]');
  } else {
    nav.classList.remove('shadow-[0_1px_0_rgba(39,39,42,0.8)]');
  }
});
```

### Tipografia
- Logo "Vibe": `font-bold text-xl` (#FFFFFF)
- Logo "Digital": `font-semibold text-xl` (#8B5CF6)
- Nav links: `text-sm font-medium` (#A1A1AA → #FFFFFF no hover)
- CTA button: `text-sm font-semibold` (#FFFFFF)
- Sidebar links mobile: `text-lg font-medium` (#A1A1AA → #FFFFFF)

---

## SEÇÃO 2 — HERO

### Conceito Visual
Layout split assimétrico: coluna esquerda ocupa 55% com o copy empilhado verticalmente (badge → H1 → subtítulo → CTAs → prova social), coluna direita com 45% exibe um elemento visual gerado puramente em CSS/SVG — uma "grade de conexões" abstrata representando redes digitais, com nós pulsantes e linhas de gradiente conectando-os, tudo animado. No background: 3 orbs de luz animados com `filter: blur(120px)` — um roxo (#8B5CF6) no canto superior esquerdo, um índigo (#6366F1) no canto inferior direito, e um roxo mais escuro no centro superior. O H1 usa a técnica de gradient text no segmento "crescendo na Irlanda".

### Layout Desktop
```html
<section class="relative min-h-screen flex items-center overflow-hidden bg-[#09090B] pt-16">
  <!-- Orbs de background -->
  <div class="absolute inset-0 pointer-events-none overflow-hidden">
    <div class="absolute -top-40 -left-40 w-[600px] h-[600px] rounded-full bg-[#8B5CF6]/20 blur-[120px] animate-pulse-slow"></div>
    <div class="absolute -bottom-40 -right-20 w-[500px] h-[500px] rounded-full bg-[#6366F1]/15 blur-[120px] animate-pulse-slow animation-delay-2000"></div>
    <div class="absolute top-1/4 left-1/3 w-[300px] h-[300px] rounded-full bg-[#8B5CF6]/8 blur-[80px] animate-pulse-slow animation-delay-4000"></div>
  </div>

  <!-- Grid de pontos sutil no fundo -->
  <div class="absolute inset-0 bg-[radial-gradient(circle,_#27272A_1px,_transparent_1px)] bg-[size:32px_32px] opacity-40"></div>

  <div class="relative z-10 max-w-7xl mx-auto px-6 w-full py-20 grid grid-cols-[55fr_45fr] gap-12 items-center">
    <!-- Coluna esquerda: copy -->
    <div class="flex flex-col gap-8">
      <!-- Badge -->
      <!-- H1 -->
      <!-- Subtítulo -->
      <!-- CTAs -->
      <!-- Prova social -->
    </div>

    <!-- Coluna direita: visual abstrato -->
    <div class="hidden lg:flex items-center justify-center relative h-[500px]">
      <!-- SVG de rede/conexões -->
    </div>
  </div>
</section>
```

### Layout Mobile (375px)
```html
<!-- Layout: coluna única, tudo centralizado exceto copy que fica alinhado à esquerda -->
<!-- O visual SVG some no mobile (hidden lg:flex no container) -->
<!-- Orbs reduzidos: w-[300px] h-[300px] no mobile -->
<!-- H1: text-4xl (38px), line-height: 1.15 -->
<!-- Padding lateral: px-5 -->
<!-- Gap entre elementos: gap-6 -->
<!-- Badge: centralizado no mobile -->
```

### Componentes Específicos

**Badge:**
```html
<div class="inline-flex items-center gap-2 px-4 py-2 rounded-full
            bg-[#18181B] border border-[#27272A] text-sm font-medium text-[#A1A1AA]
            hover:border-[#8B5CF6]/50 transition-colors duration-300 cursor-default
            shadow-[inset_0_1px_0_rgba(255,255,255,0.05)]">
  <span>🇧🇷</span>
  <span class="text-[#71717A]">+</span>
  <span>🇮🇪</span>
  <span class="text-[#A1A1AA]">Brasileiros na Irlanda</span>
  <!-- Dot animado verde indicando "ao vivo" -->
  <span class="relative flex h-2 w-2 ml-1">
    <span class="animate-ping absolute inline-flex h-full w-full rounded-full bg-[#8B5CF6] opacity-75"></span>
    <span class="relative inline-flex rounded-full h-2 w-2 bg-[#8B5CF6]"></span>
  </span>
</div>
```

**H1 com gradient text:**
```html
<h1 class="text-6xl xl:text-7xl font-bold leading-[1.1] tracking-tight text-white">
  Seu negócio
  <span class="block">crescendo na
    <span class="bg-gradient-to-r from-[#8B5CF6] to-[#6366F1] bg-clip-text text-transparent">
      Irlanda
    </span>
  </span>
  <span class="block text-[#A1A1AA] font-semibold text-5xl xl:text-6xl mt-1">
    — com quem entende
    <span class="text-white">os dois mundos.</span>
  </span>
</h1>
```

**Subtítulo:**
```html
<p class="text-lg text-[#A1A1AA] leading-relaxed max-w-[520px]">
  Marketing digital feito por brasileiros que vivem aqui.
  A gente fala a sua língua, conhece o mercado irlandês,
  e entrega resultado de verdade.
</p>
```

**CTAs:**
```html
<div class="flex flex-wrap gap-4">
  <!-- CTA Primário -->
  <a href="#contato"
     class="group relative inline-flex items-center gap-2 px-7 py-3.5 rounded-xl font-semibold text-white
            bg-gradient-to-r from-[#8B5CF6] to-[#6366F1] text-base
            hover:shadow-[0_0_40px_rgba(139,92,246,0.35)] transition-all duration-300
            hover:-translate-y-0.5 active:translate-y-0">
    Quero crescer agora
    <svg class="w-4 h-4 transition-transform duration-300 group-hover:translate-x-1" fill="none" viewBox="0 0 16 16">
      <path d="M3 8h10M9 4l4 4-4 4" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
    </svg>
  </a>

  <!-- CTA Secundário -->
  <a href="#servicos"
     class="group inline-flex items-center gap-2 px-7 py-3.5 rounded-xl font-semibold text-[#A1A1AA]
            border border-[#27272A] text-base bg-transparent
            hover:border-[#8B5CF6]/50 hover:text-white hover:bg-[#18181B] transition-all duration-300">
    Ver nossos serviços
  </a>
</div>
```

**Prova social (animated counter):**
```html
<div class="flex items-center gap-4 pt-2">
  <!-- Avatars empilhados -->
  <div class="flex -space-x-2.5">
    <!-- 5 círculos com gradientes de cor distintos representando avatars abstratos -->
    <div class="w-9 h-9 rounded-full border-2 border-[#09090B] bg-gradient-to-br from-[#8B5CF6] to-[#6366F1] flex items-center justify-center text-xs font-bold text-white">M</div>
    <div class="w-9 h-9 rounded-full border-2 border-[#09090B] bg-gradient-to-br from-[#6366F1] to-[#8B5CF6] flex items-center justify-center text-xs font-bold text-white">F</div>
    <div class="w-9 h-9 rounded-full border-2 border-[#09090B] bg-gradient-to-br from-[#7C3AED] to-[#8B5CF6] flex items-center justify-center text-xs font-bold text-white">R</div>
    <div class="w-9 h-9 rounded-full border-2 border-[#09090B] bg-gradient-to-br from-[#8B5CF6] to-[#4F46E5] flex items-center justify-center text-xs font-bold text-white">A</div>
    <div class="w-9 h-9 rounded-full border-2 border-[#09090B] bg-[#27272A] flex items-center justify-center text-xs font-bold text-[#A1A1AA]">+46</div>
  </div>
  <div>
    <p class="text-sm font-semibold text-white">Mais de 50 empresas</p>
    <p class="text-xs text-[#71717A]">de brasileiros na Irlanda já confiam na Vibe Digital</p>
  </div>
</div>
```

**Visual abstrato (coluna direita — SVG de rede):**
```html
<div class="relative w-full h-[500px]">
  <!-- SVG animado de nós conectados representando rede digital -->
  <svg class="absolute inset-0 w-full h-full" viewBox="0 0 440 500" fill="none">
    <defs>
      <radialGradient id="node-glow" cx="50%" cy="50%" r="50%">
        <stop offset="0%" stop-color="#8B5CF6" stop-opacity="0.6"/>
        <stop offset="100%" stop-color="#8B5CF6" stop-opacity="0"/>
      </radialGradient>
      <linearGradient id="line-grad-1" x1="0%" y1="0%" x2="100%" y2="100%">
        <stop offset="0%" stop-color="#8B5CF6" stop-opacity="0.6"/>
        <stop offset="100%" stop-color="#6366F1" stop-opacity="0"/>
      </linearGradient>
      <linearGradient id="line-grad-2" x1="100%" y1="0%" x2="0%" y2="100%">
        <stop offset="0%" stop-color="#6366F1" stop-opacity="0.5"/>
        <stop offset="100%" stop-color="#8B5CF6" stop-opacity="0.1"/>
      </linearGradient>
    </defs>

    <!-- Linhas de conexão -->
    <line x1="80" y1="120" x2="220" y2="80" stroke="url(#line-grad-1)" stroke-width="1"/>
    <line x1="220" y1="80" x2="360" y2="160" stroke="url(#line-grad-1)" stroke-width="1"/>
    <line x1="360" y1="160" x2="300" y2="300" stroke="url(#line-grad-2)" stroke-width="1"/>
    <line x1="300" y1="300" x2="160" y2="340" stroke="url(#line-grad-2)" stroke-width="1"/>
    <line x1="160" y1="340" x2="80" y2="120" stroke="url(#line-grad-1)" stroke-width="1" stroke-dasharray="4 4"/>
    <line x1="220" y1="80" x2="160" y2="340" stroke="url(#line-grad-2)" stroke-width="1" stroke-dasharray="4 4"/>
    <line x1="80" y1="120" x2="300" y2="300" stroke="url(#line-grad-1)" stroke-width="1" stroke-dasharray="6 6" stroke-opacity="0.3"/>
    <line x1="360" y1="160" x2="220" y2="400" stroke="url(#line-grad-2)" stroke-width="1"/>
    <line x1="220" y1="400" x2="160" y2="340" stroke="url(#line-grad-1)" stroke-width="1"/>
    <line x1="50" y1="280" x2="160" y2="340" stroke="url(#line-grad-2)" stroke-width="1" stroke-dasharray="4 4"/>
    <line x1="80" y1="120" x2="50" y2="280" stroke="url(#line-grad-1)" stroke-width="1" stroke-dasharray="4 4"/>
    <line x1="380" y1="380" x2="300" y2="300" stroke="url(#line-grad-2)" stroke-width="1"/>
    <line x1="380" y1="380" x2="220" y2="400" stroke="url(#line-grad-1)" stroke-width="1"/>

    <!-- Glow nos nós principais -->
    <circle cx="220" cy="80" r="30" fill="url(#node-glow)" class="animate-pulse-slow"/>
    <circle cx="300" cy="300" r="25" fill="url(#node-glow)" class="animate-pulse-slow animation-delay-1000"/>

    <!-- Nós (círculos) -->
    <!-- Nó principal central-topo: maior, representa BR+IE -->
    <circle cx="220" cy="80" r="10" fill="#8B5CF6" opacity="0.9"/>
    <circle cx="220" cy="80" r="6" fill="white" opacity="0.9"/>
    <!-- Texto do nó -->
    <text x="220" y="55" text-anchor="middle" fill="#A1A1AA" font-size="10" font-family="Inter, sans-serif">Vibe Digital</text>

    <circle cx="80" cy="120" r="7" fill="#6366F1" opacity="0.8"/>
    <circle cx="80" cy="120" r="4" fill="white" opacity="0.7"/>
    <text x="55" y="115" text-anchor="end" fill="#71717A" font-size="9" font-family="Inter, sans-serif">Dublin</text>

    <circle cx="360" cy="160" r="7" fill="#8B5CF6" opacity="0.8"/>
    <circle cx="360" cy="160" r="4" fill="white" opacity="0.7"/>
    <text x="385" y="155" fill="#71717A" font-size="9" font-family="Inter, sans-serif">Galway</text>

    <circle cx="300" cy="300" r="9" fill="#6366F1" opacity="0.9"/>
    <circle cx="300" cy="300" r="5" fill="white" opacity="0.9"/>
    <text x="325" y="295" fill="#A1A1AA" font-size="9" font-family="Inter, sans-serif">Cork</text>

    <circle cx="160" cy="340" r="7" fill="#8B5CF6" opacity="0.7"/>
    <circle cx="160" cy="340" r="4" fill="white" opacity="0.7"/>
    <text x="135" y="335" text-anchor="end" fill="#71717A" font-size="9" font-family="Inter, sans-serif">Limerick</text>

    <circle cx="220" cy="400" r="7" fill="#6366F1" opacity="0.7"/>
    <circle cx="220" cy="400" r="4" fill="white" opacity="0.7"/>
    <text x="220" y="420" text-anchor="middle" fill="#71717A" font-size="9" font-family="Inter, sans-serif">Waterford</text>

    <circle cx="50" cy="280" r="5" fill="#8B5CF6" opacity="0.5"/>
    <circle cx="380" cy="380" r="5" fill="#6366F1" opacity="0.5"/>

    <!-- Partícula viajando nas linhas (animação) -->
    <circle r="2.5" fill="#8B5CF6" opacity="0.9">
      <animateMotion dur="4s" repeatCount="indefinite" path="M80,120 L220,80 L360,160 L300,300 L160,340 L80,120"/>
    </circle>
    <circle r="2" fill="#6366F1" opacity="0.7">
      <animateMotion dur="6s" repeatCount="indefinite" begin="2s" path="M220,80 L360,160 L380,380 L220,400 L160,340 L80,120 L220,80"/>
    </circle>

    <!-- Card flutuante: "Brasil → Irlanda" -->
    <g transform="translate(290, 50)">
      <rect x="0" y="0" width="120" height="48" rx="8" fill="#18181B" stroke="#27272A" stroke-width="1"/>
      <rect x="0" y="0" width="120" height="48" rx="8" fill="url(#node-glow)" opacity="0.1"/>
      <text x="60" y="18" text-anchor="middle" fill="#71717A" font-size="9" font-family="Inter, sans-serif">Resultado médio</text>
      <text x="60" y="36" text-anchor="middle" fill="white" font-size="16" font-weight="700" font-family="Inter, sans-serif">+300% ROI</text>
    </g>

    <!-- Badge flutuante: clientes -->
    <g transform="translate(30, 380)">
      <rect x="0" y="0" width="110" height="44" rx="8" fill="#18181B" stroke="#8B5CF6" stroke-width="1" stroke-opacity="0.4"/>
      <text x="55" y="16" text-anchor="middle" fill="#71717A" font-size="8" font-family="Inter, sans-serif">Empresas atendidas</text>
      <text x="55" y="33" text-anchor="middle" fill="#8B5CF6" font-size="15" font-weight="700" font-family="Inter, sans-serif">+50 clientes</text>
    </g>
  </svg>
</div>
```

### Animações & Interações
```css
/* Pulse lento para os orbs */
@keyframes pulse-slow {
  0%, 100% { opacity: 0.6; transform: scale(1); }
  50% { opacity: 0.9; transform: scale(1.05); }
}
.animate-pulse-slow { animation: pulse-slow 6s ease-in-out infinite; }
.animation-delay-2000 { animation-delay: 2s; }
.animation-delay-4000 { animation-delay: 4s; }

/* Hero fade-in com stagger */
@keyframes fade-up {
  from { opacity: 0; transform: translateY(24px); }
  to { opacity: 1; transform: translateY(0); }
}
.hero-badge { animation: fade-up 0.6s ease-out 0.2s both; }
.hero-h1 { animation: fade-up 0.6s ease-out 0.4s both; }
.hero-sub { animation: fade-up 0.6s ease-out 0.6s both; }
.hero-ctas { animation: fade-up 0.6s ease-out 0.8s both; }
.hero-social { animation: fade-up 0.6s ease-out 1.0s both; }
.hero-visual { animation: fade-up 0.8s ease-out 0.5s both; }
```

### Tipografia
- Badge: `text-sm font-medium` (#A1A1AA)
- H1 principal: `text-6xl xl:text-7xl font-bold` (#FFFFFF), linha com gradient: `from-[#8B5CF6] to-[#6366F1]`
- H1 linha 3 (complemento): `text-5xl xl:text-6xl font-semibold` (#A1A1AA / #FFFFFF)
- Mobile H1: `text-4xl font-bold`
- Subtítulo: `text-lg font-normal leading-relaxed` (#A1A1AA)
- Mobile subtítulo: `text-base`
- CTA primário: `text-base font-semibold` (#FFFFFF)
- Prova social título: `text-sm font-semibold` (#FFFFFF)
- Prova social sub: `text-xs` (#71717A)

---

## SEÇÃO 3 — PAIN POINTS

### Conceito Visual
Abandona completamente o grid 3 colunas iguais. Usa um layout tipo "bento assimétrico em L": card 1 é grande (ocupa toda a largura superior), cards 2 e 3 ficam lado a lado na linha inferior com proporção 45/55. Cada card tem um tratamento visual de "dor" — uma linha diagonal vermelha/escura na borda esquerda, um ícone SVG que representa o problema visualmente, e o título tem uma textura de "rachado" simulado com um underline gradiente vermelho-para-transparente. Background da seção: `#09090B` com um vignette sutil nas bordas.

### Layout Desktop
```html
<section id="sobre" class="relative py-24 bg-[#09090B] overflow-hidden">
  <!-- Vignette lateral -->
  <div class="absolute inset-0 bg-[radial-gradient(ellipse_at_center,_transparent_40%,_#09090B_100%)] pointer-events-none"></div>

  <div class="max-w-7xl mx-auto px-6">
    <!-- Header da seção -->
    <div class="mb-12 max-w-2xl">
      <p class="text-[#8B5CF6] text-sm font-semibold uppercase tracking-widest mb-3">Você se reconhece?</p>
      <h2 class="text-4xl xl:text-5xl font-bold text-white leading-tight">
        Você se reconhece em alguma<br>
        <span class="text-[#A1A1AA]">dessas situações?</span>
      </h2>
      <p class="mt-4 text-[#71717A] text-lg">Se sim, você está no lugar certo.</p>
    </div>

    <!-- Bento grid assimétrico -->
    <div class="grid grid-cols-2 grid-rows-[auto_auto] gap-4">
      <!-- Card 1: full-width top -->
      <div class="col-span-2 ...">...</div>
      <!-- Card 2: 45% width -->
      <div class="col-span-1 ...">...</div>
      <!-- Card 3: 55% width -->
      <div class="col-span-1 ...">...</div>
    </div>

    <!-- CTA -->
    <div class="mt-10 text-center">...</div>
  </div>
</section>
```

Para o grid 45/55 usar:
```html
<div class="grid grid-cols-[45fr_55fr] gap-4 mt-4">
```

### Layout Mobile (375px)
Cards empilhados verticalmente, `grid-cols-1`. Card 1 continua sendo o maior visualmente pelo conteúdo. Padding: `px-5 py-16`. Gap entre cards: `gap-3`.

### Componentes Específicos

**Card de Pain Point:**
```html
<div class="group relative bg-[#18181B] rounded-2xl p-7 xl:p-8 overflow-hidden
            border border-[#27272A] hover:border-[#8B5CF6]/30 transition-all duration-500
            hover:bg-[#1C1C20] cursor-default">

  <!-- Linha lateral de "dor" (accent bar) -->
  <div class="absolute left-0 top-6 bottom-6 w-0.5 bg-gradient-to-b from-[#EF4444]/60 via-[#EF4444]/20 to-transparent rounded-full"></div>

  <!-- Ícone SVG no canto superior direito, grande e decorativo -->
  <div class="absolute top-5 right-6 opacity-10 group-hover:opacity-20 transition-opacity duration-500">
    <!-- SVG do ícone (veja abaixo) — 64x64 -->
  </div>

  <!-- Número decorativo muito grande -->
  <span class="absolute bottom-4 right-6 text-[120px] font-black text-white/[0.02] leading-none select-none pointer-events-none group-hover:text-white/[0.04] transition-colors duration-500">
    01
  </span>

  <!-- Conteúdo -->
  <div class="relative z-10">
    <div class="flex items-start gap-4 mb-4">
      <!-- Ícone pequeno colorido -->
      <div class="w-10 h-10 rounded-xl bg-[#EF4444]/10 border border-[#EF4444]/20 flex items-center justify-center flex-shrink-0">
        <!-- SVG 20x20 -->
      </div>
      <h3 class="text-xl font-bold text-white pt-1.5 leading-snug">
        Agência que não te entende
      </h3>
    </div>
    <p class="text-[#A1A1AA] leading-relaxed text-base">
      Já tentou trabalhar com agência irlandesa e ficou se perdendo na comunicação...
    </p>
  </div>

  <!-- Hover shimmer -->
  <div class="absolute inset-0 bg-gradient-to-r from-transparent via-white/[0.02] to-transparent
              translate-x-[-100%] group-hover:translate-x-[100%] transition-transform duration-700 pointer-events-none"></div>
</div>
```

### Ícones SVG (Pain Points)

**Ícone 1 — Comunicação perdida (balão com X):**
```html
<svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
  <path d="M21 15a2 2 0 01-2 2H7l-4 4V5a2 2 0 012-2h14a2 2 0 012 2v10z"
        stroke="#EF4444" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
  <path d="M9 10l6 0M9 14l4 0" stroke="#EF4444" stroke-width="1.5" stroke-linecap="round"/>
  <circle cx="18" cy="4" r="3" fill="#EF4444"/>
  <path d="M16.5 2.5l3 3M19.5 2.5l-3 3" stroke="white" stroke-width="1.5" stroke-linecap="round"/>
</svg>
```

**Ícone 2 — Dinheiro perdido (moeda descendo):**
```html
<svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
  <circle cx="12" cy="12" r="9" stroke="#EF4444" stroke-width="1.5"/>
  <path d="M12 7v10M14.5 9.5C14.5 8.4 13.38 8 12 8s-2.5.4-2.5 1.5 1 1.5 2.5 2 2.5 1 2.5 2-1.12 1.5-2.5 1.5S9.5 14.6 9.5 13.5"
        stroke="#EF4444" stroke-width="1.5" stroke-linecap="round"/>
  <path d="M17 20l2 2M21 20l-2 2" stroke="#EF4444" stroke-width="1.5" stroke-linecap="round"/>
</svg>
```

**Ícone 3 — Paralisia/bússola sem norte:**
```html
<svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
  <circle cx="12" cy="12" r="9" stroke="#EF4444" stroke-width="1.5"/>
  <path d="M12 3v2M12 19v2M3 12h2M19 12h2" stroke="#EF4444" stroke-width="1.5" stroke-linecap="round"/>
  <path d="M8 8l2.5 4-2.5 4 8-4-8-4z" stroke="#EF4444" stroke-width="1.5" stroke-linejoin="round" fill="#EF4444" fill-opacity="0.2"/>
  <!-- X sobre a bússola indicando sem direção -->
  <path d="M14.5 9.5l3 3M17.5 9.5l-3 3" stroke="#EF4444" stroke-width="1.5" stroke-linecap="round" opacity="0.5"/>
</svg>
```

**CTA da seção:**
```html
<a href="#servicos"
   class="group inline-flex items-center gap-2 text-[#8B5CF6] font-semibold text-base
          hover:text-[#A78BFA] transition-colors duration-200">
  A Vibe resolve isso. Veja como
  <svg class="w-4 h-4 transition-transform duration-300 group-hover:translate-x-1" fill="none" viewBox="0 0 16 16">
    <path d="M3 8h10M9 4l4 4-4 4" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
  </svg>
</a>
```

### Animações & Interações
```javascript
// Intersection Observer: cards entram com stagger
const observer = new IntersectionObserver((entries) => {
  entries.forEach(entry => {
    if (entry.isIntersecting) {
      const cards = entry.target.querySelectorAll('.pain-card');
      cards.forEach((card, i) => {
        card.style.animationDelay = `${i * 0.15}s`;
        card.classList.add('animate-fade-up');
      });
      observer.unobserve(entry.target);
    }
  });
}, { threshold: 0.1 });
```
```css
@keyframes fade-up {
  from { opacity: 0; transform: translateY(32px); }
  to { opacity: 1; transform: translateY(0); }
}
.animate-fade-up { animation: fade-up 0.65s ease-out both; }
```

### Tipografia
- Label acima: `text-sm font-semibold uppercase tracking-widest` (#8B5CF6)
- H2: `text-4xl xl:text-5xl font-bold` (#FFFFFF / #A1A1AA)
- Mobile H2: `text-3xl`
- Card título: `text-xl font-bold` (#FFFFFF)
- Card texto: `text-base leading-relaxed` (#A1A1AA)
- Número decorativo: `text-[120px] font-black` (#FFFFFF/2%)

---

## SEÇÃO 4 — QUEM SOMOS

### Conceito Visual
"Dois mundos se encontrando" — layout dividido com uma diagonal. À esquerda, o copy (textos, bullets). À direita, um elemento visual abstrato: dois semicírculos sobrepostos representando Brasil e Irlanda, com as bandeiras reduzidas a suas cores dominantes (verde/amarelo do Brasil e laranja/verde da Irlanda) fundindo-se no centro em gradiente roxo (a Vibe como ponte). Os bullets usam um checkmark SVG custom em gradiente roxo dentro de um círculo, não um simples ✓. Background: `#18181B` para diferenciar da seção anterior.

### Layout Desktop
```html
<section id="sobre" class="relative py-24 bg-[#18181B] overflow-hidden">
  <!-- Gradiente diagonal de fundo -->
  <div class="absolute inset-0 bg-gradient-to-br from-[#8B5CF6]/5 via-transparent to-[#6366F1]/5 pointer-events-none"></div>

  <div class="max-w-7xl mx-auto px-6">
    <div class="grid grid-cols-[55fr_45fr] gap-16 items-center">
      <!-- Coluna esquerda: copy -->
      <div class="flex flex-col gap-8">
        <div>
          <p class="text-[#8B5CF6] text-sm font-semibold uppercase tracking-widest mb-4">Quem somos</p>
          <h2 class="text-4xl xl:text-5xl font-bold text-white leading-tight">
            Somos brasileiros na Irlanda.
            <span class="text-[#8B5CF6]">Assim como você.</span>
          </h2>
        </div>
        <!-- 3 parágrafos -->
        <!-- Bullets -->
      </div>

      <!-- Coluna direita: visual "dois mundos" -->
      <div class="relative h-[480px] flex items-center justify-center">
        <!-- Visual SVG -->
      </div>
    </div>
  </div>
</section>
```

### Layout Mobile (375px)
`grid-cols-1`. O visual dos dois mundos aparece ACIMA do copy (ordem invertida com `order-first`), redimensionado para `h-[280px]`. Copy abaixo. Padding: `px-5 py-16`.

### Componentes Específicos

**Visual "Dois Mundos" (coluna direita):**
```html
<div class="relative w-full h-[480px]">
  <svg viewBox="0 0 400 480" class="w-full h-full" fill="none">
    <defs>
      <radialGradient id="br-grad" cx="30%" cy="50%" r="60%">
        <stop offset="0%" stop-color="#22C55E" stop-opacity="0.15"/>
        <stop offset="60%" stop-color="#EAB308" stop-opacity="0.08"/>
        <stop offset="100%" stop-color="transparent" stop-opacity="0"/>
      </radialGradient>
      <radialGradient id="ie-grad" cx="70%" cy="50%" r="60%">
        <stop offset="0%" stop-color="#F97316" stop-opacity="0.15"/>
        <stop offset="60%" stop-color="#16A34A" stop-opacity="0.08"/>
        <stop offset="100%" stop-color="transparent" stop-opacity="0"/>
      </radialGradient>
      <radialGradient id="vibe-center" cx="50%" cy="50%" r="50%">
        <stop offset="0%" stop-color="#8B5CF6" stop-opacity="0.3"/>
        <stop offset="100%" stop-color="#6366F1" stop-opacity="0"/>
      </radialGradient>
      <clipPath id="left-half">
        <rect x="0" y="0" width="200" height="480"/>
      </clipPath>
      <clipPath id="right-half">
        <rect x="200" y="0" width="200" height="480"/>
      </clipPath>
    </defs>

    <!-- Background orbs dos mundos -->
    <circle cx="140" cy="240" r="160" fill="url(#br-grad)"/>
    <circle cx="260" cy="240" r="160" fill="url(#ie-grad)"/>

    <!-- Círculo central Vibe (fusão) -->
    <circle cx="200" cy="240" r="80" fill="url(#vibe-center)"/>
    <circle cx="200" cy="240" r="80" stroke="#8B5CF6" stroke-width="1" stroke-opacity="0.3" stroke-dasharray="4 4"/>

    <!-- Círculo Brasil -->
    <circle cx="130" cy="200" r="55" stroke="#22C55E" stroke-width="1.5" stroke-opacity="0.4" fill="none"/>
    <circle cx="130" cy="200" r="55" fill="#22C55E" fill-opacity="0.04"/>
    <!-- Flag hint BR -->
    <text x="130" y="200" text-anchor="middle" dominant-baseline="middle" font-size="28">🇧🇷</text>
    <text x="130" y="225" text-anchor="middle" fill="#22C55E" font-size="10" font-family="Inter, sans-serif" opacity="0.7">Brasil</text>

    <!-- Círculo Irlanda -->
    <circle cx="270" cy="200" r="55" stroke="#F97316" stroke-width="1.5" stroke-opacity="0.4" fill="none"/>
    <circle cx="270" cy="200" r="55" fill="#F97316" fill-opacity="0.04"/>
    <!-- Flag hint IE -->
    <text x="270" y="200" text-anchor="middle" dominant-baseline="middle" font-size="28">🇮🇪</text>
    <text x="270" y="225" text-anchor="middle" fill="#F97316" font-size="10" font-family="Inter, sans-serif" opacity="0.7">Irlanda</text>

    <!-- Logo central Vibe (fusão) -->
    <circle cx="200" cy="240" r="36" fill="#18181B" stroke="#8B5CF6" stroke-width="1.5"/>
    <text x="200" y="235" text-anchor="middle" fill="#8B5CF6" font-size="9" font-family="Inter, sans-serif" font-weight="600">VIBE</text>
    <text x="200" y="250" text-anchor="middle" fill="#6366F1" font-size="8" font-family="Inter, sans-serif">DIGITAL</text>

    <!-- Linhas de conexão dos mundos para o centro -->
    <line x1="155" y1="215" x2="164" y2="228" stroke="#8B5CF6" stroke-width="1" stroke-opacity="0.5"/>
    <line x1="245" y1="215" x2="236" y2="228" stroke="#8B5CF6" stroke-width="1" stroke-opacity="0.5"/>

    <!-- Stats flutuantes -->
    <g transform="translate(20, 320)">
      <rect width="130" height="52" rx="10" fill="#18181B" stroke="#27272A" stroke-width="1"/>
      <text x="65" y="20" text-anchor="middle" fill="#71717A" font-size="9" font-family="Inter, sans-serif">Equipe baseada em</text>
      <text x="65" y="38" text-anchor="middle" fill="white" font-size="13" font-weight="700" font-family="Inter, sans-serif">Dublin, Ireland 🇮🇪</text>
    </g>
    <g transform="translate(245, 340)">
      <rect width="130" height="52" rx="10" fill="#18181B" stroke="#27272A" stroke-width="1"/>
      <text x="65" y="20" text-anchor="middle" fill="#71717A" font-size="9" font-family="Inter, sans-serif">Atendimento</text>
      <text x="65" y="38" text-anchor="middle" fill="#8B5CF6" font-size="13" font-weight="700" font-family="Inter, sans-serif">100% em Português</text>
    </g>
  </svg>
</div>
```

**Bullets com SVG custom:**
```html
<ul class="flex flex-col gap-4 mt-6">
  <li class="flex items-start gap-3">
    <!-- Checkmark gradiente em círculo -->
    <div class="w-6 h-6 rounded-full bg-gradient-to-br from-[#8B5CF6] to-[#6366F1] flex items-center justify-center flex-shrink-0 mt-0.5 shadow-[0_0_12px_rgba(139,92,246,0.3)]">
      <svg viewBox="0 0 12 12" class="w-3.5 h-3.5" fill="none">
        <path d="M2 6.5l2.5 2.5 5.5-6" stroke="white" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
      </svg>
    </div>
    <span class="text-[#A1A1AA] text-base leading-snug pt-0.5">
      Equipe 100% brasileira baseada na Irlanda
    </span>
  </li>
  <!-- Repetir para os 4 bullets -->
</ul>
```

### Animações & Interações
```css
/* Stagger para bullets */
.bullet-item { opacity: 0; transform: translateX(-16px); transition: all 0.5s ease-out; }
.bullet-item.visible { opacity: 1; transform: translateX(0); }

/* Visual dois mundos: círculos pulsam em alternância */
@keyframes world-pulse {
  0%, 100% { opacity: 0.4; }
  50% { opacity: 0.8; }
}
```
```javascript
// Observer para bullets com stagger
const bulletObserver = new IntersectionObserver((entries) => {
  entries.forEach(entry => {
    if (entry.isIntersecting) {
      const bullets = entry.target.querySelectorAll('.bullet-item');
      bullets.forEach((b, i) => {
        setTimeout(() => b.classList.add('visible'), i * 120);
      });
    }
  });
}, { threshold: 0.2 });
```

### Tipografia
- Label: `text-sm font-semibold uppercase tracking-widest` (#8B5CF6)
- H2: `text-4xl xl:text-5xl font-bold` (#FFFFFF)
- H2 destaque: `text-[#8B5CF6]`
- Mobile H2: `text-3xl`
- Parágrafos: `text-base leading-relaxed` (#A1A1AA)
- Bullets: `text-base` (#A1A1AA)

---

## SEÇÃO 5 — SERVIÇOS

### Conceito Visual
Bento box assimétrico com 6 cards em layout não-regular. Grid de 3 colunas onde cards têm alturas e spans diferentes. O card de "Tráfego Pago" (mais importante) ocupa 2 colunas na primeira linha com altura maior. "Gestão de Redes" ocupa 1 coluna. Na segunda linha: "Sites" ocupa 1 coluna, "SEO" ocupa 1 coluna, "Branding" ocupa 1 coluna. "Consultoria" vai na terceira linha com span 3 em formato horizontal compacto. Cada card tem numeração grande decorativa (`01`–`06`) em `text-[#8B5CF6]/10` no fundo, e ícone SVG completamente único. Hover state: card levanta com `translateY(-4px)` + borda roxa + glow suave + ícone rotaciona 5deg.

### Layout Desktop
```html
<section id="servicos" class="relative py-24 bg-[#09090B]">
  <!-- Linha de separação com gradiente no topo -->
  <div class="absolute top-0 left-0 right-0 h-px bg-gradient-to-r from-transparent via-[#27272A] to-transparent"></div>

  <div class="max-w-7xl mx-auto px-6">
    <div class="text-center mb-16">
      <p class="text-[#8B5CF6] text-sm font-semibold uppercase tracking-widest mb-3">Nossos serviços</p>
      <h2 class="text-4xl xl:text-5xl font-bold text-white">
        Tudo que seu negócio precisa<br>
        <span class="text-[#A1A1AA] font-semibold">para crescer online na Irlanda</span>
      </h2>
      <p class="mt-4 text-[#71717A] text-lg">Sem pacote engessado. Você escolhe o que faz sentido agora.</p>
    </div>

    <!-- Bento Grid -->
    <div class="grid grid-cols-3 gap-4">
      <!-- Card 1: 2 colunas -->
      <div class="col-span-2 service-card" data-num="01">...</div>
      <!-- Card 2: 1 coluna -->
      <div class="col-span-1 service-card" data-num="02">...</div>
      <!-- Card 3: 1 coluna -->
      <div class="col-span-1 service-card" data-num="03">...</div>
      <!-- Card 4: 1 coluna -->
      <div class="col-span-1 service-card" data-num="04">...</div>
      <!-- Card 5: 1 coluna -->
      <div class="col-span-1 service-card" data-num="05">...</div>
      <!-- Card 6: 3 colunas (horizontal) -->
      <div class="col-span-3 service-card service-card--wide" data-num="06">...</div>
    </div>

    <!-- CTA -->
    <div class="mt-12 text-center">...</div>
  </div>
</section>
```

### Layout Mobile (375px)
`grid-cols-1` — todos os cards em coluna única. `gap-3`. Card 6 (Consultoria) retorna ao layout normal de card. Padding: `px-5 py-16`.

### Componentes Específicos

**Service Card (padrão):**
```html
<div class="service-card group relative bg-[#18181B] rounded-2xl p-7 overflow-hidden
            border border-[#27272A] cursor-default
            hover:border-[#8B5CF6]/40 hover:-translate-y-1 hover:shadow-[0_16px_40px_rgba(139,92,246,0.12)]
            transition-all duration-400 ease-out min-h-[200px] flex flex-col justify-between">

  <!-- Número decorativo de fundo -->
  <span class="absolute bottom-4 right-6 text-[100px] font-black text-[#8B5CF6]/[0.06] leading-none select-none pointer-events-none
               group-hover:text-[#8B5CF6]/[0.1] transition-colors duration-400">01</span>

  <!-- Gradiente de hover no topo -->
  <div class="absolute top-0 left-0 right-0 h-0.5 bg-gradient-to-r from-[#8B5CF6] to-[#6366F1]
              scale-x-0 group-hover:scale-x-100 transition-transform duration-400 origin-left rounded-t-2xl"></div>

  <!-- Conteúdo -->
  <div class="relative z-10">
    <!-- Ícone -->
    <div class="w-12 h-12 rounded-xl bg-[#8B5CF6]/10 border border-[#8B5CF6]/20
                flex items-center justify-center mb-5
                group-hover:bg-[#8B5CF6]/15 group-hover:rotate-3 transition-all duration-300">
      <!-- SVG 24x24 -->
    </div>
    <!-- Título -->
    <h3 class="text-lg font-bold text-white mb-3 group-hover:text-[#A78BFA] transition-colors duration-300">
      Tráfego Pago
    </h3>
    <!-- Descrição -->
    <p class="text-[#71717A] text-sm leading-relaxed">
      Meta Ads e Google Ads com segmentação precisa para o mercado irlandês...
    </p>
  </div>

  <!-- Tag (apenas no card 1, o grande) -->
  <div class="mt-4 inline-flex items-center gap-1.5 px-3 py-1 rounded-full bg-[#8B5CF6]/10 border border-[#8B5CF6]/20 text-xs font-medium text-[#8B5CF6]">
    ✦ Mais solicitado
  </div>
</div>
```

**Service Card Wide (Consultoria — col-span-3):**
```html
<div class="service-card--wide group relative bg-[#18181B] rounded-2xl px-8 py-6 overflow-hidden
            border border-[#27272A] cursor-default
            hover:border-[#8B5CF6]/40 hover:shadow-[0_16px_40px_rgba(139,92,246,0.12)]
            transition-all duration-400 flex items-center gap-8">
  <!-- Ícone à esquerda -->
  <div class="w-14 h-14 rounded-xl bg-[#8B5CF6]/10 border border-[#8B5CF6]/20 flex items-center justify-center flex-shrink-0
              group-hover:bg-[#8B5CF6]/15 group-hover:rotate-3 transition-all duration-300">
    <!-- SVG -->
  </div>
  <!-- Copy central -->
  <div class="flex-1">
    <div class="flex items-center gap-3 mb-2">
      <h3 class="text-lg font-bold text-white group-hover:text-[#A78BFA] transition-colors">Consultoria Estratégica</h3>
      <span class="text-[#8B5CF6] text-sm opacity-30 font-black">06</span>
    </div>
    <p class="text-[#71717A] text-sm leading-relaxed max-w-2xl">Diagnóstico honesto do seu negócio e um plano de ação concreto...</p>
  </div>
  <!-- Seta à direita -->
  <svg class="w-5 h-5 text-[#27272A] group-hover:text-[#8B5CF6] group-hover:translate-x-1 transition-all duration-300 flex-shrink-0" fill="none" viewBox="0 0 20 20">
    <path d="M4 10h12M12 6l4 4-4 4" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
  </svg>
  <!-- Número de fundo -->
  <span class="absolute bottom-2 right-8 text-[80px] font-black text-[#8B5CF6]/[0.04] leading-none select-none pointer-events-none">06</span>
</div>
```

### Ícones SVG Serviços (24x24, stroke, únicos)

**Tráfego Pago (foguete/seta para cima com alvo):**
```html
<svg viewBox="0 0 24 24" fill="none" stroke="#8B5CF6" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round">
  <path d="M12 2C12 2 7 5 7 12h10c0-7-5-10-5-10z"/>
  <path d="M9 12v4l3 3 3-3v-4"/>
  <path d="M7 12c-2 0-3 1-3 2s1 1 3 2"/>
  <path d="M17 12c2 0 3 1 3 2s-1 1-3 2"/>
  <circle cx="12" cy="9" r="1.5" fill="#8B5CF6"/>
</svg>
```

**Gestão de Redes Sociais (rede de nós/posts):**
```html
<svg viewBox="0 0 24 24" fill="none" stroke="#8B5CF6" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round">
  <circle cx="18" cy="5" r="2"/>
  <circle cx="6" cy="12" r="2"/>
  <circle cx="18" cy="19" r="2"/>
  <path d="M8 11l8-5M8 13l8 5"/>
  <path d="M12 12h0" stroke-width="2"/>
</svg>
```

**Sites e Landing Pages (janela com cursor e raio):**
```html
<svg viewBox="0 0 24 24" fill="none" stroke="#8B5CF6" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round">
  <rect x="2" y="4" width="20" height="14" rx="2"/>
  <path d="M2 8h20"/>
  <circle cx="5" cy="6" r="0.75" fill="#8B5CF6" stroke="none"/>
  <circle cx="8" cy="6" r="0.75" fill="#8B5CF6" stroke="none"/>
  <path d="M11 13l2-4 1.5 3 1-2 1.5 3" stroke-width="1.25"/>
  <path d="M8 20h8" stroke-width="1.5"/>
  <path d="M12 18v2"/>
</svg>
```

**SEO (lupa com gráfico ascendente):**
```html
<svg viewBox="0 0 24 24" fill="none" stroke="#8B5CF6" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round">
  <circle cx="10" cy="10" r="7"/>
  <path d="M21 21l-4.35-4.35"/>
  <path d="M7 12l2-2.5 2 1.5 2-3" stroke-width="1.25"/>
</svg>
```

**Branding (diamante/cristal):**
```html
<svg viewBox="0 0 24 24" fill="none" stroke="#8B5CF6" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round">
  <path d="M6 3h12l4 6-10 12L2 9l4-6z"/>
  <path d="M2 9h20"/>
  <path d="M12 3l4 6-4 12-4-12 4-6z"/>
</svg>
```

**Consultoria (bússola com checkmark):**
```html
<svg viewBox="0 0 24 24" fill="none" stroke="#8B5CF6" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round">
  <circle cx="12" cy="12" r="9"/>
  <path d="M12 3v2M12 19v2M3 12h2M19 12h2"/>
  <path d="M8.5 8.5l3.5 3.5 4-4" stroke-width="1.5"/>
</svg>
```

### Animações & Interações
```javascript
// Stagger dos cards ao entrar na viewport
const serviceObserver = new IntersectionObserver((entries) => {
  entries.forEach(entry => {
    if (entry.isIntersecting) {
      const cards = entry.target.querySelectorAll('.service-card');
      cards.forEach((card, i) => {
        setTimeout(() => {
          card.style.opacity = '1';
          card.style.transform = 'translateY(0)';
        }, i * 80);
      });
    }
  });
}, { threshold: 0.1 });

// Estado inicial dos cards para animação
document.querySelectorAll('.service-card').forEach(card => {
  card.style.opacity = '0';
  card.style.transform = 'translateY(24px)';
  card.style.transition = 'opacity 0.5s ease-out, transform 0.5s ease-out';
});
```

### Tipografia
- Label: `text-sm font-semibold uppercase tracking-widest` (#8B5CF6)
- H2: `text-4xl xl:text-5xl font-bold` (#FFFFFF)
- Mobile H2: `text-3xl`
- Card título: `text-lg font-bold` (#FFFFFF → #A78BFA no hover)
- Card texto: `text-sm leading-relaxed` (#71717A)
- Número decorativo: `text-[100px] font-black` (#8B5CF6/6%)

---

## SEÇÃO 6 — COMO FUNCIONA

### Conceito Visual
Timeline vertical com zigzag — os 3 passos alternam de lado (esquerda → direita → esquerda) em desktop. A linha conectora é uma linha pontilhada com gradiente roxo que flui verticalmente entre os passos, com um círculo numerado no ponto de interseção. Cada passo tem um número GIGANTE (01, 02, 03) em gradiente roxo/transparente como elemento decorativo no fundo do card. O card em hover tem o número grande iluminando. Background: `#18181B`.

### Layout Desktop
```html
<section id="como-funciona" class="relative py-24 bg-[#18181B] overflow-hidden">
  <div class="max-w-7xl mx-auto px-6">
    <!-- Header -->
    <div class="text-center mb-20">
      <p class="text-[#8B5CF6] text-sm font-semibold uppercase tracking-widest mb-3">Processo</p>
      <h2 class="text-4xl xl:text-5xl font-bold text-white">
        Do primeiro contato ao resultado<br>
        <span class="text-[#A1A1AA] font-semibold">em 3 passos simples</span>
      </h2>
      <p class="mt-4 text-[#71717A] text-lg">Sem processo complicado, sem reunião interminável, sem surpresa no caminho.</p>
    </div>

    <!-- Timeline container -->
    <div class="relative max-w-4xl mx-auto">
      <!-- Linha vertical conectora -->
      <div class="absolute left-1/2 top-10 bottom-10 w-px bg-gradient-to-b from-[#8B5CF6]/60 via-[#6366F1]/40 to-[#8B5CF6]/20 -translate-x-1/2"></div>

      <!-- Passo 1: card à esquerda -->
      <div class="flex items-center gap-8 mb-16">
        <div class="w-[calc(50%-32px)] step-card"><!-- card passo 1 --></div>
        <div class="step-node flex-shrink-0 z-10"><!-- nó 01 --></div>
        <div class="w-[calc(50%-32px)]"><!-- espaço vazio --></div>
      </div>

      <!-- Passo 2: card à direita -->
      <div class="flex items-center gap-8 mb-16 flex-row-reverse">
        <div class="w-[calc(50%-32px)] step-card"><!-- card passo 2 --></div>
        <div class="step-node flex-shrink-0 z-10"><!-- nó 02 --></div>
        <div class="w-[calc(50%-32px)]"><!-- espaço vazio --></div>
      </div>

      <!-- Passo 3: card à esquerda -->
      <div class="flex items-center gap-8">
        <div class="w-[calc(50%-32px)] step-card"><!-- card passo 3 --></div>
        <div class="step-node flex-shrink-0 z-10"><!-- nó 03 --></div>
        <div class="w-[calc(50%-32px)]"><!-- espaço vazio --></div>
      </div>
    </div>

    <!-- CTA -->
    <div class="mt-16 text-center">...</div>
  </div>
</section>
```

### Layout Mobile (375px)
Timeline vertical linear (sem zigzag), todos os cards em coluna única, linha conectora à esquerda com `left-6`. Nós ficam à esquerda dos cards. `grid-cols-1`. Layout: `flex flex-col gap-0` com linha vertical `ml-6`.

### Componentes Específicos

**Nó numerado da timeline:**
```html
<div class="step-node relative w-14 h-14 flex-shrink-0 z-10">
  <!-- Glow de fundo -->
  <div class="absolute inset-0 rounded-full bg-[#8B5CF6]/20 blur-md"></div>
  <!-- Círculo principal -->
  <div class="relative w-14 h-14 rounded-full bg-gradient-to-br from-[#8B5CF6] to-[#6366F1]
              flex items-center justify-center shadow-[0_0_20px_rgba(139,92,246,0.4)]">
    <span class="text-lg font-black text-white">01</span>
  </div>
</div>
```

**Card de passo:**
```html
<div class="step-card group relative bg-[#09090B] rounded-2xl p-7 overflow-hidden
            border border-[#27272A] hover:border-[#8B5CF6]/30
            hover:shadow-[0_8px_32px_rgba(139,92,246,0.1)] transition-all duration-400">

  <!-- Número decorativo grande de fundo -->
  <span class="absolute -bottom-4 -right-4 text-[110px] font-black leading-none select-none pointer-events-none
               text-[#8B5CF6]/[0.05] group-hover:text-[#8B5CF6]/[0.09] transition-colors duration-400">01</span>

  <!-- Header com título -->
  <div class="relative z-10">
    <div class="flex items-center gap-3 mb-4">
      <!-- Ícone do passo -->
      <div class="w-10 h-10 rounded-xl bg-[#8B5CF6]/10 border border-[#8B5CF6]/20 flex items-center justify-center">
        <!-- SVG 20x20 -->
      </div>
      <h3 class="text-xl font-bold text-white">Conversa gratuita</h3>
    </div>
    <p class="text-[#A1A1AA] text-base leading-relaxed">
      Me conta o seu negócio, seus desafios e onde você quer chegar...
    </p>
    <!-- Badge de tempo -->
    <div class="mt-4 inline-flex items-center gap-2 text-xs text-[#71717A]">
      <svg class="w-3.5 h-3.5 text-[#8B5CF6]" fill="none" viewBox="0 0 14 14">
        <circle cx="7" cy="7" r="6" stroke="currentColor" stroke-width="1.2"/>
        <path d="M7 4v3l2 2" stroke="currentColor" stroke-width="1.2" stroke-linecap="round"/>
      </svg>
      30 minutos
    </div>
  </div>
</div>
```

### Ícones SVG dos Passos

**Passo 1 — Conversa (microfone/chat):**
```html
<svg viewBox="0 0 20 20" fill="none" stroke="#8B5CF6" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round">
  <path d="M10 2a4 4 0 014 4v3a4 4 0 01-8 0V6a4 4 0 014-4z"/>
  <path d="M4 10a6 6 0 0012 0"/>
  <path d="M10 16v2M8 18h4"/>
</svg>
```

**Passo 2 — Estratégia (mapa/diagrama):**
```html
<svg viewBox="0 0 20 20" fill="none" stroke="#8B5CF6" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round">
  <rect x="2" y="3" width="16" height="12" rx="2"/>
  <path d="M2 7h16"/>
  <path d="M6 11h2M10 11h2M6 13.5h6"/>
  <circle cx="5" cy="5" r="0.75" fill="#8B5CF6" stroke="none"/>
</svg>
```

**Passo 3 — Execução (raio/resultado):**
```html
<svg viewBox="0 0 20 20" fill="none" stroke="#8B5CF6" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round">
  <path d="M11 2L5 11h5l-1 7 6-9h-5l1-7z" stroke-linejoin="round"/>
</svg>
```

### Animações & Interações
```css
/* Linha timeline se desenha de cima para baixo */
@keyframes draw-line {
  from { transform: scaleY(0); transform-origin: top; }
  to { transform: scaleY(1); transform-origin: top; }
}

/* Cards da timeline: entram deslizando do lado */
.step-card-left { opacity: 0; transform: translateX(-40px); transition: all 0.6s ease-out; }
.step-card-right { opacity: 0; transform: translateX(40px); transition: all 0.6s ease-out; }
.step-card-left.visible, .step-card-right.visible { opacity: 1; transform: translateX(0); }

/* Nós: escalam de 0 para 1 com bounce */
.step-node { opacity: 0; transform: scale(0); transition: all 0.4s cubic-bezier(0.34, 1.56, 0.64, 1); }
.step-node.visible { opacity: 1; transform: scale(1); }
```

### Tipografia
- Label: `text-sm font-semibold uppercase tracking-widest` (#8B5CF6)
- H2: `text-4xl xl:text-5xl font-bold` (#FFFFFF / #A1A1AA)
- Mobile H2: `text-3xl`
- Step title: `text-xl font-bold` (#FFFFFF)
- Step text: `text-base leading-relaxed` (#A1A1AA)
- Número nó: `text-lg font-black` (#FFFFFF)
- Número decorativo fundo: `text-[110px] font-black` (#8B5CF6/5%)
- Badge tempo: `text-xs` (#71717A)

---

## SEÇÃO 7 — NÚMEROS/MÉTRICAS

### Conceito Visual
Background diferenciado: usa `#09090B` com um overlay de gradiente radial central em roxo (`radial-gradient(ellipse at center, #8B5CF6/15 0%, transparent 70%)`). Os 4 números são PROTAGONISTAS — cada métrica ocupa um quadrante numa grade 2x2, com o número em `text-7xl xl:text-8xl font-black` com gradient text roxo. Linha divisória `#27272A/50` entre os quadrantes. Animação de count-up disparada por Intersection Observer.

### Layout Desktop
```html
<section class="relative py-24 bg-[#09090B] overflow-hidden">
  <!-- Gradiente radial de fundo -->
  <div class="absolute inset-0 bg-[radial-gradient(ellipse_at_center,_rgba(139,92,246,0.12)_0%,_transparent_70%)] pointer-events-none"></div>

  <!-- Linhas decorativas cruzadas -->
  <div class="absolute inset-0 pointer-events-none">
    <div class="absolute top-1/2 left-0 right-0 h-px bg-[#27272A]/40"></div>
    <div class="absolute left-1/2 top-0 bottom-0 w-px bg-[#27272A]/40"></div>
  </div>

  <div class="max-w-7xl mx-auto px-6">
    <!-- Headline acima -->
    <div class="text-center mb-16">
      <h2 class="text-4xl xl:text-5xl font-bold text-white">
        Resultado não é promessa.
        <span class="bg-gradient-to-r from-[#8B5CF6] to-[#6366F1] bg-clip-text text-transparent"> É número.</span>
      </h2>
    </div>

    <!-- Grid 2x2 de métricas -->
    <div class="grid grid-cols-2 divide-x divide-y divide-[#27272A]/50 border border-[#27272A]/50 rounded-3xl overflow-hidden max-w-4xl mx-auto">
      <div class="metric-item p-10 xl:p-14 text-center">...</div>
      <div class="metric-item p-10 xl:p-14 text-center">...</div>
      <div class="metric-item p-10 xl:p-14 text-center">...</div>
      <div class="metric-item p-10 xl:p-14 text-center">...</div>
    </div>
  </div>
</section>
```

### Layout Mobile (375px)
`grid-cols-2` mantido mas com `p-6`. Números reduzidos para `text-5xl`. Labels em `text-xs`. Padding lateral: `px-4`. O container `max-w-4xl` não limita no mobile.

### Componentes Específicos

**Metric Item:**
```html
<div class="metric-item group relative p-10 xl:p-14 text-center
            hover:bg-[#8B5CF6]/5 transition-colors duration-300">

  <!-- Número principal com count-up -->
  <div class="flex items-baseline justify-center gap-1 mb-3">
    <!-- Prefixo -->
    <span class="text-4xl font-bold text-[#8B5CF6]">+</span>
    <!-- Número animado -->
    <span class="counter text-7xl xl:text-8xl font-black bg-gradient-to-br from-white to-[#A1A1AA] bg-clip-text text-transparent leading-none"
          data-target="50" data-suffix="">
      0
    </span>
  </div>
  <!-- Label -->
  <p class="text-base font-semibold text-white mb-1">Clientes atendidos</p>
  <!-- Contexto -->
  <p class="text-sm text-[#71717A] leading-snug">Empresas de brasileiros na Irlanda que cresceram com a Vibe</p>
</div>
```

**Para o 4.9★:**
```html
<div class="metric-item group relative p-10 xl:p-14 text-center hover:bg-[#8B5CF6]/5 transition-colors duration-300">
  <div class="flex items-baseline justify-center gap-1 mb-3">
    <span class="counter text-7xl xl:text-8xl font-black bg-gradient-to-br from-white to-[#A1A1AA] bg-clip-text text-transparent leading-none"
          data-target="49" data-format="decimal">0</span>
    <span class="text-4xl font-bold text-[#EAB308]">★</span>
  </div>
  <p class="text-base font-semibold text-white mb-1">Avaliação dos clientes</p>
  <p class="text-sm text-[#71717A] leading-snug">Nota média real de quem trabalha com a gente</p>
</div>
```

### Animações & Interações
```javascript
// Count-up com Intersection Observer
function countUp(el) {
  const target = parseInt(el.dataset.target);
  const format = el.dataset.format;
  const suffix = el.dataset.suffix || '';
  const duration = 2000;
  const start = performance.now();

  function update(now) {
    const elapsed = now - start;
    const progress = Math.min(elapsed / duration, 1);
    // Easing: easeOutCubic
    const eased = 1 - Math.pow(1 - progress, 3);
    let value = Math.floor(eased * target);

    if (format === 'decimal') {
      el.textContent = (value / 10).toFixed(1);
    } else if (format === 'currency') {
      el.textContent = '€' + (value >= 1000 ? Math.floor(value/1000) + 'K' : value) + suffix;
    } else {
      el.textContent = value + suffix;
    }

    if (progress < 1) requestAnimationFrame(update);
  }

  requestAnimationFrame(update);
}

const metricsObserver = new IntersectionObserver((entries) => {
  entries.forEach(entry => {
    if (entry.isIntersecting) {
      entry.target.querySelectorAll('.counter').forEach(countUp);
      metricsObserver.unobserve(entry.target);
    }
  });
}, { threshold: 0.4 });

document.querySelectorAll('.metric-item').forEach(item => metricsObserver.observe(item));
```

```css
/* Pulse no número ao completar count-up */
@keyframes number-pop {
  0% { transform: scale(1); }
  50% { transform: scale(1.05); }
  100% { transform: scale(1); }
}
.counter.done { animation: number-pop 0.3s ease-out; }
```

### Tipografia
- H2: `text-4xl xl:text-5xl font-bold` (#FFFFFF)
- H2 destaque: gradient text (#8B5CF6 → #6366F1)
- Números: `text-7xl xl:text-8xl font-black` (gradient branco → #A1A1AA)
- Mobile números: `text-5xl font-black`
- Prefixo/sufixo: `text-4xl font-bold` (#8B5CF6 / #EAB308 para estrela)
- Label: `text-base font-semibold` (#FFFFFF)
- Contexto: `text-sm leading-snug` (#71717A)

---

## SEÇÃO 8 — DEPOIMENTOS

### Conceito Visual
Layout em "masonry leve" — não um carrossel e não 3 cards iguais. Card central é mais alto e tem borda de gradiente roxo (o mais impactante). Cards laterais são menores. Os 3 cards ficam levemente sobrepostos com z-index diferente, criando profundidade. Aspas são um SVG custom gigante decorativo no canto superior esquerdo do card em `opacity-5`. Cada card tem o avatar (inicial colorida), nome, cargo, cidade e estrelas. Background: `#18181B`.

### Layout Desktop
```html
<section id="depoimentos" class="relative py-24 bg-[#18181B] overflow-hidden">
  <div class="max-w-7xl mx-auto px-6">
    <div class="text-center mb-16">
      <p class="text-[#8B5CF6] text-sm font-semibold uppercase tracking-widest mb-3">Depoimentos</p>
      <h2 class="text-4xl xl:text-5xl font-bold text-white">O que nossos clientes brasileiros dizem</h2>
      <p class="mt-4 text-[#71717A] text-lg">Gente como você, que apostou, cresceu, e não tem mais dúvida.</p>
    </div>

    <!-- Layout masonry leve: cards com alturas diferentes -->
    <div class="grid grid-cols-3 gap-5 items-start">
      <!-- Card 1: altura normal, sem borda especial -->
      <div class="testimonial-card mt-8">...</div>
      <!-- Card 2: central, mais alto (mt-0), borda gradiente -->
      <div class="testimonial-card testimonial-card--featured">...</div>
      <!-- Card 3: altura normal, mt-4 para offset -->
      <div class="testimonial-card mt-4">...</div>
    </div>
  </div>
</section>
```

### Layout Mobile (375px)
`grid-cols-1` — cards empilhados. Card featured perde o tratamento especial de borda (mantém apenas background ligeiramente diferente). `gap-4`. Cards em ordem: 1, 2 (featured), 3.

### Componentes Específicos

**Testimonial Card (padrão):**
```html
<div class="testimonial-card group relative bg-[#09090B] rounded-2xl p-7 overflow-hidden
            border border-[#27272A] hover:border-[#27272A]/80 transition-all duration-400
            hover:shadow-[0_8px_32px_rgba(0,0,0,0.3)] hover:-translate-y-1">

  <!-- Aspas decorativas grandes -->
  <div class="absolute top-5 right-5 opacity-[0.04] group-hover:opacity-[0.07] transition-opacity duration-400">
    <svg viewBox="0 0 60 45" class="w-16 h-12" fill="#8B5CF6">
      <path d="M0 45V27.273C0 10.909 10.909 2.727 32.727 0l2.727 5.455C24.545 7.273 18.182 13.636 16.364 22.727H27.273V45H0zm32.727 0V27.273C32.727 10.909 43.636 2.727 65.455 0l2.727 5.455C57.273 7.273 50.909 13.636 49.091 22.727H60V45H32.727z"/>
    </svg>
  </div>

  <!-- Estrelas -->
  <div class="flex gap-0.5 mb-5">
    <span class="text-[#EAB308] text-sm">★★★★★</span>
  </div>

  <!-- Texto do depoimento -->
  <p class="text-[#A1A1AA] text-base leading-relaxed mb-6 relative z-10">
    "Tentei duas agências irlandesas antes da Vibe e foi um pesadelo..."
  </p>

  <!-- Footer do card: avatar + info -->
  <div class="flex items-center gap-3 pt-5 border-t border-[#27272A]/60">
    <!-- Avatar com inicial -->
    <div class="w-10 h-10 rounded-full bg-gradient-to-br from-[#8B5CF6] to-[#6366F1]
                flex items-center justify-center text-sm font-bold text-white flex-shrink-0">
      M
    </div>
    <div>
      <p class="text-sm font-semibold text-white leading-tight">Marcelo Tavares</p>
      <p class="text-xs text-[#71717A]">Restaurante brasileiro · Dublin</p>
    </div>
    <!-- Bandeira da Irlanda discreta -->
    <span class="ml-auto text-lg opacity-60">🇮🇪</span>
  </div>
</div>
```

**Testimonial Card Featured (central):**
```html
<div class="testimonial-card testimonial-card--featured group relative rounded-2xl p-7 overflow-hidden
            hover:-translate-y-2 transition-all duration-400
            hover:shadow-[0_16px_48px_rgba(139,92,246,0.2)]">

  <!-- Borda gradiente (técnica: pseudo-elemento via wrapper) -->
  <div class="absolute inset-0 rounded-2xl bg-gradient-to-br from-[#8B5CF6] to-[#6366F1] p-px">
    <div class="w-full h-full rounded-2xl bg-[#18181B]"></div>
  </div>

  <!-- Conteúdo (z-10) -->
  <div class="relative z-10">
    <!-- Badge "Destaque" -->
    <div class="inline-flex items-center gap-1.5 px-3 py-1 rounded-full bg-[#8B5CF6]/10 border border-[#8B5CF6]/30 text-xs font-semibold text-[#8B5CF6] mb-5">
      ✦ Destaque
    </div>

    <!-- Estrelas -->
    <div class="flex gap-0.5 mb-5">
      <span class="text-[#EAB308] text-sm">★★★★★</span>
    </div>

    <!-- Aspas custom -->
    <div class="absolute top-5 right-5 opacity-[0.06]">
      <!-- mesmo SVG de aspas -->
    </div>

    <!-- Depoimento -->
    <p class="text-white text-base leading-relaxed mb-6">
      "Eu sabia que precisava de marketing, mas não sabia por onde começar..."
    </p>

    <!-- Footer -->
    <div class="flex items-center gap-3 pt-5 border-t border-[#27272A]/60">
      <div class="w-10 h-10 rounded-full bg-gradient-to-br from-[#6366F1] to-[#8B5CF6]
                  flex items-center justify-center text-sm font-bold text-white flex-shrink-0">F</div>
      <div>
        <p class="text-sm font-semibold text-white leading-tight">Fernanda Almeida</p>
        <p class="text-xs text-[#71717A]">Salão de beleza · Galway</p>
      </div>
      <span class="ml-auto text-lg opacity-60">🇮🇪</span>
    </div>
  </div>
</div>
```

### Animações & Interações
```css
/* Cards entram com fade-up e stagger */
.testimonial-card { opacity: 0; transform: translateY(32px); }
.testimonial-card.visible { opacity: 1; transform: translateY(0); transition: all 0.65s ease-out; }
/* Card featured entra com delay maior (é o foco) */
.testimonial-card--featured.visible { transition-delay: 0.15s; }
```
```javascript
const testimonialObserver = new IntersectionObserver((entries) => {
  if (entries[0].isIntersecting) {
    document.querySelectorAll('.testimonial-card').forEach((card, i) => {
      setTimeout(() => card.classList.add('visible'), i * 120);
    });
  }
}, { threshold: 0.2 });
```

### Tipografia
- Label: `text-sm font-semibold uppercase tracking-widest` (#8B5CF6)
- H2: `text-4xl xl:text-5xl font-bold` (#FFFFFF)
- Mobile H2: `text-3xl`
- Card texto: `text-base leading-relaxed` (#A1A1AA / #FFFFFF no featured)
- Nome: `text-sm font-semibold` (#FFFFFF)
- Cargo/cidade: `text-xs` (#71717A)
- Estrelas: `text-sm` (#EAB308)

---

## SEÇÃO 9 — FAQ

### Conceito Visual
Accordion completamente customizado com animação de altura via `max-height`. Cada item tem uma linha divisória sutil no `border-b border-[#27272A]/60`. O ícone de expandir é um `+` que rotaciona para `×` com `transition: transform 0.3s`. Quando aberto, o item tem um `border-l-2 border-[#8B5CF6]` que aparece com fade. Background: `#09090B`. Layout: coluna central `max-w-3xl mx-auto` para legibilidade.

### Layout Desktop
```html
<section id="faq" class="relative py-24 bg-[#09090B]">
  <!-- Linha separadora no topo -->
  <div class="absolute top-0 left-0 right-0 h-px bg-gradient-to-r from-transparent via-[#27272A] to-transparent"></div>

  <div class="max-w-3xl mx-auto px-6">
    <div class="text-center mb-14">
      <p class="text-[#8B5CF6] text-sm font-semibold uppercase tracking-widest mb-3">FAQ</p>
      <h2 class="text-4xl xl:text-5xl font-bold text-white">Perguntas frequentes</h2>
      <p class="mt-4 text-[#71717A] text-lg">A resposta que você está procurando provavelmente está aqui.</p>
    </div>

    <!-- Lista de FAQs -->
    <div class="faq-list flex flex-col">
      <!-- Item de FAQ -->
      <div class="faq-item border-b border-[#27272A]/60">
        <button class="faq-trigger w-full flex items-center justify-between py-5 text-left group">
          <!-- Pergunta -->
          <!-- Ícone +/× -->
        </button>
        <div class="faq-content max-h-0 overflow-hidden transition-all duration-400 ease-in-out">
          <!-- Resposta -->
        </div>
      </div>
      <!-- ... 6 itens -->
    </div>
  </div>
</section>
```

### Layout Mobile (375px)
Layout idêntico ao desktop mas com `px-5`. Título da pergunta `text-base`. Resposta `text-sm`. `py-4` no trigger.

### Componentes Específicos

**FAQ Item:**
```html
<div class="faq-item border-b border-[#27272A]/60 last:border-b-0">
  <button class="faq-trigger w-full flex items-center justify-between py-5 gap-4 text-left group
                 focus:outline-none focus-visible:ring-2 focus-visible:ring-[#8B5CF6]/50 rounded-lg"
          aria-expanded="false">

    <!-- Número + Pergunta -->
    <div class="flex items-start gap-4">
      <span class="text-xs font-mono text-[#8B5CF6]/60 mt-1 flex-shrink-0 font-semibold">01</span>
      <span class="text-base font-semibold text-white group-hover:text-[#A78BFA] transition-colors duration-200 leading-snug">
        Vocês atendem negócios de qualquer setor?
      </span>
    </div>

    <!-- Ícone +/× -->
    <div class="faq-icon w-7 h-7 rounded-lg bg-[#27272A] flex items-center justify-center flex-shrink-0
                group-hover:bg-[#8B5CF6]/10 group-hover:border-[#8B5CF6]/30 border border-transparent
                transition-all duration-300">
      <svg class="w-4 h-4 text-[#A1A1AA] faq-plus-icon transition-transform duration-300 group-hover:text-[#8B5CF6]"
           fill="none" viewBox="0 0 16 16">
        <path d="M8 3v10M3 8h10" stroke="currentColor" stroke-width="1.5" stroke-linecap="round"/>
      </svg>
    </div>
  </button>

  <!-- Resposta (animada) -->
  <div class="faq-content max-h-0 overflow-hidden transition-[max-height] duration-400 ease-in-out">
    <div class="pb-5 pl-9 pr-2">
      <!-- Barra lateral roxa -->
      <div class="relative pl-4 border-l-2 border-[#8B5CF6]/40">
        <p class="text-[#A1A1AA] text-base leading-relaxed">
          Sim. Já trabalhamos com restaurantes, salões de beleza...
        </p>
      </div>
    </div>
  </div>
</div>
```

### Animações & Interações
```javascript
document.querySelectorAll('.faq-item').forEach(item => {
  const trigger = item.querySelector('.faq-trigger');
  const content = item.querySelector('.faq-content');
  const icon = item.querySelector('.faq-plus-icon');

  trigger.addEventListener('click', () => {
    const isOpen = trigger.getAttribute('aria-expanded') === 'true';

    // Fechar todos os outros
    document.querySelectorAll('.faq-item').forEach(other => {
      if (other !== item) {
        other.querySelector('.faq-trigger').setAttribute('aria-expanded', 'false');
        other.querySelector('.faq-content').style.maxHeight = '0px';
        other.querySelector('.faq-plus-icon').style.transform = 'rotate(0deg)';
        other.querySelector('.faq-item-active')?.classList.remove('faq-item-active');
      }
    });

    if (isOpen) {
      trigger.setAttribute('aria-expanded', 'false');
      content.style.maxHeight = '0px';
      icon.style.transform = 'rotate(0deg)';
      item.classList.remove('faq-item-active');
    } else {
      trigger.setAttribute('aria-expanded', 'true');
      content.style.maxHeight = content.scrollHeight + 'px';
      icon.style.transform = 'rotate(45deg)'; // + vira ×
      item.classList.add('faq-item-active');
    }
  });
});
```

```css
/* Item ativo: borda lateral roxo no lado esquerdo do item inteiro */
.faq-item-active > .faq-trigger {
  color: #A78BFA;
}
/* Transição suave no max-height */
.faq-content {
  transition: max-height 0.4s cubic-bezier(0.4, 0, 0.2, 1);
}
```

### Tipografia
- Label: `text-sm font-semibold uppercase tracking-widest` (#8B5CF6)
- H2: `text-4xl xl:text-5xl font-bold` (#FFFFFF)
- Mobile H2: `text-3xl`
- Número item: `text-xs font-mono font-semibold` (#8B5CF6/60%)
- Pergunta: `text-base font-semibold` (#FFFFFF → #A78BFA hover)
- Resposta: `text-base leading-relaxed` (#A1A1AA)
- Mobile pergunta: `text-sm font-semibold`

---

## SEÇÃO 10 — CTA FINAL

### Conceito Visual
A seção mais dramática do site. Background: `#09090B` com dois orbs grandes sobrepostos (roxo e índigo) e um gradiente radial central intenso. O container do CTA é uma "ilha" flutuante com borda gradiente completa (gradient border trick), padding generoso, e elementos decorativos: linhas diagonais em SVG como textura de fundo, dois anéis concêntricos ao redor do botão principal. O headline usa font muito grande com linha quebrada estratégica. Botão principal tem tamanho incomum (`px-10 py-5`) e um efeito de "glow pulsante" no hover.

### Layout Desktop
```html
<section class="relative py-32 bg-[#09090B] overflow-hidden">
  <!-- Orbs intensos -->
  <div class="absolute inset-0 pointer-events-none">
    <div class="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2
                w-[800px] h-[800px] rounded-full bg-[#8B5CF6]/10 blur-[150px]"></div>
    <div class="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2
                w-[400px] h-[400px] rounded-full bg-[#6366F1]/20 blur-[80px] animate-pulse-slow"></div>
  </div>

  <!-- Textura de linhas diagonais -->
  <div class="absolute inset-0 opacity-[0.03] pointer-events-none"
       style="background-image: repeating-linear-gradient(45deg, #8B5CF6 0px, #8B5CF6 1px, transparent 1px, transparent 40px);">
  </div>

  <div class="relative z-10 max-w-4xl mx-auto px-6 text-center">
    <!-- Ilha com borda gradiente -->
    <div class="relative rounded-3xl p-px bg-gradient-to-br from-[#8B5CF6]/60 via-[#6366F1]/30 to-[#8B5CF6]/10">
      <div class="bg-[#09090B] rounded-3xl px-10 py-16 xl:px-16 xl:py-20">

        <!-- Badge urgência -->
        <div class="inline-flex items-center gap-2 px-4 py-1.5 rounded-full
                    bg-[#8B5CF6]/10 border border-[#8B5CF6]/30 text-sm font-medium text-[#8B5CF6] mb-8">
          <span class="relative flex h-2 w-2">
            <span class="animate-ping absolute inline-flex h-full w-full rounded-full bg-[#8B5CF6] opacity-75"></span>
            <span class="relative inline-flex rounded-full h-2 w-2 bg-[#8B5CF6]"></span>
          </span>
          Vagas limitadas este mês
        </div>

        <!-- Headline massivo -->
        <h2 class="text-5xl xl:text-6xl font-black text-white leading-[1.1] tracking-tight mb-6">
          Pronto para fazer seu negócio
          <span class="block bg-gradient-to-r from-[#8B5CF6] to-[#6366F1] bg-clip-text text-transparent">
            crescer de verdade na Irlanda?
          </span>
        </h2>

        <!-- Subtítulo -->
        <p class="text-xl text-[#A1A1AA] leading-relaxed mb-10 max-w-2xl mx-auto">
          Agende uma conversa gratuita de 30 minutos. A gente ouve, entende e te mostra
          exatamente o que precisa ser feito. Sem compromisso, sem bullshit.
        </p>

        <!-- Botão principal com glow -->
        <div class="relative inline-block mb-6">
          <!-- Anéis concêntricos ao redor do botão -->
          <div class="absolute -inset-3 rounded-2xl border border-[#8B5CF6]/20 animate-pulse-slow"></div>
          <div class="absolute -inset-6 rounded-3xl border border-[#8B5CF6]/10 animate-pulse-slow animation-delay-1000"></div>

          <a href="#contato"
             class="relative inline-flex items-center gap-3 px-10 py-5 rounded-xl
                    bg-gradient-to-r from-[#8B5CF6] to-[#6366F1]
                    text-white font-bold text-xl
                    hover:shadow-[0_0_60px_rgba(139,92,246,0.5)] transition-all duration-300
                    hover:scale-[1.02] active:scale-[0.98] group">
            Falar com a Vibe agora
            <svg class="w-5 h-5 group-hover:translate-x-1 transition-transform duration-300" fill="none" viewBox="0 0 20 20">
              <path d="M4 10h12M12 6l4 4-4 4" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"/>
            </svg>
          </a>
        </div>

        <!-- Texto auxiliar de confiança -->
        <p class="text-sm text-[#71717A] flex items-center justify-center gap-2">
          <svg class="w-4 h-4 text-[#8B5CF6]" fill="none" viewBox="0 0 16 16">
            <path d="M8 1.5L10 6h5l-4 3 1.5 5L8 11 3.5 14 5 9 1 6h5z" stroke="currentColor" stroke-width="1" fill="#8B5CF6" fill-opacity="0.2"/>
          </svg>
          Resposta em até 24 horas. Sem spam, sem pressão.
        </p>
      </div>
    </div>
  </div>
</section>
```

### Layout Mobile (375px)
`px-5 py-20`. Ilha com `px-6 py-10`. H2: `text-3xl xl:text-4xl`. Subtítulo: `text-base`. Botão: `px-7 py-4 text-lg`. Anéis concêntricos ocultados (`hidden sm:block`).

### Componentes Específicos
Descritos inline acima. O elemento mais crítico é o **gradient border trick**:
```html
<!-- Wrapper com gradiente como "borda" de 1px -->
<div class="relative p-px rounded-3xl bg-gradient-to-br from-[#8B5CF6]/60 via-[#6366F1]/30 to-transparent">
  <!-- Conteúdo com background sólido -->
  <div class="bg-[#09090B] rounded-3xl ...">
    <!-- conteúdo -->
  </div>
</div>
```

### Animações & Interações
```css
/* Botão principal: glow pulsante contínuo no idle */
@keyframes cta-glow {
  0%, 100% { box-shadow: 0 0 20px rgba(139,92,246,0.2); }
  50% { box-shadow: 0 0 40px rgba(139,92,246,0.35); }
}
a.cta-main { animation: cta-glow 3s ease-in-out infinite; }
a.cta-main:hover { animation: none; }

/* Entrada da seção */
.cta-section-container { opacity: 0; transform: scale(0.97); transition: all 0.8s ease-out; }
.cta-section-container.visible { opacity: 1; transform: scale(1); }
```
```javascript
const ctaObserver = new IntersectionObserver((entries) => {
  if (entries[0].isIntersecting) {
    document.querySelector('.cta-section-container').classList.add('visible');
  }
}, { threshold: 0.2 });
```

### Tipografia
- Badge: `text-sm font-medium` (#8B5CF6)
- H2: `text-5xl xl:text-6xl font-black` (#FFFFFF)
- H2 linha 2: gradient text (#8B5CF6 → #6366F1)
- Mobile H2: `text-3xl font-black`
- Subtítulo: `text-xl leading-relaxed` (#A1A1AA)
- Mobile subtítulo: `text-base`
- Botão: `text-xl font-bold` (#FFFFFF)
- Mobile botão: `text-lg font-bold`
- Auxiliar: `text-sm` (#71717A)

---

## SEÇÃO 11 — FOOTER

### Conceito Visual
Footer com `bg-[#09090B]` e uma linha divisória no topo que não é apenas um `<hr>` — é um gradiente de 1px que começa transparente, passa pelo roxo da Vibe no centro e volta ao transparente, com um pequeno "glow" difuso acima usando `box-shadow`. Layout em 4 colunas em desktop: logo+tagline (coluna larga), Navegação, Serviços, Contato. Acima de tudo: a linha divisória especial.

### Layout Desktop
```html
<footer class="relative bg-[#09090B]">
  <!-- Linha divisória premium -->
  <div class="relative">
    <!-- Glow difuso acima da linha -->
    <div class="absolute top-0 left-1/2 -translate-x-1/2 w-1/2 h-20 bg-[#8B5CF6]/10 blur-2xl -translate-y-1/2 pointer-events-none"></div>
    <!-- Linha gradiente de 1px -->
    <div class="h-px bg-gradient-to-r from-transparent via-[#8B5CF6]/50 to-transparent"></div>
  </div>

  <div class="max-w-7xl mx-auto px-6 py-16">
    <!-- Grid 4 colunas -->
    <div class="grid grid-cols-[2fr_1fr_1fr_1fr] gap-12">
      <!-- Coluna 1: Logo + tagline + copyright -->
      <div class="flex flex-col gap-6">
        <!-- Logo (repetir do header) -->
        <!-- Tagline -->
        <!-- Copyright -->
      </div>

      <!-- Coluna 2: Navegação -->
      <div>
        <h4 class="...">Navegação</h4>
        <ul>...</ul>
      </div>

      <!-- Coluna 3: Serviços -->
      <div>
        <h4 class="...">Serviços</h4>
        <ul>...</ul>
      </div>

      <!-- Coluna 4: Contato -->
      <div>
        <h4 class="...">Contato</h4>
        <ul>...</ul>
      </div>
    </div>
  </div>

  <!-- Bottom bar -->
  <div class="border-t border-[#27272A]/40 px-6 py-5">
    <div class="max-w-7xl mx-auto flex items-center justify-between">
      <p class="text-xs text-[#71717A]">© 2025 Vibe Digital. Todos os direitos reservados.</p>
      <a href="#" class="text-xs text-[#71717A] hover:text-[#A1A1AA] transition-colors">Política de Privacidade</a>
    </div>
  </div>
</footer>
```

### Layout Mobile (375px)
`grid-cols-1`. Coluna 1 (logo+tagline) no topo. Colunas 2 e 3 lado a lado (`grid-cols-2 gap-8`). Coluna 4 (contato) em largura total. `py-12 px-5`. Bottom bar: flex-col com gap-2, texto centralizado.

### Componentes Específicos

**Footer column header:**
```html
<h4 class="text-xs font-semibold uppercase tracking-widest text-[#71717A] mb-5">Navegação</h4>
```

**Footer links:**
```html
<li>
  <a href="#servicos"
     class="text-sm text-[#A1A1AA] hover:text-white transition-colors duration-200
            flex items-center gap-2 group py-1">
    <span class="w-1 h-1 rounded-full bg-[#8B5CF6]/0 group-hover:bg-[#8B5CF6] transition-all duration-200 flex-shrink-0"></span>
    Serviços
  </a>
</li>
```

**Contato items com ícones:**
```html
<li class="flex items-center gap-3 text-sm text-[#A1A1AA] py-1">
  <!-- Ícone WhatsApp customizado -->
  <div class="w-7 h-7 rounded-lg bg-[#25D366]/10 flex items-center justify-center flex-shrink-0">
    <svg viewBox="0 0 16 16" class="w-4 h-4" fill="none">
      <path d="M8 1.5C4.41 1.5 1.5 4.41 1.5 8c0 1.16.3 2.25.83 3.19L1.5 14.5l3.4-.82A6.48 6.48 0 008 14.5c3.59 0 6.5-2.91 6.5-6.5S11.59 1.5 8 1.5z" stroke="#25D366" stroke-width="1" fill="#25D366" fill-opacity="0.15"/>
      <path d="M6 6.5c.2.5 1 1.8 2 2.5.6.4 1 .5 1.5.5l.5-1-1-1s-.5.3-.8.3C7.7 8 7 7 7 7L6 6.5z" fill="#25D366" fill-opacity="0.7"/>
    </svg>
  </div>
  <a href="#" class="hover:text-white transition-colors">Falar com a equipe</a>
</li>

<li class="flex items-center gap-3 text-sm text-[#A1A1AA] py-1">
  <!-- Ícone email -->
  <div class="w-7 h-7 rounded-lg bg-[#8B5CF6]/10 flex items-center justify-center flex-shrink-0">
    <svg viewBox="0 0 16 16" class="w-4 h-4" fill="none" stroke="#8B5CF6" stroke-width="1.2">
      <rect x="1.5" y="3.5" width="13" height="9" rx="1.5"/>
      <path d="M1.5 5l6.5 4.5L14.5 5" stroke-linecap="round"/>
    </svg>
  </div>
  <a href="mailto:oi@vibedigital.ie" class="hover:text-white transition-colors">oi@vibedigital.ie</a>
</li>

<li class="flex items-center gap-3 text-sm text-[#A1A1AA] py-1">
  <!-- Ícone localização -->
  <div class="w-7 h-7 rounded-lg bg-[#27272A] flex items-center justify-center flex-shrink-0">
    <svg viewBox="0 0 16 16" class="w-4 h-4" fill="none" stroke="#A1A1AA" stroke-width="1.2">
      <path d="M8 1.5C5.79 1.5 4 3.29 4 5.5c0 3.25 4 9 4 9s4-5.75 4-9c0-2.21-1.79-4-4-4z"/>
      <circle cx="8" cy="5.5" r="1.5"/>
    </svg>
  </div>
  Dublin, Ireland 🇮🇪
</li>
```

**Logo no footer** (versão menor):
```html
<!-- Mesmo componente do header mas text-lg ao invés de text-xl -->
<a href="#" class="flex items-center gap-2 mb-4">
  <!-- SVG mark w-7 h-7 -->
  <span class="text-lg leading-none">
    <span class="font-bold text-white tracking-tight">Vibe</span>
    <span class="font-semibold text-[#8B5CF6] tracking-tight">Digital</span>
  </span>
</a>
```

**Tagline:**
```html
<p class="text-sm text-[#71717A] italic">
  "Seu negócio. Dois mundos. Um resultado."
</p>
```

### Animações & Interações
Sem animações pesadas no footer — apenas hover states nos links (`transition-colors duration-200`). O ponto `●` antes de cada link do footer expande de `opacity-0` para `opacity-100` e muda de cor para `#8B5CF6` no hover.

### Tipografia
- Column header: `text-xs font-semibold uppercase tracking-widest` (#71717A)
- Links: `text-sm` (#A1A1AA → #FFFFFF hover)
- Tagline: `text-sm italic` (#71717A)
- Copyright: `text-xs` (#71717A)
- Política: `text-xs` (#71717A → #A1A1AA hover)

---

## NOTAS GLOBAIS DE IMPLEMENTAÇÃO

### CSS customizado necessário (adicionar no `<style>` do HTML)

```css
/* Inter font */
@import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;900&display=swap');

* { font-family: 'Inter', sans-serif; }

/* Scroll suave */
html { scroll-behavior: smooth; }

/* Scrollbar customizada */
::-webkit-scrollbar { width: 6px; }
::-webkit-scrollbar-track { background: #09090B; }
::-webkit-scrollbar-thumb { background: #27272A; border-radius: 3px; }
::-webkit-scrollbar-thumb:hover { background: #8B5CF6; }

/* Animações globais */
@keyframes pulse-slow {
  0%, 100% { opacity: 0.5; }
  50% { opacity: 1; }
}
@keyframes fade-up {
  from { opacity: 0; transform: translateY(24px); }
  to { opacity: 1; transform: translateY(0); }
}
@keyframes ping {
  75%, 100% { transform: scale(2); opacity: 0; }
}

.animate-pulse-slow { animation: pulse-slow 4s ease-in-out infinite; }
.animate-ping { animation: ping 1s cubic-bezier(0, 0, 0.2, 1) infinite; }
.animation-delay-1000 { animation-delay: 1s; }
.animation-delay-2000 { animation-delay: 2s; }
.animation-delay-4000 { animation-delay: 4s; }

/* Gradient text utility */
.gradient-text {
  background: linear-gradient(135deg, #8B5CF6, #6366F1);
  -webkit-background-clip: text;
  background-clip: text;
  -webkit-text-fill-color: transparent;
}

/* Transition padrão global */
*, *::before, *::after {
  transition-timing-function: cubic-bezier(0.4, 0, 0.2, 1);
}
```

### Tailwind config (CDN — adicionar no `<script>` antes do CDN)
```javascript
tailwind.config = {
  theme: {
    extend: {
      colors: {
        'vibe-bg': '#09090B',
        'vibe-surface': '#18181B',
        'vibe-surface2': '#27272A',
        'vibe-primary': '#8B5CF6',
        'vibe-secondary': '#6366F1',
      },
      fontFamily: {
        sans: ['Inter', 'sans-serif'],
      },
      animation: {
        'pulse-slow': 'pulse-slow 4s ease-in-out infinite',
      }
    }
  }
}
```

### Breakpoints Tailwind usados
- `sm`: 640px (raramente)
- `lg`: 1024px (principal breakpoint desktop/mobile)
- `xl`: 1280px (tamanhos maiores de fonte)
- Mobile-first: todos os estilos base são mobile, modifiers `lg:` ativam desktop

### Touch targets mobile
Todos os botões, links e triggers de accordion: mínimo `min-h-[44px] min-w-[44px]` conforme WCAG 2.5.5.

### Performance
- SVGs inline — sem requests extras
- Tailwind CDN com JIT — apenas classes usadas
- Intersection Observer para todas as animações de entrada — sem scroll event listeners
- Orbs e blurs com `will-change: transform` para GPU acceleration
- `prefers-reduced-motion` media query para desabilitar animações se necessário
