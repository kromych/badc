
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
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
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
               	movq	(%rsp), %rbx
               	leave
               	retq

<f1>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
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
               	movq	(%rsp), %rbx
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	leaq	<rip>, %rbx
               	leaq	<rip>, %rax         # <addr>
               	movq	%rax, (%rbx)
               	callq	<addr>
               	movl	%eax, -0x8(%rbp)
               	leaq	<rip>, %rcx
               	movslq	%eax, %rax
               	movl	%eax, (%rcx)
               	leaq	<rip>, %rax
               	leaq	<rip>, %rcx         # <addr>
               	movq	%rcx, (%rax)
               	movslq	-0x8(%rbp), %rax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rdx
               	jmp	<addr>
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rdx
               	leaq	<rip>, %rsi
               	movq	(%rsi), %rsi
               	jmp	<addr>
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	movq	(%rbx), %rdx
               	leaq	<rip>, %rsi
               	movq	(%rsi), %rsi
               	jmp	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	cmpq	%rcx, %rax
               	movl	$0x1, %ecx
               	movq	%rcx, -0x8(%rbp)
               	je	<addr>
               	leaq	<rip>, %rax
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
               	movq	-0x8(%rbp), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	cmpq	%rcx, %rax
               	setb	%sil
               	movzbq	%sil, %rsi
               	xorq	%rax, %rax
               	testq	%rsi, %rsi
               	je	<addr>
               	cmpq	%rdx, %rcx
               	setbe	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rcx
               	jmp	<addr>
               	cmpq	%rcx, %rdx
               	jae	<addr>
               	cmpq	%rsi, %rcx
               	setbe	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rcx
               	jmp	<addr>
               	cmpq	%rcx, %rdx
               	jae	<addr>
               	cmpq	%rsi, %rcx
               	setbe	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	jmp	<addr>
