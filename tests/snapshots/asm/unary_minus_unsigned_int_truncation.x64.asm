
unary_minus_unsigned_int_truncation.x64:	file format elf64-x86-64

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
               	subq	$0x50, %rsp
               	movq	%r13, (%rsp)
               	movl	$0x1, %eax
               	imulq	$-0x1, %rax, %rcx
               	movl	%ecx, %ecx
               	movl	$0xffffffff, %r13d      # imm = 0xFFFFFFFF
               	cmpq	%r13, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %r13
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	imulq	$-0x1, %rax, %rcx
               	movl	%ecx, %ecx
               	orq	%rax, %rcx
               	movl	$0xffffffff, %r13d      # imm = 0xFFFFFFFF
               	cmpq	%r13, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %r13
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	imulq	$-0x1, %rax, %rcx
               	movl	%ecx, %ecx
               	orq	%rax, %rcx
               	shrq	$0x1f, %rcx
               	cmpq	$0x1, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %r13
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	xorq	%rcx, %rcx
               	imulq	$-0x1, %rcx, %rdx
               	movl	%edx, %edx
               	orq	%rdx, %rcx
               	shrq	$0x1f, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %r13
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	imulq	$-0x1, %rax, %rcx
               	movl	%ecx, %ecx
               	movl	%ecx, %edx
               	orq	%rax, %rdx
               	movl	$0xffffffff, %r13d      # imm = 0xFFFFFFFF
               	cmpq	%r13, %rdx
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %r13
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movl	%ecx, %ecx
               	orq	%rcx, %rax
               	shrq	$0x1f, %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %r13
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	xorq	%rcx, %rcx
               	xorq	%rcx, %rax
               	movl	%eax, %eax
               	imulq	$-0x1, %rax, %rcx
               	movl	%ecx, %ecx
               	orq	%rcx, %rax
               	shrq	$0x1f, %rax
               	xorq	$0x1, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	movq	(%rsp), %r13
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movl	$0x5, %eax
               	xorq	%rax, %rax
               	movl	%eax, %eax
               	imulq	$-0x1, %rax, %rcx
               	movl	%ecx, %ecx
               	orq	%rcx, %rax
               	shrq	$0x1f, %rax
               	xorq	$0x1, %rax
               	movl	%eax, %eax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	movq	(%rsp), %r13
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %r13
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
