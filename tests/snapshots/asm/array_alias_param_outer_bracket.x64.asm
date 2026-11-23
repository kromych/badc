
array_alias_param_outer_bracket.x64:	file format elf64-x86-64

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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	leaq	-0x60(%rbp), %rsi
               	movq	$0x1, -0x60(%rbp)
               	movq	$0x2, -0x48(%rbp)
               	movq	$0xb, -0x40(%rbp)
               	movq	$0xc, -0x28(%rbp)
               	movq	$0x15, -0x20(%rbp)
               	movq	$0x16, -0x8(%rbp)
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	movq	%rax, %rdx
               	shlq	$0x5, %rdx
               	addq	%rsi, %rdx
               	movq	(%rdx), %rdi
               	movq	0x18(%rdx), %rdx
               	addq	%rdi, %rdx
               	addq	%rdx, %rcx
               	incq	%rax
               	cmpl	$0x3, %eax
               	jb	<addr>
               	cmpq	$0x45, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	-0x60(%rbp), %rcx
               	leaq	0x20(%rcx), %rax
               	subq	%rcx, %rax
               	cmpq	$0x20, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	movq	%rax, -0x40(%rbp)
               	movq	%rax, -0x28(%rbp)
               	movq	-0x60(%rbp), %rdx
               	cmpq	$0x1, %rdx
               	jne	<addr>
               	movq	-0x8(%rbp), %rdx
               	cmpq	$0x16, %rdx
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movq	%rax, %rdx
               	movq	%rax, %rsi
               	shlq	$0x5, %rsi
               	addq	%rcx, %rsi
               	movq	(%rsi), %rdi
               	movq	0x18(%rsi), %rsi
               	addq	%rdi, %rsi
               	addq	%rsi, %rdx
               	incq	%rax
               	cmpl	$0x3, %eax
               	jb	<addr>
               	cmpq	$0x2e, %rdx
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
