


#include "Base"
#include "MapData"
#include "EntityData"

// * gamestates, main menu
// * hardcode some walls
// * collision detection
// * perlin noise
// * multiple maptiles
// * move map tiles
// - playstate: menu on esc ins/ of exit
// - save game
// - implement continue
// - trees
// - fov
// - plants
// - world map viewer
// - dungeons

Entity player;
MapTile wmap[WLD_WIDTH][WLD_HEIGHT];

#include "MapEd"
#include "EntityEd"
#include "GameStates/Play"
#include "GameStates/MainMenu"



U0 TempleRL()
{  
  SettingsPush; //See $LK,"SettingsPush",A="MN:SettingsPush"$
  Fs->text_attr=WHITE<<4+BLACK;
  AutoComplete;
  DocClear;
  MenuPush(
	"File {"
	"  Exit(,CH_SHIFT_ESC);"
        "}"
	);
  MainMenuLoop; // start main loop
  SettingsPop;
  MenuPop;
  Exit;
}