#define MOPT_COUNT(2)
#define TEXT_ATTR (BLACK<<12+WHITE<<8)

Entity *player;

U8 *menuopts[MOPT_COUNT];
U8 selopt = 0;
Bool showmenu = FALSE;

Bool MenuSelectOption()
{
  Bool contgame;
  switch (selopt)
  {
    case (0):
      MapFIOInit;
      WriteMap;
      EntityFIOInit;
      WriteEntities;
      contgame = FALSE;
      break;
    case (1):
      contgame = FALSE;
      break;
  }
  return contgame;
}

Bool ShowMenu()
{
  Bool contgame = TRUE;
  showmenu = !showmenu;
  I64 key=0, sc=0, msg_code;
  while (showmenu)
  {
    if (msg_code=GetMsg(&key,&sc,1<<MSG_KEY_DOWN | 1<<MSG_KEY_UP)) 
    {
      if (msg_code==MSG_KEY_DOWN) 
      {
	switch (key)
	{
	  case ('8'):
	    selopt=Clamp(selopt-1,0,MOPT_COUNT-1);
	    break;       
	  case ('2'):
	    selopt=Clamp(selopt+1,0,MOPT_COUNT-1);
	    break;          
          case (CH_SPACE):
            contgame = MenuSelectOption;
	  case (CH_ESC):
          case (CH_SHIFT_ESC):
	    showmenu=FALSE;
	    break;
	}
        if (sc.u8[0] == SC_ENTER)
        {
          contgame = MenuSelectOption;
          showmenu=FALSE;
        }
      }
    }
  }
  selopt = 0;
  return contgame;
}

U0 SetMenu()
{
  menuopts[0]="save & quit";
  menuopts[1]="just quit";
}

U0 PlayInit()
{
  SetMenu;
  player=GetPointToPlayer;
}


U0 PlayDrawIt(CTask *task, CDC *)
{
  I64 startx,starty,i,j,e, wx, wy;
// calculate necessary values
  wx=player->pos.wx;
  wy=player->pos.wy;
  startx = player->pos.x - task->win_width/2;
  starty = player->pos.y - task->win_height/2;
  if (startx < 0) startx = 0;
  if (starty < 0) starty = 0;
  if (startx > MAP_WIDTH - task->win_width)
    startx = MAP_WIDTH - task->win_width;
  if (starty > MAP_HEIGHT - task->win_height)
    starty = MAP_HEIGHT - task->win_height;
// draw map
  MapTile *curmap = &(world.wmap[wx][wy]);
  for (i=0;i<task->win_height;i++)
  {
    for (j=0; j<task->win_width;j++)
    {  
      Tile *tile = GetTileFM(curmap,startx+j,starty+i);
      TextChar(task,FALSE,j,i,tile->char+(tile->bgcolor<<4+tile->fgcolor)<<8);
      Entity *ent = curmap->entmap[startx+j][starty+i];
      if (ent->gset.char != ' ')
        TextChar(task,FALSE,ent->pos.x-startx,ent->pos.y-starty,ent->gset.char+(BLACK<<4+ent->gset.fgcolor)<<8);
    }
  }
// draw menu
  if (showmenu)
  {
    for (i=task->win_width/2-15;i<=task->win_width/2+15;i++)
      for (j=task->win_height/2-1-MOPT_COUNT/2-1;j<=task->win_height/2+1+MOPT_COUNT/2+MOPT_COUNT%2+1;j++)
      {
        TextChar(task,FALSE,i,j,' '+(BLACK<<4+WHITE)<<8);
      }
    TextBorder(task,
	task->win_width/2-15,task->win_width/2+15,
	task->win_height/2-1-MOPT_COUNT/2-1,task->win_height/2+1+MOPT_COUNT/2+MOPT_COUNT%2+1,
        TEXT_ATTR>>8,TRUE);
    for (i=0;i<MOPT_COUNT;i++)
    {
      TextPrint(task,task->win_width/2-11,task->win_height/2-MOPT_COUNT/2+i*2,TEXT_ATTR>>8,menuopts[i]);
    }
    TextChar(task,FALSE,task->win_width/2-13,task->win_height/2-MOPT_COUNT/2+selopt*2,'>'+(BLACK<<4+WHITE)<<8);
  }
}

Bool PlayLoop()
{
  Fs->draw_it=&PlayDrawIt;
  PlayInit;
  Bool running = TRUE;
  Bool continue = TRUE;
  I64 key=0, sc=0, msg_code;
  try {
    while (running) {      
      if (msg_code=GetMsg(&key,&sc,1<<MSG_KEY_DOWN | 1<<MSG_KEY_UP)) 
      {
        if (msg_code==MSG_KEY_DOWN) 
        {
	  switch (key)
	  {
	    case ('8'):
	      MovePos(&player->pos.x,&player->pos.y, &player->pos.wx, &player->pos.wy, 0, -1, MAP_WIDTH, MAP_HEIGHT, WLD_WIDTH, WLD_HEIGHT);
	      break;          
	    case ('9'):
	      MovePos(&player->pos.x,&player->pos.y, &player->pos.wx, &player->pos.wy, 1, -1, MAP_WIDTH, MAP_HEIGHT, WLD_WIDTH, WLD_HEIGHT);
              break;
            case ('6'):
	      MovePos(&player->pos.x,&player->pos.y, &player->pos.wx, &player->pos.wy, 1, 0, MAP_WIDTH, MAP_HEIGHT, WLD_WIDTH, WLD_HEIGHT);
              break;
	    case ('3'):
	      MovePos(&player->pos.x,&player->pos.y, &player->pos.wx, &player->pos.wy, 1, 1, MAP_WIDTH, MAP_HEIGHT, WLD_WIDTH, WLD_HEIGHT);
              break;
	    case ('2'):
	      MovePos(&player->pos.x,&player->pos.y, &player->pos.wx, &player->pos.wy, 0, 1, MAP_WIDTH, MAP_HEIGHT, WLD_WIDTH, WLD_HEIGHT);
	      break;          
	    case ('1'):
	      MovePos(&player->pos.x,&player->pos.y, &player->pos.wx, &player->pos.wy, -1, 1, MAP_WIDTH, MAP_HEIGHT, WLD_WIDTH, WLD_HEIGHT);
              break;
	    case ('4'):
	      MovePos(&player->pos.x,&player->pos.y, &player->pos.wx, &player->pos.wy, -1, 0, MAP_WIDTH, MAP_HEIGHT, WLD_WIDTH, WLD_HEIGHT);
	      break;          
	    case ('7'):
	      MovePos(&player->pos.x,&player->pos.y, &player->pos.wx, &player->pos.wy, -1, -1, MAP_WIDTH, MAP_HEIGHT, WLD_WIDTH, WLD_HEIGHT);
              break;
	    case ('~'):
              PlayInit;
              break;
	    case (CH_ESC):
	      running = ShowMenu;
	      break;
            case (CH_SHIFT_ESC):
              running = FALSE;
	      break;
	  }
	}
      }
    }
  } catch
    PutExcept;
  return continue;
}
