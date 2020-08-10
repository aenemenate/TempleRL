
#define WLD_WIDTH	(5)
#define WLD_HEIGHT	(5)
#define MAP_WIDTH	(TEXT_COLS*2)
#define MAP_HEIGHT	(TEXT_ROWS*2)
#define MAX_ENT 	(2048)

class Tile : Graphic
{
  Bool walkable, opaque;
};

Entity dummy_ent;
SetEntity(&dummy_ent,' ', BLACK, BLACK,
	  65535, 65535, 65535, 65535, FALSE);

class MapTile
{
  Tile map[MAP_WIDTH][MAP_HEIGHT];
  Entity *entmap[MAP_WIDTH][MAP_HEIGHT];
};

class World
{
  I64 seed;
  MapTile wmap[WLD_WIDTH][WLD_HEIGHT];
  Entity ents[MAX_ENT];
  U16 ent_cnt;
};

U0 InitWorld(World *world)
{
  I64 wi, wj, i, j, e;
  world->seed=0;
  world->ent_cnt=0;
  for (wi=0;wi<WLD_WIDTH;wi++)
    for (wj=0;wj<WLD_WIDTH;wj++)
    {
      MapTile *curmap = &(world->wmap[wi][wj]);
      for (i=0;i<MAP_WIDTH;i++)
	for (j=0;j<MAP_HEIGHT;j++)
	{
	  curmap->entmap[i][j]=&dummy_ent;
	}
    }
  for (e=0;e<MAX_ENT;e++)
    MemSet(&(world->ents[e]),0,sizeof(Entity));
}

World world;
InitWorld(&world);


// dealing with tiles

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

Tile *GetTile(I16 wx, I16 wy, I16 x, I16 y)
{
  return &(world.wmap[wx][wy].map[x][y]);
}

Tile *GetTileFM(MapTile *map, I16 x, I16 y)
{
  return &(map->map[x][y]);
}

// map data polls
U0 UpdateEntityMap()
{
  U16 wi,wj,i,j;
  for (wi=0;wi<WLD_WIDTH;wi++)
    for (wj=0;wj<WLD_WIDTH;wj++)
    {
      MapTile *curmap = &(world.wmap[wi][wj]);
      for (i=0;i<MAP_WIDTH;i++)
	for (j=0;j<MAP_HEIGHT;j++)
	{
	  curmap->entmap[i][j]=&dummy_ent;
	}
    }
  U16 e;
  for (e=0;e<world.ent_cnt;e++)
  {
    Entity *ent=&(world.ents[e]);
    world.wmap[ent->pos.wx][ent->pos.wy]
      .entmap
      [ent->pos.x]
      [ent->pos.y] 
      = &(world.ents[e]);
  }
}

// dealing with entities
Bool AddEntity(U8 char, U8 fgcolor, 
             U8 bgcolor, U16 xpos, 
             U16 ypos, U16 wxpos,
             U16 wypos, Bool isplayer)
{
  if (world.ent_cnt < MAX_ENT)
  {
    world.ent_cnt++;
    SetEntity(&(world.ents[world.ent_cnt-1]), char, fgcolor, bgcolor,
	      xpos, ypos, wxpos, wypos, isplayer);
    world.wmap[wxpos][wypos].entmap[xpos][ypos] = &(world.ents[world.ent_cnt-1]);
    return TRUE;
  }
  return FALSE;
}

I16 FindEntityIndex(U16 xpos, U16 ypos,
		   U16 wxpos, U16 wypos)
{
  I64 ei;
  for (ei=0;ei<world.ent_cnt;ei++)
  {
    if (world.ents[ei].pos.x == xpos
     && world.ents[ei].pos.y == ypos
     && world.ents[ei].pos.wx == wxpos
     && world.ents[ei].pos.wy == wypos)
      return ei;
  }
  return -1;
}

Entity *GetPointToPlayer()
{
  I64 ei;
  for (ei=0;ei<world.ent_cnt;ei++)
    if (world.ents[ei].isplayer)
      return &(world.ents[ei]);
// create player if search for them
// somehow turned up blank
// TODO:handle case where there is
// not enough space to add player
  AddEntity('@', YELLOW, BLACK, MAP_WIDTH/2, MAP_HEIGHT/2+21, 0, 0, TRUE);
  for (ei=0;ei<world.ent_cnt;ei++)
    if (world.ents[ei].isplayer)
      return &(world.ents[ei]);
}

U0 ShiftDownEnts(U16 start_index)
{
  I64 i;
  for (i=start_index;i<world.ent_cnt;i++)
  {
    CopyEntity(&(world.ents[i+1]),&(&world.ents[i]));
  }
}

Bool RemoveEntity(U16 xpos, U16 ypos, U16 wxpos, U16 wypos)
{
  if (world.ent_cnt > 0)
  {
    I64 i;
    for (i=0;i<world.ent_cnt;i++)
    {
      Entity *ent = world.ents[i];
      if (ent->pos.x == xpos
	  && ent->pos.y == ypos
	  && ent->pos.wx == wxpos
	  && ent->pos.wy == wypos)
      {
	U16 wx=ent->pos.wx, 
	    wy=ent->pos.wy;
	world.ent_cnt--;
	ShiftDownEnts(i);
	UpdateEntityMap;
	return TRUE;
      }
    }
  }
  return FALSE;
}

