struct sclass {
    int minver;
    int maxver;
    long oclass;
    const void *func;
};
struct oclass {
    struct sclass base;
    const void *handle;
};
static const struct sclass uclient_sclass = {
    .minver = -1,
    .maxver = -1,
    .oclass = 0x41,
    .func = 0,
};
struct sclass mutable_src = {1, 2, 3, 0};

static int consume(const struct oclass *o)
{
    return o->base.minver >= -1 ? 1 : -100;
}

int new_client(void)
{
    struct oclass a = {.base = uclient_sclass};
    struct oclass b = {.base = mutable_src, .handle = &a};
    mutable_src.minver = 9;
    struct oclass c = {.base = mutable_src};
    return consume(&a) + consume(&b) + consume(&c) + (c.base.minver == 9 ? 0 : 100);
}

int main(void)
{
    struct oclass chk = {.base = uclient_sclass};
    if (chk.base.oclass != 0x41 || chk.base.minver != -1)
        return 1;
    if (new_client() < 0)
        return 2;
    struct oclass chk2 = {.base = mutable_src};
    if (chk2.base.minver != 9)
        return 3;
    return 0;
}
