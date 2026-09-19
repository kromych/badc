
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
               	leaq	(%rax), %rcx
               	xorq	%rdx, %rdx
               	movl	%edx, (%rcx)
               	movl	$0x1, %ecx
               	movl	%ecx, 0x4(%rax)
               	movl	$0x4, %ecx
               	movl	%ecx, 0x8(%rax)
               	movl	$0x9, %ecx
               	movl	%ecx, 0xc(%rax)
               	movl	$0x10, %ecx
               	movl	%ecx, 0x10(%rax)
               	movl	$0x19, %ecx
               	movl	%ecx, 0x14(%rax)
               	movl	$0x24, %ecx
               	movl	%ecx, 0x18(%rax)
               	leaq	-0x28(%rbp), %rdx
               	movl	$0x31, %eax
               	movl	%eax, 0x1c(%rdx)
               	movl	$0x40, %eax
               	movl	%eax, 0x20(%rdx)
               	movl	$0x51, %eax
               	movl	%eax, 0x24(%rdx)
               	movl	$0x7, %ecx
               	xorq	%rsi, %rsi
               	movq	%rsi, %rax
               	testl	%ecx, %ecx
               	jle	<addr>
               	movq	%rcx, %rdi
               	movslq	%edi, %rdi
               	movslq	(%rdx,%rdi,4), %rdi
               	addq	%rdi, %rax
               	cmpl	$0xc8, %eax
               	jg	<addr>
               	movq	%rsi, %rcx
               	testl	%ecx, %ecx
               	jg	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x31, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	-0x28(%rbp), %rsi
               	movl	$0x99, %ecx
               	xorq	%rax, %rax
               	testl	%ecx, %ecx
               	jle	<addr>
               	movslq	%ecx, %rdx
               	imulq	$0x1999999a, %rdx, %rdi # imm = 0x1999999A
               	movq	%rdi, %r8
               	shrq	$0x20, %r8
               	imulq	$0xa, %r8, %r9
               	movq	%r9, %r10
               	movq	%rdx, %r9
               	subq	%r10, %r9
               	movslq	%r9d, %r9
               	movslq	(%rsi,%r9,4), %r9
               	addq	%r9, %rax
               	cmpl	$0xc8, %eax
               	jg	<addr>
               	movq	%r8, %rcx
               	testl	%ecx, %ecx
               	jg	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x23, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	leaq	-0x28(%rbp), %rsi
               	movl	$0xf423f, %ecx          # imm = 0xF423F
               	xorq	%rax, %rax
               	testl	%ecx, %ecx
               	jle	<addr>
               	movslq	%ecx, %rdx
               	imulq	$0x1999999a, %rdx, %rdi # imm = 0x1999999A
               	movq	%rdi, %r8
               	shrq	$0x20, %r8
               	imulq	$0xa, %r8, %r9
               	movq	%r9, %r10
               	movq	%rdx, %r9
               	subq	%r10, %r9
               	movslq	%r9d, %r9
               	movslq	(%rsi,%r9,4), %r9
               	addq	%r9, %rax
               	cmpl	$0xc8, %eax
               	jg	<addr>
               	movq	%r8, %rcx
               	testl	%ecx, %ecx
               	jg	<addr>
               	movslq	%eax, %rax
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
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
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	movq	0x10(%rax), %rcx
               	movq	%rcx, 0x10(%rdx)
               	movq	0x18(%rax), %rcx
               	movq	%rcx, 0x18(%rdx)
               	movq	0x20(%rax), %rcx
               	movq	%rcx, 0x20(%rdx)
               	movq	0x28(%rax), %rcx
               	movq	%rcx, 0x28(%rdx)
               	popq	%rcx
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	cmpq	$0x6, %rax
               	jge	<addr>
               	leaq	(%rax,%rax,2), %rsi
               	leaq	0x1(%rsi), %rdi
               	movq	(%rdx,%rax,8), %r8
               	testq	%r8, %r8
               	jle	<addr>
               	movq	(%rdx,%rax,8), %r8
               	movq	%r8, %rsi
               	imulq	%rdi, %rsi
               	addq	%rsi, %rcx
               	jmp	<addr>
               	subq	%rdi, %rcx
               	incq	%rax
               	cmpq	$0x6, %rax
               	jl	<addr>
               	cmpq	$0x42, %rcx
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	xorq	%rax, %rax
               	leave
               	retq
               	movabsq	$-0x1, %rax
               	jmp	<addr>
               	movabsq	$-0x1, %rax
               	jmp	<addr>
               	movabsq	$-0x1, %rax
               	jmp	<addr>
