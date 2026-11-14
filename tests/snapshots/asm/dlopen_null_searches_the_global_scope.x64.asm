
dlopen_null_searches_the_global_scope.x64:	file format elf64-x86-64

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
               	subq	$0x10, %rsp
               	xorl	%edi, %edi
               	movl	$0x2, %esi
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x8(%rsp)
               	testq	%r10, %r10
               	jne	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	<rip>, %rsi
               	movq	0x8(%rsp), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rdi
               	callq	*%rax
               	cmpq	$0x6, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	xorl	%edi, %edi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rdi
               	callq	*%rax
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	callq	<addr>
               	leaq	<rip>, %rsi
               	movq	0x8(%rsp), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movq	0x8(%rsp), %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	xorl	%ecx, %ecx
               	movl	$0x5, %edx
               	testq	%rax, %rax
               	cmovneq	%rdx, %rcx
               	movq	%rcx, %rax
               	leave
               	retq
