
logical_op_normalize.x64:	file format elf64-x86-64

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

<or_ll>:
               	movl	$0x1, %eax
               	xorl	%ecx, %ecx
               	testq	%rdi, %rdi
               	cmoveq	%rcx, %rax
               	retq

<or_rr>:
               	testq	%rsi, %rsi
               	setne	%al
               	movzbq	%al, %rax
               	retq

<and_ll>:
               	xorl	%eax, %eax
               	retq

<and_rr>:
               	testl	%esi, %esi
               	setne	%al
               	movzbq	%al, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movslq	<rip>, %r10 # <addr>
               	movq	%r10, 0x8(%rsp)
               	xorl	%esi, %esi
               	movq	0x8(%rsp), %rdi
               	callq	<addr>
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	xorl	%edi, %edi
               	movl	$0x5, %esi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	xorl	%edi, %edi
               	movq	0x8(%rsp), %rsi
               	callq	<addr>
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movl	$0x5, %edi
               	movl	$0x7, %esi
               	callq	<addr>
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movl	$0x5, %edi
               	xorl	%esi, %esi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	leaq	-0x8(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	xorl	%esi, %esi
               	movq	0x8(%rsp), %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	-0x8(%rbp,%rax,4), %eax
               	cmpl	$0x14, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	xorl	%edi, %edi
               	movl	$0x9, %esi
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	-0x8(%rbp,%rax,4), %eax
               	cmpl	$0xa, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	movq	0x8(%rsp), %r10
               	testq	%r10, %r10
               	jne	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
