
struct_copy_comma_side_effect.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rdx # <addr>
               	movl	$0x0, <rip> # <addr>
               	leaq	<rip>, %rcx # <addr>
               	movq	(%rcx), %r10
               	movq	%r10, (%rdx)
               	movl	0x8(%rcx), %r10d
               	movl	%r10d, 0x8(%rdx)
               	movl	$0x9, <rip> # <addr>
               	movl	<rip>, %edx # <addr>
               	cmpl	$0xf, %edx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	<rip>, %rdx # <addr>
               	movl	$0x0, <rip> # <addr>
               	movl	$0x3, %eax
               	movq	(%rcx), %r10
               	movq	%r10, (%rdx)
               	movl	0x8(%rcx), %r10d
               	movl	%r10d, 0x8(%rdx)
               	movb	%al, <rip> # <addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	$0xf, %ecx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	xorl	%ecx, %ecx
               	movl	%ecx, <rip> # <addr>
               	leaq	<rip>, %rsi # <addr>
               	leaq	<rip>, %rdi # <addr>
               	movq	(%rdi), %r10
               	movq	%r10, (%rsi)
               	movl	0x8(%rdi), %r10d
               	movl	%r10d, 0x8(%rsi)
               	movb	$0x1, <rip> # <addr>
               	movl	<rip>, %edx # <addr>
               	cmpl	$0xf, %edx
               	je	<addr>
               	retq
               	movq	%rcx, %rax
               	retq
