
c11_atomic_specifier.x64:	file format elf64-x86-64

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
               	subq	$0x20, %rsp
               	movl	$0xc8, %eax
               	movb	%al, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rax
               	movzbq	(%rax), %rcx
               	xorq	$0xc8, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0xfa, %ecx
               	movb	%cl, (%rax)
               	movzbq	-0x10(%rbp), %rcx
               	xorq	$0xfa, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x7, %rcx
               	movl	%ecx, -0x10(%rbp)
               	movl	$0xd, %edx
               	movw	%dx, -0x8(%rbp)
               	movswq	-0x8(%rbp), %rcx
               	cmpl	$0xd, %ecx
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x15, %ecx
               	movl	%ecx, (%rax)
               	movslq	-0x10(%rbp), %rax
               	cmpl	$0x15, %eax
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
