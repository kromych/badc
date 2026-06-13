
local_struct_array_runtime_init.x64:	file format elf64-x86-64

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
               	movl	$0x7, %eax
               	movl	%eax, -0x8(%rbp)
               	movl	$0x9, %eax
               	movl	%eax, -0x10(%rbp)
               	leaq	-0x30(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%r11
               	movq	(%rcx), %r11
               	movq	%r11, (%rax)
               	movq	0x8(%rcx), %r11
               	movq	%r11, 0x8(%rax)
               	movq	0x10(%rcx), %r11
               	movq	%r11, 0x10(%rax)
               	movq	0x18(%rcx), %r11
               	movq	%r11, 0x18(%rax)
               	popq	%r11
               	leaq	<rip>, %rax
               	leaq	-0x30(%rbp), %rcx
               	movq	%rax, (%rcx)
               	leaq	-0x8(%rbp), %rax
               	leaq	-0x30(%rbp), %rcx
               	movq	%rax, 0x8(%rcx)
               	leaq	<rip>, %rax
               	leaq	-0x30(%rbp), %rcx
               	movq	%rax, 0x10(%rcx)
               	leaq	-0x10(%rbp), %rax
               	leaq	-0x30(%rbp), %rcx
               	movq	%rax, 0x18(%rcx)
               	leaq	-0x30(%rbp), %rax
               	movq	0x8(%rax), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rax
               	movq	0x18(%rax), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rax
               	movq	(%rax), %rax
               	movzbq	(%rax), %rax
               	xorq	$0x78, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rax
               	movq	0x10(%rax), %rax
               	movzbq	(%rax), %rax
               	xorq	$0x79, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rax
               	movq	0x8(%rax), %rax
               	movl	$0xb, %ecx
               	movl	%ecx, (%rax)
               	movslq	-0x8(%rbp), %rax
               	cmpq	$0xb, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
