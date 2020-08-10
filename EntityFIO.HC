#define DB_FILENAME	("~/TempleRL/Ent.BIN")
#define DB_MAX		(1)
#define DB_BLKS		(1)

class EntityRW
{
  Graphic gset;
  Position pos;
  Bool isplayer;
  // subtract however many bytes
  // are used for data
  U8 tile_pad[BLK_SIZE-3-sizeof(Graphic)-sizeof(Position)-1];
};

class U16RW
{
  U16 val;
  U8 tile_pad[BLK_SIZE-2];
};

U0 EntityRWFromEntity(EntityRW *entrw, Entity *ent)
{
  entrw->gset.bgcolor = ent->gset.char;
  entrw->gset.bgcolor = ent->gset.fgcolor;
  entrw->gset.bgcolor = ent->gset.fgcolor;
  entrw->pos.x = ent->pos.x;
  entrw->pos.y = ent->pos.y;
  entrw->pos.wx = ent->pos.wx;
  entrw->pos.wy = ent->pos.wy;
  entrw->isplayer = ent->isplayer;
}

U0 EntityFromEntityRW(Entity *ent, EntityRW *entrw)
{
  ent->gset.bgcolor = entrw->gset.char;
  ent->gset.bgcolor = entrw->gset.fgcolor;
  ent->gset.bgcolor = entrw->gset.fgcolor;
  ent->pos.x = entrw->pos.x;
  ent->pos.y = entrw->pos.y;
  ent->pos.wx = entrw->pos.wx;
  ent->pos.wy = entrw->pos.wy;
  ent->isplayer = entrw->isplayer;
}

U0 InitEntityDatabase()
{
  CFile *f = FOpen(DB_FILENAME, "w", DB_MAX*DB_BLKS);
  FClose(f);
}

U0 EntityFIOInit()
{
  if (!FileFind(DB_FILENAME))
    InitMapDatabase;
}

U0 WriteEntities()
{
  U64 e;
  CFile *f;
  f=FOpen(DB_FILENAME, "w+");
  U16RW ent_cnt;
  ent_cnt.val=world.ent_cnt;
  FBlkWrite(f,&ent_cnt,0*DB_BLKS, DB_BLKS);
  for (e=0;e<world.ent_cnt;e++)
  {
    EntityRW entrw;
    EntityRWFromEntity(&entrw, &(world.ents[e]));
    FBlkWrite(f,&entrw,DB_BLKS+(e*DB_BLKS), DB_BLKS);
  }
  FClose(f);
}

U0 ReadEntities()
{
  U64 e, i, j;
  CFile *f;
  f=FOpen(DB_FILENAME,"r");
  U16RW ent_cnt;
  FBlkRead(f,&ent_cnt,0*DB_BLKS,DB_BLKS);
  world.ent_cnt=ent_cnt.val;
  for (e=0;e<world.ent_cnt;e++)
  {
    EntityRW entityrw;
    FBlkRead(f,&entityrw,DB_BLKS+e*DB_BLKS,DB_BLKS);
    EntityFromEntityRW(&(world.ents[e]), &entityrw);
  }
  UpdateEntityMap;
  FClose(f);
}
