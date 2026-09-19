
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
               	xorl	%edx, %edx
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
               	movl	$0x7, %eax
               	xorl	%esi, %esi
               	movq	%rsi, %rcx
               	testl	%eax, %eax
               	jle	<addr>
               	movslq	(%rdx,%rax,4), %rdi
               	addq	%rdi, %rcx
               	cmpl	$0xc8, %ecx
               	jg	<addr>
               	movq	%rsi, %rax
               	testl	%eax, %eax
               	jg	<addr>
               	cmpl	$0x31, %ecx
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	-0x28(%rbp), %rsi
               	movl	$0x99, %eax
               	xorl	%ecx, %ecx
               	testl	%eax, %eax
               	jle	<addr>
               	imulq	$0x1999999a, %rax, %rdi # imm = 0x1999999A
               	movq	%rdi, %r8
               	shrq	$0x20, %r8
               	imulq	$0xa, %r8, %rdx
               	movq	%rdx, %r10
               	movq	%rax, %rdx
               	subq	%r10, %rdx
               	movslq	(%rsi,%rdx,4), %rdx
               	addq	%rdx, %rcx
               	cmpl	$0xc8, %ecx
               	jg	<addr>
               	movq	%r8, %rax
               	testl	%eax, %eax
               	jg	<addr>
               	cmpl	$0x23, %ecx
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	leaq	-0x28(%rbp), %rsi
               	movl	$0xf423f, %eax          # imm = 0xF423F
               	xorl	%ecx, %ecx
               	testl	%eax, %eax
               	jle	<addr>
               	imulq	$0x1999999a, %rax, %rdi # imm = 0x1999999A
               	movq	%rdi, %r8
               	shrq	$0x20, %r8
               	imulq	$0xa, %r8, %rdx
               	movq	%rdx, %r10
               	movq	%rax, %rdx
               	subq	%r10, %rdx
               	movslq	(%rsi,%rdx,4), %rdx
               	addq	%rdx, %rcx
               	cmpl	$0xc8, %ecx
               	jg	<addr>
               	movq	%r8, %rax
               	testl	%eax, %eax
               	jg	<addr>
               	cmpl	$-0x1, %ecx
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
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	cmpl	$0x6, %eax
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
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
