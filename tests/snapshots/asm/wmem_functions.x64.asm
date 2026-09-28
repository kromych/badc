
wmem_functions.x64:	file format elf64-x86-64

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
               	subq	$0x30, %rsp
               	leaq	-0x30(%rbp), %rdi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movl	0x10(%rax), %r10d
               	movl	%r10d, 0x10(%rdi)
               	movl	$0x1e, %esi
               	movl	$0x5, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x30(%rbp), %rdi
               	leaq	0x8(%rdi), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movl	$0x63, %esi
               	movl	$0x5, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	-0x18(%rbp), %rdi
               	leaq	-0x30(%rbp), %rsi
               	movl	$0x5, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x18(%rbp), %rdi
               	leaq	-0x30(%rbp), %rsi
               	movl	$0x5, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	leaq	-0x18(%rbp), %rdi
               	movl	$0x7, %esi
               	movl	$0x3, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x18(%rbp), %rsi
               	movslq	(%rsi), %rax
               	cmpl	$0x7, %eax
               	jne	<addr>
               	movslq	0x4(%rsi), %rax
               	cmpl	$0x7, %eax
               	jne	<addr>
               	movslq	0x8(%rsi), %rax
               	cmpl	$0x7, %eax
               	jne	<addr>
               	movslq	0xc(%rsi), %rax
               	cmpl	$0x28, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	leaq	0x4(%rsi), %rdi
               	movl	$0x3, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x18(%rbp), %rax
               	movslq	0x4(%rax), %rcx
               	cmpl	$0x7, %ecx
               	jne	<addr>
               	movslq	0x8(%rax), %rcx
               	cmpl	$0x7, %ecx
               	jne	<addr>
               	movslq	0xc(%rax), %rax
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
