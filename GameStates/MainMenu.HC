#define MENU_HEIGHT(3)
#define TEXT_ATTR (WHITE<<12+BLACK<<8)

U8* opts[MENU_HEIGHT];

U8 sel_opt=0;

U0 MainMenuInit()
{
  opts[0]="new game";
  opts[1]="continue";
  opts[2]="quit";
}

U0 MainMenuDrawIt(CTask *task, CDC *)
{
  DocClear;
  TextChar(task,FALSE,task->win_width/2-6,task->win_height/2-2+sel_opt*2,'>'+(WHITE<<4+BLACK)<<8);
  TextPrint(task,task->win_width/2-4,task->win_height/2-2,TEXT_ATTR>>8,opts[0]);
  TextPrint(task,task->win_width/2-4,task->win_height/2,TEXT_ATTR>>8,opts[1]);
  TextPrint(task,task->win_width/2-4,task->win_height/2+2,TEXT_ATTR>>8,opts[2]);
}

Bool MainMenuLoop()
{
  Fs->draw_it=&MainMenuDrawIt;
  MainMenuInit;
  Bool running = TRUE;
  Bool endprog = FALSE;
  I64 key=0, sc=0, msg_code;
  try {
    while (running) {      
      if (msg_code=GetMsg(&key,&sc,1<<MSG_KEY_DOWN | 1<<MSG_KEY_UP)) 
      {
	if (msg_code==MSG_KEY_DOWN) 
	{
	  if (key == '8' || sc.u8[0] == SC_CURSOR_UP)
	    sel_opt=Clamp(sel_opt-1,0,2);
	  else if (key == '2' || sc.u8[0] == SC_CURSOR_DOWN)
	    sel_opt=Clamp(sel_opt+1,0,2);
          else if (key == CH_SPACE || sc.u8[0] == SC_ENTER)
	  {
	    if (sel_opt==0){
	      world.seed = 20;
	      GenMap;
	      running = PlayLoop;
	      Fs->draw_it=&MainMenuDrawIt;
	    }
	    else if (sel_opt==1)
	    {
	      if (FileFind(DB_FILENAME))
	      {
		InitWorld(&world);
		MapFIOInit;
		ReadMap;
		EntityFIOInit;
		ReadEntities;
		running = PlayLoop;
		Fs->draw_it=&MainMenuDrawIt;
	      }
	    }
	    else if (sel_opt==2)
	      running = FALSE;
	  }
	  else if (key == CH_ESC || key == CH_SHIFT_ESC)
	    running = FALSE;
	}
      }
    }
  } catch
    PutExcept;
  return endprog;

}