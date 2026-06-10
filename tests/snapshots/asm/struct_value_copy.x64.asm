
struct_value_copy.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$0x220, %esi            # imm = 0x220
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	leaq	-0x8(%rbp), %rax
               	movl	$0x1, %ecx
               	movl	%ecx, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movl	$0x2, %ecx
               	movl	%ecx, 0x4(%rax)
               	leaq	-0x10(%rbp), %rax
               	movl	$0x63, %ecx
               	movl	%ecx, (%rax)
               	leaq	-0x10(%rbp), %rax
               	movl	%ecx, 0x4(%rax)
               	leaq	-0x10(%rbp), %rax
               	leaq	-0x8(%rbp), %rcx
               	pushq	%r11
               	movq	(%rcx), %r11
               	movq	%r11, (%rax)
               	popq	%r11
               	leaq	-0x10(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movl	$0x3e8, %ecx            # imm = 0x3E8
               	movl	%ecx, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movl	$0x7d0, %ecx            # imm = 0x7D0
               	movl	%ecx, 0x4(%rax)
               	leaq	-0x10(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	movl	$0x7, %ecx
               	movl	%ecx, (%rax)
               	leaq	-0x20(%rbp), %rax
               	movl	$0xe, %ecx
               	movl	%ecx, 0x4(%rax)
               	leaq	-0x20(%rbp), %rax
               	movl	$0x15, %ecx
               	movl	%ecx, 0x8(%rax)
               	leaq	-0x30(%rbp), %rax
               	leaq	-0x20(%rbp), %rcx
               	pushq	%r11
               	movq	(%rcx), %r11
               	movq	%r11, (%rax)
               	movzbq	0x8(%rcx), %r11
               	movb	%r11b, 0x8(%rax)
               	movzbq	0x9(%rcx), %r11
               	movb	%r11b, 0x9(%rax)
               	movzbq	0xa(%rcx), %r11
               	movb	%r11b, 0xa(%rax)
               	movzbq	0xb(%rcx), %r11
               	movb	%r11b, 0xb(%rax)
               	popq	%r11
               	leaq	-0x30(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	cmpq	$0xe, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rax
               	movslq	0x8(%rax), %rax
               	cmpq	$0x15, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movl	$0x32, %ecx
               	movl	%ecx, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movl	$0x3c, %ecx
               	movl	%ecx, 0x4(%rax)
               	leaq	-0x8(%rbp), %rax
               	leaq	-0x8(%rbp), %rcx
               	pushq	%r11
               	movq	(%rcx), %r11
               	movq	%r11, (%rax)
               	popq	%r11
               	leaq	-0x8(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x32, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	cmpq	$0x3c, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
