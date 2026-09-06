
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
               	movl	$0xa, %eax
               	movl	%eax, -0x38(%rbp)
               	leaq	-0x38(%rbp), %rax
               	movslq	(%rax), %rcx
               	cmpl	$0xa, %ecx
               	je	<addr>
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	<rip>, %rcx
               	movl	$0x1, %edx
               	movl	%edx, (%rcx)
               	movl	$0x14, %ecx
               	movl	%ecx, (%rax)
               	movslq	-0x38(%rbp), %rcx
               	cmpl	$0x14, %ecx
               	je	<addr>
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	<rip>, %rcx
               	movl	$0x2, %edx
               	movl	%edx, (%rcx)
               	movl	$0x1e, %ecx
               	movq	%rax, %r11
               	movq	%rcx, %r10
               	xchgl	%r10d, (%r11)
               	movq	%r10, %rax
               	cmpl	$0x14, %eax
               	je	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movl	$0x3, %ecx
               	movl	%ecx, (%rax)
               	movslq	-0x38(%rbp), %rax
               	cmpl	$0x1e, %eax
               	je	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movl	$0x4, %ecx
               	movl	%ecx, (%rax)
               	movl	$0x64, %eax
               	movl	%eax, -0x38(%rbp)
               	leaq	-0x38(%rbp), %rcx
               	movl	$0x5, %edx
               	pushq	%rax
               	movq	%rcx, %r11
               	movq	%rdx, %r10
               	movq	%r10, %rax
               	lock
               	xaddl	%eax, (%r11)
               	movq	%rax, %r10
               	popq	%rax
               	movq	%r10, %rax
               	cmpl	$0x64, %eax
               	jne	<addr>
               	movslq	-0x38(%rbp), %rax
               	cmpl	$0x69, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movl	%edx, (%rax)
               	pushq	%rax
               	movq	%rcx, %r11
               	movq	%rdx, %r10
               	movq	%r10, %rax
               	negq	%rax
               	lock
               	xaddl	%eax, (%r11)
               	movq	%rax, %r10
               	popq	%rax
               	movq	%r10, %rax
               	cmpl	$0x69, %eax
               	jne	<addr>
               	movslq	-0x38(%rbp), %rax
               	cmpl	$0x64, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movl	$0x6, %edx
               	movl	%edx, (%rax)
               	movl	$0xf0, %eax
               	movl	%eax, -0x38(%rbp)
               	movl	$0x3c, %eax
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
               	cmpl	$0xf0, %eax
               	jne	<addr>
               	movslq	-0x38(%rbp), %rax
               	cmpl	$0x30, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movl	$0x7, %ecx
               	movl	%ecx, (%rax)
               	leaq	-0x38(%rbp), %rcx
               	movl	$0xf, %eax
               	pushq	%rax
               	pushq	%rcx
               	movq	%rcx, %r11
               	movq	%rax, %r10
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
               	cmpl	$0x30, %eax
               	jne	<addr>
               	movslq	-0x38(%rbp), %rax
               	cmpl	$0x3f, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movl	$0x8, %edx
               	movl	%edx, (%rax)
               	movl	$0xff, %eax
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
               	cmpl	$0x3f, %eax
               	jne	<addr>
               	movslq	-0x38(%rbp), %rax
               	cmpl	$0xc0, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movl	$0x9, %edx
               	movl	%edx, (%rax)
               	movl	$0x7, %eax
               	movl	%eax, -0x38(%rbp)
               	movl	%eax, -0x30(%rbp)
               	leaq	-0x30(%rbp), %rsi
               	movl	$0x8, %edx
               	pushq	%rax
               	pushq	%rcx
               	movq	%rcx, %r11
               	movq	%rdx, %r10
               	movq	%rsi, %rcx
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
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	<rip>, %rcx
               	movl	$0xa, %edx
               	movl	%edx, (%rcx)
               	movl	%eax, -0x30(%rbp)
               	leaq	-0x38(%rbp), %rdx
               	movl	$0x9, %ecx
               	pushq	%rax
               	pushq	%rcx
               	movq	%rdx, %r11
               	movq	%rcx, %r10
               	movq	%rsi, %rcx
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
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movslq	-0x30(%rbp), %rcx
               	cmpl	$0x8, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	<rip>, %rcx
               	movl	$0xb, %esi
               	movl	%esi, (%rcx)
               	movl	$0x64, %ecx
               	movl	%ecx, -0x38(%rbp)
               	pushq	%rax
               	movq	%rdx, %r11
               	movq	%rax, %r10
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
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movl	$0xc, %ecx
               	movl	%ecx, (%rax)
               	movl	$0x7, %eax
               	pushq	%rax
               	movq	%rdx, %r11
               	movq	%rax, %r10
               	movq	%r10, %rax
               	negq	%rax
               	lock
               	xaddl	%eax, (%r11)
               	movq	%rax, %r10
               	popq	%rax
               	movq	%r10, %rax
               	subq	$0x7, %rax
               	cmpl	$0x64, %eax
               	jne	<addr>
               	movslq	-0x38(%rbp), %rax
               	cmpl	$0x64, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movl	$0xd, %ecx
               	movl	%ecx, (%rax)
               	leaq	-0x38(%rbp), %rcx
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
               	incq	%rax
               	cmpl	$0x65, %eax
               	jne	<addr>
               	movslq	-0x38(%rbp), %rax
               	cmpl	$0x65, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movl	$0xe, %edx
               	movl	%edx, (%rax)
               	movl	$0xcc, %eax
               	movl	%eax, -0x38(%rbp)
               	movl	$0x33, %eax
               	pushq	%rax
               	pushq	%rcx
               	movq	%rcx, %r11
               	movq	%rax, %r10
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
               	cmpl	$0xcc, %eax
               	jne	<addr>
               	movslq	-0x38(%rbp), %rax
               	cmpl	$0xff, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movl	$0xf, %edx
               	movl	%edx, (%rax)
               	movl	$0xf, %edx
               	pushq	%rax
               	pushq	%rcx
               	movq	%rcx, %r11
               	movq	%rdx, %r10
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
               	andq	%rdx, %rax
               	cmpl	$0xf, %eax
               	jne	<addr>
               	movslq	-0x38(%rbp), %rax
               	cmpl	$0xf, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movl	$0x10, %ecx
               	movl	%ecx, (%rax)
               	leaq	-0x38(%rbp), %rcx
               	movl	$0xff, %edx
               	pushq	%rax
               	pushq	%rcx
               	movq	%rcx, %r11
               	movq	%rdx, %r10
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
               	xorq	%rdx, %rax
               	cmpl	$0xf0, %eax
               	jne	<addr>
               	movslq	-0x38(%rbp), %rax
               	cmpl	$0xf0, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movl	$0x11, %edx
               	movl	%edx, (%rax)
               	movl	$0x5, %edx
               	movl	%edx, -0x38(%rbp)
               	movl	$0x6, %esi
               	leaq	-0x20(%rbp), %rax
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
               	movq	%r11, %rdi
               	movslq	(%rax), %rax
               	cmpl	$0x5, %eax
               	jne	<addr>
               	movslq	-0x38(%rbp), %rax
               	cmpl	$0x6, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movl	$0x12, %edi
               	movl	%edi, (%rax)
               	movl	$0x7, %edi
               	leaq	-0x18(%rbp), %rax
               	movl	%edx, (%rax)
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
               	movq	%r11, %rcx
               	movslq	(%rax), %rax
               	cmpl	$0x6, %eax
               	jne	<addr>
               	movslq	-0x38(%rbp), %rax
               	cmpl	$0x6, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movl	$0x13, %ecx
               	movl	%ecx, (%rax)
               	leaq	-0x38(%rbp), %rcx
               	movl	$0x8, %edx
               	leaq	-0x10(%rbp), %rax
               	movl	%esi, (%rax)
               	pushq	%rax
               	pushq	%rcx
               	movq	%rcx, %r11
               	movq	%rdx, %r10
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
               	cmpq	$0x1, %rax
               	jne	<addr>
               	movslq	-0x38(%rbp), %rax
               	cmpl	$0x8, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movl	$0x14, %edx
               	movl	%edx, (%rax)
               	movl	$0x6, %edx
               	movl	$0x9, %esi
               	leaq	-0x8(%rbp), %rax
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
               	movq	%r11, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movslq	-0x38(%rbp), %rax
               	cmpl	$0x8, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movl	$0x15, %edx
               	movl	%edx, (%rax)
               	movl	$0x1, %edx
               	movl	%edx, -0x38(%rbp)
               	movl	$0x2, %eax
               	movq	%rcx, %r11
               	movq	%rax, %r10
               	xchgl	%r10d, (%r11)
               	movq	%r10, %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movslq	-0x38(%rbp), %rax
               	cmpl	$0x2, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movl	$0x16, %ecx
               	movl	%ecx, (%rax)
               	leaq	-0x38(%rbp), %rax
               	xorq	%rcx, %rcx
               	movl	%ecx, (%rax)
               	movb	%cl, -0x28(%rbp)
               	leaq	-0x28(%rbp), %rsi
               	movq	%rsi, %r11
               	movq	%rdx, %r10
               	xchgb	%r10b, (%r11)
               	movq	%r10, %rax
               	andq	$0xff, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movzbq	-0x28(%rbp), %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movl	$0x18, %edi
               	movl	%edi, (%rax)
               	movq	%rsi, %r11
               	movq	%rdx, %r10
               	xchgb	%r10b, (%r11)
               	movq	%r10, %rax
               	andq	$0xff, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movl	$0x19, %edx
               	movl	%edx, (%rax)
               	movb	%cl, (%rsi)
               	mfence
               	mfence
               	mfence
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
