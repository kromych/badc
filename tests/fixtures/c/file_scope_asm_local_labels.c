/* File-scope asm pasting several fragments into one statement, each
 * defining the same GNU as numeric labels (`10:`, `11:`). The labels are
 * redefinable: every definition is a new instance and a `10b` reference
 * binds to the nearest one backward, including from a nested pushed
 * section. The second fragment routes its table entry through a
 * `.macro`/`.irp`/`.ifc`/`.set`/`.if` register-classifying macro. */
long fastop_exception;

asm(".pushsection .text, \"ax\" \n\t"
    ".global em_div_ex \n\t"
    ".align 16 \n\t"
    "em_div_ex:\n\t"
    ".align 16 \n\t"
    ".type div_cl, @function \n\t"
    "div_cl:\n\t"
    "10: div %cl \n\t"
    "11: ret\n\t"
    ".size div_cl, .-div_cl \n\t"
    " .pushsection \"__ex_table\",\"a\"\n"
    " .balign 4\n"
    " .long (10b) - .\n"
    " .long (11b) - .\n"
    " .long 17\n"
    " .popsection\n"
    ".align 16 \n\t"
    ".type div_cx, @function \n\t"
    "div_cx:\n\t"
    "10: div %cx \n\t"
    "11: ret\n\t"
    ".size div_cx, .-div_cx \n\t"
    " .pushsection \"__ex_table\",\"a\"\n"
    " .balign 4\n"
    " .long (10b) - .\n"
    " .long (11b) - .\n"
    ".macro extable_type_reg type:req reg:req\n"
    ".set .Lfound, 0\n"
    ".set .Lregnr, 0\n"
    ".irp rs,rax,rcx,rdx,rbx,rsp,rbp,rsi,rdi\n"
    ".ifc \\reg, %%\\rs\n"
    ".set .Lfound, .Lfound+1\n"
    ".long \\type + (.Lregnr << 8)\n"
    ".endif\n"
    ".set .Lregnr, .Lregnr+1\n"
    ".endr\n"
    ".if (.Lfound != 1)\n"
    ".error \"extable_type_reg: bad register argument\"\n"
    ".endif\n"
    ".endm\n"
    "extable_type_reg reg=%%rsi, type=(17 | ((0) << 16)) \n"
    ".purgem extable_type_reg\n"
    " .popsection\n"
    ".popsection");

int main(void) { return 0; }
