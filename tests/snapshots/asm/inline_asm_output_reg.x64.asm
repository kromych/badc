
inline_asm_output_reg.x64:	file format elf64-x86-64

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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	$0x0, -0x8(%rbp)
               	leaq	-0x8(%rbp), %r10
               	movl	$0x5, %r11d
               	movq	%r11, (%r10)
               	movl	$0xa, %r10d
               	leaq	0x7(%r10), %rax
               	cmpq	$0x11, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movl	$0x6, %edx
               	movq	%rdx, %rax
               	movq	%rdx, %rcx
               	addq	%rcx, %rax
               	cmpq	$0xc, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movq	-0x8(%rbp), %rax
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movl	$0x2a, %eax
               	leave
               	retq
