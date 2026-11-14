
pthread_cond_timedwait.x64:	file format elf64-x86-64

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
               	subq	$0xb0, %rsp
               	leaq	-0x38(%rbp), %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	-0x38(%rbp), %rdi
               	xorl	%esi, %esi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	-0x38(%rbp), %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	leaq	-0x90(%rbp), %rdi
               	xorl	%esi, %esi
               	callq	<addr>
               	leaq	-0x68(%rbp), %rdi
               	xorl	%esi, %esi
               	callq	<addr>
               	leaq	-0x90(%rbp), %rdi
               	callq	<addr>
               	leaq	-0xa0(%rbp), %rdx
               	movq	$0x1, -0xa0(%rbp)
               	movq	$0x0, -0x98(%rbp)
               	leaq	-0x68(%rbp), %rdi
               	leaq	-0x90(%rbp), %rsi
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x8(%rsp)
               	leaq	-0x90(%rbp), %rdi
               	callq	<addr>
               	leaq	-0x68(%rbp), %rdi
               	callq	<addr>
               	leaq	-0x90(%rbp), %rdi
               	callq	<addr>
               	xorl	%eax, %eax
               	movl	$0x4, %ecx
               	movq	0x8(%rsp), %r10
               	testl	%r10d, %r10d
               	cmoveq	%rcx, %rax
               	leave
               	retq
