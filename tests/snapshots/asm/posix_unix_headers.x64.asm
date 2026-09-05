
posix_unix_headers.x64:	file format elf64-x86-64

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
               	subq	$0x210, %rsp            # imm = 0x210
               	leaq	-0x208(%rbp), %rdx
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	jmp	<addr>
               	movslq	%eax, %rsi
               	addq	%rdx, %rsi
               	movb	%cl, (%rsi)
               	incq	%rax
               	movslq	%eax, %rax
               	cmpl	$0x80, %eax
               	jl	<addr>
               	leaq	-0x208(%rbp), %rax
               	leaq	(%rax), %rcx
               	movzbq	(%rcx), %rdx
               	orq	$0x8, %rdx
               	movb	%dl, (%rcx)
               	movzbq	0x5(%rax), %rdx
               	orq	$0x1, %rdx
               	movb	%dl, 0x5(%rax)
               	movzbq	(%rcx), %rdx
               	movq	%rdx, %rsi
               	andq	$0x8, %rsi
               	testl	%esi, %esi
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rsi, %rsi
               	je	<addr>
               	movzbq	0x5(%rax), %rdx
               	andq	$0x1, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movzbq	(%rcx), %rax
               	andq	$0x10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	leaq	-0x208(%rbp), %rcx
               	leaq	(%rcx), %rax
               	movzbq	(%rax), %rdx
               	movq	%rdx, %rsi
               	andq	$-0x9, %rsi
               	movb	%sil, (%rax)
               	movzbq	(%rax), %rax
               	andq	$0x8, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	leave
               	retq
               	jmp	<addr>
