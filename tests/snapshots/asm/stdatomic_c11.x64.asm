
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
               	subq	$0x58, %rsp
               	movl	$0x0, 0x8(%rsp)
               	leaq	0x8(%rsp), %rcx
               	movl	$0x5, %edx
               	movl	%edx, (%rcx)
               	movl	(%rcx), %eax
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x58, %rsp
               	retq
               	movl	$0xa, %eax
               	lock
               	xaddl	%eax, (%rcx)
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x58, %rsp
               	retq
               	movl	(%rcx), %eax
               	cmpl	$0xf, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x58, %rsp
               	retq
               	movl	$0xf, %eax
               	movl	$0x63, %esi
               	movl	%eax, %eax
               	lock
               	cmpxchgl	%esi, (%rcx)
               	cmpl	$0xf, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x58, %rsp
               	retq
               	movl	(%rcx), %eax
               	cmpl	$0x63, %eax
               	je	<addr>
               	movq	%rdx, %rax
               	addq	$0x58, %rsp
               	retq
               	mfence
               	xorl	%eax, %eax
               	movq	%rax, %xmm14
               	movsd	%xmm14, 0x10(%rsp)
               	leaq	0x10(%rsp), %rcx
               	movabsq	$0x4004000000000000, %rdx # imm = 0x4004000000000000
               	movq	%rdx, (%rcx)
               	movq	(%rcx), %rcx
               	movq	%rcx, %xmm0
               	movq	%rdx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x58, %rsp
               	retq
               	leaq	0x18(%rsp), %rcx
               	movss	<rip>, %xmm0
               	movss	%xmm0, 0x18(%rsp)
               	movl	(%rcx), %edx
               	movl	%edx, 0x38(%rsp)
               	movss	0x38(%rsp), %xmm1
               	ucomiss	%xmm0, %xmm1
               	jp	<addr>
               	je	<addr>
               	movl	$0xe, %eax
               	addq	$0x58, %rsp
               	retq
               	movss	<rip>, %xmm0
               	movss	%xmm0, 0x38(%rsp)
               	movl	0x38(%rsp), %edx
               	movq	%rdx, %r10
               	xchgl	%r10d, (%rcx)
               	movl	(%rcx), %ecx
               	movl	%ecx, 0x38(%rsp)
               	movss	0x38(%rsp), %xmm1
               	ucomiss	%xmm0, %xmm1
               	jp	<addr>
               	je	<addr>
               	movl	$0xf, %eax
               	addq	$0x58, %rsp
               	retq
               	leaq	0x20(%rsp), %rcx
               	movb	$0x0, (%rcx)
               	movl	$0x1, %edx
               	movq	%rdx, %rsi
               	xchgb	%sil, (%rcx)
               	movsbq	%sil, %rsi
               	testl	%esi, %esi
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x58, %rsp
               	retq
               	movq	%rax, %r10
               	xchgb	%r10b, (%rcx)
               	movl	%eax, 0x28(%rsp)
               	leaq	0x28(%rsp), %rcx
               	movl	$0x2a, %esi
               	movq	%rsi, %r10
               	xchgl	%r10d, (%rcx)
               	movl	(%rcx), %ecx
               	cmpl	$0x2a, %ecx
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x58, %rsp
               	retq
               	leaq	0x30(%rsp), %rcx
               	movl	$0x64, %esi
               	movq	%rsi, %r10
               	xchgq	%r10, (%rcx)
               	lock
               	addq	%rdx, (%rcx)
               	movq	(%rcx), %rsi
               	cmpq	$0x65, %rsi
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x58, %rsp
               	retq
               	addq	$0x8, %rcx
               	movq	%rdx, %r10
               	xchgl	%r10d, (%rcx)
               	movl	(%rcx), %ecx
               	cmpl	$0x1, %ecx
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x58, %rsp
               	retq
               	addq	$0x58, %rsp
               	retq
