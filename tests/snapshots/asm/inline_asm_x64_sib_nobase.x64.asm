
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
               	leaq	<rip>, %rax # <addr>
               	movq	$0x2000, (%rax)         # imm = 0x2000
               	movq	$0x2001, 0x8(%rax)      # imm = 0x2001
               	movq	$0x2002, 0x10(%rax)     # imm = 0x2002
               	movq	$0x2003, 0x18(%rax)     # imm = 0x2003
               	movq	$0x2004, 0x20(%rax)     # imm = 0x2004
               	movq	$0x2005, 0x28(%rax)     # imm = 0x2005
               	movq	$0x2006, 0x30(%rax)     # imm = 0x2006
               	leaq	<rip>, %r9 # <addr>
               	movq	$0x2007, 0x38(%r9)      # imm = 0x2007
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
               	leaq	<rip>, %rax # <addr>
               	movq	0x18(%rax), %rax
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
