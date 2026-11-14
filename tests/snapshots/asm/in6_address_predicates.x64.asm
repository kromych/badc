
in6_address_predicates.x64:	file format elf64-x86-64

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

<in6>:
               	movq	%rdi, %rax
               	andq	$0xff, %rax
               	andq	$0xff, %rsi
               	shlq	$0x8, %rsi
               	orq	%rsi, %rax
               	andq	$0xff, %rdx
               	shlq	$0x10, %rdx
               	andq	$0xff, %rcx
               	shlq	$0x18, %rcx
               	orq	%rdx, %rcx
               	movq	%r8, %rdx
               	shlq	$0x38, %rdx
               	orq	%rcx, %rdx
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x130, %rsp            # imm = 0x130
               	xorl	%edi, %edi
               	movq	%rdi, %rsi
               	movq	%rdi, %r8
               	movq	%rdi, %rcx
               	movq	%rdi, %rdx
               	callq	<addr>
               	movq	%rax, -0x10(%rbp)
               	movq	%rdx, -0x8(%rbp)
               	movl	-0x10(%rbp), %r10d
               	movq	%r10, 0xb0(%rsp)
               	movl	-0xc(%rbp), %r10d
               	movq	%r10, 0xa8(%rsp)
               	movl	-0x8(%rbp), %r10d
               	movq	%r10, 0xa0(%rsp)
               	movl	-0x4(%rbp), %r10d
               	movq	%r10, 0x118(%rsp)
               	xorl	%edi, %edi
               	movl	$0x1, %r8d
               	movq	%rdi, %rsi
               	movq	%rdi, %rcx
               	movq	%rdi, %rdx
               	callq	<addr>
               	movq	%rax, -0x10(%rbp)
               	movq	%rdx, -0x8(%rbp)
               	movl	-0x10(%rbp), %r10d
               	movq	%r10, 0xf8(%rsp)
               	movl	-0xc(%rbp), %r10d
               	movq	%r10, 0xf0(%rsp)
               	movl	-0x8(%rbp), %r10d
               	movq	%r10, 0xe8(%rsp)
               	movl	-0x4(%rbp), %r10d
               	movq	%r10, 0x110(%rsp)
               	movl	$0xfe, %edi
               	movl	$0x80, %esi
               	xorl	%edx, %edx
               	movl	$0x1, %r8d
               	movq	%rdx, %rcx
               	callq	<addr>
               	movq	%rax, -0x10(%rbp)
               	movq	%rdx, -0x8(%rbp)
               	movl	-0x10(%rbp), %r10d
               	movq	%r10, 0x108(%rsp)
               	movl	-0xc(%rbp), %r10d
               	movq	%r10, 0x98(%rsp)
               	movl	-0x8(%rbp), %r10d
               	movq	%r10, 0x90(%rsp)
               	movl	-0x4(%rbp), %r10d
               	movq	%r10, 0x88(%rsp)
               	movl	$0xfe, %edi
               	movl	$0xc0, %esi
               	xorl	%edx, %edx
               	movl	$0x1, %r8d
               	movq	%rdx, %rcx
               	callq	<addr>
               	movq	%rax, -0x10(%rbp)
               	movq	%rdx, -0x8(%rbp)
               	movl	-0x10(%rbp), %r10d
               	movq	%r10, 0x100(%rsp)
               	movl	-0xc(%rbp), %r10d
               	movq	%r10, 0x80(%rsp)
               	movl	-0x8(%rbp), %r10d
               	movq	%r10, 0x78(%rsp)
               	movl	-0x4(%rbp), %r10d
               	movq	%r10, 0x70(%rsp)
               	xorl	%edi, %edi
               	movl	$0xff, %edx
               	movl	$0x1, %r8d
               	movq	%rdi, %rsi
               	movq	%rdx, %rcx
               	callq	<addr>
               	movq	%rax, -0x10(%rbp)
               	movq	%rdx, -0x8(%rbp)
               	movl	-0x10(%rbp), %r10d
               	movq	%r10, 0x68(%rsp)
               	movl	-0xc(%rbp), %r10d
               	movq	%r10, 0x60(%rsp)
               	movzbq	-0x8(%rbp), %r10
               	movq	%r10, 0x58(%rsp)
               	movzbq	-0x7(%rbp), %r10
               	movq	%r10, 0x50(%rsp)
               	movzbq	-0x6(%rbp), %r10
               	movq	%r10, 0x48(%rsp)
               	movzbq	-0x5(%rbp), %r10
               	movq	%r10, 0x40(%rsp)
               	xorl	%edi, %edi
               	movl	$0x2, %r8d
               	movq	%rdi, %rsi
               	movq	%rdi, %rcx
               	movq	%rdi, %rdx
               	callq	<addr>
               	movq	%rax, -0x10(%rbp)
               	movq	%rdx, -0x8(%rbp)
               	movl	-0x10(%rbp), %r10d
               	movq	%r10, 0x38(%rsp)
               	movl	-0xc(%rbp), %r10d
               	movq	%r10, 0x30(%rsp)
               	movl	-0x8(%rbp), %r10d
               	movq	%r10, 0x28(%rsp)
               	movl	-0x4(%rbp), %r10d
               	movq	%r10, 0x20(%rsp)
               	movl	$0xff, %edi
               	movl	$0x1, %esi
               	xorl	%edx, %edx
               	movq	%rdx, %rcx
               	movq	%rsi, %r8
               	callq	<addr>
               	movq	%rax, -0x10(%rbp)
               	movq	%rdx, -0x8(%rbp)
               	movzbq	-0x10(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movzbq	-0xf(%rbp), %r10
               	movq	%r10, 0xe0(%rsp)
               	movl	$0xff, %edi
               	movl	$0x2, %esi
               	xorl	%edx, %edx
               	movl	$0x1, %r8d
               	movq	%rdx, %rcx
               	callq	<addr>
               	movq	%rax, -0x10(%rbp)
               	movq	%rdx, -0x8(%rbp)
               	movzbq	-0x10(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movzbq	-0xf(%rbp), %r10
               	movq	%r10, 0xd8(%rsp)
               	movl	$0xff, %edi
               	movl	$0x5, %esi
               	xorl	%edx, %edx
               	movl	$0x1, %r8d
               	movq	%rdx, %rcx
               	callq	<addr>
               	movq	%rax, -0x10(%rbp)
               	movq	%rdx, -0x8(%rbp)
               	movzbq	-0x10(%rbp), %r10
               	movq	%r10, 0xd0(%rsp)
               	movzbq	-0xf(%rbp), %r10
               	movq	%r10, 0xc8(%rsp)
               	movl	$0xff, %edi
               	movl	$0x8, %esi
               	xorl	%edx, %edx
               	movl	$0x1, %r8d
               	movq	%rdx, %rcx
               	callq	<addr>
               	movq	%rax, -0x10(%rbp)
               	movq	%rdx, -0x8(%rbp)
               	movzbq	-0x10(%rbp), %r10
               	movq	%r10, 0xc0(%rsp)
               	movzbq	-0xf(%rbp), %r10
               	movq	%r10, 0xb8(%rsp)
               	movl	$0xff, %edi
               	movl	$0xe, %esi
               	xorl	%edx, %edx
               	movl	$0x1, %r8d
               	movq	%rdx, %rcx
               	callq	<addr>
               	movq	%rax, -0x10(%rbp)
               	movq	%rdx, -0x8(%rbp)
               	movzbq	-0x10(%rbp), %rcx
               	movzbq	-0xf(%rbp), %rdx
               	movq	0xb0(%rsp), %r10
               	testl	%r10d, %r10d
               	jne	<addr>
               	movq	0xa8(%rsp), %r10
               	testl	%r10d, %r10d
               	jne	<addr>
               	movq	0xa0(%rsp), %r10
               	testl	%r10d, %r10d
               	jne	<addr>
               	movq	0x118(%rsp), %r10
               	testl	%r10d, %r10d
               	jne	<addr>
               	movq	0xf8(%rsp), %r10
               	testl	%r10d, %r10d
               	jne	<addr>
               	movq	0xf0(%rsp), %r10
               	testl	%r10d, %r10d
               	jne	<addr>
               	movq	0xe8(%rsp), %r10
               	testl	%r10d, %r10d
               	jne	<addr>
               	movq	0x110(%rsp), %r10
               	testl	%r10d, %r10d
               	jne	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movq	0xf8(%rsp), %r10
               	testl	%r10d, %r10d
               	jne	<addr>
               	movq	0xf0(%rsp), %r10
               	testl	%r10d, %r10d
               	jne	<addr>
               	movq	0xe8(%rsp), %r10
               	testl	%r10d, %r10d
               	jne	<addr>
               	movq	0x110(%rsp), %rax
               	testb	$-0x1, %al
               	jne	<addr>
               	movq	%rax, %rsi
               	shrq	$0x8, %rsi
               	testb	$-0x1, %sil
               	jne	<addr>
               	movq	%rax, %rsi
               	shrq	$0x10, %rsi
               	testb	$-0x1, %sil
               	jne	<addr>
               	shrq	$0x18, %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movq	0x118(%rsp), %rax
               	testb	$-0x1, %al
               	jne	<addr>
               	movq	0x118(%rsp), %rax
               	movq	%rax, %rsi
               	shrq	$0x8, %rsi
               	testb	$-0x1, %sil
               	jne	<addr>
               	movq	%rax, %rsi
               	shrq	$0x10, %rsi
               	testb	$-0x1, %sil
               	jne	<addr>
               	shrq	$0x18, %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movq	0x108(%rsp), %rax
               	movq	%rax, %rsi
               	andq	$0xff, %rsi
               	cmpl	$0xfe, %esi
               	jne	<addr>
               	shrq	$0x8, %rax
               	andq	$0xff, %rax
               	andq	$0xc0, %rax
               	cmpl	$0x80, %eax
               	jne	<addr>
               	movq	0x100(%rsp), %rax
               	movq	%rax, %rsi
               	andq	$0xff, %rsi
               	cmpl	$0xfe, %esi
               	jne	<addr>
               	shrq	$0x8, %rax
               	andq	$0xff, %rax
               	andq	$0xc0, %rax
               	cmpl	$0x80, %eax
               	jne	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movq	0x100(%rsp), %rax
               	movq	%rax, %rsi
               	andq	$0xff, %rsi
               	cmpl	$0xfe, %esi
               	jne	<addr>
               	shrq	$0x8, %rax
               	andq	$0xff, %rax
               	andq	$0xc0, %rax
               	cmpl	$0xc0, %eax
               	jne	<addr>
               	movq	0x108(%rsp), %rax
               	shrq	$0x8, %rax
               	andq	$0xff, %rax
               	andq	$0xc0, %rax
               	cmpl	$0xc0, %eax
               	jne	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movq	0x68(%rsp), %r10
               	testl	%r10d, %r10d
               	jne	<addr>
               	movq	0x60(%rsp), %r10
               	testl	%r10d, %r10d
               	jne	<addr>
               	movq	0x58(%rsp), %r10
               	testl	%r10d, %r10d
               	jne	<addr>
               	movq	0x50(%rsp), %r10
               	testl	%r10d, %r10d
               	jne	<addr>
               	movq	0x48(%rsp), %rax
               	cmpl	$0xff, %eax
               	jne	<addr>
               	movq	0x40(%rsp), %rax
               	cmpl	$0xff, %eax
               	jne	<addr>
               	movq	0x38(%rsp), %r10
               	testl	%r10d, %r10d
               	jne	<addr>
               	movq	0x30(%rsp), %r10
               	testl	%r10d, %r10d
               	jne	<addr>
               	movq	0x28(%rsp), %r10
               	testl	%r10d, %r10d
               	jne	<addr>
               	movq	%rcx, 0x8(%rsp)
               	movq	%rdx, (%rsp)
               	movq	0x20(%rsp), %rdi
               	callq	<addr>
               	movl	%eax, %eax
               	movq	0x8(%rsp), %rcx
               	movq	(%rsp), %rdx
               	cmpq	$0x1, %rax
               	jbe	<addr>
               	movq	%rcx, 0x8(%rsp)
               	movq	%rdx, (%rsp)
               	movq	0x110(%rsp), %rdi
               	callq	<addr>
               	movl	%eax, %eax
               	movq	0x8(%rsp), %rcx
               	movq	(%rsp), %rdx
               	cmpq	$0x1, %rax
               	jbe	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	movq	0x10(%rsp), %rax
               	cmpl	$0xff, %eax
               	jne	<addr>
               	movq	0x18(%rsp), %rax
               	cmpl	$0xff, %eax
               	jne	<addr>
               	movq	0xe0(%rsp), %rax
               	andq	$0xf, %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movq	0xd8(%rsp), %rax
               	andq	$0xf, %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	movq	0xd8(%rsp), %rax
               	andq	$0xf, %rax
               	cmpl	$0x2, %eax
               	jne	<addr>
               	movq	0xd0(%rsp), %rax
               	cmpl	$0xff, %eax
               	jne	<addr>
               	movq	0xc8(%rsp), %rax
               	andq	$0xf, %rax
               	cmpl	$0x2, %eax
               	jne	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	movq	0xd0(%rsp), %rax
               	cmpl	$0xff, %eax
               	jne	<addr>
               	movq	0xc8(%rsp), %rax
               	andq	$0xf, %rax
               	cmpl	$0x5, %eax
               	jne	<addr>
               	movq	0xc0(%rsp), %rax
               	cmpl	$0xff, %eax
               	jne	<addr>
               	movq	0xb8(%rsp), %rax
               	andq	$0xf, %rax
               	cmpl	$0x5, %eax
               	jne	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	movq	0xc0(%rsp), %rax
               	cmpl	$0xff, %eax
               	jne	<addr>
               	movq	0xb8(%rsp), %rax
               	andq	$0xf, %rax
               	cmpl	$0x8, %eax
               	jne	<addr>
               	cmpl	$0xff, %ecx
               	jne	<addr>
               	movq	%rdx, %rax
               	andq	$0xf, %rax
               	cmpl	$0x8, %eax
               	jne	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	cmpl	$0xff, %ecx
               	jne	<addr>
               	andq	$0xf, %rdx
               	cmpl	$0xe, %edx
               	jne	<addr>
               	movq	0xe0(%rsp), %rax
               	andq	$0xf, %rax
               	cmpl	$0xe, %eax
               	jne	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	movq	0x108(%rsp), %rax
               	cmpl	0x100(%rsp), %eax
               	jne	<addr>
               	movq	0x98(%rsp), %rax
               	cmpl	0x80(%rsp), %eax
               	jne	<addr>
               	movq	0x90(%rsp), %rax
               	cmpl	0x78(%rsp), %eax
               	jne	<addr>
               	movq	0x88(%rsp), %rax
               	cmpl	0x70(%rsp), %eax
               	jne	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
               	movl	$0x7, %eax
               	leave
               	retq
               	movl	$0x5, %eax
               	leave
               	retq
