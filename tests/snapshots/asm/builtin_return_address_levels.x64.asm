
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
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rax         # <addr>
               	movq	%rax, (%rdx)
               	movslq	-0x8(%rbp), %rax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	leaq	<rip>, %rsi
               	movq	(%rsi), %rsi
               	cmpq	%rsi, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	<rip>, %rsi
               	movq	(%rsi), %rcx
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rdi
               	cmpq	%rdi, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rcx
               	leaq	<rip>, %r8
               	movq	(%r8), %r8
               	cmpq	%r8, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movq	(%rax), %rcx
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	leaq	<rip>, %r8
               	movq	(%r8), %r8
               	cmpq	%rcx, %rax
               	setb	%r9b
               	movzbq	%r9b, %r9
               	xorl	%eax, %eax
               	testq	%r9, %r9
               	je	<addr>
               	jmp	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movq	(%rsi), %rcx
               	leaq	<rip>, %rsi
               	movq	(%rsi), %rsi
               	leaq	<rip>, %r8
               	movq	(%r8), %r8
               	cmpq	%rcx, %rsi
               	jae	<addr>
               	jmp	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	movq	(%rdi), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	movq	(%rdx), %rdx
               	cmpq	%rax, %rcx
               	setb	%sil
               	movzbq	%sil, %rsi
               	xorl	%ecx, %ecx
               	testq	%rsi, %rsi
               	je	<addr>
               	jmp	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rdi
               	cmpq	%rdi, %rsi
               	movq	$0x1, -0x8(%rbp)
               	je	<addr>
               	movq	(%rdx), %rdx
               	leaq	<rip>, %rsi
               	movq	(%rsi), %rsi
               	cmpq	%rsi, %rdx
               	sete	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, -0x8(%rbp)
               	movq	-0x8(%rbp), %rdx
               	movq	%rdx, -0x8(%rbp)
               	testq	%rdx, %rdx
               	jne	<addr>
               	movq	(%rax), %rax
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rdx
               	cmpq	%rdx, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x8(%rbp)
               	cmpq	$0x0, -0x8(%rbp)
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	movq	%rcx, %rax
               	leave
               	retq
               	cmpq	%r8, %rcx
               	setbe	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	jmp	<addr>
               	cmpq	%r8, %rcx
               	setbe	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	jmp	<addr>
               	cmpq	%rdx, %rax
               	setbe	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rcx, %rax
               	jmp	<addr>
