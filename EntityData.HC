
// Data Types

class Entity : Graphic
{
  U16 xpos, ypos, wxpos, wypos;
};


// Builders

U0 SetEntity(Entity *ent, U8 char, U8 fgcolor, 
                   U8 bgcolor, U16 xpos, 
                   U16 ypos, U16 wxpos,
                   U16 wypos)
{
  ent->char = char;
  ent->fgcolor = fgcolor;
  ent->bgcolor = bgcolor;
  ent->xpos = xpos;
  ent->ypos = ypos;
  ent->wxpos = wxpos;
  ent->wypos = wypos;
}
