
atomic_rmw_ops.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x90, %rsp
               	movq	%r13, (%rsp)
               	movl	$0xa, %eax
               	movq	%rax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movl	$0x5, %ecx
               	pushq	%rax
               	movq	%rax, %r13
               	movq	%rcx, %r10
               	movq	%r10, %rax
               	lock
               	xaddq	%rax, (%r13)
               	movq	%rax, %r10
               	popq	%rax
               	movq	%r10, %rax
               	cmpq	$0xa, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	-0x8(%rbp), %rax
               	cmpq	$0xf, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %r13
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movl	$0x3, %ecx
               	pushq	%rax
               	movq	%rax, %r13
               	movq	%rcx, %r10
               	movq	%r10, %rax
               	negq	%rax
               	lock
               	xaddq	%rax, (%r13)
               	movq	%rax, %r10
               	popq	%rax
               	movq	%r10, %rax
               	cmpq	$0xf, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	-0x8(%rbp), %rax
               	cmpq	$0xc, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %r13
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movl	$0xf0, %ecx
               	pushq	%rax
               	pushq	%rcx
               	movq	%rax, %r13
               	movq	%rcx, %r10
               	movq	(%r13), %rax
               	movq	%rax, %rcx
               	andq	%r10, %rcx
               	lock
               	cmpxchgq	%rcx, (%r13)
               	jne	<addr>
               	movq	%rax, %r10
               	popq	%rcx
               	popq	%rax
               	movq	%r10, %rax
               	cmpq	$0xc, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	-0x8(%rbp), %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %r13
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movl	$0x5, %ecx
               	pushq	%rax
               	pushq	%rcx
               	movq	%rax, %r13
               	movq	%rcx, %r10
               	movq	(%r13), %rax
               	movq	%rax, %rcx
               	orq	%r10, %rcx
               	lock
               	cmpxchgq	%rcx, (%r13)
               	jne	<addr>
               	movq	%rax, %r10
               	popq	%rcx
               	popq	%rax
               	movq	%r10, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	-0x8(%rbp), %rax
               	cmpq	$0x5, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %r13
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movl	$0x6, %ecx
               	pushq	%rax
               	pushq	%rcx
               	movq	%rax, %r13
               	movq	%rcx, %r10
               	movq	(%r13), %rax
               	movq	%rax, %rcx
               	xorq	%r10, %rcx
               	lock
               	cmpxchgq	%rcx, (%r13)
               	jne	<addr>
               	movq	%rax, %r10
               	popq	%rcx
               	popq	%rax
               	movq	%r10, %rax
               	cmpq	$0x5, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	-0x8(%rbp), %rax
               	cmpq	$0x3, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %r13
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movl	$0x63, %ecx
               	movq	%rax, %r13
               	movq	%rcx, %r10
               	xchgq	%r10, (%r13)
               	movq	%r10, %rax
               	cmpq	$0x3, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	-0x8(%rbp), %rax
               	cmpq	$0x63, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %r13
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movl	$0x63, %eax
               	movq	%rax, -0x10(%rbp)
               	leaq	-0x8(%rbp), %rax
               	leaq	-0x10(%rbp), %rcx
               	movl	$0x7, %edx
               	pushq	%rax
               	pushq	%rcx
               	movq	%rax, %r13
               	movq	%rdx, %r10
               	movq	(%rcx), %rax
               	lock
               	cmpxchgq	%r10, (%r13)
               	je	<addr>
               	movq	%rax, (%rcx)
               	sete	%r13b
               	movzbq	%r13b, %r13
               	popq	%rcx
               	popq	%rax
               	movq	%r13, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x7, %eax
               	movq	(%rsp), %r13
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movq	-0x8(%rbp), %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	movq	(%rsp), %r13
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movl	$0x64, %eax
               	movq	%rax, -0x10(%rbp)
               	leaq	-0x8(%rbp), %rax
               	leaq	-0x10(%rbp), %rcx
               	xorq	%rdx, %rdx
               	pushq	%rax
               	pushq	%rcx
               	movq	%rax, %r13
               	movq	%rdx, %r10
               	movq	(%rcx), %rax
               	lock
               	cmpxchgq	%r10, (%r13)
               	je	<addr>
               	movq	%rax, (%rcx)
               	sete	%r13b
               	movzbq	%r13b, %r13
               	popq	%rcx
               	popq	%rax
               	movq	%r13, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	movq	(%rsp), %r13
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movq	-0x8(%rbp), %rax
               	cmpq	$0x7, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	-0x10(%rbp), %rax
               	cmpq	$0x7, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0xa, %eax
               	movq	(%rsp), %r13
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movl	$0x4, %eax
               	movl	%eax, -0x18(%rbp)
               	leaq	-0x18(%rbp), %rax
               	movl	$0x1, %ecx
               	pushq	%rax
               	movq	%rax, %r13
               	movq	%rcx, %r10
               	movq	%r10, %rax
               	lock
               	xaddl	%eax, (%r13)
               	movq	%rax, %r10
               	popq	%rax
               	movq	%r10, %rax
               	movslq	%eax, %rax
               	cmpq	$0x4, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movslq	-0x18(%rbp), %rax
               	cmpq	$0x5, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0xb, %eax
               	movq	(%rsp), %r13
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movl	$0x5, %eax
               	movl	%eax, -0x20(%rbp)
               	leaq	-0x18(%rbp), %rax
               	leaq	-0x20(%rbp), %rcx
               	movabsq	$-0x1, %rdx
               	pushq	%rax
               	pushq	%rcx
               	movq	%rax, %r13
               	movq	%rdx, %r10
               	movl	(%rcx), %eax
               	lock
               	cmpxchgl	%r10d, (%r13)
               	je	<addr>
               	movl	%eax, (%rcx)
               	sete	%r13b
               	movzbq	%r13b, %r13
               	popq	%rcx
               	popq	%rax
               	movq	%r13, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xc, %eax
               	movq	(%rsp), %r13
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movslq	-0x18(%rbp), %rax
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	movq	(%rsp), %r13
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movl	$0xc, %eax
               	movl	%eax, -0x28(%rbp)
               	leaq	-0x28(%rbp), %rax
               	movl	$0xf0, %ecx
               	pushq	%rax
               	pushq	%rcx
               	movq	%rax, %r13
               	movq	%rcx, %r10
               	movl	(%r13), %eax
               	movq	%rax, %rcx
               	andq	%r10, %rcx
               	lock
               	cmpxchgl	%ecx, (%r13)
               	jne	<addr>
               	movq	%rax, %r10
               	popq	%rcx
               	popq	%rax
               	movq	%r10, %rax
               	movslq	%eax, %rax
               	cmpq	$0xc, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movslq	-0x28(%rbp), %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0xe, %eax
               	movq	(%rsp), %r13
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x28(%rbp), %rax
               	movl	$0x5, %ecx
               	pushq	%rax
               	pushq	%rcx
               	movq	%rax, %r13
               	movq	%rcx, %r10
               	movl	(%r13), %eax
               	movq	%rax, %rcx
               	orq	%r10, %rcx
               	lock
               	cmpxchgl	%ecx, (%r13)
               	jne	<addr>
               	movq	%rax, %r10
               	popq	%rcx
               	popq	%rax
               	movq	%r10, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movslq	-0x28(%rbp), %rax
               	cmpq	$0x5, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0xf, %eax
               	movq	(%rsp), %r13
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x28(%rbp), %rax
               	movl	$0x6, %ecx
               	pushq	%rax
               	pushq	%rcx
               	movq	%rax, %r13
               	movq	%rcx, %r10
               	movl	(%r13), %eax
               	movq	%rax, %rcx
               	xorq	%r10, %rcx
               	lock
               	cmpxchgl	%ecx, (%r13)
               	jne	<addr>
               	movq	%rax, %r10
               	popq	%rcx
               	popq	%rax
               	movq	%r10, %rax
               	movslq	%eax, %rax
               	cmpq	$0x5, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movslq	-0x28(%rbp), %rax
               	cmpq	$0x3, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x10, %eax
               	movq	(%rsp), %r13
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %r13
               	addq	$0x90, %rsp
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
               	addb	%al, 0x41(%rdx)
