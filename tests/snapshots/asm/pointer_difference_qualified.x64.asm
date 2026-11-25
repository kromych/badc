
pointer_difference_qualified.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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

<pc_relative>:
               	movq	(%rsi), %rax
               	subq	%rax, %rdi
               	movq	%rdi, %rax
               	sarq	$0x3f, %rax
               	shrq	$0x3e, %rax
               	addq	%rdi, %rax
               	sarq	$0x2, %rax
               	decq	%rax
               	retq

<unqualified_left>:
               	subq	%rsi, %rdi
               	movq	%rdi, %rax
               	sarq	$0x3f, %rax
               	shrq	$0x3e, %rax
               	addq	%rdi, %rax
               	sarq	$0x2, %rax
               	retq

<volatile_right>:
               	subq	%rsi, %rdi
               	movq	%rdi, %rax
               	retq

<wide_elements>:
               	subq	%rsi, %rdi
               	movq	%rdi, %rax
               	sarq	$0x3f, %rax
               	shrq	$0x3d, %rax
               	addq	%rdi, %rax
               	sarq	$0x3, %rax
               	retq

<back>:
               	shlq	$0x2, %rsi
               	subq	%rsi, %rdi
               	movq	%rdi, %rax
               	retq

<main>:
               	subq	$0x28, %rsp
               	leaq	(%rsp), %rax
               	leaq	0x18(%rax), %rcx
               	subq	%rax, %rcx
               	movq	%rcx, %rdx
               	sarq	$0x3f, %rdx
               	shrq	$0x3e, %rdx
               	addq	%rdx, %rcx
               	sarq	$0x2, %rcx
               	decq	%rcx
               	leaq	-0x5(%rcx), %rsi
               	leaq	0xc(%rax), %rcx
               	subq	%rax, %rcx
               	movq	%rcx, %rdx
               	sarq	$0x3f, %rdx
               	shrq	$0x3e, %rdx
               	addq	%rdx, %rcx
               	sarq	$0x2, %rcx
               	subq	$0x3, %rcx
               	addq	%rcx, %rsi
               	leaq	0x18(%rsp), %rcx
               	leaq	0x5(%rcx), %rdx
               	subq	%rcx, %rdx
               	leaq	-0x5(%rdx), %rcx
               	leaq	(%rsi,%rcx), %rdi
               	leaq	0x10(%rax), %rcx
               	movq	%rcx, %rdx
               	subq	%rax, %rdx
               	movq	%rdx, %rsi
               	sarq	$0x3f, %rsi
               	shrq	$0x3d, %rsi
               	addq	%rsi, %rdx
               	sarq	$0x3, %rdx
               	subq	$0x2, %rdx
               	addq	%rdi, %rdx
               	subq	$0x10, %rcx
               	cmpq	%rax, %rcx
               	setne	%al
               	movzbq	%al, %rax
               	addq	%rdx, %rax
               	addq	$0x28, %rsp
               	retq
