
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
               	subq	$0x60, %rsp
               	xorl	%edx, %edx
               	movb	%dl, -0x48(%rbp)
               	leaq	-0x48(%rbp), %rax
               	movl	$0x1, %ecx
               	movq	%rcx, %rsi
               	xchgb	%sil, (%rax)
               	movsbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movsbq	-0x48(%rbp), %rsi
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
               	cmpb	$0x0, -0x48(%rbp)
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	movb	%cl, -0x40(%rbp)
               	movw	%cx, -0x38(%rbp)
               	movl	%ecx, -0x30(%rbp)
               	movq	%rcx, -0x28(%rbp)
               	leaq	-0x40(%rbp), %rsi
               	movl	$0x2, %edx
               	movzbq	%cl, %rax
               	lock
               	cmpxchgb	%dl, (%rsi)
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movsbq	-0x40(%rbp), %rax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	leaq	-0x38(%rbp), %rsi
               	movzwl	%cx, %eax
               	lock
               	cmpxchgw	%dx, (%rsi)
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movswq	-0x38(%rbp), %rax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	leaq	-0x30(%rbp), %rsi
               	movl	$0x1, %ecx
               	movl	%ecx, %eax
               	lock
               	cmpxchgl	%edx, (%rsi)
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movl	-0x30(%rbp), %eax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	leaq	-0x28(%rbp), %rsi
               	movq	%rcx, %rax
               	lock
               	cmpxchgq	%rdx, (%rsi)
               	cmpq	$0x1, %rax
               	jne	<addr>
               	movq	-0x28(%rbp), %rax
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leaq	-0x60(%rbp), %rsi
               	movq	%rcx, -0x60(%rbp)
               	movq	%rax, -0x58(%rbp)
               	leaq	-0x20(%rbp), %rdi
               	movq	%rcx, -0x20(%rbp)
               	movq	%rax, -0x18(%rbp)
               	leaq	-0x10(%rbp), %rcx
               	movq	%rdx, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	movq	%rdi, %r10
               	pushq	%r10
               	movq	%rcx, %r10
               	movq	%rsi, %r11
               	pushq	%rbx
               	pushq	%rax
               	movq	(%r10), %rbx
               	movq	0x8(%r10), %rcx
               	movq	0x10(%rsp), %r10
               	movq	(%r10), %rax
               	movq	0x8(%r10), %rdx
               	lock
               	cmpxchg16b	(%r11)
               	je	<addr>
               	movq	%rax, (%r10)
               	movq	%rdx, 0x8(%r10)
               	sete	%cl
               	movzbq	%cl, %r10
               	popq	%rax
               	popq	%rbx
               	popq	%r11
               	movq	%r10, %rcx
               	testl	%ecx, %ecx
               	je	<addr>
               	movq	-0x60(%rbp), %rcx
               	movq	-0x58(%rbp), %rdx
               	xorq	$0x2, %rcx
               	orq	%rdx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	leave
               	retq
