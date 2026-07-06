
dead_local_load_frame_elide.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<fold>:
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	jmp	<addr>
               	shlq	$0x8, %rcx
               	leaq	(%rdi,%rax), %rdx
               	movzbq	(%rdx), %rdx
               	orq	%rdx, %rcx
               	incq	%rax
               	cmpq	$0x8, %rax
               	jb	<addr>
               	movq	%rcx, %rax
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
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	leaq	-0x8(%rbp), %rax
               	addq	%rcx, %rax
               	leaq	0x1(%rcx), %rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%rax)
               	incq	%rcx
               	cmpq	$0x8, %rcx
               	jb	<addr>
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
