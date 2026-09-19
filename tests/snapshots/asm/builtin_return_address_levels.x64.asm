
builtin_return_address_levels.x64:	file format elf64-x86-64

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

<f3>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	<rip>, %rax
               	movq	0x8(%rbp), %rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movq	0x8(%rbp), %rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movq	%rbp, %rcx
               	movq	(%rcx), %rcx
               	movq	0x8(%rcx), %rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movq	%rbp, %rcx
               	movq	(%rcx), %rcx
               	movq	(%rcx), %rcx
               	movq	0x8(%rcx), %rcx
               	movq	%rcx, (%rax)
               	movl	$0x1, %eax
               	popq	%rbp
               	retq

<f2>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	leaq	<rip>, %rax
               	movq	0x8(%rbp), %rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	leaq	<rip>, %rcx         # <addr>
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rbx
               	callq	<addr>
               	movl	%eax, (%rbx)
               	leaq	<rip>, %rax
               	leaq	<rip>, %rcx         # <addr>
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	incq	%rax
               	movslq	%eax, %rax
               	popq	%rbx
               	leave
               	retq

<f1>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	leaq	<rip>, %rax
               	movq	0x8(%rbp), %rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	leaq	<rip>, %rcx         # <addr>
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rbx
               	callq	<addr>
               	movl	%eax, (%rbx)
               	leaq	<rip>, %rax
               	leaq	<rip>, %rcx         # <addr>
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	incq	%rax
               	movslq	%eax, %rax
               	popq	%rbx
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	<rip>, %rax
               	leaq	<rip>, %rcx         # <addr>
               	movq	%rcx, (%rax)
               	callq	<addr>
               	movl	%eax, -0x8(%rbp)
               	leaq	<rip>, %rcx
               	movl	%eax, (%rcx)
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rax         # <addr>
               	movq	%rax, (%rcx)
               	movslq	-0x8(%rbp), %rax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rdx
               	leaq	<rip>, %rsi
               	movq	(%rsi), %rsi
               	cmpq	%rsi, %rdx
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rsi
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rdi
               	cmpq	%rdi, %rsi
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	leaq	<rip>, %rsi
               	movq	(%rsi), %rdi
               	leaq	<rip>, %r8
               	movq	(%r8), %r8
               	cmpq	%r8, %rdi
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movq	(%rax), %rdi
               	leaq	<rip>, %r8
               	movq	(%r8), %r8
               	leaq	<rip>, %r9
               	movq	(%r9), %r9
               	cmpq	%rdi, %r8
               	jb	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movq	(%rdx), %rdx
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rdi
               	leaq	<rip>, %r8
               	movq	(%r8), %r8
               	cmpq	%rdx, %rdi
               	jb	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	movq	(%rsi), %rdx
               	leaq	<rip>, %rsi
               	movq	(%rsi), %rsi
               	movq	(%rcx), %rcx
               	cmpq	%rdx, %rsi
               	jb	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	movq	(%rax), %rcx
               	leaq	<rip>, %rax
               	movq	(%rax), %rdx
               	cmpq	%rdx, %rcx
               	movq	$0x1, -0x8(%rbp)
               	je	<addr>
               	movq	(%rax), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	cmpq	%rcx, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	movq	%rax, -0x8(%rbp)
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	cmpq	%rcx, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x8(%rbp)
               	cmpq	$0x0, -0x8(%rbp)
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
               	cmpq	%r9, %rdi
               	jbe	<addr>
               	jmp	<addr>
               	cmpq	%r8, %rdx
               	jbe	<addr>
               	jmp	<addr>
               	cmpq	%rcx, %rdx
               	jbe	<addr>
               	jmp	<addr>
