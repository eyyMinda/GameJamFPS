# FPS Survival/Horror Tycoon Game Design Document

## Introduction

This game is an FPS survival/horror with a tycoon gameloop, set in a spaceship environment. Players must navigate through the challenges of survival, repairing and upgrading their ship, while deciding whether to engage with others as friendlies or hostiles.

## Initial Setup

Players begin by waking up alone in a pod inside a dark spaceship, with only red alert lights for illumination. The initial exploration phase involves discovering broken equipment and workbenches, setting up the necessity for repairs.

## Friendly NPCs

In the hostile environment of our game, not every encounter is a threat. Players will occasionally come across friendly NPCs, survivors like themselves, navigating the perils of the ship.

### Characteristics and Behavior

- **Passive Presence:** These NPCs are non-aggressive and are placed in various parts of the ship. Their primary role is to add depth to the game's atmosphere, portraying the widespread fear and desperation aboard the ship.
- **Minimal Interaction:** For the time being, interaction with these NPCs is limited. They do not offer quests, items, or assistance.

### Interaction Mechanism

- **Dialogue Prompt:** The displayed text, "Please leave me be!", indicates that the NPC is frightened and uninterested in interaction. This simple dialogue adds to the immersive experience of the game, reflecting the NPCs' fear and desire to avoid trouble.

### Role in the Game World

- **Atmospheric Enhancement:** The inclusion of these NPCs serves to reinforce the game's survival/horror theme, reminding players that they are not the only ones struggling to survive in this treacherous environment.
- **Future Expansion:** While currently limited in interaction, these NPCs have the potential for more involved roles in future game updates, such as providing information, trading, or even joining the player under certain conditions.

## Upgrade and Crafting Mechanics

In the game, 'tycoon' aspect is represented through the player's ability to upgrade their personal equipment and repair certain ship systems. While the ship's structure remains unchanged throughout the game, players can significantly enhance their gear and some ship functionalities.

### Personal Equipment Upgrades

- **Armor and Weapons:** Players can find and craft better armor and a variety of weapons, including both melee and firearms. Upgrades will increase damage output, durability...
- **Mobility Gear:** Upgrades like faster boots improve the player's movement speed, agility.

### Ship System Repairs and Upgrades

- **Lighting System:** Initially, the ship may have limited lighting, affecting visibility. Repairing the lighting system can improve navigation and reduce the risk of enemy ambushes.
- **Workbench Upgrades:** The ship's workbench can be upgraded to enhance specific attributes of weapons, like increasing the rate of fire, accuracy, or damage of guns. It can also be used to reinforce armor, making it more resistant to enemy attacks.

### Resource Management and Crafting

- **Looting for Resources:** Players must scavenge for resources within the ships they explore. These resources are crucial for repairs and crafting upgrades.
- **Strategic Upgrades:** Players must choose wisely which equipment to upgrade, balancing their immediate survival needs against potential future encounters. Each upgrade or repair decision can significantly impact the player’s ability to progress in the game.

### Progression System

- **Incremental Improvements:** Upgrades provide a tangible sense of progression, with each enhancement making the player stronger and better equipped to face the challenges ahead.
- **Reward and Motivation:** Successfully upgrading equipment and repairing ship systems not only enhances the player's survival prospects but also serves as a motivator, driving them to explore more dangerous ship encounters.

## In-Game Events (Loop)

1. **Prerecorded Message:**

   - A voice message announces that the ship (e.g., Exon148) will soon connect with another base.

2. **Impact Event:**

   - The ship shakes, simulating a collision. The prerecorded message "Boarding complete" is played, and a door lights up in green, indicating a new area to explore.

3. **Connected Ship Exploration:**
   - Players have 5-10 minutes to explore the connected ship. A timer near the door in both the home and boarded ship displays the remaining time. Players must return to their ship before the timer expires, or face dire consequences.

## Boarding Process Failure

If players fail to return to their ship in time:

- A voice message announces the presence of unauthorized personnel after the disconnection.
- Toxic gas is released, turning the player into a monster, and the game ends.

## End Game Screen

Displays:

- Number of successful boarding processes survived
- Equipment and workbenches unlocked
- Monster kills

## NPC and Monster Mechanics

- Each boarded ship contains exactly one NPC.
- Up to 4 monsters may be encountered, indicating previous survivors who failed to escape and were transformed by the toxic gas.

## Enemies

In the game, players will encounter hostile entities that have been mutated by the toxic environment of the spaceship. These enemies are always hostile but will only actively engage the player upon visual detection. There are currently two variations of enemies, each presenting unique challenges to the player.

### 1. The Infected (Medium Difficulty)

- **Appearance:** Human-like with a worn-out, mutated face, indicative of prolonged exposure to the toxic gas.
- **Behavior:** These enemies stand upright and move at a moderate pace. They represent former humans who failed to leave the boarded ship in time and underwent mutation.
- **Attack Pattern:** The Infected engage in close-range combat, using simple melee attacks. Players must be cautious of their direct approach and reasonably quick movements simillar to the players speed.

### 2. Crawling Infected (Easy Difficulty)

- **Appearance:** These enemies move on all fours, appearing more deteriorated than the standing Infected.
- **Behavior:** They crawl towards the player slowly, making them less immediately threatening but dangerous in close quarters.
- **Attack Pattern:** Once in range, the Crawling Infected can latch onto the player, significantly reducing the player's movement speed. This makes escape difficult, and players will suffer continuous damage from melee attacks while in its grasp.

### Strategy

Players must employ different strategies to combat these enemy types. Stealth and avoidance can be key, especially in areas heavily populated with Infected. Managing the line of sight and using the environment to one’s advantage will be crucial for survival. Additionally, the varying difficulty levels of these enemies encourage players to prioritize threats and manage resources effectively during combat.

## Prerecorded Voice Messages

### For Sound/Music Development Team

1. Initial Ship Connection:
   - "Attention: [Ship Name] will connect with base in 2 minutes."
2. Boarding Complete:
   - "Boarding complete. Please proceed with caution."
3. Unauthorized Personnel Warning:
   - "[Ship Name] has detected unauthorized personnel. Failure to leave before disconnection will result in termination."
4. Failure to Exit:
   - "Attention: Unauthorized personnel detected. Initiating containment protocol."

## Music and Ambience

Eerie and unsettling horror ambience, including sounds of metal creaking and wind within the ship. Music should amplify the sense of dread and urgency, especially during the boarding process and the countdown timer.

## Conclusion

This FPS survival/horror tycoon game promises an intense and immersive experience, blending the urgency of survival with strategic upgrades and hostile encounters, set in the haunting confines of a spaceship.
