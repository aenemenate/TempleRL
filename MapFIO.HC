#define DB_FILENAME	("~/TempleRL/Map.BIN")
#define DB_MAX		(1)
#define DB_BLKS		(1)

class WorldRW
{
  I64 seed;
  U8 tile_pad[BLK_SIZE-8];
};

U0 WorldRWFromWorld(WorldRW *worldrw, World *world)
{
  worldrw->seed = world->seed;
}

U0 WorldFromWorldRW(World *world, WorldRW *worldrw)
{
  MemSet(world, 0, sizeof(World));
  world->seed = worldrw->seed;
  GenMap;
}

U0 InitMapDatabase()
{
  CFile *f = FOpen(DB_FILENAME, "w", DB_MAX*DB_BLKS);
  FClose(f);
}

U0 MapFIOInit()
{
  if (!FileFind(DB_FILENAME))
    InitMapDatabase;
}

U0 WriteMap()
{
  CFile *f;
  f=FOpen(DB_FILENAME, "w+");
  WorldRW worldrw;
  MemSet(&worldrw, 0, BLK_SIZE);
  WorldRWFromWorld(&worldrw, &world);
  FBlkWrite(f,&worldrw,0*DB_BLKS, DB_BLKS);
  FClose(f);
}

U0 ReadMap()
{
  CFile *f;
  f=FOpen(DB_FILENAME,"r");
  WorldRW worldrw;
  FBlkRead(f,&worldrw,0*DB_BLKS, DB_BLKS);
  WorldFromWorldRW(&world, &worldrw);
  FClose(f);
}