
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
               	subq	$0x30, %rsp
               	movq	%rbx, (%rsp)
               	xorq	%rax, %rax
               	movq	%rax, -0x18(%rbp)
               	leaq	-0x18(%rbp), %rax
               	movl	$0x5, %ebx
               	movq	%rbx, (%rax)
               	movl	$0xa, %ebx
               	leaq	0x7(%rbx), %rax
               	movq	%rax, -0x10(%rbp)
               	movq	-0x10(%rbp), %rax
               	cmpq	$0x11, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0x6, %ecx
               	movq	%rcx, %rax
               	movq	%rcx, %rbx
               	movq	%rax, -0x10(%rbp)
               	movq	%rbx, -0x8(%rbp)
               	movq	-0x10(%rbp), %rax
               	movq	-0x8(%rbp), %rcx
               	addq	%rcx, %rax
               	cmpq	$0xc, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movq	-0x18(%rbp), %rax
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0x2a, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
