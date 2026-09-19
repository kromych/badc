
dead_local_load_frame_elide.x64:	file format elf64-x86-64

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

<fold>:
               	movq	(%rdi), %rax
               	bswapq	%rax
               	retq

<vol_keep>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movzbq	(%rdi), %rax
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	movl	$0x9, %eax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x8(%rbp), %rax
               	leaq	(%rax), %rcx
               	movb	$0x1, (%rcx)
               	movb	$0x2, 0x1(%rax)
               	movb	$0x3, 0x2(%rax)
               	movb	$0x4, 0x3(%rax)
               	movb	$0x5, 0x4(%rax)
               	movb	$0x6, 0x5(%rax)
               	movb	$0x7, 0x6(%rax)
               	leaq	-0x8(%rbp), %rdi
               	movb	$0x8, 0x7(%rdi)
               	movq	(%rdi), %rax
               	bswapq	%rax
               	movabsq	$0x102030405060708, %r11 # imm = 0x102030405060708
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	callq	<addr>
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
