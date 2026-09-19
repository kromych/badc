
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
               	subq	$0x8, %rsp
               	pushq	%rbx
               	movq	%rdi, %rbx
               	leaq	<rip>, %rdi
               	movl	$0x1, %esi
               	movl	$0x10, %edx
               	movq	%rbx, %rcx
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x10, %rax
               	je	<addr>
               	movq	$-0x1, %rax
               	popq	%rbx
               	leave
               	retq
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movq	$-0x1, %rax
               	popq	%rbx
               	leave
               	retq
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	popq	%rbx
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r13
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r14
               	testq	%r13, %r13
               	je	<addr>
               	testq	%r14, %r14
               	jne	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movq	%r13, %rdi
               	callq	<addr>
               	movq	%rax, %r12
               	movq	%r14, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rbx
               	testl	%r12d, %r12d
               	jl	<addr>
               	testl	%ebx, %ebx
               	jge	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movl	$0x4, %eax
               	movq	%rax, -0x10(%rbp)
               	xorl	%r9d, %r9d
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
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movq	-0x10(%rbp), %rax
               	cmpq	$0xc, %rax
               	jne	<addr>
               	movq	-0x8(%rbp), %rax
               	cmpq	$0x8, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movslq	%r12d, %rdi
               	xorl	%esi, %esi
               	movl	$0x1, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x10, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movslq	%ebx, %rdi
               	xorl	%esi, %esi
               	movl	$0x1, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movslq	%ebx, %rdi
               	xorl	%esi, %esi
               	movq	%rsi, %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movslq	%ebx, %rdi
               	leaq	-0x28(%rbp), %rsi
               	movl	$0x8, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x8, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
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
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movslq	%r12d, %rdi
               	movl	$0x2, %esi
               	xorl	%edx, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movslq	%ebx, %rdi
               	movl	$0x8, %esi
               	xorl	%edx, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x8, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movslq	%r12d, %rdi
               	xorl	%esi, %esi
               	movslq	%ebx, %rdx
               	movl	$0x4, %r8d
               	movq	%rsi, %rcx
               	movq	%rsi, %r9
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movslq	%r12d, %rdi
               	xorl	%esi, %esi
               	movl	$0x1, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x6, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movslq	%ebx, %rdi
               	xorl	%esi, %esi
               	movl	$0x1, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0xc, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movslq	%ebx, %rdi
               	movl	$0x8, %esi
               	xorl	%edx, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x8, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movslq	%ebx, %rdi
               	leaq	-0x28(%rbp), %rsi
               	movl	$0x4, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
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
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movl	$0xd, %eax
               	movq	%rax, -0x10(%rbp)
               	xorl	%r9d, %r9d
               	movq	%r9, -0x8(%rbp)
               	movslq	%r12d, %rdi
               	leaq	-0x10(%rbp), %rsi
               	movslq	%ebx, %rdx
               	leaq	-0x8(%rbp), %rcx
               	movl	$0x40, %r8d
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x3, %rax
               	jne	<addr>
               	movq	-0x10(%rbp), %rax
               	cmpq	$0x10, %rax
               	jne	<addr>
               	movq	-0x8(%rbp), %rax
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x12, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movl	$0x10, %eax
               	movq	%rax, -0x10(%rbp)
               	xorl	%r9d, %r9d
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
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movq	-0x10(%rbp), %rax
               	cmpq	$0x10, %rax
               	jne	<addr>
               	movq	-0x8(%rbp), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x14, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movl	$0x5, %eax
               	movq	%rax, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	movslq	%r12d, %rdi
               	leaq	-0x10(%rbp), %rsi
               	movslq	%ebx, %rdx
               	leaq	-0x8(%rbp), %rcx
               	xorl	%r8d, %r8d
               	movq	%r8, %r9
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x15, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movq	-0x10(%rbp), %rax
               	cmpq	$0x5, %rax
               	jne	<addr>
               	movq	-0x8(%rbp), %rax
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x16, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movq	%r13, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%r14, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
