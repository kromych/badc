
array_alias_param_outer_bracket.x64:	file format elf64-x86-64

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
               	subq	$0x60, %rsp
               	leaq	-0x60(%rbp), %rsi
               	movq	$0x1, (%rsi)
               	movq	$0x2, 0x18(%rsi)
               	movq	$0xb, 0x20(%rsi)
               	leaq	0x20(%rsi), %rax
               	movq	$0xc, 0x18(%rax)
               	movq	$0x15, 0x40(%rsi)
               	leaq	0x40(%rsi), %rax
               	movq	$0x16, 0x18(%rax)
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
               	leaq	-0x60(%rbp), %rsi
               	leaq	0x20(%rsi), %rcx
               	movq	%rcx, %rax
               	subq	%rsi, %rax
               	cmpq	$0x20, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	movq	%rax, (%rcx)
               	movq	%rax, 0x18(%rcx)
               	movq	(%rsi), %rcx
               	cmpq	$0x1, %rcx
               	jne	<addr>
               	movq	0x58(%rsi), %rcx
               	cmpq	$0x16, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
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
               	cmpq	$0x2e, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
