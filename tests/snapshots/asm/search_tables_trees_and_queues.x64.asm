
search_tables_trees_and_queues.x64:	file format elf64-x86-64

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

<cmp>:
               	movl	(%rdi), %eax
               	movl	(%rsi), %ecx
               	subq	%rcx, %rax
               	retq

<collect>:
               	movq	%rsi, %rax
               	xorq	$0x1, %rax
               	testl	%eax, %eax
               	je	<addr>
               	xorq	$0x3, %rsi
               	testl	%esi, %esi
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	movl	(%rax), %ecx
               	cmpl	$0x8, %ecx
               	jge	<addr>
               	leaq	<rip>, %rdx # <addr>
               	movslq	(%rax), %rcx
               	leaq	0x1(%rcx), %rsi
               	movl	%esi, (%rax)
               	movq	(%rdi), %rax
               	movl	(%rax), %eax
               	movl	%eax, (%rdx,%rcx,4)
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xa0, %rsp
               	pushq	%r12
               	pushq	%rbx
               	movq	$0x0, -0x98(%rbp)
               	movl	$0x1e, -0x90(%rbp)
               	movl	$0x28, -0x88(%rbp)
               	leaq	-0x20(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movq	$0x3, -0x80(%rbp)
               	leaq	<rip>, %rdi # <addr>
               	leaq	-0x98(%rbp), %rsi
               	leaq	-<rip>, %rdx # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	(%rax), %rcx
               	leaq	<rip>, %rax # <addr>
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	0x4(%rax), %rdi
               	leaq	-0x98(%rbp), %rsi
               	leaq	-<rip>, %rdx # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	(%rax), %rcx
               	leaq	<rip>, %rax # <addr>
               	leaq	0x4(%rax), %rdx
               	cmpq	%rdx, %rcx
               	jne	<addr>
               	leaq	0x8(%rax), %rdi
               	leaq	-0x98(%rbp), %rsi
               	leaq	-<rip>, %rdx # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	(%rax), %rcx
               	leaq	<rip>, %rax # <addr>
               	leaq	0x8(%rax), %rdx
               	cmpq	%rdx, %rcx
               	jne	<addr>
               	leaq	0xc(%rax), %rdi
               	leaq	-0x98(%rbp), %rsi
               	leaq	-<rip>, %rdx # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	(%rax), %rcx
               	leaq	<rip>, %rax # <addr>
               	leaq	0xc(%rax), %rdx
               	cmpq	%rdx, %rcx
               	jne	<addr>
               	leaq	0x10(%rax), %rdi
               	leaq	-0x98(%rbp), %rsi
               	leaq	-<rip>, %rdx # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	(%rax), %rcx
               	leaq	<rip>, %rax # <addr>
               	leaq	0x10(%rax), %rdx
               	cmpq	%rdx, %rcx
               	jne	<addr>
               	leaq	0x14(%rax), %rdi
               	leaq	-0x98(%rbp), %rsi
               	leaq	-<rip>, %rdx # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	(%rax), %rcx
               	leaq	<rip>, %rax # <addr>
               	leaq	0x14(%rax), %rdx
               	cmpq	%rdx, %rcx
               	jne	<addr>
               	leaq	0x10(%rax), %rdi
               	leaq	-0x98(%rbp), %rsi
               	leaq	-<rip>, %rdx # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	(%rax), %rax
               	leaq	<rip>, %rcx # <addr>
               	addq	$0x10, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x90(%rbp), %rdi
               	leaq	-0x98(%rbp), %rsi
               	leaq	-<rip>, %rdx # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-0x88(%rbp), %rdi
               	leaq	-0x98(%rbp), %rsi
               	leaq	-<rip>, %rdx # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movq	-0x98(%rbp), %rdi
               	leaq	-<rip>, %rsi # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rax # <addr>
               	movl	(%rax), %eax
               	cmpl	$0x6, %eax
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	movl	(%rax), %ecx
               	cmpl	$0xa, %ecx
               	jne	<addr>
               	movl	0x8(%rax), %ecx
               	cmpl	$0x1e, %ecx
               	jne	<addr>
               	movl	0x14(%rax), %eax
               	cmpl	$0x46, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax # <addr>
               	leaq	0x4(%rax), %rdi
               	leaq	-0x98(%rbp), %rsi
               	leaq	-<rip>, %rdx # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x4(%rax), %rdi
               	leaq	-0x98(%rbp), %rsi
               	leaq	-<rip>, %rdx # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax # <addr>
               	movl	$0x0, (%rax)
               	movq	-0x98(%rbp), %rdi
               	leaq	-<rip>, %rsi # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rax # <addr>
               	movl	(%rax), %eax
               	cmpl	$0x5, %eax
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	movl	0x4(%rax), %eax
               	cmpl	$0x1e, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rdi # <addr>
               	leaq	-0x98(%rbp), %rsi
               	leaq	-<rip>, %rdx # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x4(%rax), %rdi
               	leaq	-0x98(%rbp), %rsi
               	leaq	-<rip>, %rdx # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x8(%rax), %rdi
               	leaq	-0x98(%rbp), %rsi
               	leaq	-<rip>, %rdx # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0xc(%rax), %rdi
               	leaq	-0x98(%rbp), %rsi
               	leaq	-<rip>, %rdx # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x10(%rax), %rdi
               	leaq	-0x98(%rbp), %rsi
               	leaq	-<rip>, %rdx # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x14(%rax), %rdi
               	leaq	-0x98(%rbp), %rsi
               	leaq	-<rip>, %rdx # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x0, -0x98(%rbp)
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x88(%rbp), %rdi
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0x80(%rbp), %rdx
               	movl	$0x4, %ecx
               	leaq	-<rip>, %r8 # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	(%rax), %eax
               	cmpl	$0x28, %eax
               	jne	<addr>
               	movq	-0x80(%rbp), %rax
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x20(%rbp), %rsi
               	movl	$0x4, %ecx
               	leaq	0x4(%rsi), %rdi
               	leaq	-0x80(%rbp), %rdx
               	leaq	-<rip>, %r8 # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x20(%rbp), %rsi
               	leaq	0x4(%rsi), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movq	-0x80(%rbp), %rax
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x88(%rbp), %rdi
               	leaq	-0x80(%rbp), %rdx
               	movl	$0x4, %ecx
               	leaq	-<rip>, %r8 # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x20(%rbp), %rcx
               	addq	$0xc, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x68(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movq	0x10(%rcx), %r10
               	movq	%r10, 0x10(%rax)
               	leaq	-0x50(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movq	0x10(%rcx), %r10
               	movq	%r10, 0x10(%rax)
               	leaq	-0x38(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movq	0x10(%rcx), %r10
               	movq	%r10, 0x10(%rax)
               	leaq	<rip>, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	<rip>, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r12
               	movl	$0x10, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xb, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x78(%rbp), %rdi
               	movq	%rbx, -0x78(%rbp)
               	leaq	<rip>, %rax # <addr>
               	movq	%rax, -0x70(%rbp)
               	movl	$0x1, %edx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xc, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x78(%rbp), %rdi
               	movq	%r12, -0x78(%rbp)
               	leaq	<rip>, %rax # <addr>
               	addq	$0x4, %rax
               	movq	%rax, -0x70(%rbp)
               	movl	$0x1, %edx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xd, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x78(%rbp), %rdi
               	leaq	<rip>, %rax
               	movq	%rax, -0x78(%rbp)
               	xorl	%edx, %edx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movq	0x8(%rax), %rax
               	leaq	<rip>, %rcx # <addr>
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x78(%rbp), %rdi
               	leaq	<rip>, %rax
               	movq	%rax, -0x78(%rbp)
               	xorl	%edx, %edx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x68(%rbp), %rdi
               	xorl	%esi, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x38(%rbp), %rdi
               	leaq	-0x68(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x50(%rbp), %rdi
               	leaq	-0x68(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x68(%rbp), %rax
               	movq	-0x68(%rbp), %rcx
               	leaq	-0x50(%rbp), %rdi
               	cmpq	%rdi, %rcx
               	jne	<addr>
               	movq	-0x50(%rbp), %rcx
               	leaq	-0x38(%rbp), %rdx
               	cmpq	%rdx, %rcx
               	jne	<addr>
               	movq	-0x30(%rbp), %rcx
               	cmpq	%rdi, %rcx
               	jne	<addr>
               	movq	-0x48(%rbp), %rcx
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x10, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x68(%rbp), %rax
               	movq	-0x68(%rbp), %rcx
               	leaq	-0x38(%rbp), %rdx
               	cmpq	%rdx, %rcx
               	jne	<addr>
               	movq	-0x30(%rbp), %rcx
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x11, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
