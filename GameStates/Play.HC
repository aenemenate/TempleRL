

U0 PlayInit()
{
  SetEntity(&player, '@', YELLOW, BLACK, MAP_WIDTH/2, MAP_HEIGHT/2, 0, 0);
  GenMap;
}


U0 PlayDrawIt(CTask *task, CDC *)
{
  I64 i,j,startx,starty;
  startx = player.xpos - task->win_width/2;
  starty = player.ypos - task->win_height/2;
  if (startx < 0) startx = 0;
  if (starty < 0) starty = 0;
  if (startx > MAP_WIDTH - task->win_width)
    startx = MAP_WIDTH - task->win_width;
  if (starty > MAP_HEIGHT - task->win_height)
    starty = MAP_HEIGHT - task->win_height;
  for (i=0;i<task->win_height;i++)
  {
    for (j=0; j<task->win_width;j++)
    {  
      Tile *tile = &(wmap[player.wxpos][player.wypos].map[startx+j][starty+i]);
      TextChar(task,FALSE,j,i,tile->char+(tile->bgcolor<<4+tile->fgcolor)<<8);
    }
  }
  TextChar(task,FALSE,player.xpos-startx,player.ypos-starty,player.char+(BLACK<<4+player.fgcolor)<<8);
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
          if      (key == '8')
	    MovePos(&player.xpos,&player.ypos, &player.wxpos, &player.wypos, 0, -1, MAP_WIDTH, MAP_HEIGHT, WLD_WIDTH, WLD_HEIGHT);
          else if (key == '9')
	    MovePos(&player.xpos,&player.ypos, &player.wxpos, &player.wypos, 1, -1, MAP_WIDTH, MAP_HEIGHT, WLD_WIDTH, WLD_HEIGHT);
          else if (key == '6')
	    MovePos(&player.xpos,&player.ypos, &player.wxpos, &player.wypos, 1, 0, MAP_WIDTH, MAP_HEIGHT, WLD_WIDTH, WLD_HEIGHT);
          else if (key == '3')
	    MovePos(&player.xpos,&player.ypos, &player.wxpos, &player.wypos, 1, 1, MAP_WIDTH, MAP_HEIGHT, WLD_WIDTH, WLD_HEIGHT);
          else if (key == '2')
	    MovePos(&player.xpos,&player.ypos, &player.wxpos, &player.wypos, 0, 1, MAP_WIDTH, MAP_HEIGHT, WLD_WIDTH, WLD_HEIGHT);
          else if (key == '1')
	    MovePos(&player.xpos,&player.ypos, &player.wxpos, &player.wypos, -1, 1, MAP_WIDTH, MAP_HEIGHT, WLD_WIDTH, WLD_HEIGHT);
          else if (key == '4')
	    MovePos(&player.xpos,&player.ypos, &player.wxpos, &player.wypos, -1, 0, MAP_WIDTH, MAP_HEIGHT, WLD_WIDTH, WLD_HEIGHT);
          else if (key == '7')
	    MovePos(&player.xpos,&player.ypos, &player.wxpos, &player.wypos, -1, -1, MAP_WIDTH, MAP_HEIGHT, WLD_WIDTH, WLD_HEIGHT);
          else if (key == '~')
            PlayInit;
          else if (key == CH_ESC || key == CH_SHIFT_ESC)
            running = FALSE;
	}
      }
    }
  } catch
    PutExcept;
  return continue;
}
