
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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	leaq	<rip>, %rdx
               	leaq	(%rdx), %rax
               	movl	$0x2000, %ecx           # imm = 0x2000
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movl	$0x2001, %ecx           # imm = 0x2001
               	movq	%rcx, 0x8(%rax)
               	leaq	<rip>, %rax
               	movl	$0x2002, %ecx           # imm = 0x2002
               	movq	%rcx, 0x10(%rax)
               	leaq	<rip>, %rax
               	movl	$0x2003, %ecx           # imm = 0x2003
               	movq	%rcx, 0x18(%rax)
               	leaq	<rip>, %rax
               	movl	$0x2004, %ecx           # imm = 0x2004
               	movq	%rcx, 0x20(%rax)
               	leaq	<rip>, %rax
               	movl	$0x2005, %ecx           # imm = 0x2005
               	movq	%rcx, 0x28(%rax)
               	leaq	<rip>, %rax
               	movl	$0x2006, %ecx           # imm = 0x2006
               	movq	%rcx, 0x30(%rax)
               	leaq	<rip>, %rax
               	movl	$0x2007, %ecx           # imm = 0x2007
               	movq	%rcx, 0x38(%rax)
               	leaq	<rip>, %rcx
               	movq	%rcx, %rax
               	andq	$0x7, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movq	%rcx, %rax
               	shrq	$0x3, %rax
               	movq	%rax, %rbx
               	movq	(,%rbx,8), %rax
               	movq	%rax, -0x10(%rbp)
               	movq	-0x10(%rbp), %rax
               	cmpq	$0x2000, %rax           # imm = 0x2000
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movq	%rcx, %rax
               	shrq	$0x3, %rax
               	movq	%rax, %rbx
               	movq	0x10(,%rbx,8), %rax
               	movq	%rax, -0x10(%rbp)
               	movq	-0x10(%rbp), %rax
               	cmpq	$0x2002, %rax           # imm = 0x2002
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movq	%rcx, %rax
               	shrq	$0x2, %rax
               	movq	%rax, %rbx
               	movq	(,%rbx,4), %rax
               	movq	%rax, -0x10(%rbp)
               	movq	-0x10(%rbp), %rax
               	cmpq	$0x2000, %rax           # imm = 0x2000
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movq	%rcx, %rax
               	shrq	$0x3, %rax
               	movl	$0xbeef, %ebx           # imm = 0xBEEF
               	movq	%rbx, 0x18(,%rax,8)
               	movq	0x18(%rdx), %rax
               	cmpq	$0xbeef, %rax           # imm = 0xBEEF
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movq	%rcx, %rax
               	shrq	$0x3, %rax
               	movq	%rax, %rbx
               	leaq	0x8(,%rbx,8), %rax
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	addq	$0x8, %rdx
               	cmpq	%rdx, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movq	%rcx, %rax
               	shrq	%rax
               	movq	%rax, %r9
               	movq	0x28(,%r9,2), %rax
               	movq	%rax, -0x10(%rbp)
               	movq	-0x10(%rbp), %rax
               	cmpq	$0x2005, %rax           # imm = 0x2005
               	je	<addr>
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0x2a, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
