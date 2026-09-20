
builtin_frame_address_levels.x64:	file format elf64-x86-64

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
               	movq	%rbp, %rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movq	%rbp, %rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movq	%rbp, %rcx
               	movq	(%rcx), %rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movq	%rbp, %rcx
               	movq	(%rcx), %rcx
               	movq	(%rcx), %rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movq	%rbp, %rcx
               	movq	(%rcx), %rcx
               	movq	(%rcx), %rcx
               	movq	(%rcx), %rcx
               	movq	%rcx, (%rax)
               	movl	$0x1, %eax
               	popq	%rbp
               	retq

<f2>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	<rip>, %rax
               	movq	%rbp, %rcx
               	movq	%rcx, (%rax)
               	callq	<addr>
               	leaq	<rip>, %rcx
               	movl	%eax, (%rcx)
               	incq	%rax
               	popq	%rbp
               	retq

<f1>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	<rip>, %rax
               	movq	%rbp, %rcx
               	movq	%rcx, (%rax)
               	callq	<addr>
               	leaq	<rip>, %rcx
               	movl	%eax, (%rcx)
               	incq	%rax
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	<rip>, %rax
               	movq	%rbp, %rcx
               	movq	%rcx, (%rax)
               	callq	<addr>
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	leaq	<rip>, %rsi
               	movq	(%rsi), %rsi
               	cmpq	%rsi, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rsi
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rdi
               	cmpq	%rdi, %rsi
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rsi
               	movq	(%rsi), %rdi
               	leaq	<rip>, %r8
               	movq	(%r8), %r8
               	cmpq	%r8, %rdi
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
               	movq	(%rdx), %rdx
               	movq	(%rax), %rdi
               	cmpq	%rdi, %rdx
               	je	<addr>
               	movq	(%rax), %rax
               	movq	(%rcx), %rdx
               	cmpq	%rdx, %rax
               	je	<addr>
               	movq	(%rcx), %rax
               	movq	(%rsi), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movl	$0x6, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
