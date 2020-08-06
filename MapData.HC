
#define WLD_WIDTH	(5)
#define WLD_HEIGHT	(5)
#define MAP_WIDTH	(TEXT_COLS*2)
#define MAP_HEIGHT	(TEXT_ROWS*2)

class Tile : Graphic
{
  Bool walkable, opaque;
};

class MapTile
{
  Tile map[MAP_WIDTH][MAP_HEIGHT];
};


U0 SetTile(Tile *tile, U8 char, U8 fgcolor, 
               U8 bgcolor, Bool walkable, 
               Bool opaque)
{
  tile->char = char;
  tile->fgcolor = fgcolor;
  tile->bgcolor = bgcolor;
  tile->walkable = walkable;
  tile->opaque = opaque;
}
