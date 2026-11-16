
setjmp_longjmp.x64:	file format elf64-x86-64

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

<trigger>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x7, %esi
               	movl	%esi, 0xc8(%rdi)
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xe0, %rsp
               	movl	$0x0, -0xd8(%rbp)
               	leaq	-0xd0(%rbp), %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	-0xd8(%rbp), %eax
               	incq	%rax
               	movl	%eax, -0xd8(%rbp)
               	leaq	-0xd0(%rbp), %rdi
               	movl	$0x7, %esi
               	callq	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	movl	-0xd8(%rbp), %eax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0xe, %eax
               	leave
               	retq
               	movl	-0x8(%rbp), %eax
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0xf, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
