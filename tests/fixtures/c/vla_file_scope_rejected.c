/* C99 6.7.6.2p2: a variably-modified type at file scope is a
   constraint violation. */
extern int n;
int g[n];
int main(void) { return 0; }
