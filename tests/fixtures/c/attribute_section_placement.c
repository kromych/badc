/* `__attribute__((section("name")))` on functions and objects. The
   relocatable object places the bytes in the named sections; the
   linker folds them back by their flags, so the program behaves
   identically. Same-section calls stay direct; the cross-section call
   from main resolves through a relocation. */
__attribute__((section(".init.text"))) static int boot_step(int x) { return x + 3; }
__attribute__((section(".init.text"))) int boot(void) { return boot_step(4); }

int cfg __attribute__((section(".cfg.data"))) = 35;
int cfg_zero __attribute__((section(".cfg.data")));
static int tbl[2] __attribute__((section(".cfg.data"), used)) = {1, 2};

int main(void) {
    if (cfg_zero != 0) {
        return 1;
    }
    return boot() + cfg - 42;
}
