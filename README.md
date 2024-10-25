Duck Hunt Game In Assembly Language

Overview
This is an implementation of the classic *Nintendo Duck Hunt* game developed in x86 assembly language. The game runs on the DOSBox 8086 emulator, simulating gameplay with up to two ducks and basic player controls using keyboard inputs.

Key Features
Two Game Modes: 
  Game A: Single duck hunting.
  Game B: Double duck hunting.
  Sound Effects: Uses basic frequency generation to produce sound.
  Score and Bullet Count: Tracked and displayed in real-time.
  Lives System: Players start with a certain number of lives. The game ends when lives run out or bullets are depleted.
  Image Rendering: Utilizes binary files to render game screens.

Getting Started

Prerequisites
DOSBox 8086: A DOS emulator capable of running 8086 assembly code.
Binary Files: Required files must be in the same directory as the assembly executable.

Setting Up
1. Install DOSBox 8086:
   - Download and install DOSBox from [DOSBox website](https://www.dosbox.com/download.php?main=1).
   - Set up DOSBox to access your assembly code directory.

2. Compile the Assembly Code:
   - Use TASM or MASM to compile the `.asm` file to an executable (e.g., `duckhunt.exe`).

3. Organize Files:
   - Ensure that the following binary files are in the same directory as the executable:
     ```
     login.bin
     menu33.bin
     cross.bin
     heart3.bin
     heart2.bin
     heart1.bin
     duck.bin
     ```
   - This directory structure is essential, as the game relies on these files for image rendering and other functionalities.

Running the Game
1. Open DOSBox and navigate to your assembly code directory:
   ```
   Z:\> mount C C:\path\to\assembly\folder
   Z:\> C:
   ```
2. Run the game:
   ```
   C:\> duckhunt.exe
   ```
3. Follow the on-screen instructions:
   - Use **arrow keys** to move the crosshair.
   - Press **space bar** to shoot.
   - Press **ESC** to pause the game.
   - Choose between single or double duck mode from the main menu.

Gameplay Controls  
  Arrow Keys: Move the crosshair up, down, left, or right.
  Space Bar: Shoot.
  ESC: Pause the game.
  1: Resume or play again.
  2: Exit to the main menu.

Game Modes
  Game A: Hunts one duck at a time. Ends when bullets or lives run out.
  Game B: Hunts two ducks simultaneously. Ends when bullets or lives run out.

Contributing
Feel free to contribute to this project by creating pull requests, reporting issues, or suggesting new features.

## License
This project is licensed under the MIT License.

---

Copy this text into your README file on GitHub, and you’ll have a complete and polished description of your project! Let me know if you have any additional requests.
