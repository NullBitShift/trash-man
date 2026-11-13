# Project Roadmap: Cozy Trash Collector

## Vision
A casual, cozy, non-stressful clean-up game where players pick up trash, deposit it into cans for coins, and spend those coins on a perk and cosmetic system that speeds up the gameplay loop.

---

## Milestones

### Milestone 1: Prototype (Current Phase)
*Focus: Foundational core loop feel, automated spawning, and structural integrity.*
- [x] Player movement strategy pattern & basic input controller
- [x] Trash collection mechanics (`CollectionComponent`, `CollectionData`) with max-capacity enforcement
- [x] Trash can deposition, cooldowns, and coin-pop VFX (`TrashCan`, `ProgressionData`)
- [x] Sandbox testing environment and clean project directory structure
- [x] **Trash Spawner & Variants:** Implement an automated spawner in the sandbox that randomly selects from the 3 trash sprite variants over time.
- [ ] **Shared Play Area:** Extract the boundary polygon and `NavigationRegion2D` from `TrashSpawner` into a shared play-area node for spawning and player navigation.
- [ ] **Player Boundary Confinement:** Constrain player movement to the shared play-area boundaries.
- [ ] **Bag Scale Visual Cue:** Add dynamic scale manipulation to the player's bag component to reflect inventory fill percentage visually.
- [ ] **Barebones Coin HUD:** Implement a clean on-screen coin counter wired to `ProgressionData`.

### Milestone 2: Vertical Slice
*Focus: Economy, progression depth, and designed space.*
- [ ] **Perk Shop & Economy Integration:**
    - Implement the "Bag" unlock as the first mandatory progression gate.
    - Build upgrade tiers for Bag Capacity and Movement Speed using `ProgressionData`.
    - Add a foundational cosmetic skin purchase to test non-stat items.
- [ ] **Designed Level:**
    - Transition out of the sandbox into an intentional, cozy play space layout.
- [ ] **Loop Balancing:**
    - Tune spawn rates, inventory caps, and coin costs for optimal cozy pacing.

### Milestone 3: Complete Indie Game
*Focus: Advanced features, polish, and final packaging.*
- [ ] **Advanced Perks:**
    - Trash Magnet, Longer Reach pickup aura, and Companion pet logic.
- [ ] **Expanded Content & Cosmetics:**
    - Additional player skins, trash variants, and environment dressings.
- [ ] **Audio Design:**
    - Custom sound effects and ambient audio layer (developer-created last step).
- [ ] **Final Polish & Build:**
    - Juice pass (tweens, particles, screen feel), export presets, and final distribution prep.