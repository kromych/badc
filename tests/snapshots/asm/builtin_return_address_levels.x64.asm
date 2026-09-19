
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
               	subq	$0x18, %rsp
               	pushq	%rbx
               	leaq	<rip>, %rbx
               	leaq	<rip>, %rax         # <addr>
               	movq	%rax, (%rbx)
               	callq	<addr>
               	movl	%eax, -0x8(%rbp)
               	leaq	<rip>, %rcx
               	movl	%eax, (%rcx)
               	leaq	<rip>, %rax
               	leaq	<rip>, %rcx         # <addr>
               	movq	%rcx, (%rax)
               	movslq	-0x8(%rbp), %rax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rdx
               	cmpq	%rcx, %rax
               	setb	%sil
               	movzbq	%sil, %rsi
               	xorl	%eax, %eax
               	testq	%rsi, %rsi
               	je	<addr>
               	jmp	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rdx
               	leaq	<rip>, %rsi
               	movq	(%rsi), %rsi
               	cmpq	%rcx, %rdx
               	jae	<addr>
               	jmp	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	movq	(%rbx), %rdx
               	leaq	<rip>, %rsi
               	movq	(%rsi), %rsi
               	cmpq	%rcx, %rdx
               	jae	<addr>
               	jmp	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rdx
               	cmpq	%rdx, %rcx
               	movq	$0x1, -0x8(%rbp)
               	je	<addr>
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rdx
               	cmpq	%rdx, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rcx, -0x8(%rbp)
               	movq	-0x8(%rbp), %rcx
               	movq	%rcx, -0x8(%rbp)
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rdx
               	cmpq	%rdx, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rcx, -0x8(%rbp)
               	cmpq	$0x0, -0x8(%rbp)
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	leave
               	retq
               	popq	%rbx
               	leave
               	retq
               	cmpq	%rdx, %rcx
               	setbe	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	jmp	<addr>
               	cmpq	%rsi, %rcx
               	setbe	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	jmp	<addr>
               	cmpq	%rsi, %rcx
               	setbe	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
