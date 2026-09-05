
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
               	subq	$0x70, %rsp
               	leaq	-0x60(%rbp), %rax
               	leaq	(%rax), %rcx
               	movl	$0x1, %edx
               	movq	%rdx, (%rcx)
               	movl	$0x2, %edx
               	movq	%rdx, 0x18(%rcx)
               	movl	$0xb, %ecx
               	movq	%rcx, 0x20(%rax)
               	leaq	0x20(%rax), %rcx
               	movl	$0xc, %edx
               	movq	%rdx, 0x18(%rcx)
               	movl	$0x15, %ecx
               	movq	%rcx, 0x40(%rax)
               	addq	$0x40, %rax
               	movl	$0x16, %ecx
               	movq	%rcx, 0x18(%rax)
               	leaq	-0x60(%rbp), %rdi
               	xorq	%rax, %rax
               	movq	%rax, %rsi
               	jmp	<addr>
               	movq	%rcx, %rdx
               	shlq	$0x5, %rdx
               	addq	%rdi, %rdx
               	movq	(%rdx), %r8
               	movq	0x18(%rdx), %rdx
               	addq	%r8, %rdx
               	addq	%rdx, %rsi
               	leaq	0x1(%rcx), %rax
               	movl	%eax, %ecx
               	cmpl	$0x3, %ecx
               	jb	<addr>
               	cmpq	$0x45, %rsi
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	-0x60(%rbp), %rdi
               	leaq	0x20(%rdi), %rcx
               	movq	%rcx, %rax
               	subq	%rdi, %rax
               	cmpq	$0x20, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	xorq	%rax, %rax
               	movq	%rax, (%rcx)
               	movq	%rax, 0x18(%rcx)
               	movq	%rax, %rcx
               	movq	(%rdi), %rcx
               	cmpq	$0x1, %rcx
               	jne	<addr>
               	movq	0x58(%rdi), %rcx
               	cmpq	$0x16, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movq	%rax, %rsi
               	jmp	<addr>
               	movq	%rcx, %rdx
               	shlq	$0x5, %rdx
               	addq	%rdi, %rdx
               	movq	(%rdx), %r8
               	movq	0x18(%rdx), %rdx
               	addq	%r8, %rdx
               	addq	%rdx, %rsi
               	leaq	0x1(%rcx), %rax
               	movl	%eax, %ecx
               	cmpl	$0x3, %ecx
               	jb	<addr>
               	cmpq	$0x2e, %rsi
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	xorq	%rax, %rax
               	leave
               	retq
