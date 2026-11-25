
ulimit_reports_the_file_size_limit.x64:	file format elf64-x86-64

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
               	movl	$0x1, %edi
               	leaq	0x10(%rsp), %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x28, %rsp
               	retq
               	movq	0x10(%rsp), %rax
               	movabsq	$0x7fffffffffffffff, %rcx # imm = 0x7FFFFFFFFFFFFFFF
               	movq	%rax, %rdx
               	shrq	$0x9, %rdx
               	cmpq	$-0x1, %rax
               	movq	%rdx, %r10
               	cmoveq	%rcx, %r10
               	movq	%r10, 0x8(%rsp)
               	movl	$0x1, %edi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	%rax, %rcx
               	cmpq	0x8(%rsp), %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x28, %rsp
               	retq
               	movq	0x10(%rsp), %rax
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movq	%rcx, (%rsp)
               	movq	%rcx, %rsi
               	movl	$0x2, %edi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	(%rsp), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x28, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x28, %rsp
               	retq
