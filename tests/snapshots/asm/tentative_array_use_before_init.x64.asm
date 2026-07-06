
tentative_array_use_before_init.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<count_named>:
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	jmp	<addr>
               	movslq	%eax, %rax
               	incq	%rax
               	movslq	%ecx, %rcx
               	incq	%rcx
               	leaq	<rip>, %rdx
               	movslq	%ecx, %rsi
               	shlq	$0x4, %rsi
               	addq	%rsi, %rdx
               	movq	(%rdx), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movslq	%eax, %rax
               	retq

<sum_first_four>:
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	movslq	%ecx, %rsi
               	movslq	(%rdx,%rsi,4), %rdx
               	addq	%rdx, %rax
               	movslq	%ecx, %rcx
               	incq	%rcx
               	movslq	%ecx, %rdx
               	cmpq	$0x4, %rdx
               	jl	<addr>
               	movslq	%eax, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	callq	<addr>
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	0x8(%rax), %rax
               	cmpq	$0xa, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x28(%rax), %rax
               	cmpq	$0x1e, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	callq	<addr>
               	cmpq	$0xa, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
               	jmp	<addr>
               	addb	%al, (%rax)
