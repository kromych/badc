
gnu_capability_macros.x64:	file format elf64-x86-64

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
               	subq	$0x68, %rsp
               	xorl	%edx, %edx
               	movb	%dl, 0x18(%rsp)
               	leaq	0x18(%rsp), %rax
               	movl	$0x1, %ecx
               	movq	%rcx, %rsi
               	xchgb	%sil, (%rax)
               	movsbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x68, %rsp
               	retq
               	movsbq	0x18(%rsp), %rsi
               	cmpl	$0x1, %esi
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x68, %rsp
               	retq
               	movq	%rcx, %rsi
               	xchgb	%sil, (%rax)
               	movsbq	%sil, %rsi
               	testl	%esi, %esi
               	jne	<addr>
               	movl	$0x5, %eax
               	addq	$0x68, %rsp
               	retq
               	movq	%rdx, %r10
               	xchgb	%r10b, (%rax)
               	cmpb	$0x0, 0x18(%rsp)
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x68, %rsp
               	retq
               	movb	%cl, 0x20(%rsp)
               	movw	%cx, 0x28(%rsp)
               	movl	%ecx, 0x30(%rsp)
               	movq	%rcx, 0x38(%rsp)
               	leaq	0x20(%rsp), %rsi
               	movl	$0x2, %edx
               	movzbq	%cl, %rax
               	lock
               	cmpxchgb	%dl, (%rsi)
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movsbq	0x20(%rsp), %rax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x68, %rsp
               	retq
               	leaq	0x28(%rsp), %rsi
               	movzwl	%cx, %eax
               	lock
               	cmpxchgw	%dx, (%rsi)
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movswq	0x28(%rsp), %rax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x68, %rsp
               	retq
               	leaq	0x30(%rsp), %rsi
               	movl	%ecx, %eax
               	lock
               	cmpxchgl	%edx, (%rsi)
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movl	0x30(%rsp), %eax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x68, %rsp
               	retq
               	leaq	0x38(%rsp), %rsi
               	movq	%rcx, %rax
               	lock
               	cmpxchgq	%rdx, (%rsi)
               	cmpq	$0x1, %rax
               	jne	<addr>
               	movq	0x38(%rsp), %rax
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0x68, %rsp
               	retq
               	xorl	%eax, %eax
               	leaq	(%rsp), %rsi
               	movq	$0x1, (%rsp)
               	movq	%rax, 0x8(%rsp)
               	leaq	0x40(%rsp), %rdi
               	movq	$0x1, 0x40(%rsp)
               	movq	%rax, 0x48(%rsp)
               	leaq	0x50(%rsp), %rcx
               	movq	%rdx, 0x50(%rsp)
               	movq	%rax, 0x58(%rsp)
               	movq	%rdi, %r10
               	movq	%r10, -0x40(%rsp)
               	movq	%rcx, %r10
               	movq	%rsi, %r11
               	movq	%rbx, -0x48(%rsp)
               	movq	%rax, -0x50(%rsp)
               	movq	(%r10), %rbx
               	movq	0x8(%r10), %rcx
               	movq	-0x40(%rsp), %r10
               	movq	(%r10), %rax
               	movq	0x8(%r10), %rdx
               	lock
               	cmpxchg16b	(%r11)
               	je	<addr>
               	movq	%rax, (%r10)
               	movq	%rdx, 0x8(%r10)
               	sete	%cl
               	movzbq	%cl, %r10
               	movq	-0x50(%rsp), %rax
               	movq	-0x48(%rsp), %rbx
               	movq	%r10, %rcx
               	testl	%ecx, %ecx
               	je	<addr>
               	movq	(%rsp), %rcx
               	movq	0x8(%rsp), %rdx
               	xorq	$0x2, %rcx
               	orq	%rdx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0x68, %rsp
               	retq
               	addq	$0x68, %rsp
               	retq
