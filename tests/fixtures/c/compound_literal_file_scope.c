// File-scope compound literals (C99 6.5.2.5) for the
// `&(T){...}` pointer-init idiom chibicc's type.c and
// parse.c rely on. Each one synthesizes an anonymous
// internal-linkage symbol whose initialiser bytes are
// written through the struct-initializer collector; the
// surrounding `&` reloc resolves to the new symbol's slot.
#include <stdio.h>

struct Type {
  int kind;
  int size;
  int align;
};

struct Scope {
  int id;
  char *name;
  struct Scope *parent;
};

struct Type *ty_int = &(struct Type){1, 4, 4};
struct Type *ty_long = &(struct Type){2, 8, 8};

struct Scope *root_scope = &(struct Scope){0, "root", 0};

// Empty initializer -- every field zero-filled.
struct Type *ty_zero = &(struct Type){};

int main() {
  if (ty_int->kind != 1 || ty_int->size != 4 || ty_int->align != 4) return 1;
  if (ty_long->kind != 2 || ty_long->size != 8 || ty_long->align != 8) return 2;
  if (root_scope->id != 0) return 3;
  if (root_scope->name[0] != 'r' || root_scope->name[1] != 'o') return 4;
  if (root_scope->parent != 0) return 5;
  if (ty_zero->kind != 0 || ty_zero->size != 0 || ty_zero->align != 0) return 6;
  return 0;
}
