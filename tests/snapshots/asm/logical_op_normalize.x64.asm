
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
               	testq	%rdi, %rdi
               	jne	<addr>
               	xorl	%eax, %eax
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
               	subq	$0x10, %rsp
               	pushq	%r12
               	pushq	%rbx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rbx
               	xorl	%esi, %esi
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	xorl	%edi, %edi
               	movl	$0x5, %esi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	xorl	%edi, %edi
               	movq	%rbx, %rsi
               	callq	<addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x5, %edi
               	movl	$0x7, %esi
               	callq	<addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x5, %edi
               	xorl	%esi, %esi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x8(%rbp), %r12
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%r12)
               	popq	%rcx
               	xorl	%esi, %esi
               	movq	%rbx, %rdi
               	callq	<addr>
               	movslq	(%r12,%rax,4), %rax
               	cmpl	$0x14, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x8(%rbp), %r12
               	xorl	%edi, %edi
               	movl	$0x9, %esi
               	callq	<addr>
               	movslq	(%r12,%rax,4), %rax
               	cmpl	$0xa, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	testq	%rbx, %rbx
               	jne	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
