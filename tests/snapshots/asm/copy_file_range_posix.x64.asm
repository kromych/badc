
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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x8(%rsp)
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, (%rsp)
               	movq	0x8(%rsp), %r10
               	testq	%r10, %r10
               	je	<addr>
               	movq	(%rsp), %r10
               	testq	%r10, %r10
               	jne	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	<rip>, %rdi # <addr>
               	movl	$0x1, %esi
               	movl	$0x10, %edx
               	movq	0x8(%rsp), %rcx
               	callq	<addr>
               	cmpq	$0x10, %rax
               	je	<addr>
               	movq	$-0x1, %r10
               	movq	%r10, 0x10(%rsp)
               	movq	(%rsp), %rdi
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x10(%rsp), %rax
               	testl	%eax, %eax
               	jl	<addr>
               	movq	0x18(%rsp), %rax
               	testl	%eax, %eax
               	jge	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movq	$0x4, -0x28(%rbp)
               	xorl	%r9d, %r9d
               	movq	%r9, -0x20(%rbp)
               	leaq	-0x28(%rbp), %rsi
               	leaq	-0x20(%rbp), %rcx
               	movl	$0x8, %r8d
               	movq	0x10(%rsp), %rdi
               	movq	0x18(%rsp), %rdx
               	callq	<addr>
               	cmpq	$0x8, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movq	-0x28(%rbp), %rax
               	cmpq	$0xc, %rax
               	jne	<addr>
               	movq	-0x20(%rbp), %rax
               	cmpq	$0x8, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	xorl	%esi, %esi
               	movl	$0x1, %edx
               	movq	0x10(%rsp), %rdi
               	callq	<addr>
               	cmpq	$0x10, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	xorl	%esi, %esi
               	movl	$0x1, %edx
               	movq	0x18(%rsp), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	xorl	%esi, %esi
               	movq	%rsi, %rdx
               	movq	0x18(%rsp), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	leaq	-0x18(%rbp), %rsi
               	movl	$0x8, %edx
               	movq	0x18(%rsp), %rdi
               	callq	<addr>
               	cmpq	$0x8, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	leaq	-0x18(%rbp), %rdi
               	leaq	<rip>, %rax # <addr>
               	leaq	0x4(%rax), %rsi
               	movl	$0x8, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	movl	$0x2, %esi
               	xorl	%edx, %edx
               	movq	0x10(%rsp), %rdi
               	callq	<addr>
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	movl	$0x8, %esi
               	xorl	%edx, %edx
               	movq	0x18(%rsp), %rdi
               	callq	<addr>
               	cmpq	$0x8, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	xorl	%esi, %esi
               	movl	$0x4, %r8d
               	movq	%rsi, %rcx
               	movq	%rsi, %r9
               	movq	0x10(%rsp), %rdi
               	movq	0x18(%rsp), %rdx
               	callq	<addr>
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	xorl	%esi, %esi
               	movl	$0x1, %edx
               	movq	0x10(%rsp), %rdi
               	callq	<addr>
               	cmpq	$0x6, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	xorl	%esi, %esi
               	movl	$0x1, %edx
               	movq	0x18(%rsp), %rdi
               	callq	<addr>
               	cmpq	$0xc, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	leave
               	retq
               	movl	$0x8, %esi
               	xorl	%edx, %edx
               	movq	0x18(%rsp), %rdi
               	callq	<addr>
               	cmpq	$0x8, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	leave
               	retq
               	leaq	-0x18(%rbp), %rsi
               	movl	$0x4, %edx
               	movq	0x18(%rsp), %rdi
               	callq	<addr>
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	leave
               	retq
               	leaq	-0x18(%rbp), %rdi
               	leaq	<rip>, %rax # <addr>
               	leaq	0x2(%rax), %rsi
               	movl	$0x4, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x11, %eax
               	leave
               	retq
               	movq	$0xd, -0x28(%rbp)
               	xorl	%r9d, %r9d
               	movq	%r9, -0x20(%rbp)
               	leaq	-0x28(%rbp), %rsi
               	leaq	-0x20(%rbp), %rcx
               	movl	$0x40, %r8d
               	movq	0x10(%rsp), %rdi
               	movq	0x18(%rsp), %rdx
               	callq	<addr>
               	cmpq	$0x3, %rax
               	jne	<addr>
               	movq	-0x28(%rbp), %rax
               	cmpq	$0x10, %rax
               	jne	<addr>
               	movq	-0x20(%rbp), %rax
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x12, %eax
               	leave
               	retq
               	movq	$0x10, -0x28(%rbp)
               	xorl	%r9d, %r9d
               	movq	%r9, -0x20(%rbp)
               	leaq	-0x28(%rbp), %rsi
               	leaq	-0x20(%rbp), %rcx
               	movl	$0x40, %r8d
               	movq	0x10(%rsp), %rdi
               	movq	0x18(%rsp), %rdx
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x13, %eax
               	leave
               	retq
               	movq	-0x28(%rbp), %rax
               	cmpq	$0x10, %rax
               	jne	<addr>
               	cmpq	$0x0, -0x20(%rbp)
               	je	<addr>
               	movl	$0x14, %eax
               	leave
               	retq
               	movq	$0x5, -0x28(%rbp)
               	movq	$0x5, -0x20(%rbp)
               	leaq	-0x28(%rbp), %rsi
               	leaq	-0x20(%rbp), %rcx
               	xorl	%r8d, %r8d
               	movq	%r8, %r9
               	movq	0x10(%rsp), %rdi
               	movq	0x18(%rsp), %rdx
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x15, %eax
               	leave
               	retq
               	movq	-0x28(%rbp), %rax
               	cmpq	$0x5, %rax
               	jne	<addr>
               	movq	-0x20(%rbp), %rax
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x16, %eax
               	leave
               	retq
               	movq	0x8(%rsp), %rdi
               	callq	<addr>
               	movq	(%rsp), %rdi
               	callq	<addr>
               	xorl	%eax, %eax
               	leave
               	retq
               	movq	0x8(%rsp), %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movq	$-0x1, %r10
               	movq	%r10, 0x10(%rsp)
               	jmp	<addr>
               	movq	0x8(%rsp), %rdi
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x10(%rsp)
               	jmp	<addr>
