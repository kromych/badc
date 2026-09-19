
gcc_atomics.x64:	file format elf64-x86-64

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
               	subq	$0x40, %rsp
               	movl	$0xa, -0x38(%rbp)
               	leaq	-0x38(%rbp), %rax
               	movl	(%rax), %ecx
               	cmpl	$0xa, %ecx
               	je	<addr>
               	leaq	<rip>, %rcx
               	cmpl	$0x0, (%rcx)
               	jne	<addr>
               	movl	$0x1, (%rcx)
               	movl	$0x14, %ecx
               	movq	%rcx, %r10
               	xchgl	%r10d, (%rax)
               	movslq	-0x38(%rbp), %rcx
               	cmpl	$0x14, %ecx
               	je	<addr>
               	leaq	<rip>, %rcx
               	cmpl	$0x0, (%rcx)
               	jne	<addr>
               	movl	$0x2, (%rcx)
               	movl	$0x1e, %ecx
               	movq	%rax, %r11
               	movq	%rcx, %r10
               	xchgl	%r10d, (%r11)
               	movq	%r10, %rcx
               	cmpl	$0x14, %ecx
               	je	<addr>
               	leaq	<rip>, %rcx
               	cmpl	$0x0, (%rcx)
               	jne	<addr>
               	movl	$0x3, (%rcx)
               	movslq	-0x38(%rbp), %rcx
               	cmpl	$0x1e, %ecx
               	je	<addr>
               	leaq	<rip>, %rcx
               	cmpl	$0x0, (%rcx)
               	jne	<addr>
               	movl	$0x4, (%rcx)
               	movl	$0x64, -0x38(%rbp)
               	movl	$0x5, %ecx
               	pushq	%rax
               	movq	%rax, %r11
               	movq	%rcx, %r10
               	movq	%r10, %rax
               	lock
               	xaddl	%eax, (%r11)
               	movq	%rax, %r10
               	popq	%rax
               	movq	%r10, %rdx
               	cmpl	$0x64, %edx
               	jne	<addr>
               	movslq	-0x38(%rbp), %rdx
               	cmpl	$0x69, %edx
               	je	<addr>
               	leaq	<rip>, %rdx
               	cmpl	$0x0, (%rdx)
               	jne	<addr>
               	movl	%ecx, (%rdx)
               	pushq	%rax
               	movq	%rax, %r11
               	movq	%rcx, %r10
               	movq	%r10, %rax
               	negq	%rax
               	lock
               	xaddl	%eax, (%r11)
               	movq	%rax, %r10
               	popq	%rax
               	movq	%r10, %rcx
               	cmpl	$0x69, %ecx
               	jne	<addr>
               	movslq	-0x38(%rbp), %rcx
               	cmpl	$0x64, %ecx
               	je	<addr>
               	leaq	<rip>, %rcx
               	cmpl	$0x0, (%rcx)
               	jne	<addr>
               	movl	$0x6, (%rcx)
               	movl	$0xf0, -0x38(%rbp)
               	movl	$0x3c, %ecx
               	pushq	%rax
               	pushq	%rcx
               	movq	%rax, %r11
               	movq	%rcx, %r10
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
               	cmpl	$0xf0, %eax
               	jne	<addr>
               	movslq	-0x38(%rbp), %rax
               	cmpl	$0x30, %eax
               	je	<addr>
               	leaq	<rip>, %rax
               	cmpl	$0x0, (%rax)
               	jne	<addr>
               	movl	$0x7, (%rax)
               	leaq	-0x38(%rbp), %rax
               	movl	$0xf, %ecx
               	pushq	%rax
               	pushq	%rcx
               	movq	%rax, %r11
               	movq	%rcx, %r10
               	movl	(%r11), %eax
               	movq	%rax, %rcx
               	orq	%r10, %rcx
               	lock
               	cmpxchgl	%ecx, (%r11)
               	jne	<addr>
               	movq	%rax, %r10
               	popq	%rcx
               	popq	%rax
               	movq	%r10, %rcx
               	cmpl	$0x30, %ecx
               	jne	<addr>
               	movslq	-0x38(%rbp), %rcx
               	cmpl	$0x3f, %ecx
               	je	<addr>
               	leaq	<rip>, %rcx
               	cmpl	$0x0, (%rcx)
               	jne	<addr>
               	movl	$0x8, (%rcx)
               	movl	$0xff, %ecx
               	pushq	%rax
               	pushq	%rcx
               	movq	%rax, %r11
               	movq	%rcx, %r10
               	movl	(%r11), %eax
               	movq	%rax, %rcx
               	xorq	%r10, %rcx
               	lock
               	cmpxchgl	%ecx, (%r11)
               	jne	<addr>
               	movq	%rax, %r10
               	popq	%rcx
               	popq	%rax
               	movq	%r10, %rcx
               	cmpl	$0x3f, %ecx
               	jne	<addr>
               	movslq	-0x38(%rbp), %rcx
               	cmpl	$0xc0, %ecx
               	je	<addr>
               	leaq	<rip>, %rcx
               	cmpl	$0x0, (%rcx)
               	jne	<addr>
               	movl	$0x9, (%rcx)
               	movl	$0x7, %ecx
               	movl	%ecx, -0x38(%rbp)
               	movl	%ecx, -0x30(%rbp)
               	leaq	-0x30(%rbp), %rdx
               	movl	$0x8, %esi
               	pushq	%rax
               	pushq	%rcx
               	movq	%rax, %r11
               	movq	%rsi, %r10
               	movq	%rdx, %rcx
               	movl	(%rcx), %eax
               	lock
               	cmpxchgl	%r10d, (%r11)
               	je	<addr>
               	movl	%eax, (%rcx)
               	sete	%r11b
               	movzbq	%r11b, %r11
               	popq	%rcx
               	popq	%rax
               	movq	%r11, %rsi
               	cmpq	$0x1, %rsi
               	jne	<addr>
               	movslq	-0x38(%rbp), %rsi
               	cmpl	$0x8, %esi
               	je	<addr>
               	leaq	<rip>, %rsi
               	cmpl	$0x0, (%rsi)
               	jne	<addr>
               	movl	$0xa, (%rsi)
               	movl	%ecx, -0x30(%rbp)
               	movl	$0x9, %esi
               	pushq	%rax
               	pushq	%rcx
               	movq	%rax, %r11
               	movq	%rsi, %r10
               	movq	%rdx, %rcx
               	movl	(%rcx), %eax
               	lock
               	cmpxchgl	%r10d, (%r11)
               	je	<addr>
               	movl	%eax, (%rcx)
               	sete	%r11b
               	movzbq	%r11b, %r11
               	popq	%rcx
               	popq	%rax
               	movq	%r11, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movslq	-0x38(%rbp), %rdx
               	cmpl	$0x8, %edx
               	jne	<addr>
               	movslq	-0x30(%rbp), %rdx
               	cmpl	$0x8, %edx
               	je	<addr>
               	leaq	<rip>, %rdx
               	cmpl	$0x0, (%rdx)
               	jne	<addr>
               	movl	$0xb, (%rdx)
               	movl	$0x64, -0x38(%rbp)
               	pushq	%rax
               	movq	%rax, %r11
               	movq	%rcx, %r10
               	movq	%r10, %rax
               	lock
               	xaddl	%eax, (%r11)
               	movq	%rax, %r10
               	popq	%rax
               	movq	%r10, %rax
               	cmpl	$0x64, %eax
               	jne	<addr>
               	movslq	-0x38(%rbp), %rax
               	cmpl	$0x6b, %eax
               	je	<addr>
               	leaq	<rip>, %rax
               	cmpl	$0x0, (%rax)
               	jne	<addr>
               	movl	$0xc, (%rax)
               	leaq	-0x38(%rbp), %rax
               	movl	$0x7, %ecx
               	pushq	%rax
               	movq	%rax, %r11
               	movq	%rcx, %r10
               	movq	%r10, %rax
               	negq	%rax
               	lock
               	xaddl	%eax, (%r11)
               	movq	%rax, %r10
               	popq	%rax
               	movq	%r10, %rcx
               	subq	$0x7, %rcx
               	cmpl	$0x64, %ecx
               	jne	<addr>
               	movslq	-0x38(%rbp), %rcx
               	cmpl	$0x64, %ecx
               	je	<addr>
               	leaq	<rip>, %rcx
               	cmpl	$0x0, (%rcx)
               	jne	<addr>
               	movl	$0xd, (%rcx)
               	movl	$0x1, %ecx
               	pushq	%rax
               	movq	%rax, %r11
               	movq	%rcx, %r10
               	movq	%r10, %rax
               	lock
               	xaddl	%eax, (%r11)
               	movq	%rax, %r10
               	popq	%rax
               	movq	%r10, %rcx
               	incq	%rcx
               	cmpl	$0x65, %ecx
               	jne	<addr>
               	movslq	-0x38(%rbp), %rcx
               	cmpl	$0x65, %ecx
               	je	<addr>
               	leaq	<rip>, %rcx
               	cmpl	$0x0, (%rcx)
               	jne	<addr>
               	movl	$0xe, (%rcx)
               	movl	$0xcc, -0x38(%rbp)
               	movl	$0x33, %ecx
               	pushq	%rax
               	pushq	%rcx
               	movq	%rax, %r11
               	movq	%rcx, %r10
               	movl	(%r11), %eax
               	movq	%rax, %rcx
               	orq	%r10, %rcx
               	lock
               	cmpxchgl	%ecx, (%r11)
               	jne	<addr>
               	movq	%rax, %r10
               	popq	%rcx
               	popq	%rax
               	movq	%r10, %rcx
               	cmpl	$0xcc, %ecx
               	jne	<addr>
               	movslq	-0x38(%rbp), %rcx
               	cmpl	$0xff, %ecx
               	je	<addr>
               	leaq	<rip>, %rcx
               	cmpl	$0x0, (%rcx)
               	jne	<addr>
               	movl	$0xf, (%rcx)
               	movl	$0xf, %ecx
               	pushq	%rax
               	pushq	%rcx
               	movq	%rax, %r11
               	movq	%rcx, %r10
               	movl	(%r11), %eax
               	movq	%rax, %rcx
               	andq	%r10, %rcx
               	lock
               	cmpxchgl	%ecx, (%r11)
               	jne	<addr>
               	movq	%rax, %r10
               	popq	%rcx
               	popq	%rax
               	movq	%r10, %rdx
               	andq	%rdx, %rcx
               	cmpl	$0xf, %ecx
               	jne	<addr>
               	movslq	-0x38(%rbp), %rcx
               	cmpl	$0xf, %ecx
               	je	<addr>
               	leaq	<rip>, %rcx
               	cmpl	$0x0, (%rcx)
               	jne	<addr>
               	movl	$0x10, (%rcx)
               	movl	$0xff, %ecx
               	pushq	%rax
               	pushq	%rcx
               	movq	%rax, %r11
               	movq	%rcx, %r10
               	movl	(%r11), %eax
               	movq	%rax, %rcx
               	xorq	%r10, %rcx
               	lock
               	cmpxchgl	%ecx, (%r11)
               	jne	<addr>
               	movq	%rax, %r10
               	popq	%rcx
               	popq	%rax
               	movq	%r10, %rdx
               	xorq	%rdx, %rcx
               	cmpl	$0xf0, %ecx
               	jne	<addr>
               	movslq	-0x38(%rbp), %rcx
               	cmpl	$0xf0, %ecx
               	je	<addr>
               	leaq	<rip>, %rcx
               	cmpl	$0x0, (%rcx)
               	jne	<addr>
               	movl	$0x11, (%rcx)
               	movl	$0x5, -0x38(%rbp)
               	movl	$0x6, %esi
               	leaq	-0x20(%rbp), %rdx
               	movl	$0x5, (%rdx)
               	pushq	%rax
               	pushq	%rcx
               	movq	%rax, %r11
               	movq	%rsi, %r10
               	movq	%rdx, %rcx
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
               	movslq	(%rdx), %rax
               	cmpl	$0x5, %eax
               	jne	<addr>
               	movslq	-0x38(%rbp), %rax
               	cmpl	$0x6, %eax
               	je	<addr>
               	leaq	<rip>, %rax
               	cmpl	$0x0, (%rax)
               	jne	<addr>
               	movl	$0x12, (%rax)
               	leaq	-0x38(%rbp), %rax
               	movl	$0x7, %edi
               	leaq	-0x18(%rbp), %rdx
               	movl	$0x5, (%rdx)
               	pushq	%rax
               	pushq	%rcx
               	movq	%rax, %r11
               	movq	%rdi, %r10
               	movq	%rdx, %rcx
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
               	movslq	(%rdx), %rcx
               	cmpl	$0x6, %ecx
               	jne	<addr>
               	movslq	-0x38(%rbp), %rcx
               	cmpl	$0x6, %ecx
               	je	<addr>
               	leaq	<rip>, %rcx
               	cmpl	$0x0, (%rcx)
               	jne	<addr>
               	movl	$0x13, (%rcx)
               	movl	$0x8, %edx
               	leaq	-0x10(%rbp), %rcx
               	movl	%esi, (%rcx)
               	pushq	%rax
               	pushq	%rcx
               	movq	%rax, %r11
               	movq	%rdx, %r10
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
               	cmpq	$0x1, %rcx
               	jne	<addr>
               	movslq	-0x38(%rbp), %rcx
               	cmpl	$0x8, %ecx
               	je	<addr>
               	leaq	<rip>, %rcx
               	cmpl	$0x0, (%rcx)
               	jne	<addr>
               	movl	$0x14, (%rcx)
               	movl	$0x9, %esi
               	leaq	-0x8(%rbp), %rcx
               	movl	$0x6, (%rcx)
               	pushq	%rax
               	pushq	%rcx
               	movq	%rax, %r11
               	movq	%rsi, %r10
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
               	jne	<addr>
               	movslq	-0x38(%rbp), %rcx
               	cmpl	$0x8, %ecx
               	je	<addr>
               	leaq	<rip>, %rcx
               	cmpl	$0x0, (%rcx)
               	jne	<addr>
               	movl	$0x15, (%rcx)
               	movl	$0x1, %ecx
               	movl	%ecx, -0x38(%rbp)
               	movl	$0x2, %edx
               	movq	%rax, %r11
               	movq	%rdx, %r10
               	xchgl	%r10d, (%r11)
               	movq	%r10, %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movslq	-0x38(%rbp), %rax
               	cmpl	$0x2, %eax
               	je	<addr>
               	leaq	<rip>, %rax
               	cmpl	$0x0, (%rax)
               	jne	<addr>
               	movl	$0x16, (%rax)
               	leaq	-0x38(%rbp), %rdx
               	xorl	%eax, %eax
               	movl	%eax, (%rdx)
               	cmpl	$0x0, -0x38(%rbp)
               	je	<addr>
               	leaq	<rip>, %rdx
               	cmpl	$0x0, (%rdx)
               	jne	<addr>
               	movl	$0x17, (%rdx)
               	movb	%al, -0x28(%rbp)
               	leaq	-0x28(%rbp), %rdx
               	movq	%rdx, %r11
               	movq	%rcx, %r10
               	xchgb	%r10b, (%r11)
               	movq	%r10, %rsi
               	testb	$-0x1, %sil
               	jne	<addr>
               	cmpb	$0x0, -0x28(%rbp)
               	jne	<addr>
               	leaq	<rip>, %rsi
               	cmpl	$0x0, (%rsi)
               	jne	<addr>
               	movl	$0x18, (%rsi)
               	movq	%rdx, %r11
               	movq	%rcx, %r10
               	xchgb	%r10b, (%r11)
               	movq	%r10, %rcx
               	testb	$-0x1, %cl
               	jne	<addr>
               	leaq	<rip>, %rcx
               	cmpl	$0x0, (%rcx)
               	jne	<addr>
               	movl	$0x19, (%rcx)
               	movq	%rax, %r10
               	xchgb	%r10b, (%rdx)
               	cmpb	$0x0, -0x28(%rbp)
               	je	<addr>
               	leaq	<rip>, %rax
               	cmpl	$0x0, (%rax)
               	jne	<addr>
               	movl	$0x1a, (%rax)
               	mfence
               	mfence
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
