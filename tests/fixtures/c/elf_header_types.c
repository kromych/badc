/* <elf.h> carries the specification-fixed ELF type and struct layouts
 * that system headers layered over it (gelf.h, libelf.h) reference. */
#include <elf.h>

int main(void) {
    if (sizeof(Elf64_Half) != 2 || sizeof(Elf64_Word) != 4)
        return 1;
    if (sizeof(Elf64_Section) != 2 || sizeof(Elf64_Versym) != 2)
        return 2;
    if (sizeof(Elf32_Ehdr) != 52 || sizeof(Elf64_Ehdr) != 64)
        return 3;
    if (sizeof(Elf32_Shdr) != 40 || sizeof(Elf64_Shdr) != 64)
        return 4;
    if (sizeof(Elf32_Sym) != 16 || sizeof(Elf64_Sym) != 24)
        return 5;
    if (sizeof(Elf32_Phdr) != 32 || sizeof(Elf64_Phdr) != 56)
        return 6;
    if (sizeof(Elf32_Rela) != 12 || sizeof(Elf64_Rela) != 24)
        return 7;
    if (sizeof(Elf64_Dyn) != 16 || sizeof(Elf64_Nhdr) != 12)
        return 8;
    if (sizeof(Elf64_Chdr) != 24 || sizeof(Elf32_Chdr) != 12)
        return 9;

    Elf64_Sym sym = {0};
    sym.st_shndx = SHN_ABS;
    sym.st_info = (unsigned char)ELF64_ST_INFO(STB_GLOBAL, STT_FUNC);
    if (ELF64_ST_BIND(sym.st_info) != STB_GLOBAL)
        return 10;
    if (ELF64_ST_TYPE(sym.st_info) != STT_FUNC)
        return 11;
    return 0;
}
