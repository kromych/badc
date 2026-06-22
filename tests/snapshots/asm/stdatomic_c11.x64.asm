
stdatomic_c11.x64:	file format elf64-x86-64

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
               	subq	$0x60, %rsp
               	movq	%r13, (%rsp)
               	xorq	%rax, %rax
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movl	$0x5, %ecx
               	movl	%ecx, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %r13
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movl	$0xa, %ecx
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
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %r13
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movslq	-0x8(%rbp), %rax
               	cmpq	$0xf, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %r13
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movl	$0xf, %eax
               	movl	%eax, -0x10(%rbp)
               	leaq	-0x8(%rbp), %rax
               	leaq	-0x10(%rbp), %rcx
               	movl	$0x63, %edx
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
               	movl	$0x4, %eax
               	movq	(%rsp), %r13
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movslq	-0x8(%rbp), %rax
               	cmpq	$0x63, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %r13
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%r11
               	movzbq	(%rcx), %r11
               	movb	%r11b, (%rax)
               	popq	%r11
               	leaq	-0x18(%rbp), %rax
               	movl	$0x1, %ecx
               	movq	%rax, %r13
               	movq	%rcx, %r10
               	xchgb	%r10b, (%r13)
               	movq	%r10, %rax
               	movsbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %r13
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	xorq	%rcx, %rcx
               	movb	%cl, (%rax)
               	movl	%ecx, -0x20(%rbp)
               	leaq	-0x20(%rbp), %rax
               	movl	$0x2a, %ecx
               	movl	%ecx, (%rax)
               	leaq	-0x20(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	movq	(%rsp), %r13
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rax
               	movl	$0x64, %ecx
               	movq	%rcx, (%rax)
               	leaq	-0x30(%rbp), %rax
               	movl	$0x1, %ecx
               	pushq	%rax
               	movq	%rax, %r13
               	movq	%rcx, %r10
               	movq	%r10, %rax
               	lock
               	xaddq	%rax, (%r13)
               	movq	%rax, %r10
               	popq	%rax
               	movq	%r10, %rax
               	leaq	-0x30(%rbp), %rax
               	movq	(%rax), %rax
               	cmpq	$0x65, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	movq	(%rsp), %r13
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rax
               	movl	$0x1, %ecx
               	movl	%ecx, 0x8(%rax)
               	leaq	-0x30(%rbp), %rax
               	movslq	0x8(%rax), %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	movq	(%rsp), %r13
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movl	$0x7fff, %eax           # imm = 0x7FFF
               	movl	$0xffffffff, %ecx       # imm = 0xFFFFFFFF
               	xorq	%rsi, %rsi
               	cmpq	$0x7fff, %rax           # imm = 0x7FFF
               	setne	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0xa, %eax
               	movq	(%rsp), %r13
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movl	$0xffffffff, %r13d      # imm = 0xFFFFFFFF
               	movq	%rcx, %rax
               	cmpq	%r13, %rcx
               	je	<addr>
               	movl	$0xb, %eax
               	movq	(%rsp), %r13
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0xc, %eax
               	movq	(%rsp), %r13
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %r13
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
