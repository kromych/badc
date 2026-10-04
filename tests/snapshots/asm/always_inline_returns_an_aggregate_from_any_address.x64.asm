
always_inline_returns_an_aggregate_from_any_address.x64:	file format elf64-x86-64

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

<via_param>:
               	movq	%rdi, %rax
               	retq

<via_global>:
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rax
               	retq

<via_pointer>:
               	movq	(%rdi), %rax
               	retq

<via_member>:
               	movq	0x8(%rdi), %rax
               	retq

<store_through>:
               	movq	%rsi, (%rdi)
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	-0x20(%rbp), %rsi
               	leaq	<rip>, %rax
               	movq	(%rax), %r10
               	movq	%r10, (%rsi)
               	leaq	-0x18(%rbp), %rdi
               	movq	$0x0, (%rdi)
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	-0x20(%rbp), %rdi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	callq	<addr>
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	-0x20(%rbp), %rdi
               	callq	<addr>
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	leaq	-0x10(%rbp), %rdi
               	callq	<addr>
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movq	-0x18(%rbp), %rax
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movq	$0xb, (%rax)
               	callq	<addr>
               	cmpq	$0xb, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
