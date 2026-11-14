
posix_legacy_and_gnu_names.x64:	file format elf64-x86-64

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
               	subq	$0x30, %rsp
               	leaq	<rip>, %rdi
               	movl	$0x62, %esi
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x8(%rsp)
               	movl	$0x62, %esi
               	leaq	<rip>, %rdi
               	callq	<addr>
               	movq	%rax, %r10
               	movq	0x8(%rsp), %rax
               	cmpq	%r10, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movl	$0x62, %esi
               	leaq	<rip>, %rdi
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x8(%rsp)
               	movl	$0x62, %esi
               	leaq	<rip>, %rdi
               	callq	<addr>
               	movq	%rax, %r10
               	movq	0x8(%rsp), %rax
               	cmpq	%r10, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movl	$0x7a, %esi
               	leaq	<rip>, %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movl	$0x41, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	leaq	<rip>, %rdi
               	movl	$0x3, %esi
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x3, %rax
               	jge	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	leaq	-0x10(%rbp), %rsi
               	leaq	<rip>, %rcx
               	movq	%rcx, -0x10(%rbp)
               	movq	$0x0, -0x8(%rbp)
               	leaq	-0x18(%rbp), %rdx
               	movq	$0x0, -0x18(%rbp)
               	leaq	<rip>, %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	leaq	<rip>, %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
