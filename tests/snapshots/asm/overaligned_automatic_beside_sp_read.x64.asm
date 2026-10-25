
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
               	leaq	<rip>, %rax # <addr>
               	movl	(%rax), %ecx
               	addq	$0xa, %rcx
               	movl	%ecx, (%rax)
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
               	movq	-0x8(%rbp), %rdx
               	movq	%rax, %rcx
               	andq	$0x3f, %rcx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movsbq	0x3f(%rsp), %rsi
               	cmpl	$0x3, %esi
               	setne	%sil
               	movzbq	%sil, %rsi
               	shlq	%rsi
               	orq	%rcx, %rsi
               	cmpq	%rdx, %rax
               	movl	$0x1, %ecx
               	jb	<addr>
               	subq	%rdx, %rax
               	cmpq	$0x1000, %rax           # imm = 0x1000
               	seta	%cl
               	movzbq	%cl, %rcx
               	shlq	$0x2, %rcx
               	orq	%rsi, %rcx
               	movq	%rcx, %rax
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
               	orq	%rcx, %rdx
               	cmpq	%rbx, %rax
               	movl	$0x1, %ecx
               	jb	<addr>
               	subq	%rbx, %rax
               	cmpq	$0x1000, %rax           # imm = 0x1000
               	seta	%cl
               	movzbq	%cl, %rcx
               	shlq	$0x2, %rcx
               	orq	%rdx, %rcx
               	movq	%rcx, %rax
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
