
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
               	subq	$0x40, %rsp
               	leaq	<rip>, %rax
               	addq	$0x0, %rax
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
               	leaq	<rip>, %rax
               	movq	%rax, %rcx
               	andq	$0x7, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	-0x10(%rbp), %rcx
               	movq	%rax, %rdx
               	shrq	$0x3, %rdx
               	movq	%rax, -0x40(%rbp)
               	movq	%rbx, -0x38(%rbp)
               	movq	%rcx, -0x30(%rbp)
               	movq	%rdx, -0x28(%rbp)
               	movq	-0x28(%rbp), %rbx
               	movq	(,%rbx,8), %rax
               	movq	-0x30(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x40(%rbp), %rax
               	movq	-0x38(%rbp), %rbx
               	movq	-0x10(%rbp), %rcx
               	cmpq	$0x2000, %rcx           # imm = 0x2000
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	-0x10(%rbp), %rcx
               	movq	%rax, %rdx
               	shrq	$0x3, %rdx
               	movq	%rax, -0x40(%rbp)
               	movq	%rbx, -0x38(%rbp)
               	movq	%rcx, -0x30(%rbp)
               	movq	%rdx, -0x28(%rbp)
               	movq	-0x28(%rbp), %rbx
               	movq	0x10(,%rbx,8), %rax
               	movq	-0x30(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x40(%rbp), %rax
               	movq	-0x38(%rbp), %rbx
               	movq	-0x10(%rbp), %rcx
               	cmpq	$0x2002, %rcx           # imm = 0x2002
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	leaq	-0x10(%rbp), %rcx
               	movq	%rax, %rdx
               	shrq	$0x2, %rdx
               	movq	%rax, -0x40(%rbp)
               	movq	%rbx, -0x38(%rbp)
               	movq	%rcx, -0x30(%rbp)
               	movq	%rdx, -0x28(%rbp)
               	movq	-0x28(%rbp), %rbx
               	movq	(,%rbx,4), %rax
               	movq	-0x30(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x40(%rbp), %rax
               	movq	-0x38(%rbp), %rbx
               	movq	-0x10(%rbp), %rcx
               	cmpq	$0x2000, %rcx           # imm = 0x2000
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movq	%rax, %rcx
               	shrq	$0x3, %rcx
               	movl	$0xbeef, %edx           # imm = 0xBEEF
               	movq	%rax, -0x40(%rbp)
               	movq	%rbx, -0x38(%rbp)
               	movq	%rcx, -0x30(%rbp)
               	movq	%rdx, -0x28(%rbp)
               	movq	-0x30(%rbp), %rax
               	movq	-0x28(%rbp), %rbx
               	movq	%rbx, 0x18(,%rax,8)
               	movq	-0x40(%rbp), %rax
               	movq	-0x38(%rbp), %rbx
               	leaq	<rip>, %rcx
               	movq	0x18(%rcx), %rcx
               	cmpq	$0xbeef, %rcx           # imm = 0xBEEF
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	leaq	-0x8(%rbp), %rcx
               	movq	%rax, %rdx
               	shrq	$0x3, %rdx
               	movq	%rax, -0x40(%rbp)
               	movq	%rbx, -0x38(%rbp)
               	movq	%rcx, -0x30(%rbp)
               	movq	%rdx, -0x28(%rbp)
               	movq	-0x28(%rbp), %rbx
               	leaq	0x8(,%rbx,8), %rax
               	movq	-0x30(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x40(%rbp), %rax
               	movq	-0x38(%rbp), %rbx
               	movq	-0x8(%rbp), %rcx
               	leaq	<rip>, %rdx
               	addq	$0x8, %rdx
               	cmpq	%rdx, %rcx
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	shrq	%rax
               	leaq	-0x10(%rbp), %rcx
               	movq	%rax, -0x40(%rbp)
               	movq	%r9, -0x38(%rbp)
               	movq	%rcx, -0x30(%rbp)
               	movq	%rax, -0x28(%rbp)
               	movq	-0x28(%rbp), %r9
               	movq	0x28(,%r9,2), %rax
               	movq	-0x30(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x40(%rbp), %rax
               	movq	-0x38(%rbp), %r9
               	movq	-0x10(%rbp), %rax
               	cmpq	$0x2005, %rax           # imm = 0x2005
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	movl	$0x2a, %eax
               	leave
               	retq
