
inline_asm_x64_sib_nobase.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3

<main>:
               	movq	$0x2000, <rip> # imm = 0x2000
                                                # <addr>
               	movq	$0x2001, <rip> # imm = 0x2001
                                                # <addr>
               	movq	$0x2002, <rip> # imm = 0x2002
                                                # <addr>
               	movq	$0x2003, <rip> # imm = 0x2003
                                                # <addr>
               	movq	$0x2004, <rip> # imm = 0x2004
                                                # <addr>
               	movq	$0x2005, <rip> # imm = 0x2005
                                                # <addr>
               	movq	$0x2006, <rip> # imm = 0x2006
                                                # <addr>
               	leaq	<rip>, %r9 # <addr>
               	movq	$0x2007, <rip> # imm = 0x2007
                                                # <addr>
               	testb	$0x7, %r9b
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movq	%r9, %rax
               	shrq	$0x3, %rax
               	movq	(,%rax,8), %rax
               	cmpq	$0x2000, %rax           # imm = 0x2000
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movq	%r9, %rax
               	shrq	$0x3, %rax
               	movq	0x10(,%rax,8), %rax
               	cmpq	$0x2002, %rax           # imm = 0x2002
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movq	%r9, %rax
               	shrq	$0x2, %rax
               	movq	(,%rax,4), %rax
               	cmpq	$0x2000, %rax           # imm = 0x2000
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	movq	%r9, %rax
               	shrq	$0x3, %rax
               	movl	$0xbeef, %r10d          # imm = 0xBEEF
               	movq	%r10, 0x18(,%rax,8)
               	movq	<rip>, %rax # <addr>
               	cmpq	$0xbeef, %rax           # imm = 0xBEEF
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	movq	%r9, %rax
               	shrq	$0x3, %rax
               	leaq	0x8(,%rax,8), %rax
               	leaq	<rip>, %rcx # <addr>
               	addq	$0x8, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	shrq	%r9
               	movq	0x28(,%r9,2), %rax
               	cmpq	$0x2005, %rax           # imm = 0x2005
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	movl	$0x2a, %eax
               	retq
