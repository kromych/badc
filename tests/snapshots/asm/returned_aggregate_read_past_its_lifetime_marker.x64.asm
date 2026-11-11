
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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movswq	%si, %rsi
               	movsbq	%dl, %rdx
               	leaq	-0x8(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movb	$0x0, <rip> # <addr>
               	movb	$0x0, <rip> # <addr>
               	movzbq	<rip>, %rdx # <addr>
               	cmpl	$0x7, %edx
               	je	<addr>
               	movl	$0x0, -0x10(%rbp)
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	leave
               	retq
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	<rip>, %rdx # <addr>
               	leaq	-0x8(%rbp), %rcx
               	leaq	<rip>, %rax
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	xorl	%eax, %eax
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movzbq	<rip>, %rsi # <addr>
               	cmpl	$0x7, %esi
               	movq	(%rcx), %rcx
               	movq	%rcx, (%rdx)
               	movq	<rip>, %rcx # <addr>
               	cmpq	$0x3, %rcx
               	jne	<addr>
               	leave
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
