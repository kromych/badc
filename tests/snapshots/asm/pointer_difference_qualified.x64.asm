
pointer_difference_qualified.x64:	file format elf64-x86-64

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

<pc_relative>:
               	movq	(%rsi), %rcx
               	movq	%rdi, %rax
               	subq	%rcx, %rax
               	movq	%rax, %rcx
               	sarq	$0x3f, %rcx
               	shrq	$0x3e, %rcx
               	addq	%rcx, %rax
               	sarq	$0x2, %rax
               	decq	%rax
               	retq

<unqualified_left>:
               	movq	%rdi, %rax
               	subq	%rsi, %rax
               	movq	%rax, %rcx
               	sarq	$0x3f, %rcx
               	shrq	$0x3e, %rcx
               	addq	%rcx, %rax
               	sarq	$0x2, %rax
               	retq

<volatile_right>:
               	movq	%rdi, %rax
               	subq	%rsi, %rax
               	retq

<wide_elements>:
               	movq	%rdi, %rax
               	subq	%rsi, %rax
               	movq	%rax, %rcx
               	sarq	$0x3f, %rcx
               	shrq	$0x3d, %rcx
               	addq	%rcx, %rax
               	sarq	$0x3, %rax
               	retq

<back>:
               	movq	%rsi, %rcx
               	shlq	$0x2, %rcx
               	movq	%rdi, %rax
               	subq	%rcx, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	leaq	-0x48(%rbp), %rax
               	leaq	0x18(%rax), %rcx
               	subq	%rax, %rcx
               	movq	%rcx, %rdx
               	sarq	$0x3f, %rdx
               	shrq	$0x3e, %rdx
               	addq	%rdx, %rcx
               	sarq	$0x2, %rcx
               	decq	%rcx
               	leaq	-0x5(%rcx), %rdx
               	leaq	0xc(%rax), %rcx
               	subq	%rax, %rcx
               	movq	%rcx, %rsi
               	sarq	$0x3f, %rsi
               	shrq	$0x3e, %rsi
               	addq	%rsi, %rcx
               	sarq	$0x2, %rcx
               	subq	$0x3, %rcx
               	addq	%rcx, %rdx
               	leaq	-0x8(%rbp), %rcx
               	leaq	0x5(%rcx), %rsi
               	subq	%rcx, %rsi
               	leaq	-0x5(%rsi), %rcx
               	leaq	(%rdx,%rcx), %rsi
               	leaq	-0x28(%rbp), %rcx
               	leaq	0x10(%rcx), %rdx
               	subq	%rcx, %rdx
               	movq	%rdx, %rcx
               	sarq	$0x3f, %rcx
               	shrq	$0x3d, %rcx
               	addq	%rdx, %rcx
               	sarq	$0x3, %rcx
               	subq	$0x2, %rcx
               	addq	%rsi, %rcx
               	leaq	0x10(%rax), %rdx
               	subq	$0x10, %rdx
               	cmpq	%rax, %rdx
               	setne	%al
               	movzbq	%al, %rax
               	addq	%rcx, %rax
               	leave
               	retq
