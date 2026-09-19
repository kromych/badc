
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
               	leaq	-0x60(%rbp), %rax
               	leaq	(%rax), %rcx
               	movq	$0x1, (%rcx)
               	movq	$0x2, 0x18(%rcx)
               	movq	$0xb, 0x20(%rax)
               	leaq	0x20(%rax), %rcx
               	movq	$0xc, 0x18(%rcx)
               	movq	$0x15, 0x40(%rax)
               	addq	$0x40, %rax
               	movq	$0x16, 0x18(%rax)
               	leaq	-0x60(%rbp), %rsi
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	cmpl	$0x3, %eax
               	jae	<addr>
               	movq	%rax, %rcx
               	shlq	$0x5, %rcx
               	addq	%rsi, %rcx
               	movq	(%rcx), %rdi
               	movq	0x18(%rcx), %rcx
               	addq	%rdi, %rcx
               	addq	%rcx, %rdx
               	incq	%rax
               	cmpl	$0x3, %eax
               	jb	<addr>
               	cmpq	$0x45, %rdx
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
               	movq	%rax, %rdx
               	cmpl	$0x3, %eax
               	jae	<addr>
               	movq	%rax, %rcx
               	shlq	$0x5, %rcx
               	addq	%rsi, %rcx
               	movq	(%rcx), %rdi
               	movq	0x18(%rcx), %rcx
               	addq	%rdi, %rcx
               	addq	%rcx, %rdx
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
