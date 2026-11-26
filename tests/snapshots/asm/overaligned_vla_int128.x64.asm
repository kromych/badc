
overaligned_vla_int128.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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
               	movl	$0xc, %eax
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
               	movq	$0x3, -0x10(%rbp)
               	movq	-0x10(%rbp), %rcx
               	movq	%rcx, %rsi
               	sarq	$0x3f, %rsi
               	leaq	-0x20(%rbp), %rdx
               	movq	%rcx, -0x20(%rbp)
               	movq	%rsi, -0x18(%rbp)
               	testb	$0xf, %dl
               	je	<addr>
               	movl	<rip>, %ecx # <addr>
               	orq	$0x1, %rcx
               	movl	%ecx, <rip> # <addr>
               	movl	$0x3, (%rax)
               	movl	$0x6, 0x8(%rax)
               	movq	-0x20(%rbp), %rcx
               	movq	-0x18(%rbp), %rdx
               	leaq	0x9(%rcx), %rax
               	cmpq	%rcx, %rax
               	setb	%cl
               	movzbq	%cl, %rcx
               	addq	%rdx, %rcx
               	movq	%rax, -0x20(%rbp)
               	movq	%rcx, -0x18(%rbp)
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
               	movl	<rip>, %ecx # <addr>
               	orq	$0x2, %rcx
               	movl	%ecx, <rip> # <addr>
               	movq	$0x2, (%rax)
               	movq	$0x0, 0x8(%rax)
               	movq	$0x6, 0x10(%rax)
               	movq	$0x0, 0x18(%rax)
               	movl	$0x8, %eax
               	leave
               	retq

<main>:
               	pushq	%rax
               	movl	$0x3, %edi
               	callq	<addr>
               	cmpq	$0xc, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	popq	%r11
               	retq
               	movl	$0x2, %edi
               	callq	<addr>
               	cmpq	$0x8, %rax
               	je	<addr>
               	movl	$0x20, %eax
               	popq	%r11
               	retq
               	movl	<rip>, %eax # <addr>
               	popq	%r11
               	retq
