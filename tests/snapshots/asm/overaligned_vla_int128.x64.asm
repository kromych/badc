
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
               	subq	$0x20, %rsp
               	movl	$0xc, %ecx
               	movq	%rcx, %r11
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
               	movq	$0x3, -0x10(%rbp)
               	movq	-0x10(%rbp), %rdx
               	movq	%rdx, %rsi
               	sarq	$0x3f, %rsi
               	leaq	-0x20(%rbp), %rdi
               	movq	%rdx, -0x20(%rbp)
               	movq	%rsi, -0x18(%rbp)
               	testb	$0xf, %dil
               	je	<addr>
               	leaq	<rip>, %rdx      # <addr>
               	movl	(%rdx), %esi
               	orq	$0x1, %rsi
               	movl	%esi, (%rdx)
               	movl	$0x3, (%rcx)
               	movl	$0x6, 0x8(%rcx)
               	movq	-0x20(%rbp), %rcx
               	movq	-0x18(%rbp), %rdx
               	leaq	0x9(%rcx), %rax
               	cmpq	%rcx, %rax
               	setb	%cl
               	movzbq	%cl, %rcx
               	addq	%rdx, %rcx
               	movq	%rax, -0x20(%rbp)
               	movq	%rcx, -0x18(%rbp)
               	leaq	-0x20(%rbp), %rsp
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
               	testb	$0xf, %al
               	je	<addr>
               	leaq	<rip>, %rcx      # <addr>
               	movl	(%rcx), %esi
               	orq	$0x2, %rsi
               	movl	%esi, (%rcx)
               	movq	$0x2, (%rax)
               	movq	$0x0, 0x8(%rax)
               	addq	$0x10, %rax
               	movq	$0x6, (%rax)
               	movq	$0x0, 0x8(%rax)
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
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %eax
               	popq	%rbp
               	retq
