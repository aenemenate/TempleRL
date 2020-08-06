
Bool MovePos(U16 *xpos, U16 *ypos,
	U16 *wxpos, U16 *wypos,
        I16 xsign, I16 ysign,
        U16 xbound, U16 ybound,
        U16 wxbound, U16 wybound)
{
  xsign=Clamp(xsign,-1,1);
  ysign=Clamp(ysign,-1,1);
  I16 nxpos = *xpos+xsign, nypos = *ypos+ysign;
  U16 nwxpos = *wxpos, nwypos = *wypos;
  if (nxpos < 0 && *wxpos-1>=0)
  { nwxpos = *wxpos - 1; nxpos = xbound-1; }
  if (nypos < 0 && *wypos-1>=0)
  { nwypos = *wypos - 1; nypos = ybound-1; }
  if (nxpos >= xbound && *wxpos+1<wxbound)
  { nwxpos = *wxpos + 1; nxpos = 0; }
  if (nypos >= ybound && *wypos+1<wybound)
  { nwypos = *wypos + 1; nypos = 0; }
  if (wmap[nwxpos][nwypos].map[nxpos][nypos].walkable == FALSE)
  {
    nxpos=*xpos;
    nypos=*ypos;
    nwxpos=*wxpos;
    nwypos=*wypos;
  }
  if (*xpos==nxpos && *ypos == nypos)
    return FALSE;
  *xpos = nxpos;
  *ypos = nypos;
  *wxpos = nwxpos;
  *wypos = nwypos;
  return TRUE;
}

