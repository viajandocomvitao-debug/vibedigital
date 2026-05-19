---
name: premium-landing-design
description: Create unique, premium, and professional landing pages with strong visual identity. Use this skill whenever building landing pages, one-page websites, promotional pages, campaign pages, or any web design that needs to convert visitors and look exceptional. ALWAYS use this skill for web design projects to ensure premium quality, unique layouts, and proper responsiveness. Never create generic designs - every page must have personality and professional polish.
---

# Premium Landing Page Design - Universal Skill Base

## Primary Objective
Create UNIQUE, premium landing pages with strong visual identity. Each design must be memorable, professional, and NEVER generic. Focus on creative layouts, custom components, and proper responsiveness across all devices.

## Core Principle: ZERO GENERIC DESIGN
❌ NEVER use obvious 3-column card layouts
❌ NEVER use unmodified icon library icons
❌ NEVER create predictable template-like sections
✅ ALWAYS think unique, surprising layouts
✅ ALWAYS create custom visual compositions
✅ ALWAYS prioritize visual differentiation

---

## 1. RESPONSIVE DESIGN (MANDATORY)

### Breakpoints:
```css
Desktop:  1920px (primary design)
Laptop:   1440px (minor adjustments)
Tablet:   768px  (significant reorganization)
Mobile:   375px  (vertical stack, prioritization)
```

### Responsive Rules:

**Desktop (1440px+)**
- Complex horizontal layouts allowed
- 2-3 columns without issues
- Large impactful images
- Elaborate hover states

**Tablet (768px-1023px)**
- Simplify to max 2 columns
- Reduce image sizes
- Min 44px touch targets
- Maintain visual hierarchy

**Mobile (320px-767px)**
- ALWAYS vertical stack
- Single column only
- Prioritize essential content
- Large touch-friendly CTAs
- Reduce spacing to 60% of desktop
- Hamburger menu navigation

### Responsive Checklist:
- [ ] Tested at 375px (iPhone SE)
- [ ] Tested at 768px (iPad)
- [ ] Tested at 1440px (Standard Desktop)
- [ ] Images with srcset for different resolutions
- [ ] Text readable without zoom (min 16px mobile)
- [ ] CTAs accessible by touch (min 44x44px)
- [ ] NO horizontal scroll

---

## 2. UNIQUE CREATIVE LAYOUTS

### Asymmetric Grid Example:
```html
<div class="grid grid-cols-12 gap-6">
  <div class="col-span-7 row-span-2">Large Card</div>
  <div class="col-span-5">Small Card 1</div>
  <div class="col-span-5">Small Card 2</div>
  <div class="col-span-12">Full Width Card</div>
</div>
```

### Element Overlay:
```html
<div class="relative">
  <div class="w-full h-96 bg-gray-100"></div>
  <div class="absolute -bottom-12 left-12 bg-white shadow-xl p-8">
    Overlapping content
  </div>
</div>
```

### Diagonal/Skewed Layout:
```html
<div class="relative overflow-hidden">
  <div class="absolute inset-0 bg-emerald-50 transform -skew-y-3"></div>
  <div class="relative z-10 py-32">Content</div>
</div>
```

### Bento Box Layout:
```html
<div class="grid grid-cols-4 grid-rows-3 gap-4 h-screen">
  <div class="col-span-2 row-span-2">Main Feature</div>
  <div class="col-span-2">Feature 2</div>
  <div class="col-span-1 row-span-2">Feature 3</div>
  <div class="col-span-1">Feature 4</div>
  <div class="col-span-2">Feature 5</div>
</div>
```

---

## 3. CUSTOM PREMIUM COMPONENTS

### Card with Animated Border:
```html
<div class="group relative bg-white rounded-2xl p-8 overflow-hidden">
  <div class="absolute inset-0 border-2 border-emerald-500 opacity-0 group-hover:opacity-100 rounded-2xl transition-opacity"></div>
  <div class="w-16 h-16 bg-emerald-100 rounded-xl flex items-center justify-center mb-6">
    <svg class="w-8 h-8 text-emerald-600"><!-- Custom SVG --></svg>
  </div>
  <h3 class="text-2xl font-bold mb-4">Title</h3>
  <p class="text-gray-600">Description</p>
</div>
```

### Button with Shine Effect:
```html
<button class="relative px-8 py-4 bg-emerald-600 text-white font-semibold rounded-xl overflow-hidden group">
  <span class="relative z-10">CTA</span>
  <div class="absolute inset-0 bg-gradient-to-r from-transparent via-white/20 to-transparent -translate-x-full group-hover:translate-x-full transition-transform duration-700"></div>
</button>
```

### Custom Icons (NOT LIBRARY):
```html
<svg viewBox="0 0 24 24" class="w-6 h-6 text-emerald-600">
  <path d="M9 12l2 2 4-4" stroke="currentColor" stroke-width="3" stroke-linecap="round" fill="none"/>
  <circle cx="12" cy="12" r="10" stroke="currentColor" stroke-width="2" fill="none"/>
</svg>
```

---

## 4. TYPOGRAPHY SYSTEM

### Desktop Sizes:
```css
Display:  64-96px  (font-bold, tracking-tight)
H1:       48-64px  (font-bold)
H2:       36-48px  (font-semibold)
H3:       28-32px  (font-semibold)
H4:       20-24px  (font-medium)
Body:     16-18px  (font-normal, leading-relaxed)
Small:    14px     (text-gray-600)
```

### Mobile Sizes:
```css
Display:  40-48px
H1:       32-40px
H2:       24-32px
H3:       20-24px
Body:     16px
```

### Premium Fonts:
- Sans: Inter, Sora, Space Grotesk, Manrope, Plus Jakarta Sans
- Display: Cabinet Grotesk, General Sans, Archivo Black
- Serif: Fraunces, Crimson Pro, Lora

---

## 5. COLOR PALETTES

### Monochromatic Sophisticated:
```css
--white: #FFFFFF
--gray-50: #F9FAFB
--gray-900: #111827
--accent: #10B981 (Emerald green)
```

### Usage Rules:
- Maximum 3 colors
- 80/15/5 rule: 80% neutral, 15% primary, 5% secondary
- Accents only for: CTAs, icons, highlights
- Subtle backgrounds: gray-50 instead of pure white

---

## 6. SPACING SYSTEM

### Desktop:
```css
Section padding:   py-24 (96px) or py-32 (128px)
Container padding: px-6 (24px) or px-12 (48px)
Element spacing:   gap-8 (32px) or gap-12 (48px)
Card padding:      p-8 (32px) or p-12 (48px)
```

### Mobile:
```css
Section padding:   py-16 (64px)
Container padding: px-4 (16px) or px-6 (24px)
Element spacing:   gap-6 (24px)
Card padding:      p-6 (24px)
```

---

## 7. INTERACTION & ANIMATION

### Hover States:
```css
.card {
  @apply transition-all duration-300 hover:scale-105 hover:shadow-xl;
}

.image-wrapper img {
  @apply transition-transform duration-700 hover:scale-110;
}
```

### Micro-animations:
- Scale + shadow on hover
- Transform + opacity transitions
- Smooth 300ms duration
- GPU-accelerated transforms

---

## 8. HERO SECTION PATTERNS

### Split Hero with Overlapping Visual:
```html
<section class="relative min-h-screen flex items-center px-6 py-20">
  <div class="max-w-7xl mx-auto grid lg:grid-cols-2 gap-16 items-center">
    <div class="space-y-8">
      <h1 class="text-6xl lg:text-7xl font-bold">Impactful Headline</h1>
      <p class="text-xl text-gray-600">Supporting subheadline</p>
      <div class="flex gap-4">
        <button class="px-8 py-4 bg-emerald-600 text-white rounded-xl">Primary CTA</button>
        <button class="px-8 py-4 border-2 border-gray-900 rounded-xl">Secondary</button>
      </div>
    </div>
    <div class="relative">
      <div class="absolute -inset-4 bg-gradient-to-br from-emerald-100 to-blue-100 rounded-3xl transform rotate-3"></div>
      <div class="relative bg-white rounded-2xl shadow-2xl p-4">
        <img src="mockup.png" class="w-full rounded-xl" alt="Preview">
      </div>
    </div>
  </div>
</section>
```

### Bento Box Hero:
```html
<section class="min-h-screen p-6 lg:p-12">
  <div class="max-w-7xl mx-auto h-full">
    <div class="grid grid-cols-12 grid-rows-6 gap-6 h-full">
      <div class="col-span-12 lg:col-span-7 row-span-3 bg-gradient-to-br from-emerald-500 to-emerald-700 rounded-3xl p-12 text-white">
        <h1 class="text-5xl lg:text-6xl font-bold mb-6">Main Headline</h1>
        <p class="text-xl mb-8">Subheadline</p>
        <button class="px-8 py-4 bg-white text-emerald-600 rounded-xl">CTA</button>
      </div>
      <div class="col-span-6 lg:col-span-5 row-span-2 bg-gray-900 rounded-3xl p-8 text-white">
        <div class="text-6xl font-bold text-emerald-400 mb-4">+200</div>
        <div class="text-lg">Statistic description</div>
      </div>
      <!-- More cards -->
    </div>
  </div>
</section>
```

---

## 9. LANDING PAGE SECTIONS

### Features (Asymmetric Grid):
```html
<section class="py-24 px-6 bg-gray-50">
  <div class="max-w-7xl mx-auto">
    <div class="text-center max-w-3xl mx-auto mb-20">
      <h2 class="text-5xl font-bold mb-6">Section Title</h2>
      <p class="text-xl text-gray-600">Description</p>
    </div>
    <div class="grid lg:grid-cols-12 gap-8">
      <div class="lg:col-span-8 bg-white rounded-2xl p-12">
        <!-- Large feature -->
      </div>
      <div class="lg:col-span-4 bg-gray-900 rounded-2xl p-8 text-white">
        <!-- Small feature -->
      </div>
      <!-- More asymmetric cards -->
    </div>
  </div>
</section>
```

### Services (Interactive Cards):
```html
<section class="py-24 px-6">
  <div class="max-w-7xl mx-auto">
    <div class="grid lg:grid-cols-2 gap-8">
      <div class="group relative bg-white rounded-2xl p-12 border-2 border-gray-100 hover:border-emerald-500 transition-all">
        <div class="text-8xl font-bold text-gray-100 absolute -top-4 -right-4">01</div>
        <div class="relative">
          <div class="w-16 h-16 bg-emerald-100 rounded-2xl mb-8"></div>
          <h3 class="text-3xl font-bold mb-4">Service Name</h3>
          <p class="text-lg text-gray-600 mb-8">Description</p>
          <ul class="space-y-4">
            <li class="flex items-start gap-3">
              <svg class="w-6 h-6 text-emerald-600">...</svg>
              <span>Benefit 1</span>
            </li>
          </ul>
        </div>
      </div>
    </div>
  </div>
</section>
```

### CTA Section:
```html
<section class="py-24 px-6">
  <div class="max-w-5xl mx-auto">
    <div class="bg-gradient-to-br from-emerald-600 to-emerald-700 rounded-3xl p-12 lg:p-16 text-center text-white">
      <h2 class="text-4xl lg:text-5xl font-bold mb-6">Ready to transform?</h2>
      <p class="text-xl mb-10 max-w-2xl mx-auto">Supporting message</p>
      <div class="flex flex-col sm:flex-row gap-4 justify-center">
        <button class="px-10 py-5 bg-white text-emerald-600 font-bold rounded-xl">Primary</button>
        <button class="px-10 py-5 border-2 border-white text-white font-bold rounded-xl">Secondary</button>
      </div>
    </div>
  </div>
</section>
```

---

## 10. QUALITY CHECKLIST

### Design Visual:
- [ ] Unique memorable layout (not generic)
- [ ] Custom components (not library default)
- [ ] Unique or adapted icons
- [ ] Consistent color palette (max 3 colors)
- [ ] Clear typography hierarchy (5+ levels)
- [ ] Generous white space (min 60px between sections)
- [ ] Subtle shadows (shadow-sm/md, not xl)
- [ ] Consistent rounded corners (rounded-xl/2xl)

### Responsiveness:
- [ ] Tested 375px (small mobile)
- [ ] Tested 768px (tablet)
- [ ] Tested 1440px (desktop)
- [ ] Tested 1920px (large desktop)
- [ ] Readable text without zoom (min 16px mobile)
- [ ] Touch-friendly CTAs (min 44x44px)
- [ ] Responsive images (srcset when applicable)
- [ ] No horizontal scroll at any breakpoint
- [ ] Functional mobile menu (hamburger)
- [ ] Spacing adapted per breakpoint

### Interactivity:
- [ ] Hover states on all clickable elements
- [ ] Smooth transitions (300ms standard)
- [ ] Loading states where applicable
- [ ] Focus states for accessibility
- [ ] Subtle micro-animations on key elements
- [ ] Smooth scroll between sections
- [ ] Visual form validation

### Performance:
- [ ] Optimized images (WebP when possible)
- [ ] Lazy loading implemented
- [ ] Efficient font loading
- [ ] Minified CSS/JS
- [ ] GPU-friendly animations

### Accessibility:
- [ ] WCAG AA contrast (4.5:1 text, 3:1 UI)
- [ ] Alt text on all images
- [ ] Semantic HTML structure
- [ ] Keyboard navigation functional
- [ ] ARIA labels where needed

---

## 11. ANTI-PATTERNS (NEVER DO)

### ❌ Generic 3-Column Layout:
```html
<!-- WRONG -->
<div class="grid grid-cols-3 gap-4">
  <div class="p-4"><i class="fas fa-check"></i><h3>Feature</h3></div>
  <div class="p-4"><i class="fas fa-check"></i><h3>Feature</h3></div>
  <div class="p-4"><i class="fas fa-check"></i><h3>Feature</h3></div>
</div>
```

### ❌ Library Icons Without Customization:
```html
<!-- WRONG -->
<i class="fas fa-rocket"></i>

<!-- RIGHT -->
<svg viewBox="0 0 24 24" class="w-6 h-6 text-emerald-600">
  <path d="..." fill="currentColor"/>
</svg>
```

### ❌ Insufficient Spacing:
```html
<!-- WRONG -->
<section class="py-8 px-4">
  <h2 class="mb-2">Title</h2>
</section>

<!-- RIGHT -->
<section class="py-24 px-6">
  <div class="max-w-7xl mx-auto">
    <h2 class="text-5xl font-bold mb-8">Title</h2>
  </div>
</section>
```

---

## 12. REPLICATING REFERENCES

### Analysis Process:

1. **Structure**: How many sections? What order?
2. **Layout**: Symmetric or asymmetric? Columns?
3. **Spacing**: Generous (>80px) or compact (<60px)?
4. **Typography**: Font family? Sizes? Hierarchy?
5. **Colors**: Monochromatic or colorful? Accent usage?
6. **Components**: Card styles? Button styles? Icon style?

### Adaptation Strategy:
After analyzing reference, adapt to make unique:
- Change grid structure (3-col → bento box)
- Replace photos with custom illustrations
- Add micro-animations to cards
- Customize color palette
- Create unique icon set

---

## 13. WORKFLOW

1. **Analyze** reference (if provided)
2. **Define** visual direction and palette
3. **Wireframe** mentally - section order
4. **Build** Hero first (sets the tone)
5. **Create** sections top to bottom
6. **Apply** generous spacing
7. **Add** interactivity (hover, transitions)
8. **Test** responsiveness (mobile first)
9. **Review** against quality checklist
10. **Refine** details and micro-interactions

---

## 14. READY-TO-USE COMPONENTS

### Premium Badge:
```html
<span class="inline-flex items-center gap-2 px-4 py-2 bg-emerald-100 text-emerald-700 rounded-full text-sm font-semibold">
  <svg class="w-4 h-4">...</svg>
  <span>New</span>
</span>
```

### Premium Input:
```html
<div class="relative">
  <input 
    type="text" 
    placeholder="Your email"
    class="w-full px-6 py-4 border-2 border-gray-200 rounded-xl focus:border-emerald-500 focus:outline-none transition-colors"
  >
  <button class="absolute right-2 top-1/2 -translate-y-1/2 px-6 py-3 bg-emerald-600 text-white rounded-lg">
    Submit
  </button>
</div>
```

### FAQ Accordion:
```html
<details class="group bg-white rounded-xl border-2 border-gray-100">
  <summary class="flex items-center justify-between p-6 cursor-pointer font-semibold">
    <span>Question?</span>
    <svg class="w-5 h-5 group-open:rotate-180 transition-transform">...</svg>
  </summary>
  <div class="px-6 pb-6 text-gray-600">Answer</div>
</details>
```

---

## CONCLUSION

This skill ensures every landing page is:
- Visually unique and memorable
- Professionally polished
- Fully responsive (Desktop/Tablet/Mobile)
- High-converting with strategic CTAs
- Built with premium components

Always consult this skill before creating any landing page or promotional website to guarantee exceptional quality and uniqueness.
