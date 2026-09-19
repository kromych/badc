
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
               	leaq	<rip>, %rax
               	leaq	<rip>, %rcx         # <addr>
               	movq	%rcx, (%rax)
               	callq	<addr>
               	leaq	<rip>, %rcx
               	movl	%eax, (%rcx)
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rdx         # <addr>
               	movq	%rdx, (%rcx)
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rdx
               	leaq	<rip>, %rsi
               	movq	(%rsi), %rsi
               	cmpq	%rsi, %rdx
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rsi
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rdi
               	cmpq	%rdi, %rsi
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rsi
               	movq	(%rsi), %rdi
               	leaq	<rip>, %r8
               	movq	(%r8), %r8
               	cmpq	%r8, %rdi
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	movq	(%rax), %rdi
               	leaq	<rip>, %r8
               	movq	(%r8), %r8
               	leaq	<rip>, %r9
               	movq	(%r9), %r9
               	cmpq	%rdi, %r8
               	jae	<addr>
               	cmpq	%r9, %rdi
               	jbe	<addr>
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
               	movq	(%rdx), %rdx
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rdi
               	leaq	<rip>, %r8
               	movq	(%r8), %r8
               	cmpq	%rdx, %rdi
               	jae	<addr>
               	cmpq	%r8, %rdx
               	jbe	<addr>
               	movl	$0x6, %eax
               	popq	%rbp
               	retq
               	movq	(%rsi), %rdx
               	leaq	<rip>, %rsi
               	movq	(%rsi), %rsi
               	movq	(%rcx), %rcx
               	cmpq	%rdx, %rsi
               	jae	<addr>
               	cmpq	%rcx, %rdx
               	jbe	<addr>
               	movl	$0x7, %eax
               	popq	%rbp
               	retq
               	movq	(%rax), %rcx
               	leaq	<rip>, %rax
               	movq	(%rax), %rdx
               	cmpq	%rdx, %rcx
               	je	<addr>
               	movq	(%rax), %rcx
               	leaq	<rip>, %rax
               	movq	(%rax), %rdx
               	cmpq	%rdx, %rcx
               	je	<addr>
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	movq	(%rax), %rax
               	cmpq	%rax, %rcx
               	jne	<addr>
               	movl	$0x8, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
