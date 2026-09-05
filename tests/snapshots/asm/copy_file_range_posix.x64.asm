
copy_file_range_posix.x64:	file format elf64-x86-64

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

<fill>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movq	%rdi, %rbx
               	leaq	<rip>, %rdi
               	movl	$0x1, %esi
               	movl	$0x10, %edx
               	movq	%rbx, %rcx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x10, %rax
               	je	<addr>
               	movabsq	$-0x1, %rax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movabsq	$-0x1, %rax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r13
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r14
               	testq	%r13, %r13
               	sete	%al
               	movzbq	%al, %rax
               	testq	%r13, %r13
               	je	<addr>
               	testq	%r14, %r14
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	movq	%r13, %rdi
               	callq	<addr>
               	movq	%rax, %r12
               	movq	%r14, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %rbx
               	testl	%r12d, %r12d
               	setl	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	testl	%ebx, %ebx
               	setl	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	movl	$0x4, %eax
               	movq	%rax, -0x10(%rbp)
               	xorq	%r9, %r9
               	movq	%r9, -0x8(%rbp)
               	movslq	%r12d, %rdi
               	leaq	-0x10(%rbp), %rsi
               	movslq	%ebx, %rdx
               	leaq	-0x8(%rbp), %rcx
               	movl	$0x8, %r8d
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x8, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	movq	-0x10(%rbp), %rax
               	cmpq	$0xc, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	-0x8(%rbp), %rax
               	cmpq	$0x8, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	movslq	%r12d, %rdi
               	xorq	%rsi, %rsi
               	movl	$0x1, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x10, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	movslq	%ebx, %rdi
               	xorq	%rsi, %rsi
               	movl	$0x1, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	movslq	%ebx, %rdi
               	xorq	%rsi, %rsi
               	movq	%rsi, %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	movslq	%ebx, %rdi
               	leaq	-0x28(%rbp), %rsi
               	movl	$0x8, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x8, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	leaq	-0x28(%rbp), %rdi
               	leaq	<rip>, %rax
               	leaq	0x4(%rax), %rsi
               	movl	$0x8, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	movslq	%r12d, %rdi
               	movl	$0x2, %esi
               	xorq	%rdx, %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	movslq	%ebx, %rdi
               	movl	$0x8, %esi
               	xorq	%rdx, %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x8, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	movslq	%r12d, %rdi
               	xorq	%rsi, %rsi
               	movslq	%ebx, %rdx
               	movl	$0x4, %r8d
               	movq	%rsi, %rcx
               	movq	%rsi, %r9
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	movslq	%r12d, %rdi
               	xorq	%rsi, %rsi
               	movl	$0x1, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x6, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	movslq	%ebx, %rdi
               	xorq	%rsi, %rsi
               	movl	$0x1, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0xc, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	movslq	%ebx, %rdi
               	movl	$0x8, %esi
               	xorq	%rdx, %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x8, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	movslq	%ebx, %rdi
               	leaq	-0x28(%rbp), %rsi
               	movl	$0x4, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	leaq	-0x28(%rbp), %rdi
               	leaq	<rip>, %rax
               	leaq	0x2(%rax), %rsi
               	movl	$0x4, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x11, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	movl	$0xd, %eax
               	movq	%rax, -0x10(%rbp)
               	xorq	%r9, %r9
               	movq	%r9, -0x8(%rbp)
               	movslq	%r12d, %rdi
               	leaq	-0x10(%rbp), %rsi
               	movslq	%ebx, %rdx
               	leaq	-0x8(%rbp), %rcx
               	movl	$0x40, %r8d
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x3, %rax
               	movl	$0x1, %eax
               	jne	<addr>
               	movq	-0x10(%rbp), %rax
               	cmpq	$0x10, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	-0x8(%rbp), %rax
               	cmpq	$0x3, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x12, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	movl	$0x10, %eax
               	movq	%rax, -0x10(%rbp)
               	xorq	%r9, %r9
               	movq	%r9, -0x8(%rbp)
               	movslq	%r12d, %rdi
               	leaq	-0x10(%rbp), %rsi
               	movslq	%ebx, %rdx
               	leaq	-0x8(%rbp), %rcx
               	movl	$0x40, %r8d
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x13, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	movq	-0x10(%rbp), %rax
               	cmpq	$0x10, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	-0x8(%rbp), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x14, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	movl	$0x5, %eax
               	movq	%rax, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	movslq	%r12d, %rdi
               	leaq	-0x10(%rbp), %rsi
               	movslq	%ebx, %rdx
               	leaq	-0x8(%rbp), %rcx
               	xorq	%r8, %r8
               	movq	%r8, %r9
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x15, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	movq	-0x10(%rbp), %rax
               	cmpq	$0x5, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	-0x8(%rbp), %rax
               	cmpq	$0x5, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x16, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	movq	%r13, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%r14, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
