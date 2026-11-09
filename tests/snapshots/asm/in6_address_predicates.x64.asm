
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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movb	$0x0, -0x10(%rbp)
               	movb	$0x0, -0xf(%rbp)
               	movb	$0x0, -0xe(%rbp)
               	movb	$0x0, -0xd(%rbp)
               	movb	$0x0, -0xc(%rbp)
               	movb	$0x0, -0xb(%rbp)
               	movb	$0x0, -0xa(%rbp)
               	movb	$0x0, -0x9(%rbp)
               	movb	$0x0, -0x8(%rbp)
               	movb	$0x0, -0x7(%rbp)
               	movb	$0x0, -0x6(%rbp)
               	movb	$0x0, -0x5(%rbp)
               	movb	$0x0, -0x4(%rbp)
               	movb	$0x0, -0x3(%rbp)
               	movb	$0x0, -0x2(%rbp)
               	movb	$0x0, -0x1(%rbp)
               	andq	$0xff, %rdi
               	movb	%dil, -0x10(%rbp)
               	andq	$0xff, %rsi
               	movb	%sil, -0xf(%rbp)
               	andq	$0xff, %rdx
               	movb	%dl, -0x6(%rbp)
               	andq	$0xff, %rcx
               	movb	%cl, -0x5(%rbp)
               	andq	$0xff, %r8
               	movb	%r8b, -0x1(%rbp)
               	leaq	-0x10(%rbp), %rax
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xd8, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	xorl	%edi, %edi
               	movq	%rdi, %rsi
               	movq	%rdi, %r8
               	movq	%rdi, %rcx
               	movq	%rdi, %rdx
               	callq	<addr>
               	movq	%rax, -0x50(%rbp)
               	movq	%rdx, -0x48(%rbp)
               	xorl	%edi, %edi
               	movl	$0x1, %r8d
               	movq	%rdi, %rsi
               	movq	%rdi, %rcx
               	movq	%rdi, %rdx
               	callq	<addr>
               	movq	%rax, -0x40(%rbp)
               	movq	%rdx, -0x38(%rbp)
               	movl	$0xfe, %edi
               	movl	$0x80, %esi
               	xorl	%edx, %edx
               	movl	$0x1, %r8d
               	movq	%rdx, %rcx
               	callq	<addr>
               	movq	%rax, -0x30(%rbp)
               	movq	%rdx, -0x28(%rbp)
               	movl	$0xfe, %edi
               	movl	$0xc0, %esi
               	xorl	%edx, %edx
               	movl	$0x1, %r8d
               	movq	%rdx, %rcx
               	callq	<addr>
               	movq	%rax, -0x20(%rbp)
               	movq	%rdx, -0x18(%rbp)
               	xorl	%edi, %edi
               	movl	$0xff, %edx
               	movl	$0x1, %r8d
               	movq	%rdi, %rsi
               	movq	%rdx, %rcx
               	callq	<addr>
               	movq	%rax, -0x10(%rbp)
               	movq	%rdx, -0x8(%rbp)
               	movl	-0x10(%rbp), %r15d
               	movl	-0xc(%rbp), %r10d
               	movq	%r10, 0xa8(%rsp)
               	movzbq	-0x8(%rbp), %r10
               	movq	%r10, 0xa0(%rsp)
               	movzbq	-0x7(%rbp), %r10
               	movq	%r10, 0x98(%rsp)
               	movzbq	-0x6(%rbp), %r10
               	movq	%r10, 0x90(%rsp)
               	movzbq	-0x5(%rbp), %r10
               	movq	%r10, 0x88(%rsp)
               	xorl	%edi, %edi
               	movl	$0x2, %r8d
               	movq	%rdi, %rsi
               	movq	%rdi, %rcx
               	movq	%rdi, %rdx
               	callq	<addr>
               	movq	%rax, -0x10(%rbp)
               	movq	%rdx, -0x8(%rbp)
               	movl	-0x10(%rbp), %r10d
               	movq	%r10, 0x80(%rsp)
               	movl	-0xc(%rbp), %r10d
               	movq	%r10, 0x78(%rsp)
               	movl	-0x8(%rbp), %r10d
               	movq	%r10, 0x70(%rsp)
               	movl	-0x4(%rbp), %r10d
               	movq	%r10, 0x68(%rsp)
               	movl	$0xff, %edi
               	movl	$0x1, %esi
               	xorl	%edx, %edx
               	movq	%rdx, %rcx
               	movq	%rsi, %r8
               	callq	<addr>
               	movq	%rax, -0x10(%rbp)
               	movq	%rdx, -0x8(%rbp)
               	movzbq	-0x10(%rbp), %r10
               	movq	%r10, 0x60(%rsp)
               	movzbq	-0xf(%rbp), %rbx
               	movl	$0xff, %edi
               	movl	$0x2, %esi
               	xorl	%edx, %edx
               	movl	$0x1, %r8d
               	movq	%rdx, %rcx
               	callq	<addr>
               	movq	%rax, -0x10(%rbp)
               	movq	%rdx, -0x8(%rbp)
               	movzbq	-0x10(%rbp), %r10
               	movq	%r10, 0x58(%rsp)
               	movzbq	-0xf(%rbp), %r10
               	movq	%r10, 0x50(%rsp)
               	movl	$0xff, %edi
               	movl	$0x5, %esi
               	xorl	%edx, %edx
               	movl	$0x1, %r8d
               	movq	%rdx, %rcx
               	callq	<addr>
               	movq	%rax, -0x10(%rbp)
               	movq	%rdx, -0x8(%rbp)
               	movzbq	-0x10(%rbp), %r10
               	movq	%r10, 0x48(%rsp)
               	movzbq	-0xf(%rbp), %r12
               	movl	$0xff, %edi
               	movl	$0x8, %esi
               	xorl	%edx, %edx
               	movl	$0x1, %r8d
               	movq	%rdx, %rcx
               	callq	<addr>
               	movq	%rax, -0x10(%rbp)
               	movq	%rdx, -0x8(%rbp)
               	movzbq	-0x10(%rbp), %r10
               	movq	%r10, 0x40(%rsp)
               	movzbq	-0xf(%rbp), %r13
               	movl	$0xff, %edi
               	movl	$0xe, %esi
               	xorl	%edx, %edx
               	movl	$0x1, %r8d
               	movq	%rdx, %rcx
               	callq	<addr>
               	movq	%rax, -0x10(%rbp)
               	movq	%rdx, -0x8(%rbp)
               	movzbq	-0x10(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movzbq	-0xf(%rbp), %r14
               	cmpl	$0x0, -0x50(%rbp)
               	jne	<addr>
               	cmpl	$0x0, -0x4c(%rbp)
               	jne	<addr>
               	cmpl	$0x0, -0x48(%rbp)
               	jne	<addr>
               	cmpl	$0x0, -0x44(%rbp)
               	jne	<addr>
               	cmpl	$0x0, -0x40(%rbp)
               	jne	<addr>
               	cmpl	$0x0, -0x3c(%rbp)
               	jne	<addr>
               	cmpl	$0x0, -0x38(%rbp)
               	jne	<addr>
               	cmpl	$0x0, -0x34(%rbp)
               	jne	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	cmpl	$0x0, -0x40(%rbp)
               	jne	<addr>
               	cmpl	$0x0, -0x3c(%rbp)
               	jne	<addr>
               	cmpl	$0x0, -0x38(%rbp)
               	jne	<addr>
               	cmpb	$0x0, -0x34(%rbp)
               	jne	<addr>
               	cmpb	$0x0, -0x33(%rbp)
               	jne	<addr>
               	cmpb	$0x0, -0x32(%rbp)
               	jne	<addr>
               	movzbq	-0x31(%rbp), %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	cmpl	$0x0, -0x50(%rbp)
               	jne	<addr>
               	cmpl	$0x0, -0x4c(%rbp)
               	jne	<addr>
               	cmpl	$0x0, -0x48(%rbp)
               	jne	<addr>
               	cmpb	$0x0, -0x44(%rbp)
               	jne	<addr>
               	cmpb	$0x0, -0x43(%rbp)
               	jne	<addr>
               	cmpb	$0x0, -0x42(%rbp)
               	jne	<addr>
               	movzbq	-0x41(%rbp), %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movzbq	-0x30(%rbp), %rax
               	cmpl	$0xfe, %eax
               	jne	<addr>
               	movzbq	-0x2f(%rbp), %rax
               	andq	$0xc0, %rax
               	cmpl	$0x80, %eax
               	jne	<addr>
               	movzbq	-0x20(%rbp), %rax
               	cmpl	$0xfe, %eax
               	jne	<addr>
               	movzbq	-0x1f(%rbp), %rax
               	andq	$0xc0, %rax
               	cmpl	$0x80, %eax
               	jne	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movzbq	-0x20(%rbp), %rax
               	cmpl	$0xfe, %eax
               	jne	<addr>
               	movzbq	-0x1f(%rbp), %rax
               	andq	$0xc0, %rax
               	cmpl	$0xc0, %eax
               	jne	<addr>
               	movzbq	-0x30(%rbp), %rax
               	cmpl	$0xfe, %eax
               	jne	<addr>
               	movzbq	-0x2f(%rbp), %rax
               	andq	$0xc0, %rax
               	cmpl	$0xc0, %eax
               	jne	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	testl	%r15d, %r15d
               	jne	<addr>
               	movq	0xa8(%rsp), %r10
               	testl	%r10d, %r10d
               	jne	<addr>
               	movq	0xa0(%rsp), %r10
               	testl	%r10d, %r10d
               	jne	<addr>
               	movq	0x98(%rsp), %r10
               	testl	%r10d, %r10d
               	jne	<addr>
               	movq	0x90(%rsp), %rax
               	cmpl	$0xff, %eax
               	jne	<addr>
               	movq	0x88(%rsp), %rax
               	cmpl	$0xff, %eax
               	jne	<addr>
               	cmpl	$0x0, -0x40(%rbp)
               	jne	<addr>
               	cmpl	$0x0, -0x3c(%rbp)
               	jne	<addr>
               	cmpb	$0x0, -0x38(%rbp)
               	jne	<addr>
               	cmpb	$0x0, -0x37(%rbp)
               	jne	<addr>
               	movzbq	-0x36(%rbp), %rax
               	cmpl	$0xff, %eax
               	jne	<addr>
               	movzbq	-0x35(%rbp), %rax
               	cmpl	$0xff, %eax
               	jne	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movq	0x80(%rsp), %r10
               	testl	%r10d, %r10d
               	jne	<addr>
               	movq	0x78(%rsp), %r10
               	testl	%r10d, %r10d
               	jne	<addr>
               	movq	0x70(%rsp), %r10
               	testl	%r10d, %r10d
               	jne	<addr>
               	movq	0x68(%rsp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	%eax, %eax
               	cmpq	$0x1, %rax
               	jbe	<addr>
               	cmpl	$0x0, -0x40(%rbp)
               	jne	<addr>
               	cmpl	$0x0, -0x3c(%rbp)
               	jne	<addr>
               	cmpl	$0x0, -0x38(%rbp)
               	jne	<addr>
               	movl	-0x34(%rbp), %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	%eax, %eax
               	cmpq	$0x1, %rax
               	jbe	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movq	0x58(%rsp), %rax
               	cmpl	$0xff, %eax
               	jne	<addr>
               	movzbq	-0x30(%rbp), %rax
               	cmpl	$0xff, %eax
               	jne	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movq	0x60(%rsp), %rax
               	cmpl	$0xff, %eax
               	jne	<addr>
               	movq	%rbx, %rax
               	andq	$0xf, %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movq	0x50(%rsp), %rax
               	andq	$0xf, %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	cmpl	$0x2, %eax
               	jne	<addr>
               	movq	0x48(%rsp), %rax
               	xorq	$0xff, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movq	%r12, %rcx
               	andq	$0xf, %rcx
               	cmpl	$0x2, %ecx
               	jne	<addr>
               	movl	$0x9, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	testl	%eax, %eax
               	jne	<addr>
               	andq	$0xf, %r12
               	cmpl	$0x5, %r12d
               	jne	<addr>
               	movq	0x40(%rsp), %rax
               	xorq	$0xff, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movq	%r13, %rcx
               	andq	$0xf, %rcx
               	cmpl	$0x5, %ecx
               	jne	<addr>
               	movl	$0xa, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	testl	%eax, %eax
               	jne	<addr>
               	andq	$0xf, %r13
               	cmpl	$0x8, %r13d
               	jne	<addr>
               	movq	0x38(%rsp), %rax
               	xorq	$0xff, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movq	%r14, %rcx
               	andq	$0xf, %rcx
               	cmpl	$0x8, %ecx
               	jne	<addr>
               	movl	$0xb, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	testl	%eax, %eax
               	jne	<addr>
               	andq	$0xf, %r14
               	cmpl	$0xe, %r14d
               	jne	<addr>
               	andq	$0xf, %rbx
               	cmpl	$0xe, %ebx
               	jne	<addr>
               	movl	$0xc, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	-0x30(%rbp), %eax
               	movl	-0x20(%rbp), %ecx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movl	-0x2c(%rbp), %eax
               	movl	-0x1c(%rbp), %ecx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movl	-0x28(%rbp), %eax
               	movl	-0x18(%rbp), %ecx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movl	-0x24(%rbp), %eax
               	movl	-0x14(%rbp), %ecx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movl	$0xd, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
