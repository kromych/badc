
atomic_rmw_ops.x64:	file format elf64-x86-64

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
               	movl	$0xa, %eax
               	movq	%rax, -0x28(%rbp)
               	leaq	-0x28(%rbp), %rax
               	movl	$0x5, %edx
               	pushq	%rax
               	movq	%rax, %r11
               	movq	%rdx, %r10
               	movq	%r10, %rax
               	lock
               	xaddq	%rax, (%r11)
               	movq	%rax, %r10
               	popq	%rax
               	movq	%r10, %rcx
               	cmpq	$0xa, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	-0x28(%rbp), %rcx
               	cmpq	$0xf, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3, %esi
               	pushq	%rax
               	movq	%rax, %r11
               	movq	%rsi, %r10
               	movq	%r10, %rax
               	negq	%rax
               	lock
               	xaddq	%rax, (%r11)
               	movq	%rax, %r10
               	popq	%rax
               	movq	%r10, %rcx
               	cmpq	$0xf, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	-0x28(%rbp), %rcx
               	cmpq	$0xc, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movl	$0xf0, %ecx
               	pushq	%rax
               	pushq	%rcx
               	movq	%rax, %r11
               	movq	%rcx, %r10
               	movq	(%r11), %rax
               	movq	%rax, %rcx
               	andq	%r10, %rcx
               	lock
               	cmpxchgq	%rcx, (%r11)
               	jne	<addr>
               	movq	%rax, %r10
               	popq	%rcx
               	popq	%rax
               	movq	%r10, %rcx
               	cmpq	$0xc, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	-0x28(%rbp), %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	%rsi, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	pushq	%rax
               	pushq	%rcx
               	movq	%rax, %r11
               	movq	%rdx, %r10
               	movq	(%r11), %rax
               	movq	%rax, %rcx
               	orq	%r10, %rcx
               	lock
               	cmpxchgq	%rcx, (%r11)
               	jne	<addr>
               	movq	%rax, %r10
               	popq	%rcx
               	popq	%rax
               	movq	%r10, %rsi
               	testq	%rsi, %rsi
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rsi, %rsi
               	jne	<addr>
               	movq	-0x28(%rbp), %rcx
               	cmpq	$0x5, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movl	$0x6, %esi
               	pushq	%rax
               	pushq	%rcx
               	movq	%rax, %r11
               	movq	%rsi, %r10
               	movq	(%r11), %rax
               	movq	%rax, %rcx
               	xorq	%r10, %rcx
               	lock
               	cmpxchgq	%rcx, (%r11)
               	jne	<addr>
               	movq	%rax, %r10
               	popq	%rcx
               	popq	%rax
               	movq	%r10, %rax
               	cmpq	$0x5, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	-0x28(%rbp), %rax
               	cmpq	$0x3, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rdx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x28(%rbp), %rcx
               	movl	$0x63, %edx
               	movq	%rcx, %r11
               	movq	%rdx, %r10
               	xchgq	%r10, (%r11)
               	movq	%r10, %rax
               	cmpq	$0x3, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	-0x28(%rbp), %rax
               	cmpq	$0x63, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rsi, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movq	%rdx, -0x20(%rbp)
               	leaq	-0x20(%rbp), %rax
               	movl	$0x7, %edx
               	pushq	%rax
               	pushq	%rcx
               	movq	%rcx, %r11
               	movq	%rdx, %r10
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
               	movq	%r11, %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	movq	%rdx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movq	-0x28(%rbp), %rdx
               	cmpq	$0x7, %rdx
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movl	$0x64, %edx
               	movq	%rdx, -0x20(%rbp)
               	xorq	%rsi, %rsi
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
               	movq	%r11, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movq	-0x28(%rbp), %rax
               	cmpq	$0x7, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	-0x20(%rbp), %rax
               	cmpq	$0x7, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movl	$0x4, %eax
               	movl	%eax, -0x18(%rbp)
               	leaq	-0x18(%rbp), %rcx
               	movl	$0x1, %eax
               	pushq	%rax
               	movq	%rcx, %r11
               	movq	%rax, %r10
               	movq	%r10, %rax
               	lock
               	xaddl	%eax, (%r11)
               	movq	%rax, %r10
               	popq	%rax
               	movq	%r10, %rax
               	cmpl	$0x4, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movslq	-0x18(%rbp), %rax
               	cmpl	$0x5, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movl	$0x5, %edx
               	movl	%edx, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rax
               	movabsq	$-0x1, %rdi
               	pushq	%rax
               	pushq	%rcx
               	movq	%rcx, %r11
               	movq	%rdi, %r10
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
               	movq	%r11, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xc, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movslq	-0x18(%rbp), %rax
               	cmpl	$-0x1, %eax
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movl	$0xc, %eax
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rcx
               	movl	$0xf0, %eax
               	pushq	%rax
               	pushq	%rcx
               	movq	%rcx, %r11
               	movq	%rax, %r10
               	movl	(%r11), %eax
               	movq	%rax, %rcx
               	andq	%r10, %rcx
               	lock
               	cmpxchgl	%ecx, (%r11)
               	jne	<addr>
               	movq	%rax, %r10
               	popq	%rcx
               	popq	%rax
               	movq	%r10, %rax
               	cmpl	$0xc, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movslq	-0x8(%rbp), %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	pushq	%rax
               	pushq	%rcx
               	movq	%rcx, %r11
               	movq	%rdx, %r10
               	movl	(%r11), %eax
               	movq	%rax, %rcx
               	orq	%r10, %rcx
               	lock
               	cmpxchgl	%ecx, (%r11)
               	jne	<addr>
               	movq	%rax, %r10
               	popq	%rcx
               	popq	%rax
               	movq	%r10, %rax
               	testl	%eax, %eax
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rax, %rax
               	jne	<addr>
               	movslq	-0x8(%rbp), %rax
               	cmpl	$0x5, %eax
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0xf, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movl	$0x6, %eax
               	pushq	%rax
               	pushq	%rcx
               	movq	%rcx, %r11
               	movq	%rax, %r10
               	movl	(%r11), %eax
               	movq	%rax, %rcx
               	xorq	%r10, %rcx
               	lock
               	cmpxchgl	%ecx, (%r11)
               	jne	<addr>
               	movq	%rax, %r10
               	popq	%rcx
               	popq	%rax
               	movq	%r10, %rax
               	cmpl	$0x5, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movslq	-0x8(%rbp), %rax
               	cmpl	$0x3, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movq	%rsi, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
