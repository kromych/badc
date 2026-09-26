
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
               	movslq	-0x38(%rbp), %rax
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
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movslq	-0x38(%rbp), %rax
               	cmpl	$0x63, %eax
               	je	<addr>
               	movq	%rdx, %rax
               	leave
               	retq
               	mfence
               	movq	$0x0, -0x30(%rbp)
               	leaq	-0x30(%rbp), %rcx
               	movabsq	$0x4004000000000000, %rdx # imm = 0x4004000000000000
               	leaq	-0x8(%rbp), %rax
               	movq	%rdx, %xmm14
               	movsd	%xmm14, (%rax)
               	movq	(%rax), %rsi
               	movq	%rsi, (%rcx)
               	movq	(%rcx), %rcx
               	movq	%rcx, (%rax)
               	movsd	(%rax), %xmm0
               	movq	%rdx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	leaq	-0x28(%rbp), %rcx
               	movl	$0xbfa00000, %edx       # imm = 0xBFA00000
               	movq	%rdx, %xmm14
               	movss	%xmm14, (%rax)
               	movl	(%rax), %esi
               	movl	%esi, (%rcx)
               	movl	(%rcx), %esi
               	movl	%esi, (%rax)
               	movss	(%rax), %xmm0
               	movq	%rdx, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xe, %eax
               	leave
               	retq
               	movl	$0x40400000, %edx       # imm = 0x40400000
               	movq	%rdx, %xmm14
               	movss	%xmm14, (%rax)
               	movl	(%rax), %eax
               	movq	%rax, %r10
               	xchgl	%r10d, (%rcx)
               	movss	-0x28(%rbp), %xmm0
               	movq	%rdx, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xf, %eax
               	leave
               	retq
               	leaq	-0x20(%rbp), %rcx
               	movb	$0x0, (%rcx)
               	movl	$0x1, %edx
               	movq	%rdx, %rax
               	xchgb	%al, (%rcx)
               	movsbq	%al, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	movq	%rax, %r10
               	xchgb	%r10b, (%rcx)
               	movl	%eax, -0x18(%rbp)
               	leaq	-0x18(%rbp), %rcx
               	movl	$0x2a, %esi
               	movq	%rsi, %r10
               	xchgl	%r10d, (%rcx)
               	movl	(%rcx), %ecx
               	cmpl	$0x2a, %ecx
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	leaq	-0x10(%rbp), %rcx
               	movl	$0x64, %esi
               	movq	%rsi, %r10
               	xchgq	%r10, (%rcx)
               	movq	%rdx, %r10
               	lock
               	xaddq	%r10, (%rcx)
               	movq	(%rcx), %rsi
               	cmpq	$0x65, %rsi
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	movl	%edx, 0x8(%rcx)
               	leave
               	retq
