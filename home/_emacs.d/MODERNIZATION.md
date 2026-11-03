# Emacs Config Modernization Plan

Tracking the migration of `init.el` from the 2019–2021 Ivy-era setup to a
modern (Emacs 29/30+) configuration.

**Status legend:** ⬜ todo · 🔄 in progress · ✅ done · ⏸️ deferred

---

## Stage 1 — Low-risk cleanup & housekeeping

Safe changes that remove dead code and fix small bugs. No behavioral surprises.

- ✅ **1.1** Remove dead `org` ELPA archive (orgmode.org/elpa was shut down)
- ✅ **1.2** Add `nongnu` ELPA archive (now required by many packages)
- ✅ **1.3** Drop the `use-package` bootstrap/install dance (built into Emacs 29+)
- ✅ **1.4** Create `early-init.el` and move the GC + `file-name-handler-alist`
  startup hacks into it (manual GC kept; `gcmh` noted as a TODO in early-init.el)
- ✅ **1.5** Remove redundant `display-line-numbers-mode 1`
  (keep only `global-display-line-numbers-mode 1`)
- ✅ **1.6** Fix yasnippet hook: `(prog-mode . yas-minor-mode)` instead of
  hooking `yas-global-mode` on `prog-mode`
- ✅ **1.7** Resolve flymake/flycheck duplication (removed redundant flymake block; flycheck global)
- ✅ **1.8** Drop `editorconfig` package on Emacs 30+ (built-in) — `:ensure` guarded for older Emacs

## Stage 2 — Icons: all-the-icons → nerd-icons

The ecosystem default moved to `nerd-icons` (renders in terminal too).

- ✅ **2.1** Replace `all-the-icons` → `nerd-icons`
- ✅ **2.2** `all-the-icons-dired` → `nerd-icons-dired`
- ✅ **2.3** Removed `all-the-icons-ivy`; added `nerd-icons-ivy-rich` (+ `ivy-rich`)
  as a BRIDGE so completion icons keep working until Stage 3 swaps in
  `nerd-icons-completion` + marginalia
- ✅ **2.4** centaur-tabs `centaur-tabs-icon-type 'nerd-icons`; added
  `treemacs-nerd-icons` theme; doom-modeline uses nerd-icons by default (v4+)
- ✅ **2.5** Updated font-install comment to `M-x nerd-icons-install-fonts`;
  README package list updated

## Stage 3 — Completion: Ivy → Vertico stack (the big one)

> **Deferred / skipped for now.** When picking this up, remove the bridge
> packages added in 2.3 (`nerd-icons-ivy-rich`, `ivy-rich`) along with ivy itself,
> and wire up `nerd-icons-completion` instead.

Replace Ivy/Counsel/Swiper with Vertico + Consult + Orderless + Marginalia + Embark.

- ⬜ **3.1** Add `vertico`, `orderless`, `marginalia`, `consult`, `embark`, `embark-consult`
- ⬜ **3.2** Rebind keys (swiper→`consult-line`, counsel-M-x→`execute-extended-command`,
  counsel-rg→`consult-ripgrep`, counsel-git-grep, etc.)
- ⬜ **3.3** Remove `ivy`, `counsel`, `swiper`, `ivy-posframe`, `all-the-icons-ivy`
- ⬜ **3.4** `counsel-projectile` → `consult` + projectile (or `consult-projectile`)
- ⬜ **3.5** `lsp-ivy` → lsp + consult integration
- ⬜ **3.6** Decide: keep `company` or switch to `corfu` + `cape` (capf-based)
- ⬜ **3.7** Update `projectile-completion-system` / `which-key` integration

## Stage 4 — Tree-sitter language modes (Emacs 29+)

Adopt built-in `treesit` modes; retire regex/abandoned modes.

- ✅ **4.1** Added `treesit-language-source-alist` + `my/treesit-install-all-grammars`
  helper; remaps via `major-mode-remap-alist` + explicit `auto-mode-alist` entries
- ✅ **4.2** `python-mode` → `python-ts-mode`
- ✅ **4.3** `typescript-mode` → `typescript-ts-mode` / `tsx-ts-mode` (package removed)
- ✅ **4.4** `js2-mode` + `rjsx-mode` (abandoned) → `js-ts-mode` / `tsx-ts-mode` (packages removed)
- ✅ **4.5** `go-mode` → `go-ts-mode`, `rust-mode` → `rust-ts-mode` (packages removed;
  before-save/cargo hooks moved to the `-ts-mode` hooks)
- ✅ **4.6** `json-mode`/`yaml-mode`/`toml-mode`/`dockerfile-mode` → `-ts-mode` variants (packages removed)
- ✅ **4.7** LSP hooks retargeted to the `-ts-mode` names (ts-modes don't run the classic hooks)

## Stage 5 — Optional / evaluate later

Not strictly modernization; decide per preference.

- ⏸️ `projectile` → built-in `project.el` (projectile still fine)
- ⏸️ `lsp-mode` → built-in `eglot` (lsp-mode still fine)
- ⏸️ Revisit `minimap`, `sx`, `ein`, `centaur-tabs` for continued use

---

## Progress log

- 2026-11-03 — Plan created. Starting Stage 1.
- 2026-11-03 — **Stage 1 complete.** Added `nongnu` ELPA, removed dead org ELPA
  + use-package bootstrap, created `early-init.el` (GC + file-name-handler moved
  there), fixed line-number/yasnippet/flycheck/editorconfig items. Verified on
  Emacs 31.1: `early-init.el` byte-compiles clean, `init.el` parses OK.
- 2026-11-03 — **Stage 2 complete.** all-the-icons → nerd-icons (+ dired),
  centaur-tabs/treemacs pointed at nerd-icons, font-install comment + README
  updated. `all-the-icons-ivy` removed (completion icons land in Stage 3).
  `init.el` parses OK; no stray all-the-icons code refs remain.
- 2026-11-03 — Added `nerd-icons-ivy-rich` + `ivy-rich` bridge so completion
  icons keep working on Ivy. Stage 3 (Vertico) deferred to a future session;
  remove the bridge when it starts.
- 2026-11-03 — **Stage 4 complete** (Stage 3 skipped for now). Added TREE-SITTER
  section (grammar sources + `my/treesit-install-all-grammars` + remaps +
  auto-mode-alist). Migrated python/js/ts/tsx/json/yaml/toml/go/rust/dockerfile
  to built-in `-ts-mode`; removed the superseded external packages; moved
  go/rust before-save + cargo hooks and all LSP hooks to the `-ts-mode` names.
  Verified on Emacs 31.1: parses OK, all 11 ts-modes available. NOTE: grammars
  must be built once via `M-x my/treesit-install-all-grammars` (needs a C compiler).
