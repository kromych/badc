
overaligned_vla_int128.x64:	file format elf64-x86-64

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

<fixed_beside_vla>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movl	$0x3, %esi
               	movl	$0xc, %eax
               	movq	%rax, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %rcx
               	subq	%r11, %rcx
               	shrq	$0xc, %r11
               	testq	%r11, %r11
               	je	<addr>
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r11
               	jne	<addr>
               	movq	%rcx, %rsp
               	movq	%rsi, -0x20(%rbp)
               	movq	-0x20(%rbp), %rax
               	leaq	-0x30(%rbp), %rdx
               	movq	%rax, (%rdx)
               	sarq	$0x3f, %rax
               	movq	%rax, 0x8(%rdx)
               	leaq	-0x50(%rbp), %rax
               	pushq	%rcx
               	movq	(%rdx), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rdx), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
               	movq	%rax, %rdx
               	movq	%rax, %rdx
               	andq	$0xf, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	leaq	<rip>, %rdx
               	movslq	(%rdx), %rdi
               	orq	$0x1, %rdi
               	movl	%edi, (%rdx)
               	movl	%esi, (%rcx)
               	movl	$0x6, %edx
               	movl	%edx, 0x8(%rcx)
               	movq	(%rax), %rsi
               	movq	0x8(%rax), %rdi
               	movslq	(%rcx), %r8
               	movslq	%edx, %rcx
               	addq	%r8, %rcx
               	movslq	%ecx, %rcx
               	movq	%rcx, %rdx
               	sarq	$0x3f, %rdx
               	addq	%rsi, %rcx
               	cmpq	%rsi, %rcx
               	setb	%sil
               	movzbq	%sil, %rsi
               	addq	%rdi, %rdx
               	addq	%rsi, %rdx
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	leaq	-0x50(%rbp), %rsp
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq

<int128_vla>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movl	$0x2, %esi
               	movl	$0x20, %eax
               	movq	%rax, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %rcx
               	subq	%r11, %rcx
               	shrq	$0xc, %r11
               	testq	%r11, %r11
               	je	<addr>
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r11
               	jne	<addr>
               	movq	%rcx, %rsp
               	movq	%rcx, %rax
               	andq	$0xf, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rdx
               	orq	$0x2, %rdx
               	movl	%edx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	movq	%rsi, (%rax)
               	xorq	%rsi, %rsi
               	movq	%rsi, 0x8(%rax)
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rdx
               	leaq	0x10(%rcx), %rdx
               	movl	$0x6, %edi
               	movq	%rdi, (%rax)
               	movq	%rsi, 0x8(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	movq	(%rcx), %rax
               	movq	(%rdx), %rcx
               	addq	%rax, %rcx
               	leaq	-0x20(%rbp), %rsp
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x3, %edi
               	callq	<addr>
               	cmpq	$0xc, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	popq	%rbp
               	retq
               	movl	$0x2, %edi
               	callq	<addr>
               	cmpq	$0x8, %rax
               	je	<addr>
               	movl	$0x20, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbp
               	retq
