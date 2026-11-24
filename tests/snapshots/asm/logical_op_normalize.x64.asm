
logical_op_normalize.x64:	file format elf64-x86-64

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
               	subq	$0x28, %rsp
               	movslq	<rip>, %rdi # <addr>
               	xorl	%esi, %esi
               	movq	%rdi, 0x8(%rsp)
               	callq	<addr>
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x28, %rsp
               	retq
               	xorl	%edi, %edi
               	movl	$0x5, %esi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x28, %rsp
               	retq
               	xorl	%edi, %edi
               	movq	0x8(%rsp), %rsi
               	callq	<addr>
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	$0x5, %edi
               	movl	$0x7, %esi
               	callq	<addr>
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	$0x5, %edi
               	xorl	%esi, %esi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x28, %rsp
               	retq
               	leaq	0x18(%rsp), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	xorl	%esi, %esi
               	movq	0x8(%rsp), %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	0x18(%rsp,%rax,4), %eax
               	cmpl	$0x14, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x28, %rsp
               	retq
               	xorl	%edi, %edi
               	movl	$0x9, %esi
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	0x18(%rsp,%rax,4), %eax
               	cmpl	$0xa, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x28, %rsp
               	retq
               	movq	0x8(%rsp), %r10
               	testq	%r10, %r10
               	jne	<addr>
               	movl	$0x8, %eax
               	addq	$0x28, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x28, %rsp
               	retq
