
wordexp_splits_and_offsets_fields.x64:	file format elf64-x86-64

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
               	subq	$0x28, %rsp
               	leaq	<rip>, %rdi
               	leaq	0x8(%rsp), %rsi
               	xorl	%edx, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x28, %rsp
               	retq
               	movq	0x8(%rsp), %rax
               	cmpq	$0x3, %rax
               	jne	<addr>
               	movq	0x10(%rsp), %rax
               	movq	0x10(%rax), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x28, %rsp
               	retq
               	leaq	<rip>, %rdi
               	leaq	0x8(%rsp), %rsi
               	movl	$0x2, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x28, %rsp
               	retq
               	movq	0x8(%rsp), %rax
               	cmpq	$0x4, %rax
               	jne	<addr>
               	movq	0x10(%rsp), %rax
               	movq	0x18(%rax), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	0x10(%rsp), %rax
               	cmpq	$0x0, 0x20(%rax)
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x28, %rsp
               	retq
               	leaq	0x8(%rsp), %rdi
               	callq	<addr>
               	movq	$0x2, 0x18(%rsp)
               	leaq	<rip>, %rdi
               	leaq	0x8(%rsp), %rsi
               	movl	$0x1, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x28, %rsp
               	retq
               	movq	0x8(%rsp), %rax
               	cmpq	$0x2, %rax
               	jne	<addr>
               	movq	0x10(%rsp), %rax
               	cmpq	$0x0, (%rax)
               	jne	<addr>
               	cmpq	$0x0, 0x8(%rax)
               	jne	<addr>
               	movq	0x18(%rax), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x28, %rsp
               	retq
               	leaq	0x8(%rsp), %rdi
               	callq	<addr>
               	leaq	<rip>, %rdi
               	leaq	0x8(%rsp), %rsi
               	movl	$0x4, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x28, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x28, %rsp
               	retq
