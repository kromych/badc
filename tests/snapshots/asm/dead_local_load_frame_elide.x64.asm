
dead_local_load_frame_elide.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<fold>:
               	leaq	(%rdi), %rax
               	movzbq	(%rax), %rax
               	orq	$0x0, %rax
               	shlq	$0x8, %rax
               	movzbq	0x1(%rdi), %rcx
               	orq	%rcx, %rax
               	shlq	$0x8, %rax
               	movzbq	0x2(%rdi), %rcx
               	orq	%rcx, %rax
               	shlq	$0x8, %rax
               	movzbq	0x3(%rdi), %rcx
               	orq	%rcx, %rax
               	shlq	$0x8, %rax
               	movzbq	0x4(%rdi), %rcx
               	orq	%rcx, %rax
               	shlq	$0x8, %rax
               	movzbq	0x5(%rdi), %rcx
               	orq	%rcx, %rax
               	shlq	$0x8, %rax
               	movzbq	0x6(%rdi), %rcx
               	orq	%rcx, %rax
               	shlq	$0x8, %rax
               	movzbq	0x7(%rdi), %rcx
               	orq	%rcx, %rax
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
               	subq	$0x20, %rsp
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
               	leaq	-0x8(%rbp), %rdi
               	callq	<addr>
               	movabsq	$0x102030405060708, %r11 # imm = 0x102030405060708
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
