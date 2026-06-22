
c11_atomic_specifier.x64:	file format elf64-x86-64

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
               	movl	$0xc8, %eax
               	movb	%al, -0x8(%rbp)
               	movl	$0x9c40, %eax           # imm = 0x9C40
               	movl	$0x11223344, %ecx       # imm = 0x11223344
               	movabsq	$0x1122334455667788, %rdx # imm = 0x1122334455667788
               	movzbq	-0x8(%rbp), %rsi
               	xorq	$0xc8, %rsi
               	movl	%esi, %esi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %r13
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	xorq	$0x9c40, %rax           # imm = 0x9C40
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %r13
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	cmpq	$0x11223344, %rcx       # imm = 0x11223344
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %r13
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x1122334455667788, %r13 # imm = 0x1122334455667788
               	movq	%rdx, %rax
               	cmpq	%r13, %rdx
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %r13
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movzbq	(%rax), %rcx
               	xorq	$0xc8, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %r13
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movl	$0xfa, %ecx
               	movb	%cl, (%rax)
               	movzbq	-0x8(%rbp), %rax
               	xorq	$0xfa, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %r13
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x7, %rax
               	movl	%eax, -0x30(%rbp)
               	movl	$0x63, %eax
               	movl	$0xd, %ecx
               	movslq	-0x30(%rbp), %rdx
               	cmpq	$-0x7, %rdx
               	je	<addr>
               	movl	$0x7, %eax
               	movq	(%rsp), %r13
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	cmpq	$0x63, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	movq	(%rsp), %r13
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	cmpq	$0xd, %rcx
               	je	<addr>
               	movl	$0x9, %eax
               	movq	(%rsp), %r13
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rax
               	movl	$0x15, %ecx
               	movl	%ecx, (%rax)
               	movslq	-0x30(%rbp), %rax
               	cmpq	$0x15, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	movq	(%rsp), %r13
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %r13
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
