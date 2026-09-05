
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
               	movl	%esi, 0x200(%rdi)
               	xorl	%eax, %eax
               	callq	<addr>
               	movzbq	%al, %rax
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x210, %rsp            # imm = 0x210
               	xorq	%rax, %rax
               	movl	%eax, -0x210(%rbp)
               	leaq	-0x208(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movslq	-0x210(%rbp), %rax
               	incq	%rax
               	movl	%eax, -0x210(%rbp)
               	leaq	-0x208(%rbp), %rdi
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
               	movslq	-0x210(%rbp), %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0xe, %eax
               	leave
               	retq
               	leaq	-0x208(%rbp), %rax
               	movslq	0x200(%rax), %rax
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0xf, %eax
               	leave
               	retq
               	xorq	%rax, %rax
               	leave
               	retq
