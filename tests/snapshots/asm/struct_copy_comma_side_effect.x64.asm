
struct_copy_comma_side_effect.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rsi # <addr>
               	movl	$0x0, <rip> # <addr>
               	leaq	<rip>, %rdx # <addr>
               	movq	(%rdx), %r10
               	movq	%r10, (%rsi)
               	movl	0x8(%rdx), %r10d
               	movl	%r10d, 0x8(%rsi)
               	movl	$0x9, <rip> # <addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0xf, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	<rip>, %rdi # <addr>
               	movl	$0x0, <rip> # <addr>
               	movl	$0x3, %eax
               	movq	(%rdx), %r10
               	movq	%r10, (%rdi)
               	movl	0x8(%rdx), %r10d
               	movl	%r10d, 0x8(%rdi)
               	movb	%al, <rip> # <addr>
               	movl	<rip>, %edx # <addr>
               	cmpl	$0xf, %edx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movl	$0x0, <rip> # <addr>
               	leaq	<rip>, %rdx # <addr>
               	movq	(%rdx), %r10
               	movq	%r10, (%rsi)
               	movl	0x8(%rdx), %r10d
               	movl	%r10d, 0x8(%rsi)
               	movb	$0x1, <rip> # <addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	$0xf, %ecx
               	je	<addr>
               	retq
               	xorl	%eax, %eax
               	retq
