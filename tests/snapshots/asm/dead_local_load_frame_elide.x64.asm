
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
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x8(%rbp), %rax
               	addq	$0x0, %rax
               	movl	$0x1, %ecx
               	movb	%cl, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movl	$0x2, %ecx
               	movb	%cl, 0x1(%rax)
               	leaq	-0x8(%rbp), %rax
               	movl	$0x3, %ecx
               	movb	%cl, 0x2(%rax)
               	leaq	-0x8(%rbp), %rax
               	movl	$0x4, %ecx
               	movb	%cl, 0x3(%rax)
               	leaq	-0x8(%rbp), %rax
               	movl	$0x5, %ecx
               	movb	%cl, 0x4(%rax)
               	leaq	-0x8(%rbp), %rax
               	movl	$0x6, %ecx
               	movb	%cl, 0x5(%rax)
               	leaq	-0x8(%rbp), %rax
               	movl	$0x7, %ecx
               	movb	%cl, 0x6(%rax)
               	leaq	-0x8(%rbp), %rax
               	movl	$0x8, %ecx
               	movb	%cl, 0x7(%rax)
               	leaq	-0x8(%rbp), %rax
               	movq	(%rax), %rax
               	bswapq	%rax
               	movabsq	$0x102030405060708, %r11 # imm = 0x102030405060708
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rdi
               	callq	<addr>
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
