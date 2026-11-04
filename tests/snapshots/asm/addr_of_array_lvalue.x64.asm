
addr_of_array_lvalue.x64:	file format elf64-x86-64

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
               	leaq	-0x30(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movups	0x20(%rcx), %xmm14
               	movups	%xmm14, 0x20(%rax)
               	addq	$0xc, %rax
               	movq	%rax, -0x8(%rbp)
               	movl	$0x2a, <rip> # <addr>
               	movl	$0x7, <rip> # <addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x4, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x4, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x2a, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x2a, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movl	-0x28(%rbp), %eax
               	cmpl	$0x3, %eax
               	jne	<addr>
               	movl	-0x2c(%rbp), %eax
               	cmpl	$0x2, %eax
               	jne	<addr>
               	movl	-0x10(%rbp), %eax
               	cmpl	$0x6, %eax
               	jne	<addr>
               	movl	-0x18(%rbp), %eax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	movq	-0x8(%rbp), %rax
               	movl	0x10(%rax), %eax
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	movq	<rip>, %rax # <addr>
               	movl	0x8(%rax), %eax
               	cmpl	$0x3, %eax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movl	0xc(%rax), %eax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	movq	<rip>, %rax # <addr>
               	movl	0xc(%rax), %eax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	movq	<rip>, %rax # <addr>
               	movl	0x5c(%rax), %eax
               	cmpl	$0x2a, %eax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movl	0x2c(%rax), %eax
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	leaq	0x8(%rcx), %rax
               	subq	%rcx, %rax
               	movq	%rax, %rcx
               	sarq	$0x3f, %rcx
               	shrq	$0x3d, %rcx
               	addq	%rax, %rcx
               	sarq	$0x3, %rcx
               	cmpq	$0x1, %rcx
               	jne	<addr>
               	cmpq	$0x8, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	leave
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x4, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0xf, %eax
               	leave
               	retq
               	leaq	-0x40(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movl	0x8(%rcx), %r10d
               	movl	%r10d, 0x8(%rax)
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0x12, %eax
               	leave
               	retq
               	leaq	<rip>, %rax # <addr>
               	leaq	0x8(%rax), %rcx
               	movl	0x4(%rcx), %edx
               	cmpl	$0x4, %edx
               	jne	<addr>
               	subq	%rax, %rcx
               	leaq	0xf(%rcx), %rdx
               	andq	$-0x10, %rdx
               	cmpq	$0x10, %rdx
               	jne	<addr>
               	movq	%rcx, %rdx
               	sarq	$0x3f, %rdx
               	shrq	$0x3e, %rdx
               	addq	%rdx, %rcx
               	sarq	$0x2, %rcx
               	addq	$0x3, %rcx
               	andq	$-0x4, %rcx
               	cmpq	$0x4, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx # <addr>
               	movl	<rip>, %edx # <addr>
               	movq	<rip>, %rsi # <addr>
               	movl	(%rsi), %esi
               	addq	%rsi, %rdx
               	cmpl	$0x3, %edx
               	je	<addr>
               	movl	$0x1a, %eax
               	leave
               	retq
               	movq	%rcx, -0x48(%rbp)
               	movq	%rax, -0x38(%rbp)
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x2a, %eax
               	jne	<addr>
               	xorl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
               	movl	$0x17, %eax
               	jmp	<addr>
               	movl	$0x1b, %eax
               	leave
               	retq
               	movl	$0x13, %eax
               	leave
               	retq
               	movl	$0x6, %eax
               	leave
               	retq
