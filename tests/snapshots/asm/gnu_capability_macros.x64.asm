
gnu_capability_macros.x64:	file format elf64-x86-64

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
               	xorl	%edx, %edx
               	movb	%dl, -0x28(%rbp)
               	leaq	-0x28(%rbp), %rax
               	movl	$0x1, %ecx
               	movq	%rcx, %rsi
               	xchgb	%sil, (%rax)
               	movsbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movsbq	-0x28(%rbp), %rsi
               	cmpl	$0x1, %esi
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movq	%rcx, %rsi
               	xchgb	%sil, (%rax)
               	movsbq	%sil, %rsi
               	testl	%esi, %esi
               	jne	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movq	%rdx, %r10
               	xchgb	%r10b, (%rax)
               	cmpb	$0x0, -0x28(%rbp)
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	movb	%cl, -0x20(%rbp)
               	movw	%cx, -0x18(%rbp)
               	movl	%ecx, -0x10(%rbp)
               	movq	%rcx, -0x8(%rbp)
               	leaq	-0x20(%rbp), %rsi
               	movl	$0x2, %edx
               	movzbq	%cl, %rax
               	lock
               	cmpxchgb	%dl, (%rsi)
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movsbq	-0x20(%rbp), %rax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	leaq	-0x18(%rbp), %rsi
               	movzwl	%cx, %eax
               	lock
               	cmpxchgw	%dx, (%rsi)
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movswq	-0x18(%rbp), %rax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	leaq	-0x10(%rbp), %rsi
               	movl	$0x1, %ecx
               	movl	%ecx, %eax
               	lock
               	cmpxchgl	%edx, (%rsi)
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movslq	-0x10(%rbp), %rax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	leaq	-0x8(%rbp), %rsi
               	movq	%rcx, %rax
               	lock
               	cmpxchgq	%rdx, (%rsi)
               	cmpq	$0x1, %rax
               	jne	<addr>
               	movq	-0x8(%rbp), %rax
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
