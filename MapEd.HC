
#include "Libs/PerlinNoise"

U0 GenTerrain()
{
  SEED=world.seed;
  U64 wi, wj, i, j;
  for (wi=0; wi<WLD_WIDTH; wi++)
    for (wj=0; wj<WLD_HEIGHT; wj++)
    {
      MapTile *curmap = &(world.wmap[wi][wj]);
      for (i=0; i<MAP_WIDTH; i++)
        for (j=0; j<MAP_HEIGHT; j++)
        {
          F64 height = perlin2d(wi*MAP_WIDTH+i, wj*MAP_HEIGHT+j, 0.08, 4);
          if (height <= .3)
            SetTile(GetTileFM(curmap,i,j), '~', BLUE, BLACK, FALSE, FALSE);
          else if (height <= .7)
            SetTile(GetTileFM(curmap,i,j), '.', BROWN, BLACK, TRUE, FALSE);
          else if (height <= 1)
            SetTile(GetTileFM(curmap,i,j), '#', DKGRAY, BLACK, FALSE, TRUE);
        }
    }
}

U0 GenRivers()
{

}

U0 GenTrees()
{
  
}

U0 GenEntities()
{
  AddEntity('@', YELLOW, BLACK, MAP_WIDTH/2, MAP_HEIGHT/2+20, 0, 0, TRUE);
  AddEntity('g', GREEN, BLACK, MAP_WIDTH/2, MAP_HEIGHT/2+30, 0, 0, FALSE);
}

U0 GenMap()
{
  InitWorld(&world);
  GenTerrain;
  GenRivers;
  GenTrees;
  GenEntities;
}