
copy_file_range_posix.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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
               	subq	$0x58, %rsp
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x8(%rsp)
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, (%rsp)
               	cmpq	$0x0, 0x8(%rsp)
               	je	<addr>
               	cmpq	$0x0, (%rsp)
               	jne	<addr>
               	movl	$0x1, %eax
               	addq	$0x58, %rsp
               	retq
               	leaq	<rip>, %rdi # <addr>
               	movl	$0x1, %esi
               	movl	$0x10, %edx
               	movq	0x8(%rsp), %rcx
               	callq	<addr>
               	cmpq	$0x10, %rax
               	je	<addr>
               	movq	$-0x1, %r10
               	movq	%r10, 0x18(%rsp)
               	movq	(%rsp), %rdi
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x18(%rsp), %rax
               	testl	%eax, %eax
               	jl	<addr>
               	movq	0x10(%rsp), %rax
               	testl	%eax, %eax
               	jge	<addr>
               	movl	$0x2, %eax
               	addq	$0x58, %rsp
               	retq
               	movq	$0x4, 0x28(%rsp)
               	xorl	%r9d, %r9d
               	movq	%r9, 0x30(%rsp)
               	movq	0x18(%rsp), %rdi
               	leaq	0x28(%rsp), %rsi
               	movq	0x10(%rsp), %rdx
               	leaq	0x30(%rsp), %rcx
               	movl	$0x8, %r8d
               	callq	<addr>
               	cmpq	$0x8, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x58, %rsp
               	retq
               	movq	0x28(%rsp), %rax
               	cmpq	$0xc, %rax
               	jne	<addr>
               	movq	0x30(%rsp), %rax
               	cmpq	$0x8, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x58, %rsp
               	retq
               	movq	0x18(%rsp), %rdi
               	xorl	%esi, %esi
               	movl	$0x1, %edx
               	callq	<addr>
               	cmpq	$0x10, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x58, %rsp
               	retq
               	movq	0x10(%rsp), %rdi
               	xorl	%esi, %esi
               	movl	$0x1, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x58, %rsp
               	retq
               	movq	0x10(%rsp), %rdi
               	xorl	%esi, %esi
               	xorl	%edx, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x58, %rsp
               	retq
               	movq	0x10(%rsp), %rdi
               	leaq	0x38(%rsp), %rsi
               	movl	$0x8, %edx
               	callq	<addr>
               	cmpq	$0x8, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x58, %rsp
               	retq
               	leaq	<rip>, %rax # <addr>
               	leaq	0x4(%rax), %rsi
               	leaq	0x38(%rsp), %rdi
               	movl	$0x8, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x58, %rsp
               	retq
               	movq	0x18(%rsp), %rdi
               	movl	$0x2, %esi
               	xorl	%edx, %edx
               	callq	<addr>
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0x58, %rsp
               	retq
               	movq	0x10(%rsp), %rdi
               	movl	$0x8, %esi
               	xorl	%edx, %edx
               	callq	<addr>
               	cmpq	$0x8, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x58, %rsp
               	retq
               	movq	0x18(%rsp), %rdi
               	xorl	%esi, %esi
               	movq	0x10(%rsp), %rdx
               	xorl	%ecx, %ecx
               	movl	$0x4, %r8d
               	xorl	%r9d, %r9d
               	callq	<addr>
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x58, %rsp
               	retq
               	movq	0x18(%rsp), %rdi
               	xorl	%esi, %esi
               	movl	$0x1, %edx
               	callq	<addr>
               	cmpq	$0x6, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x58, %rsp
               	retq
               	movq	0x10(%rsp), %rdi
               	xorl	%esi, %esi
               	movl	$0x1, %edx
               	callq	<addr>
               	cmpq	$0xc, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	addq	$0x58, %rsp
               	retq
               	movq	0x10(%rsp), %rdi
               	movl	$0x8, %esi
               	xorl	%edx, %edx
               	callq	<addr>
               	cmpq	$0x8, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	addq	$0x58, %rsp
               	retq
               	movq	0x10(%rsp), %rdi
               	leaq	0x38(%rsp), %rsi
               	movl	$0x4, %edx
               	callq	<addr>
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	addq	$0x58, %rsp
               	retq
               	leaq	<rip>, %rax # <addr>
               	leaq	0x2(%rax), %rsi
               	leaq	0x38(%rsp), %rdi
               	movl	$0x4, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x11, %eax
               	addq	$0x58, %rsp
               	retq
               	movq	$0xd, 0x28(%rsp)
               	xorl	%r9d, %r9d
               	movq	%r9, 0x30(%rsp)
               	movq	0x18(%rsp), %rdi
               	leaq	0x28(%rsp), %rsi
               	movq	0x10(%rsp), %rdx
               	leaq	0x30(%rsp), %rcx
               	movl	$0x40, %r8d
               	callq	<addr>
               	cmpq	$0x3, %rax
               	jne	<addr>
               	movq	0x28(%rsp), %rax
               	cmpq	$0x10, %rax
               	jne	<addr>
               	movq	0x30(%rsp), %rax
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x12, %eax
               	addq	$0x58, %rsp
               	retq
               	movq	$0x10, 0x28(%rsp)
               	xorl	%r9d, %r9d
               	movq	%r9, 0x30(%rsp)
               	movq	0x18(%rsp), %rdi
               	leaq	0x28(%rsp), %rsi
               	movq	0x10(%rsp), %rdx
               	leaq	0x30(%rsp), %rcx
               	movl	$0x40, %r8d
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x13, %eax
               	addq	$0x58, %rsp
               	retq
               	movq	0x28(%rsp), %rax
               	cmpq	$0x10, %rax
               	jne	<addr>
               	cmpq	$0x0, 0x30(%rsp)
               	je	<addr>
               	movl	$0x14, %eax
               	addq	$0x58, %rsp
               	retq
               	movq	$0x5, 0x28(%rsp)
               	movq	$0x5, 0x30(%rsp)
               	movq	0x18(%rsp), %rdi
               	leaq	0x28(%rsp), %rsi
               	movq	0x10(%rsp), %rdx
               	leaq	0x30(%rsp), %rcx
               	xorl	%r8d, %r8d
               	xorl	%r9d, %r9d
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x15, %eax
               	addq	$0x58, %rsp
               	retq
               	movq	0x28(%rsp), %rax
               	cmpq	$0x5, %rax
               	jne	<addr>
               	movq	0x30(%rsp), %rax
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x16, %eax
               	addq	$0x58, %rsp
               	retq
               	movq	0x8(%rsp), %rdi
               	callq	<addr>
               	movq	(%rsp), %rdi
               	callq	<addr>
               	xorl	%eax, %eax
               	addq	$0x58, %rsp
               	retq
               	movq	0x8(%rsp), %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movq	$-0x1, %r10
               	movq	%r10, 0x18(%rsp)
               	jmp	<addr>
               	movq	0x8(%rsp), %rdi
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x18(%rsp)
               	jmp	<addr>
