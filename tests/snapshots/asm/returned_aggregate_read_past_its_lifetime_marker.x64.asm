
returned_aggregate_read_past_its_lifetime_marker.x64:	file format elf64-x86-64

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

<k>:
               	movswq	%si, %rsi
               	movsbq	%dl, %rdx
               	movl	$0x3, %eax
               	movb	$0x0, <rip> # <addr>
               	movb	$0x0, <rip> # <addr>
               	movzbq	<rip>, %rcx # <addr>
               	cmpl	$0x7, %ecx
               	je	<addr>
               	retq
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	<rip>, %rdx # <addr>
               	leaq	-0x8(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	xorl	%ecx, %ecx
               	movb	%cl, <rip> # <addr>
               	movb	%cl, <rip> # <addr>
               	movzbq	<rip>, %rsi # <addr>
               	cmpl	$0x7, %esi
               	movq	(%rax), %rax
               	movq	%rax, (%rdx)
               	movl	$0x1, %eax
               	movq	<rip>, %rdx # <addr>
               	cmpq	$0x3, %rdx
               	cmoveq	%rcx, %rax
               	leave
               	retq
