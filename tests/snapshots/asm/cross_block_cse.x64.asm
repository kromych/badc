
cross_block_cse.x64:	file format elf64-x86-64

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
               	subq	$0x30, %rsp
               	leaq	-0x28(%rbp), %rax
               	movl	$0x0, (%rax)
               	movl	$0x1, 0x4(%rax)
               	movl	$0x4, 0x8(%rax)
               	movl	$0x9, 0xc(%rax)
               	movl	$0x10, 0x10(%rax)
               	movl	$0x19, 0x14(%rax)
               	movl	$0x24, 0x18(%rax)
               	leaq	-0x28(%rbp), %rsi
               	movl	$0x31, 0x1c(%rsi)
               	movl	$0x40, 0x20(%rsi)
               	movl	$0x51, 0x24(%rsi)
               	movslq	0x1c(%rsi), %rax
               	cmpl	$0xc8, %eax
               	jle	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	cmpl	$0x31, %eax
               	jne	<addr>
               	movl	$0x99, %ecx
               	xorl	%eax, %eax
               	imulq	$0x1999999a, %rcx, %rdx # imm = 0x1999999A
               	shrq	$0x20, %rdx
               	imulq	$0xa, %rdx, %rdi
               	subq	%rdi, %rcx
               	movslq	(%rsi,%rcx,4), %rcx
               	addq	%rcx, %rax
               	cmpl	$0xc8, %eax
               	jg	<addr>
               	movq	%rdx, %rcx
               	testl	%ecx, %ecx
               	jg	<addr>
               	cmpl	$0x23, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	leaq	-0x28(%rbp), %rsi
               	movl	$0xf423f, %ecx          # imm = 0xF423F
               	xorl	%eax, %eax
               	imulq	$0x1999999a, %rcx, %rdx # imm = 0x1999999A
               	shrq	$0x20, %rdx
               	imulq	$0xa, %rdx, %rdi
               	subq	%rdi, %rcx
               	movslq	(%rsi,%rcx,4), %rcx
               	addq	%rcx, %rax
               	cmpl	$0xc8, %eax
               	jg	<addr>
               	movq	%rdx, %rcx
               	testl	%ecx, %ecx
               	jg	<addr>
               	cmpl	$-0x1, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	movq	%rcx, %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	movl	$0xc, %eax
               	movabsq	$-0x8000000000000000, %rcx # imm = 0x8000000000000000
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rax, %xmm0
               	movabsq	$0x4000000000000000, %rdx # imm = 0x4000000000000000
               	movq	%rdx, %xmm15
               	divsd	%xmm15, %xmm0
               	movabsq	$0x4018000000000000, %rdx # imm = 0x4018000000000000
               	movq	%rdx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rax, %xmm0
               	movl	$0x40800000, %eax       # imm = 0x40800000
               	movq	%rax, %xmm15
               	divss	%xmm15, %xmm0
               	movl	$0x40400000, %eax       # imm = 0x40400000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	xorps	%xmm0, %xmm0
               	movq	%rcx, %r10
               	testq	%r10, %r10
               	js	<addr>
               	cvtsi2sd	%r10, %xmm0
               	jmp	<addr>
               	movq	%r10, %r11
               	shrq	%r11
               	andq	$0x1, %r10
               	orq	%r10, %r11
               	cvtsi2sd	%r11, %xmm0
               	addsd	%xmm0, %xmm0
               	movabsq	$0x43e0000000000000, %rax # imm = 0x43E0000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	xorps	%xmm0, %xmm0
               	movq	%rcx, %r10
               	testq	%r10, %r10
               	js	<addr>
               	cvtsi2ss	%r10, %xmm0
               	jmp	<addr>
               	movq	%r10, %r11
               	shrq	%r11
               	andq	$0x1, %r10
               	orq	%r10, %r11
               	cvtsi2ss	%r11, %xmm0
               	addss	%xmm0, %xmm0
               	movl	$0x5f000000, %eax       # imm = 0x5F000000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	leaq	-0x30(%rbp), %rdx
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movups	0x20(%rax), %xmm14
               	movups	%xmm14, 0x20(%rdx)
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	leaq	(%rax,%rax,2), %rsi
               	incq	%rsi
               	movq	(%rdx,%rax,8), %rdi
               	testq	%rdi, %rdi
               	jle	<addr>
               	movq	(%rdx,%rax,8), %rdi
               	imulq	%rdi, %rsi
               	addq	%rsi, %rcx
               	jmp	<addr>
               	subq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x6, %eax
               	jl	<addr>
               	cmpq	$0x42, %rcx
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
