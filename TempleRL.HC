
#include "Core"
#include "EntityData"
#include "MapData"

// * gamestates, main menu
// * hardcode some walls
// * collision detection
// * perlin noise
// * multiple maptiles
// * move map tiles
// * change playstate input to switch statement
// * remove excessive array access in genmap and playstatedrawit
// * add GetTile function
// * move wmap into MapData
// * move entity into EntityData
// * playstate: 
	// menu on esc ins/ of exit
// * fix bug when switching maps
// * add border to esc menu
// * save map
// * implement continue
// * save seed instead of saving map
// * player flag to entity
// * store entities as array & nument
// * make Entity *ent_map; to allow
	// for easy access and retrieval
// * save entities
// * dummy draw entities
// * test entities
// * efficient draw entities
// - fov
// - trees
// - plants
// - world map viewer
// - dungeons
// - scheduler
// - basic attack
// - items
// - armor
// - weapons
// - ai
// - ranged weapons
// - scrolls
// - user interface


#include "MapEd"
#include "MapFIO"
#include "EntityEd"
#include "EntityFIO"
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


