
stdatomic_c11.x64:	file format elf64-x86-64

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
               	subq	$0x40, %rsp
               	movl	$0x0, -0x38(%rbp)
               	leaq	-0x38(%rbp), %rcx
               	movl	$0x5, %edx
               	movl	%edx, (%rcx)
               	movl	(%rcx), %eax
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movl	$0xa, %eax
               	lock
               	xaddl	%eax, (%rcx)
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movl	(%rcx), %eax
               	cmpl	$0xf, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movl	$0xf, %eax
               	movl	$0x63, %esi
               	movl	%eax, %eax
               	lock
               	cmpxchgl	%esi, (%rcx)
               	cmpl	$0xf, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movl	(%rcx), %eax
               	cmpl	$0x63, %eax
               	je	<addr>
               	movq	%rdx, %rax
               	leave
               	retq
               	mfence
               	movq	$0x0, -0x30(%rbp)
               	leaq	-0x30(%rbp), %rax
               	movsd	<rip>, %xmm0
               	movsd	%xmm0, -0x8(%rbp)
               	movq	-0x8(%rbp), %rcx
               	movq	%rcx, (%rax)
               	movq	(%rax), %rax
               	movq	%rax, -0x8(%rbp)
               	movq	%rax, %xmm1
               	ucomisd	%xmm0, %xmm1
               	jp	<addr>
               	je	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	leaq	-0x28(%rbp), %rax
               	movss	<rip>, %xmm0
               	movss	%xmm0, -0x28(%rbp)
               	movl	(%rax), %ecx
               	movl	%ecx, -0x8(%rbp)
               	movss	-0x8(%rbp), %xmm1
               	ucomiss	%xmm0, %xmm1
               	jp	<addr>
               	je	<addr>
               	movl	$0xe, %eax
               	leave
               	retq
               	movss	<rip>, %xmm0
               	movss	%xmm0, -0x8(%rbp)
               	movl	-0x8(%rbp), %ecx
               	movq	%rcx, %r10
               	xchgl	%r10d, (%rax)
               	movl	(%rax), %eax
               	movl	%eax, -0x8(%rbp)
               	movss	-0x8(%rbp), %xmm1
               	ucomiss	%xmm0, %xmm1
               	jp	<addr>
               	je	<addr>
               	movl	$0xf, %eax
               	leave
               	retq
               	leaq	-0x20(%rbp), %rax
               	movb	$0x0, (%rax)
               	movl	$0x1, %ecx
               	movq	%rcx, %rdx
               	xchgb	%dl, (%rax)
               	movsbq	%dl, %rdx
               	testl	%edx, %edx
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	xorl	%edx, %edx
               	movq	%rdx, %r10
               	xchgb	%r10b, (%rax)
               	movl	%edx, -0x18(%rbp)
               	leaq	-0x18(%rbp), %rax
               	movl	$0x2a, %edx
               	movq	%rdx, %r10
               	xchgl	%r10d, (%rax)
               	movl	(%rax), %eax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	leaq	-0x10(%rbp), %rax
               	movl	$0x64, %edx
               	movq	%rdx, %r10
               	xchgq	%r10, (%rax)
               	lock
               	addq	%rcx, (%rax)
               	movq	(%rax), %rdx
               	cmpq	$0x65, %rdx
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	addq	$0x8, %rax
               	movq	%rcx, %r10
               	xchgl	%r10d, (%rax)
               	movl	(%rax), %eax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
