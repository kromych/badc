
pthread_cond_timedwait.x64:	file format elf64-x86-64

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

<main>:
               	subq	$0xb8, %rsp
               	leaq	0x78(%rsp), %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0xb8, %rsp
               	retq
               	leaq	0x78(%rsp), %rdi
               	xorl	%esi, %esi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0xb8, %rsp
               	retq
               	leaq	0x78(%rsp), %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0xb8, %rsp
               	retq
               	leaq	0x20(%rsp), %rdi
               	xorl	%esi, %esi
               	callq	<addr>
               	leaq	0x48(%rsp), %rdi
               	xorl	%esi, %esi
               	callq	<addr>
               	leaq	0x20(%rsp), %rdi
               	callq	<addr>
               	movq	$0x1, 0x10(%rsp)
               	movq	$0x0, 0x18(%rsp)
               	leaq	0x48(%rsp), %rdi
               	leaq	0x20(%rsp), %rsi
               	leaq	0x10(%rsp), %rdx
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x8(%rsp)
               	leaq	0x20(%rsp), %rdi
               	callq	<addr>
               	leaq	0x48(%rsp), %rdi
               	callq	<addr>
               	leaq	0x20(%rsp), %rdi
               	callq	<addr>
               	xorl	%eax, %eax
               	movl	$0x4, %ecx
               	movq	0x8(%rsp), %r10
               	testl	%r10d, %r10d
               	cmoveq	%rcx, %rax
               	addq	$0xb8, %rsp
               	retq
