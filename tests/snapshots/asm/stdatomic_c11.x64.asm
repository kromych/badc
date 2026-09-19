
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
               	subq	$0x50, %rsp
               	movl	$0x0, -0x40(%rbp)
               	leaq	-0x40(%rbp), %rax
               	movl	$0x5, %edx
               	movl	%edx, (%rax)
               	movl	(%rax), %ecx
               	cmpl	$0x5, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movl	$0xa, %ecx
               	pushq	%rax
               	movq	%rax, %r11
               	movq	%rcx, %r10
               	movq	%r10, %rax
               	lock
               	xaddl	%eax, (%r11)
               	movq	%rax, %r10
               	popq	%rax
               	movq	%r10, %rcx
               	cmpl	$0x5, %ecx
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movslq	-0x40(%rbp), %rcx
               	cmpl	$0xf, %ecx
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movl	$0xf, -0x38(%rbp)
               	leaq	-0x38(%rbp), %rcx
               	movl	$0x63, %esi
               	pushq	%rax
               	pushq	%rcx
               	movq	%rax, %r11
               	movq	%rsi, %r10
               	movl	(%rcx), %eax
               	lock
               	cmpxchgl	%r10d, (%r11)
               	je	<addr>
               	movl	%eax, (%rcx)
               	sete	%r11b
               	movzbq	%r11b, %r11
               	popq	%rcx
               	popq	%rax
               	movq	%r11, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movslq	-0x40(%rbp), %rax
               	cmpl	$0x63, %eax
               	je	<addr>
               	movq	%rdx, %rax
               	leave
               	retq
               	mfence
               	movq	$0x0, -0x30(%rbp)
               	leaq	-0x30(%rbp), %rcx
               	movabsq	$0x4004000000000000, %rdx # imm = 0x4004000000000000
               	leaq	-0x48(%rbp), %rax
               	movq	%rdx, %xmm14
               	movsd	%xmm14, (%rax,%riz)
               	movq	(%rax), %rsi
               	movq	%rsi, (%rcx)
               	movq	(%rcx), %rcx
               	movq	%rcx, (%rax)
               	movsd	(%rax,%riz), %xmm0
               	movq	%rdx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	leaq	-0x28(%rbp), %rcx
               	movl	$0x3fa00000, %edx       # imm = 0x3FA00000
               	movq	%rdx, %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movss	%xmm0, (%rax,%riz)
               	movl	(%rax), %edx
               	movl	%edx, (%rcx)
               	movl	(%rcx), %edx
               	movl	%edx, (%rax)
               	movss	(%rax,%riz), %xmm1
               	ucomiss	%xmm0, %xmm1
               	jp	<addr>
               	je	<addr>
               	movl	$0xe, %eax
               	leave
               	retq
               	movl	$0x40400000, %edx       # imm = 0x40400000
               	movq	%rdx, %xmm14
               	movss	%xmm14, (%rax,%riz)
               	movl	(%rax), %eax
               	movq	%rax, %r10
               	xchgl	%r10d, (%rcx)
               	movss	-0x28(%rbp,%riz), %xmm0
               	movq	%rdx, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xf, %eax
               	leave
               	retq
               	leaq	-0x20(%rbp), %rax
               	movb	$0x0, (%rax)
               	movl	$0x1, %ecx
               	movq	%rax, %r11
               	movq	%rcx, %r10
               	xchgb	%r10b, (%r11)
               	movq	%r10, %rdx
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
               	movl	$0x2a, %esi
               	movq	%rsi, %r10
               	xchgl	%r10d, (%rax)
               	movl	(%rax), %eax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	leaq	-0x10(%rbp), %rax
               	movl	$0x64, %esi
               	movq	%rsi, %r10
               	xchgq	%r10, (%rax)
               	pushq	%rax
               	movq	%rax, %r11
               	movq	%rcx, %r10
               	movq	%r10, %rax
               	lock
               	xaddq	%rax, (%r11)
               	movq	%rax, %r10
               	popq	%rax
               	movq	%r10, %rsi
               	movq	(%rax), %rsi
               	cmpq	$0x65, %rsi
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	movl	%ecx, 0x8(%rax)
               	movq	%rdx, %rax
               	leave
               	retq
