
scalar_compound_literal_lvalue.x64:	file format elf64-x86-64

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
               	movl	$0x5, -0x8(%rbp)
               	movl	$0xa, -0x8(%rbp)
               	movl	$0x9, -0x8(%rbp)
               	movsd	<rip>, %xmm0
               	movsd	%xmm0, -0x8(%rbp)
               	movsd	-0x8(%rbp), %xmm1
               	ucomisd	%xmm0, %xmm1
               	jp	<addr>
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movb	$0x41, -0x8(%rbp)
               	movl	$0x7, -0x8(%rbp)
               	movl	$0x2a, -0x8(%rbp)
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movl	0x8(%rcx), %r10d
               	movl	%r10d, 0x8(%rax)
               	xorl	%eax, %eax
               	leave
               	retq
