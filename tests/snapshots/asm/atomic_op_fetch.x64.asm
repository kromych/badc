
atomic_op_fetch.x64:	file format elf64-x86-64

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
               	movl	$0xa, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movl	$0x5, %edx
               	pushq	%rax
               	movq	%rax, %r11
               	movq	%rdx, %r10
               	movq	%r10, %rax
               	lock
               	xaddl	%eax, (%r11)
               	movq	%rax, %r10
               	popq	%rax
               	movq	%r10, %rcx
               	addq	$0x5, %rcx
               	cmpl	$0xf, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movl	$0x3, %ecx
               	pushq	%rax
               	movq	%rax, %r11
               	movq	%rcx, %r10
               	movq	%r10, %rax
               	negq	%rax
               	lock
               	xaddl	%eax, (%r11)
               	movq	%rax, %r10
               	popq	%rax
               	movq	%r10, %rsi
               	subq	$0x3, %rsi
               	cmpl	$0xc, %esi
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movl	$0xf, %esi
               	pushq	%rax
               	pushq	%rcx
               	movq	%rax, %r11
               	movq	%rsi, %r10
               	movl	(%r11), %eax
               	movq	%rax, %rcx
               	andq	%r10, %rcx
               	lock
               	cmpxchgl	%ecx, (%r11)
               	jne	<addr>
               	movq	%rax, %r10
               	popq	%rcx
               	popq	%rax
               	movq	%r10, %rdi
               	andq	%rdi, %rsi
               	cmpl	$0xc, %esi
               	je	<addr>
               	movq	%rcx, %rax
               	leave
               	retq
               	movl	$0x1, %esi
               	pushq	%rax
               	pushq	%rcx
               	movq	%rax, %r11
               	movq	%rsi, %r10
               	movl	(%r11), %eax
               	movq	%rax, %rcx
               	orq	%r10, %rcx
               	lock
               	cmpxchgl	%ecx, (%r11)
               	jne	<addr>
               	movq	%rax, %r10
               	popq	%rcx
               	popq	%rax
               	movq	%r10, %rdi
               	orq	%rdi, %rsi
               	cmpl	$0xd, %esi
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
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
               	movq	%r10, %rax
               	xorq	%rcx, %rax
               	cmpl	$0xe, %eax
               	je	<addr>
               	movq	%rdx, %rax
               	leave
               	retq
               	movslq	-0x8(%rbp), %rax
               	cmpl	$0xe, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	movq	$0x64, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rax
               	movl	$0x7, %ecx
               	pushq	%rax
               	movq	%rax, %r11
               	movq	%rcx, %r10
               	movq	%r10, %rax
               	lock
               	xaddq	%rax, (%r11)
               	movq	%rax, %r10
               	popq	%rax
               	movq	%r10, %rdx
               	addq	$0x7, %rdx
               	cmpq	$0x6b, %rdx
               	je	<addr>
               	movq	%rcx, %rax
               	leave
               	retq
               	movl	$0xa, %ecx
               	pushq	%rax
               	movq	%rax, %r11
               	movq	%rcx, %r10
               	movq	%r10, %rax
               	negq	%rax
               	lock
               	xaddq	%rax, (%r11)
               	movq	%rax, %r10
               	popq	%rax
               	movq	%r10, %rax
               	subq	$0xa, %rax
               	cmpq	$0x61, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	movq	-0x10(%rbp), %rax
               	cmpq	$0x61, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
