
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
               	subq	$0x30, %rsp
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
               	movq	$0x3, -0x20(%rbp)
               	movq	-0x20(%rbp), %rsi
               	movq	%rsi, %rdi
               	sarq	$0x3f, %rdi
               	leaq	-0x30(%rbp), %rax
               	movq	%rsi, (%rax)
               	movq	%rdi, 0x8(%rax)
               	movq	%rax, %rsi
               	andq	$0xf, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	leaq	<rip>, %rsi
               	movslq	(%rsi), %rdi
               	orq	$0x1, %rdi
               	movl	%edi, (%rsi)
               	movl	$0x3, (%rcx)
               	movl	$0x6, 0x8(%rcx)
               	movq	(%rax), %rdx
               	movq	0x8(%rax), %rsi
               	leaq	0x9(%rdx), %rcx
               	cmpq	%rdx, %rcx
               	setb	%dl
               	movzbq	%dl, %rdx
               	addq	$0x0, %rsi
               	addq	%rsi, %rdx
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movq	%rcx, %rax
               	leaq	-0x30(%rbp), %rsp
               	leave
               	retq

<int128_vla>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	$0x20, %eax
               	movq	%rax, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %rax
               	subq	%r11, %rax
               	shrq	$0xc, %r11
               	testq	%r11, %r11
               	je	<addr>
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r11
               	jne	<addr>
               	movq	%rax, %rsp
               	movq	%rax, %rcx
               	andq	$0xf, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rdx
               	orq	$0x2, %rdx
               	movl	%edx, (%rcx)
               	movq	$0x2, (%rax)
               	movq	$0x0, 0x8(%rax)
               	leaq	0x10(%rax), %rdx
               	movq	$0x6, (%rdx)
               	movq	$0x0, 0x8(%rdx)
               	movl	$0x8, %eax
               	leaq	-0x10(%rbp), %rsp
               	leave
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
