
static_init_once_guard.x64:	file format elf64-x86-64

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

<step>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	%edi, -0x10(%rbp)
               	testl	%edi, %edi
               	jne	<addr>
               	leaq	<rip>, %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rax
               	movq	%rax, (%rcx)
               	jmpq	*%rax
               	movl	$0xa, %eax
               	leave
               	retq
               	movl	$0x14, %eax
               	leave
               	retq
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	cmpq	%rdx, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	%rax, (%rcx)
               	jmpq	*%rax

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	xorl	%edi, %edi
               	callq	<addr>
               	cmpq	$0x14, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	movl	$0x1, %edi
               	callq	<addr>
               	cmpq	$0xa, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movl	$0x7, %ecx
               	movl	%ecx, 0x4(%rax)
               	cmpl	$0x7, %ecx
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	movslq	0x4(%rax), %rcx
               	cmpl	$0x7, %ecx
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
               	movslq	(%rax), %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
