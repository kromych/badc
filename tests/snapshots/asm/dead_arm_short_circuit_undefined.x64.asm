
dead_arm_short_circuit_undefined.x64:	file format elf64-x86-64

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
               	leaq	-0x10(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movq	$0x0, -0x10(%rbp)
               	movq	$0x0, -0x8(%rbp)
               	movq	$0x1, -0x10(%rbp)
               	movq	$0x1, -0x8(%rbp)
               	movq	$0x0, -0x10(%rbp)
               	movq	$0x2, -0x8(%rbp)
               	movq	$0x1, -0x10(%rbp)
               	movq	$0x3, -0x8(%rbp)
               	movq	$0x0, -0x10(%rbp)
               	movq	$0x4, -0x8(%rbp)
               	movq	$0x1, -0x10(%rbp)
               	movq	$0x5, -0x8(%rbp)
               	movq	$0x0, -0x10(%rbp)
               	movq	$0x6, -0x8(%rbp)
               	movq	$0x1, -0x10(%rbp)
               	movq	$0x7, -0x8(%rbp)
               	xorl	%eax, %eax
               	leave
               	retq
