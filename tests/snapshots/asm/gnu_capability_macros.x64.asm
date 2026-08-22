
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
               	subq	$0x50, %rsp
               	xorq	%rax, %rax
               	movb	%al, -0x48(%rbp)
               	leaq	-0x48(%rbp), %rax
               	movl	$0x1, %ecx
               	movq	%rax, %r11
               	movq	%rcx, %r10
               	xchgb	%r10b, (%r11)
               	movq	%r10, %rax
               	movsbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movsbq	-0x48(%rbp), %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x48(%rbp), %rax
               	movl	$0x1, %ecx
               	movq	%rax, %r11
               	movq	%rcx, %r10
               	xchgb	%r10b, (%r11)
               	movq	%r10, %rax
               	movsbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x5, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x48(%rbp), %rax
               	xorq	%rcx, %rcx
               	movb	%cl, (%rax)
               	movl	$0x1, %eax
               	movb	%al, -0x40(%rbp)
               	movw	%ax, -0x38(%rbp)
               	movl	%eax, -0x30(%rbp)
               	movq	%rax, -0x28(%rbp)
               	leaq	-0x40(%rbp), %rdx
               	movl	$0x2, %esi
               	leaq	-0x20(%rbp), %rcx
               	movb	%al, (%rcx)
               	pushq	%rax
               	pushq	%rcx
               	movq	%rdx, %r11
               	movq	%rsi, %r10
               	movzbq	(%rcx), %rax
               	lock
               	cmpxchgb	%r10b, (%r11)
               	je	<addr>
               	movb	%al, (%rcx)
               	sete	%r11b
               	movzbq	%r11b, %r11
               	popq	%rcx
               	popq	%rax
               	movq	%r11, %rcx
               	testq	%rcx, %rcx
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rcx, %rcx
               	je	<addr>
               	movsbq	-0x40(%rbp), %rax
               	cmpq	$0x2, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x38(%rbp), %rcx
               	movl	$0x1, %edx
               	movl	$0x2, %esi
               	leaq	-0x18(%rbp), %rax
               	movw	%dx, (%rax)
               	pushq	%rax
               	pushq	%rcx
               	movq	%rcx, %r11
               	movq	%rsi, %r10
               	movq	%rax, %rcx
               	movzwq	(%rcx), %rax
               	lock
               	cmpxchgw	%r10w, (%r11)
               	je	<addr>
               	movw	%ax, (%rcx)
               	sete	%r11b
               	movzbq	%r11b, %r11
               	popq	%rcx
               	popq	%rax
               	movq	%r11, %rcx
               	testq	%rcx, %rcx
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rcx, %rcx
               	je	<addr>
               	movswq	-0x38(%rbp), %rax
               	cmpq	$0x2, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rcx
               	movl	$0x1, %edx
               	movl	$0x2, %esi
               	leaq	-0x10(%rbp), %rax
               	movl	%edx, (%rax)
               	pushq	%rax
               	pushq	%rcx
               	movq	%rcx, %r11
               	movq	%rsi, %r10
               	movq	%rax, %rcx
               	movl	(%rcx), %eax
               	lock
               	cmpxchgl	%r10d, (%r11)
               	je	<addr>
               	movl	%eax, (%rcx)
               	sete	%r11b
               	movzbq	%r11b, %r11
               	popq	%rcx
               	popq	%rax
               	movq	%r11, %rcx
               	testq	%rcx, %rcx
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rcx, %rcx
               	je	<addr>
               	movslq	-0x30(%rbp), %rax
               	cmpq	$0x2, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x28(%rbp), %rcx
               	movl	$0x1, %edx
               	movl	$0x2, %esi
               	leaq	-0x8(%rbp), %rax
               	movq	%rdx, (%rax)
               	pushq	%rax
               	pushq	%rcx
               	movq	%rcx, %r11
               	movq	%rsi, %r10
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	lock
               	cmpxchgq	%r10, (%r11)
               	je	<addr>
               	movq	%rax, (%rcx)
               	sete	%r11b
               	movzbq	%r11b, %r11
               	popq	%rcx
               	popq	%rax
               	movq	%r11, %rcx
               	testq	%rcx, %rcx
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	-0x28(%rbp), %rax
               	cmpq	$0x2, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	xorq	%rdx, %rdx
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
