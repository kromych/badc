
overaligned_automatic.x64:	file format elf64-x86-64

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
               	subq	$0xc0, %rsp
               	andq	$-0x40, %rsp
               	leaq	(%rsp), %rax
               	andq	$0x3f, %rax
               	leaq	0x60(%rsp), %rcx
               	andq	$0x1f, %rcx
               	orq	%rax, %rcx
               	leaq	0x40(%rsp), %rdx
               	andq	$0x3f, %rdx
               	orq	%rdx, %rcx
               	leaq	0x80(%rsp), %rdx
               	andq	$0x1f, %rdx
               	orq	%rdx, %rcx
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	leaq	(%rbp), %rsp
               	popq	%rbp
               	retq
               	movb	$0xb, (%rsp)
               	movl	$0x16, 0x6c(%rsp)
               	movq	$0x21, 0x40(%rsp)
               	movl	$0x2c, 0x80(%rsp)
               	movsbq	(%rsp), %rcx
               	cmpl	$0xb, %ecx
               	jne	<addr>
               	movl	0x6c(%rsp), %ecx
               	cmpl	$0x16, %ecx
               	jne	<addr>
               	movq	0x40(%rsp), %rcx
               	cmpq	$0x21, %rcx
               	jne	<addr>
               	leaq	0x40(%rsp), %rcx
               	andq	$0x3f, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	leaq	(%rbp), %rsp
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	leaq	(%rbp), %rsp
               	popq	%rbp
               	retq
               	movl	$0x2, %eax
               	leaq	(%rbp), %rsp
               	popq	%rbp
               	retq
