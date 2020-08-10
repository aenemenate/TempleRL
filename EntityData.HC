
// Data Types

class Entity
{
  Graphic gset;
  Position pos;
  Bool isplayer;
};


// Builders

U0 SetEntity(Entity *ent, U8 char, U8 fgcolor,
	     U8 bgcolor, U16 xpos, 
	     U16 ypos, U16 wxpos,
	     U16 wypos, Bool isplayer)
{
  ent->gset.char = char;
  ent->gset.fgcolor = fgcolor;
  ent->gset.bgcolor = bgcolor;
  ent->pos.x = xpos;
  ent->pos.y = ypos;
  ent->pos.wx = wxpos;
  ent->pos.wy = wypos;
  ent->isplayer = isplayer;
}

U0 CopyEntity(Entity *ent_fr, Entity *ent_to)
{
  ent_to->gset.char = ent_fr->gset.char;
  ent_to->gset.fgcolor = ent_fr->gset.fgcolor;
  ent_to->gset.bgcolor = ent_fr->gset.bgcolor;
  ent_to->pos.x = ent_fr->pos.x;
  ent_to->pos.y = ent_fr->pos.y;
  ent_to->pos.wx = ent_fr->pos.wx;
  ent_to->pos.wy = ent_fr->pos.wy;
  ent_to->isplayer = ent_fr->isplayer;
}

