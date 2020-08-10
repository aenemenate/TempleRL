


// Move the entities within the world
Bool MovePos(U16 *xpos, U16 *ypos,
	U16 *wxpos, U16 *wypos,
        I16 xsign, I16 ysign,
        U16 xbound, U16 ybound,
        U16 wxbound, U16 wybound)
{
  xsign=Clamp(xsign,-1,1);
  ysign=Clamp(ysign,-1,1);
// new positions
  I16 nxpos = Clamp(*xpos+xsign,-1,xbound), 
      nypos = Clamp(*ypos+ysign,-1,ybound);
  U16 nwxpos = *wxpos, nwypos = *wypos;
// bounds checking, switching maps
  if (nxpos==-1 
      && xsign==-1
      && *wxpos-1>=0)
  { nwxpos = *wxpos - 1; nxpos = xbound-1; }
  else if (nxpos==xbound 
           && xsign==1
           && *wxpos+1<wxbound)
  { nwxpos = *wxpos + 1; nxpos = 0; }
  if (nypos==-1 
      && ysign==-1
      && *wypos-1>=0)
  { nwypos = *wypos - 1; nypos = ybound-1; }
  else if (nypos==ybound
           && ysign==1 
           && *wypos+1<wybound)
  { nwypos = *wypos + 1; nypos = 0; }
// checking for walls and entities
  if (world
      .wmap[nwxpos][nwypos]
      .map[nxpos][nypos]
      .walkable == FALSE
  ||  world.wmap[nwxpos][nwypos]
      .entmap[nxpos][nypos]
      ->pos.x!=65535
     ) {
    nxpos =*xpos;
    nypos =*ypos;
    nwxpos=*wxpos;
    nwypos=*wypos;
  }
// return false if unit does not move
  if (*xpos==nxpos && *ypos == nypos 
  || (nxpos>=xbound || nypos>=ybound))
    return FALSE;
// set entity map (separate from
// the entity list)
  world
  .wmap[nwxpos][nwypos]
  .entmap[nxpos][nypos]
  = world.wmap[*wxpos][*wypos]
    .entmap[*xpos][*ypos];
  world.wmap[*wxpos][*wypos]
  .entmap[*xpos][*ypos]
  = &dummy_ent;
// set values
  *xpos =nxpos;
  *ypos =nypos;
  *wxpos=nwxpos;
  *wypos=nwypos;
  return TRUE;
}
