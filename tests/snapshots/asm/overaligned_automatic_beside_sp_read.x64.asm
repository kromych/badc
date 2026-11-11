
overaligned_automatic_beside_sp_read.x64:	file format elf64-x86-64

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

<touch>:
               	movb	$0xa, (%rdi)
               	movl	<rip>, %eax # <addr>
               	addq	$0xa, %rax
               	movl	%eax, <rip> # <addr>
               	retq

<reads_sp>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x40, %rsp
               	andq	$-0x40, %rsp
               	leaq	(%rsp), %rdi
               	movl	$0x3, %esi
               	movl	$0x40, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rsp, %rax
               	movq	%rax, -0x8(%rbp)
               	xorl	%ebx, %ebx
               	xorl	%r12d, %r12d
               	xorl	%r13d, %r13d
               	xorl	%r14d, %r14d
               	xorl	%r15d, %r15d
               	leaq	(%rsp), %rdi
               	movl	$0xa, %esi
               	callq	<addr>
               	leaq	(%rsp), %rax
               	movq	-0x8(%rbp), %rcx
               	movq	%rax, %rdx
               	andq	$0x3f, %rdx
               	testl	%edx, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	movsbq	0x3f(%rsp), %rsi
               	cmpl	$0x3, %esi
               	setne	%sil
               	movzbq	%sil, %rsi
               	shlq	%rsi
               	orq	%rsi, %rdx
               	movl	$0x1, %esi
               	movq	%rax, %rdi
               	subq	%rcx, %rdi
               	cmpq	$0x1000, %rdi           # imm = 0x1000
               	seta	%dil
               	movzbq	%dil, %rdi
               	cmpq	%rcx, %rax
               	movq	%rdi, %rax
               	cmovbq	%rsi, %rax
               	shlq	$0x2, %rax
               	orq	%rdx, %rax
               	leaq	-0x40(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq

<reads_sp_inlined>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x40, %rsp
               	andq	$-0x40, %rsp
               	leaq	(%rsp), %rdi
               	movl	$0x3, %esi
               	movl	$0x40, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	xorl	%ebx, %ebx
               	xorl	%r12d, %r12d
               	xorl	%r13d, %r13d
               	xorl	%r14d, %r14d
               	xorl	%r15d, %r15d
               	movq	%rsp, %rax
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rbx
               	leaq	(%rsp), %rdi
               	movl	$0xa, %esi
               	callq	<addr>
               	leaq	(%rsp), %rax
               	movq	%rax, %rcx
               	andq	$0x3f, %rcx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movsbq	0x3f(%rsp), %rdx
               	cmpl	$0x3, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	movl	$0x1, %edx
               	movq	%rax, %rsi
               	subq	%rbx, %rsi
               	cmpq	$0x1000, %rsi           # imm = 0x1000
               	seta	%sil
               	movzbq	%sil, %rsi
               	cmpq	%rbx, %rax
               	movq	%rsi, %rax
               	cmovbq	%rdx, %rax
               	shlq	$0x2, %rax
               	orq	%rcx, %rax
               	leaq	-0x40(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0xa, %edi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movl	$0xa, %edi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
