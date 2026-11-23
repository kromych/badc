
stdatomic_c11.x64:	file format elf64-x86-64

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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movl	$0x0, -0x48(%rbp)
               	leaq	-0x48(%rbp), %rcx
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
               	xorl	%eax, %eax
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x40(%rbp)
               	leaq	-0x40(%rbp), %rcx
               	movabsq	$0x4004000000000000, %rdx # imm = 0x4004000000000000
               	movq	%rdx, (%rcx)
               	movq	(%rcx), %rcx
               	movq	%rcx, %xmm0
               	movq	%rdx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	leaq	-0x38(%rbp), %rcx
               	movss	<rip>, %xmm0
               	movss	%xmm0, -0x38(%rbp)
               	movl	(%rcx), %edx
               	movl	%edx, -0x18(%rbp)
               	movss	-0x18(%rbp), %xmm1
               	ucomiss	%xmm0, %xmm1
               	jp	<addr>
               	je	<addr>
               	movl	$0xe, %eax
               	leave
               	retq
               	movss	<rip>, %xmm0
               	movss	%xmm0, -0x18(%rbp)
               	movl	-0x18(%rbp), %edx
               	movq	%rdx, %r10
               	xchgl	%r10d, (%rcx)
               	movl	(%rcx), %ecx
               	movl	%ecx, -0x18(%rbp)
               	movss	-0x18(%rbp), %xmm1
               	ucomiss	%xmm0, %xmm1
               	jp	<addr>
               	je	<addr>
               	movl	$0xf, %eax
               	leave
               	retq
               	leaq	-0x30(%rbp), %rcx
               	movb	$0x0, (%rcx)
               	movl	$0x1, %edx
               	movq	%rdx, %rsi
               	xchgb	%sil, (%rcx)
               	movsbq	%sil, %rsi
               	testl	%esi, %esi
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	movq	%rax, %r10
               	xchgb	%r10b, (%rcx)
               	movl	%eax, -0x28(%rbp)
               	leaq	-0x28(%rbp), %rax
               	movl	$0x2a, %ecx
               	movq	%rcx, %r10
               	xchgl	%r10d, (%rax)
               	movl	(%rax), %eax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	leaq	-0x20(%rbp), %rax
               	movl	$0x64, %ecx
               	movq	%rcx, %r10
               	xchgq	%r10, (%rax)
               	lock
               	addq	%rdx, (%rax)
               	movq	(%rax), %rcx
               	cmpq	$0x65, %rcx
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	addq	$0x8, %rax
               	movq	%rdx, %r10
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
