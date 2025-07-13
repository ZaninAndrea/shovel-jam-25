Struttura dei file

project_name/
│
├── assets/             # File multimediali grezzi: immagini, audio, video
│   ├── textures/
│   ├── sprites/
│   ├── audio/
│   └── fonts/
│
├── scenes/             # Tutte le scene `.tscn` e le risorse e script utilizzati solo da una scene
│   ├── ui/             # Scene di interfaccia utente
│   ├── player/         # Scene per player
│   ├── rooms/          # Scene delle stanze dell'astronave
│   ├── items/          # Oggetti che si possono raccogliere
│   └── objects/        # Oggetti che stanno dentro le stanze
│
├── scripts/            # Script `.gd` generali
│   ├── core/           # Funzionalità di base (es. input, salvataggio)
│   ├── managers/       # Scene manager, audio manager, ecc.
│   └── components/     # Comportamenti riutilizzabili (es. Health, AI)
│
├── resources/          # Risorse custom generali: `.tres`, `.res`
│
├── autoload/           # Script per singleton/autoloads (es. `Game.gd`)
│
└── project.godot       # File principale del progetto
