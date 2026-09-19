
designator_range_in_chain.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rcx
               	leaq	0x8(%rcx), %rax
               	cmpq	$0x0, (%rax)
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	cmpq	$0x0, 0x8(%rax)
               	jne	<addr>
               	cmpq	$0x0, 0x10(%rax)
               	jne	<addr>
               	cmpq	$0x0, 0x18(%rax)
               	jne	<addr>
               	movq	(%rcx), %rax
               	cmpq	$0x5, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	0x28(%rax), %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	xorl	%eax, %eax
               	leaq	<rip>, %rdx
               	cmpl	$0x3, %eax
               	jge	<addr>
               	leaq	0x4(%rdx), %rsi
               	movq	%rax, %rdi
               	shlq	$0x3, %rdi
               	leaq	(%rsi,%rdi), %rcx
               	movslq	(%rcx), %r8
               	cmpl	$0x7, %r8d
               	jne	<addr>
               	movslq	0x4(%rcx), %rcx
               	cmpl	$0x8, %ecx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x3, %eax
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movslq	0x1c(%rax), %rax
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	xorl	%eax, %eax
               	retq
               	movl	$0x3, %eax
               	retq
