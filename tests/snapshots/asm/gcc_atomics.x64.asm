
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
               	subq	$0x10, %rsp
               	movl	$0xa, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rcx
               	movl	(%rcx), %eax
               	cmpl	$0xa, %eax
               	je	<addr>
               	leaq	<rip>, %rax
               	cmpl	$0x0, (%rax)
               	jne	<addr>
               	movl	$0x1, (%rax)
               	movl	$0x14, %eax
               	movq	%rax, %r10
               	xchgl	%r10d, (%rcx)
               	movslq	-0x10(%rbp), %rax
               	cmpl	$0x14, %eax
               	je	<addr>
               	leaq	<rip>, %rax
               	cmpl	$0x0, (%rax)
               	jne	<addr>
               	movl	$0x2, (%rax)
               	movl	$0x1e, %eax
               	xchgl	%eax, (%rcx)
               	cmpl	$0x14, %eax
               	je	<addr>
               	leaq	<rip>, %rax
               	cmpl	$0x0, (%rax)
               	jne	<addr>
               	movl	$0x3, (%rax)
               	movslq	-0x10(%rbp), %rax
               	cmpl	$0x1e, %eax
               	je	<addr>
               	leaq	<rip>, %rax
               	cmpl	$0x0, (%rax)
               	jne	<addr>
               	movl	$0x4, (%rax)
               	movl	$0x64, -0x10(%rbp)
               	movl	$0x5, %eax
               	movq	%rax, %rdx
               	lock
               	xaddl	%edx, (%rcx)
               	cmpl	$0x64, %edx
               	jne	<addr>
               	movslq	-0x10(%rbp), %rdx
               	cmpl	$0x69, %edx
               	je	<addr>
               	leaq	<rip>, %rdx
               	cmpl	$0x0, (%rdx)
               	jne	<addr>
               	movl	%eax, (%rdx)
               	negq	%rax
               	lock
               	xaddl	%eax, (%rcx)
               	cmpl	$0x69, %eax
               	jne	<addr>
               	movslq	-0x10(%rbp), %rax
               	cmpl	$0x64, %eax
               	je	<addr>
               	leaq	<rip>, %rax
               	cmpl	$0x0, (%rax)
               	jne	<addr>
               	movl	$0x6, (%rax)
               	movl	$0xf0, -0x10(%rbp)
               	movl	$0x3c, %edx
               	movl	(%rcx), %eax
               	movq	%rax, %r10
               	andq	%rdx, %r10
               	lock
               	cmpxchgl	%r10d, (%rcx)
               	jne	<addr>
               	cmpl	$0xf0, %eax
               	jne	<addr>
               	movslq	-0x10(%rbp), %rax
               	cmpl	$0x30, %eax
               	je	<addr>
               	leaq	<rip>, %rax
               	cmpl	$0x0, (%rax)
               	jne	<addr>
               	movl	$0x7, (%rax)
               	leaq	-0x10(%rbp), %rdx
               	movl	$0xf, %ecx
               	movl	(%rdx), %eax
               	movq	%rax, %r10
               	orq	%rcx, %r10
               	lock
               	cmpxchgl	%r10d, (%rdx)
               	jne	<addr>
               	cmpl	$0x30, %eax
               	jne	<addr>
               	movslq	-0x10(%rbp), %rax
               	cmpl	$0x3f, %eax
               	je	<addr>
               	leaq	<rip>, %rax
               	cmpl	$0x0, (%rax)
               	jne	<addr>
               	movl	$0x8, (%rax)
               	movl	$0xff, %ecx
               	movl	(%rdx), %eax
               	movq	%rax, %r10
               	xorq	%rcx, %r10
               	lock
               	cmpxchgl	%r10d, (%rdx)
               	jne	<addr>
               	cmpl	$0x3f, %eax
               	jne	<addr>
               	movslq	-0x10(%rbp), %rax
               	cmpl	$0xc0, %eax
               	je	<addr>
               	leaq	<rip>, %rax
               	cmpl	$0x0, (%rax)
               	jne	<addr>
               	movl	$0x9, (%rax)
               	movl	$0x7, %ecx
               	movl	%ecx, -0x10(%rbp)
               	movl	$0x8, %esi
               	movl	%ecx, %eax
               	lock
               	cmpxchgl	%esi, (%rdx)
               	cmpl	$0x7, %eax
               	sete	%al
               	movzbq	%al, %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movslq	-0x10(%rbp), %rax
               	cmpl	$0x8, %eax
               	je	<addr>
               	leaq	<rip>, %rax
               	cmpl	$0x0, (%rax)
               	jne	<addr>
               	movl	$0xa, (%rax)
               	movl	$0x9, %esi
               	movl	%ecx, %eax
               	lock
               	cmpxchgl	%esi, (%rdx)
               	cmpl	$0x7, %eax
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movq	%rcx, %rax
               	testl	%esi, %esi
               	jne	<addr>
               	movslq	-0x10(%rbp), %rsi
               	cmpl	$0x8, %esi
               	jne	<addr>
               	cmpl	$0x8, %eax
               	je	<addr>
               	leaq	<rip>, %rax
               	cmpl	$0x0, (%rax)
               	jne	<addr>
               	movl	$0xb, (%rax)
               	movl	$0x64, -0x10(%rbp)
               	movq	%rcx, %rax
               	lock
               	xaddl	%eax, (%rdx)
               	cmpl	$0x64, %eax
               	jne	<addr>
               	movslq	-0x10(%rbp), %rax
               	cmpl	$0x6b, %eax
               	je	<addr>
               	leaq	<rip>, %rax
               	cmpl	$0x0, (%rax)
               	jne	<addr>
               	movl	$0xc, (%rax)
               	leaq	-0x10(%rbp), %rdx
               	movq	%rcx, %rax
               	negq	%rax
               	lock
               	xaddl	%eax, (%rdx)
               	subq	$0x7, %rax
               	cmpl	$0x64, %eax
               	jne	<addr>
               	movslq	-0x10(%rbp), %rax
               	cmpl	$0x64, %eax
               	je	<addr>
               	leaq	<rip>, %rax
               	cmpl	$0x0, (%rax)
               	jne	<addr>
               	movl	$0xd, (%rax)
               	movl	$0x1, %eax
               	lock
               	xaddl	%eax, (%rdx)
               	incq	%rax
               	cmpl	$0x65, %eax
               	jne	<addr>
               	movslq	-0x10(%rbp), %rax
               	cmpl	$0x65, %eax
               	je	<addr>
               	leaq	<rip>, %rax
               	cmpl	$0x0, (%rax)
               	jne	<addr>
               	movl	$0xe, (%rax)
               	movl	$0xcc, -0x10(%rbp)
               	movl	$0x33, %ecx
               	movl	(%rdx), %eax
               	movq	%rax, %r10
               	orq	%rcx, %r10
               	lock
               	cmpxchgl	%r10d, (%rdx)
               	jne	<addr>
               	cmpl	$0xcc, %eax
               	jne	<addr>
               	movslq	-0x10(%rbp), %rax
               	cmpl	$0xff, %eax
               	je	<addr>
               	leaq	<rip>, %rax
               	cmpl	$0x0, (%rax)
               	jne	<addr>
               	movl	$0xf, (%rax)
               	movl	$0xf, %ecx
               	movl	(%rdx), %eax
               	movq	%rax, %r10
               	andq	%rcx, %r10
               	lock
               	cmpxchgl	%r10d, (%rdx)
               	jne	<addr>
               	andq	%rcx, %rax
               	cmpl	$0xf, %eax
               	jne	<addr>
               	movslq	-0x10(%rbp), %rax
               	cmpl	$0xf, %eax
               	je	<addr>
               	leaq	<rip>, %rax
               	cmpl	$0x0, (%rax)
               	jne	<addr>
               	movl	$0x10, (%rax)
               	movl	$0xff, %ecx
               	movl	(%rdx), %eax
               	movq	%rax, %r10
               	xorq	%rcx, %r10
               	lock
               	cmpxchgl	%r10d, (%rdx)
               	jne	<addr>
               	xorq	%rcx, %rax
               	cmpl	$0xf0, %eax
               	jne	<addr>
               	movslq	-0x10(%rbp), %rax
               	cmpl	$0xf0, %eax
               	je	<addr>
               	leaq	<rip>, %rax
               	cmpl	$0x0, (%rax)
               	jne	<addr>
               	movl	$0x11, (%rax)
               	movl	$0x5, %esi
               	movl	%esi, -0x10(%rbp)
               	movl	$0x6, %edi
               	movl	%esi, %eax
               	lock
               	cmpxchgl	%edi, (%rdx)
               	cmpl	$0x5, %eax
               	jne	<addr>
               	movslq	-0x10(%rbp), %rax
               	cmpl	$0x6, %eax
               	je	<addr>
               	leaq	<rip>, %rax
               	cmpl	$0x0, (%rax)
               	jne	<addr>
               	movl	$0x12, (%rax)
               	leaq	-0x10(%rbp), %rcx
               	movl	$0x7, %edx
               	movl	%esi, %eax
               	lock
               	cmpxchgl	%edx, (%rcx)
               	cmpl	$0x6, %eax
               	jne	<addr>
               	movslq	-0x10(%rbp), %rax
               	cmpl	$0x6, %eax
               	je	<addr>
               	leaq	<rip>, %rax
               	cmpl	$0x0, (%rax)
               	jne	<addr>
               	movl	$0x13, (%rax)
               	movl	$0x8, %edx
               	movl	%edi, %eax
               	lock
               	cmpxchgl	%edx, (%rcx)
               	cmpl	$0x6, %eax
               	sete	%al
               	movzbq	%al, %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movslq	-0x10(%rbp), %rax
               	cmpl	$0x8, %eax
               	je	<addr>
               	leaq	<rip>, %rax
               	cmpl	$0x0, (%rax)
               	jne	<addr>
               	movl	$0x14, (%rax)
               	movl	$0x9, %edx
               	movl	%edi, %eax
               	lock
               	cmpxchgl	%edx, (%rcx)
               	cmpl	$0x6, %eax
               	je	<addr>
               	movslq	-0x10(%rbp), %rax
               	cmpl	$0x8, %eax
               	je	<addr>
               	leaq	<rip>, %rax
               	cmpl	$0x0, (%rax)
               	jne	<addr>
               	movl	$0x15, (%rax)
               	movl	$0x1, %eax
               	movl	%eax, -0x10(%rbp)
               	movl	$0x2, %edx
               	xchgl	%edx, (%rcx)
               	cmpl	$0x1, %edx
               	jne	<addr>
               	movslq	-0x10(%rbp), %rcx
               	cmpl	$0x2, %ecx
               	je	<addr>
               	leaq	<rip>, %rcx
               	cmpl	$0x0, (%rcx)
               	jne	<addr>
               	movl	$0x16, (%rcx)
               	leaq	-0x10(%rbp), %rdx
               	xorl	%ecx, %ecx
               	movl	%ecx, (%rdx)
               	cmpl	$0x0, -0x10(%rbp)
               	je	<addr>
               	leaq	<rip>, %rdx
               	cmpl	$0x0, (%rdx)
               	jne	<addr>
               	movl	$0x17, (%rdx)
               	movb	%cl, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rdx
               	movq	%rax, %rsi
               	xchgb	%sil, (%rdx)
               	testb	$-0x1, %sil
               	jne	<addr>
               	cmpb	$0x0, -0x8(%rbp)
               	jne	<addr>
               	leaq	<rip>, %rsi
               	cmpl	$0x0, (%rsi)
               	jne	<addr>
               	movl	$0x18, (%rsi)
               	xchgb	%al, (%rdx)
               	testb	$-0x1, %al
               	jne	<addr>
               	leaq	<rip>, %rax
               	cmpl	$0x0, (%rax)
               	jne	<addr>
               	movl	$0x19, (%rax)
               	movq	%rcx, %r10
               	xchgb	%r10b, (%rdx)
               	cmpb	$0x0, -0x8(%rbp)
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
