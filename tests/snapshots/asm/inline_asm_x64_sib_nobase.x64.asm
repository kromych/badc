
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
               	leaq	<rip>, %rax
               	movq	$0x2000, (%rax)         # imm = 0x2000
               	movq	$0x2001, 0x8(%rax)      # imm = 0x2001
               	movq	$0x2002, 0x10(%rax)     # imm = 0x2002
               	movq	$0x2003, 0x18(%rax)     # imm = 0x2003
               	movq	$0x2004, 0x20(%rax)     # imm = 0x2004
               	movq	$0x2005, 0x28(%rax)     # imm = 0x2005
               	movq	$0x2006, 0x30(%rax)     # imm = 0x2006
               	leaq	<rip>, %rax
               	movq	$0x2007, 0x38(%rax)     # imm = 0x2007
               	testb	$0x7, %al
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movq	%rax, %rcx
               	shrq	$0x3, %rcx
               	movq	(,%rcx,8), %rcx
               	cmpq	$0x2000, %rcx           # imm = 0x2000
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movq	%rax, %rcx
               	shrq	$0x3, %rcx
               	movq	0x10(,%rcx,8), %rcx
               	cmpq	$0x2002, %rcx           # imm = 0x2002
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movq	%rax, %rcx
               	shrq	$0x2, %rcx
               	movq	(,%rcx,4), %rcx
               	cmpq	$0x2000, %rcx           # imm = 0x2000
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	movq	%rax, %rcx
               	shrq	$0x3, %rcx
               	movl	$0xbeef, %r10d          # imm = 0xBEEF
               	movq	%r10, 0x18(,%rcx,8)
               	leaq	<rip>, %rcx
               	movq	0x18(%rcx), %rcx
               	cmpq	$0xbeef, %rcx           # imm = 0xBEEF
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	movq	%rax, %rcx
               	shrq	$0x3, %rcx
               	leaq	0x8(,%rcx,8), %rcx
               	leaq	<rip>, %rdx
               	addq	$0x8, %rdx
               	cmpq	%rdx, %rcx
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	shrq	%rax
               	movq	%rax, %r9
               	movq	0x28(,%r9,2), %rax
               	cmpq	$0x2005, %rax           # imm = 0x2005
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	movl	$0x2a, %eax
               	retq
