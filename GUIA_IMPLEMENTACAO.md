# GUIA DE IMPLEMENTAÇÃO — COPY ATUALIZADO VIBE DIGITAL

---

## 📋 CHECKLIST DE IMPLEMENTAÇÃO

### SEÇÃO HERO
- [ ] Adicionar slogan `"Para brasileiros que empreendem na Irlanda: estratégia que faz sentido e entrega resultado."` após o subtítulo
- [ ] Manter H1, subtítulo e CTAs (sem mudança)

### SEÇÃO QUEM SOMOS
- [ ] Manter parágrafos 1 e 2 como estão
- [ ] Inserir slogan `"Não somos mais uma agência. Somos seu parceiro de crescimento na Irlanda."` entre parágrafo 2 e 3
- [ ] Manter parágrafo 3 e bullets (sem mudança)

### SEÇÃO SERVIÇOS ⚠️ MUDANÇA MAIOR
- [ ] Remover TODA a seção anterior (6 serviços)
- [ ] Criar 5 CARDS NOVOS com a copy exata fornecida:
  - [ ] Landing Pages Profissionais
  - [ ] Google Ads
  - [ ] Meta Ads
  - [ ] Automação de Whatsapp
  - [ ] Branding
- [ ] Cada card deve ter: Título + Parágrafo + "Destaque"
- [ ] CTA da seção permanece igual

### SEÇÃO FAQ
- [ ] Pergunta 1 "Vocês atendem..." → MANTER igual
- [ ] Pergunta 2 "Quanto custa..." → MANTER igual
- [ ] Pergunta 3 "Em quanto tempo..." → ATUALIZAR com referência a "Google Ads e Meta Ads" (remover "Tráfego pago")
- [ ] Pergunta 4 "Posso contratar..." → ATUALIZAR menção a serviços (remover "redes sociais", adicionar "Automação de WhatsApp")
- [ ] Pergunta 5 "Como funciona..." → MANTER igual
- [ ] Pergunta 6 "Vocês trabalham..." → MANTER igual

### SEÇÃO FOOTER
- [ ] Atualizar lista de serviços de:
  ```
  Tráfego Pago · Redes Sociais · Sites e Landing Pages · SEO · Branding · Consultoria
  ```
  Para:
  ```
  Google Ads · Meta Ads · Landing Pages · Automação de WhatsApp · Branding
  ```

---

## 🎨 ESTRUTURA HTML DOS CARDS DE SERVIÇOS

### Cada card deve seguir este padrão:

```html
<div class="service-card">
  <h3 class="service-title">NOME DO SERVIÇO</h3>
  
  <p class="service-description">
    [Parágrafo principal — 3-4 linhas máximo]
  </p>
  
  <div class="service-highlight">
    <strong>Destaque:</strong> [Benefício 1], [Benefício 2], [Benefício 3]
  </div>
</div>
```

### Exemplo real - Google Ads:

```html
<div class="service-card">
  <h3 class="service-title">GOOGLE ADS</h3>
  
  <p class="service-description">
    Apareça no topo do Google quando brasileiros e irlandeses 
    buscam exatamente o que você oferece. Tráfego pago 
    qualificado, resultado em poucos dias, e ROI que você 
    consegue rastrear. Google Ads é para quem quer vender 
    rápido, sem esperar meses por organicidade.
  </p>
  
  <div class="service-highlight">
    <strong>Destaque:</strong> Resultado rápido, tráfego qualificado, ROI mensurável
  </div>
</div>
```

---

## 📝 COPY EXATA DOS 5 SERVIÇOS (PRONTA PARA COPIAR E COLAR)

### 1. LANDING PAGES PROFISSIONAIS

**Título:**
```
LANDING PAGES PROFISSIONAIS
```

**Descrição:**
```
Páginas construídas para converter visitante em cliente, 
não só para ficar bonita no portfólio. Otimizadas para 
velocidade, mobile-first, com copy persuasivo e CTAs 
estratégicos. Sua landing page funciona 24/7 gerando 
leads e vendas enquanto você dorme.
```

**Destaque:**
```
Rápidas, responsivas, prontas para vender
```

---

### 2. GOOGLE ADS

**Título:**
```
GOOGLE ADS
```

**Descrição:**
```
Apareça no topo do Google quando brasileiros e irlandeses 
buscam exatamente o que você oferece. Tráfego pago 
qualificado, resultado em poucos dias, e ROI que você 
consegue rastrear. Google Ads é para quem quer vender 
rápido, sem esperar meses por organicidade.
```

**Destaque:**
```
Resultado rápido, tráfego qualificado, ROI mensurável
```

---

### 3. META ADS

**Título:**
```
META ADS
```

**Descrição:**
```
Facebook e Instagram com segmentação cirúrgica para atingir 
brasileiros na Irlanda. A gente monta campanhas que conectam 
com o seu público exato — e converte interesse em vendas 
reais. Meta Ads é perfeito para gerar reconhecimento de 
marca e vender pra quem já está aqui.
```

**Destaque:**
```
Segmentação precisa, alcance local, conversão garantida
```

---

### 4. AUTOMAÇÃO DE WHATSAPP

**Título:**
```
AUTOMAÇÃO DE WHATSAPP
```

**Descrição:**
```
Chatbot e automação para responder seus clientes 24/7 no 
WhatsApp — sem perder oportunidade de venda. Qualifica 
leads automaticamente, responde dúvidas frequentes, e deixa 
contato pronto pra fechar a venda quando você acordar. 
WhatsApp é o app que todo mundo usa; a gente coloca ele 
pra trabalhar pra você.
```

**Destaque:**
```
Respostas automáticas, qualificação de leads, zero oportunidades perdidas
```

---

### 5. BRANDING

**Título:**
```
BRANDING
```

**Descrição:**
```
Mais que logo e cores bonitas. Branding é sua identidade 
completa: logo, paleta visual, tom de voz, guidelines de 
marca. A gente cria uma marca que passa credibilidade no 
mercado irlandês — profissional, confiável — mas que ainda 
guarda a essência brasileira. Sua marca fica única e 
memorável.
```

**Destaque:**
```
Identidade visual completa, credibilidade no mercado local, identidade brasileira preservada
```

---

## 🎯 SLOGANS A ADICIONAR

### Slogan 1 — SEÇÃO HERO
**Local:** Após o subtítulo, antes do CTA primário
**Texto:**
```
"Para brasileiros que empreendem na Irlanda: 
estratégia que faz sentido e entrega resultado."
```
**Styling:** Itálico, em bloco visual destaque

**Código HTML sugerido:**
```html
<p class="slogan">
  <em>"Para brasileiros que empreendem na Irlanda: 
  estratégia que faz sentido e entrega resultado."</em>
</p>
```

---

### Slogan 2 — SEÇÃO QUEM SOMOS
**Local:** Após parágrafo 2, antes de parágrafo 3
**Texto:**
```
"Não somos mais uma agência. Somos seu parceiro de 
crescimento na Irlanda."
```
**Styling:** Itálico, em bloco visual destaque

**Código HTML sugerido:**
```html
<p class="slogan">
  <em>"Não somos mais uma agência. Somos seu parceiro 
  de crescimento na Irlanda."</em>
</p>
```

---

## 🔄 SEÇÕES QUE PERMANECEM IDÊNTICAS

As seguintes seções NÃO foram alteradas e podem permanecer como estão:
- ✓ NAV
- ✓ HERO (exceto adição do slogan)
- ✓ PAIN POINTS
- ✓ QUEM SOMOS (exceto adição do slogan)
- ✓ COMO FUNCIONA
- ✓ NÚMEROS
- ✓ DEPOIMENTOS
- ✓ CTA FINAL

---

## 📊 RESUMO VISUAL DO ANTES E DEPOIS

### SEÇÃO SERVIÇOS — LAYOUT ANTES
```
┌─────────────────────────────────────────┐
│ Tráfego Pago                            │
│ Meta Ads e Google Ads com segmentação...│
└─────────────────────────────────────────┘

┌─────────────────────────────────────────┐
│ Gestão de Redes Sociais                 │
│ Conteúdo que conecta, engaja e converte│
└─────────────────────────────────────────┘

┌─────────────────────────────────────────┐
│ Sites e Landing Pages                   │
│ Páginas que não são só bonitas...      │
└─────────────────────────────────────────┘

┌─────────────────────────────────────────┐
│ SEO                                     │
│ Seja encontrado no Google...            │
└─────────────────────────────────────────┘

┌─────────────────────────────────────────┐
│ Identidade Visual e Branding            │
│ Da logo à paleta de cores...            │
└─────────────────────────────────────────┘

┌─────────────────────────────────────────┐
│ Consultoria Estratégica                 │
│ Diagnóstico honesto do seu negócio...   │
└─────────────────────────────────────────┘
```

### SEÇÃO SERVIÇOS — LAYOUT DEPOIS (5 cards, melhor distribuição)
```
┌─────────────────────────────────────────┐
│ LANDING PAGES PROFISSIONAIS             │
│ Páginas construídas para converter...   │
│ Destaque: Rápidas, responsivas, prontas│
└─────────────────────────────────────────┘

┌─────────────────────────────────────────┐
│ GOOGLE ADS                              │
│ Apareça no topo do Google quando...     │
│ Destaque: Resultado rápido, tráfego...  │
└─────────────────────────────────────────┘

┌─────────────────────────────────────────┐
│ META ADS                                │
│ Facebook e Instagram com segmentação... │
│ Destaque: Segmentação precisa, alcance..│
└─────────────────────────────────────────┘

┌─────────────────────────────────────────┐
│ AUTOMAÇÃO DE WHATSAPP                   │
│ Chatbot e automação para responder...   │
│ Destaque: Respostas automáticas, zero...│
└─────────────────────────────────────────┘

┌─────────────────────────────────────────┐
│ BRANDING                                │
│ Mais que logo e cores bonitas...        │
│ Destaque: Identidade visual completa... │
└─────────────────────────────────────────┘
```

---

## ⚠️ NOTAS IMPORTANTES

1. **Ordem dos Cards:** Mantém a ordem sugerida (Landing Pages → Google Ads → Meta Ads → WhatsApp → Branding)

2. **Copy é Oficial:** Use EXATAMENTE como fornecido — cada palavra foi escolhida por motivo estratégico

3. **Slogans:** São frases que devem estar em itálico/destaque visual para não se confundir com body text

4. **FAQ:** Apenas 2 perguntas precisam de atualização (pergunta 3 e 4) — as outras 4 permanecem iguais

5. **Footer:** A lista de serviços é derivada dos 5 novos serviços — use exatamente como está

6. **Palavras-chave:** Cada serviço foi escrito com palavras-chave estratégicas incluídas (Google, Meta, Chatbot, WhatsApp, Branding, etc.) — isso ajuda em SEO

---

## 🚀 PRÓXIMOS PASSOS APÓS IMPLEMENTAÇÃO

1. Testar responsividade dos 5 cards em mobile, tablet e desktop
2. Verificar que todos os links para "Fale Conosco" funcionam
3. Atualizar Meta tags (se necessário) com referência aos 5 serviços
4. Considerar atualizar imagens/ícones dos cards se houver
5. A/B testar os slogans (opcional — podem ser removidos se não resonarem)

---

## 📄 ARQUIVOS RELACIONADOS

- `COPY_FINAL_ATUALIZADO.md` — Copy completo formatado
- `MUDANCAS_COMPARATIVO.md` — Detalhamento de cada mudança
- `index.html` — Arquivo atual do site (será atualizado com novo copy)
