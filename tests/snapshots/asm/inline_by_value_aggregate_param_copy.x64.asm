
inline_by_value_aggregate_param_copy.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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
               	leaq	-0x8(%rbp), %rax
               	movw	$0x0, (%rax)
               	movb	$0x11, -0x8(%rbp)
               	movb	$-0x74, -0x8(%rbp)
               	movb	$0x7, -0x8(%rbp)
               	movq	%rax, <rip> # <addr>
               	movzbq	-0x8(%rbp), %rcx
               	movb	$0x63, (%rax)
               	cmpl	$0x7, %ecx
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movzbq	-0x8(%rbp), %rax
               	cmpl	$0x63, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movb	$0x8, -0x8(%rbp)
               	movb	$0x3, -0x8(%rbp)
               	movb	$0x37, -0x8(%rbp)
               	movb	$0x4d, <rip> # <addr>
               	xorl	%eax, %eax
               	leave
               	retq
