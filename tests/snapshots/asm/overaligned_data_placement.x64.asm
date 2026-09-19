
overaligned_data_placement.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rax
               	andq	$0x3f, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	<rip>, %rax
               	movq	%rax, %rcx
               	andq	$0x7f, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %rcx
               	andq	$0xff, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	leaq	<rip>, %rcx
               	andq	$0x3f, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	leaq	<rip>, %rcx
               	andq	$0x7f, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	leaq	<rip>, %rcx
               	movq	%rcx, %rdx
               	andq	$0xff, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	leaq	<rip>, %rdx
               	andq	$0x3f, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	leaq	<rip>, %rdx
               	movq	%rdx, %rsi
               	andq	$0x7f, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	leaq	<rip>, %rsi
               	movq	%rsi, %rdi
               	andq	$0xff, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	movl	$0x9, %eax
               	retq
               	movl	$0xb, %edi
               	movl	%edi, (%rax)
               	movl	$0x16, (%rcx)
               	movl	$0x21, (%rdx)
               	movl	$0x2c, (%rsi)
               	movslq	(%rax), %rax
               	cmpl	$0xb, %eax
               	jne	<addr>
               	movslq	(%rcx), %rax
               	cmpl	$0x16, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x21, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x2c, %eax
               	je	<addr>
               	movl	$0xa, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x2, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x7, %eax
               	je	<addr>
               	movq	%rdi, %rax
               	retq
               	xorl	%eax, %eax
               	retq
