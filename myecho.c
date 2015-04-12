#include <stdio.h>

int main(int argc, char* argv[], char* envp[])
{
  printf("Die Anzahl der Argumente sind:\t%d\n",argc);
  int k;
  for (k = 0; k<argc; k++)
  {
    printf("Das %d -te Argument ist :\t%s\n",k,argv[k]);
  }

  return 0;
}
