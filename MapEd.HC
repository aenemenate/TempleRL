
#include "Libs/PerlinNoise"

U0 GenTerrain()
{
  U64 wi, wj, i, j;
  for (wi=0; wi<WLD_WIDTH; wi++)
    for (wj=0; wj<WLD_HEIGHT; wj++)
      for (i=0; i<MAP_WIDTH; i++)
        for (j=0; j<MAP_HEIGHT; j++)
        {
          F64 height = perlin2d(wi*MAP_WIDTH+i, wj*MAP_HEIGHT+j, 0.08, 4);
          if (height <= .3)
            SetTile(&(wmap[wi][wj].map[i][j]), '~', BLUE, BLACK, FALSE, FALSE);
          else if (height <= .7)
            SetTile(&(wmap[wi][wj].map[i][j]), '.', BROWN, BLACK, TRUE, FALSE);
          else if (height <= 1)
            SetTile(&(wmap[wi][wj].map[i][j]), '#', DKGRAY, BLACK, FALSE, TRUE);
        }
}

U0 GenTrees()
{
  
}

U0 GenRivers()
{

}

U0 GenMap()
{
  GenTerrain;
  GenRivers;
  GenTrees;
}