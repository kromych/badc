
ulimit_reports_the_file_size_limit.x64:	file format elf64-x86-64

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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movl	$0x1, %edi
               	leaq	-0x10(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movq	-0x10(%rbp), %rax
               	movabsq	$0x7fffffffffffffff, %rcx # imm = 0x7FFFFFFFFFFFFFFF
               	movq	%rax, %rdx
               	shrq	$0x9, %rdx
               	cmpq	$-0x1, %rax
               	movq	%rdx, %r10
               	cmoveq	%rcx, %r10
               	movq	%r10, (%rsp)
               	movl	$0x1, %edi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x8(%rsp), %rax
               	cmpq	(%rsp), %rax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movq	-0x10(%rbp), %rax
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x2, %edi
               	movq	0x8(%rsp), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	cmpq	0x8(%rsp), %rax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
