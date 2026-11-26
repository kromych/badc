
posix_legacy_and_gnu_names.x64:	file format elf64-x86-64

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
               	subq	$0x38, %rsp
               	leaq	<rip>, %rdi
               	movl	$0x62, %esi
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x8(%rsp)
               	leaq	<rip>, %rdi
               	movl	$0x62, %esi
               	callq	<addr>
               	movq	%rax, %r10
               	movq	0x8(%rsp), %rax
               	cmpq	%r10, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x38, %rsp
               	retq
               	leaq	<rip>, %rdi
               	movl	$0x62, %esi
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x8(%rsp)
               	leaq	<rip>, %rdi
               	movl	$0x62, %esi
               	callq	<addr>
               	movq	%rax, %r10
               	movq	0x8(%rsp), %rax
               	cmpq	%r10, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x38, %rsp
               	retq
               	leaq	<rip>, %rdi
               	movl	$0x7a, %esi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x38, %rsp
               	retq
               	movl	$0x41, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x38, %rsp
               	retq
               	leaq	<rip>, %rdi
               	movl	$0x3, %esi
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x38, %rsp
               	retq
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x3, %rax
               	jge	<addr>
               	movl	$0x9, %eax
               	addq	$0x38, %rsp
               	retq
               	leaq	<rip>, %rax
               	movq	%rax, 0x20(%rsp)
               	movq	$0x0, 0x28(%rsp)
               	movq	$0x0, 0x18(%rsp)
               	leaq	<rip>, %rdi
               	leaq	0x20(%rsp), %rsi
               	leaq	0x18(%rsp), %rdx
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x38, %rsp
               	retq
               	leaq	<rip>, %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x38, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x38, %rsp
               	retq
