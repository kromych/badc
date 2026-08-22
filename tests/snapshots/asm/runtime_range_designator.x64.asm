
runtime_range_designator.x64:	file format elf64-x86-64

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

<check_once_eval>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	leaq	<rip>, %rdx
               	xorq	%rcx, %rcx
               	movl	%ecx, (%rdx)
               	leaq	-0x48(%rbp), %rax
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	%rcx, 0x10(%rax)
               	movq	%rcx, 0x18(%rax)
               	movq	%rcx, 0x20(%rax)
               	movq	%rcx, 0x28(%rax)
               	movq	%rcx, 0x30(%rax)
               	movq	%rcx, 0x38(%rax)
               	movl	%ecx, 0x40(%rax)
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rsi
               	incq	%rsi
               	movl	%esi, (%rcx)
               	movl	$0xb, %ecx
               	movl	%ecx, (%rax)
               	movl	(%rax), %ecx
               	movl	%ecx, 0x4(%rax)
               	movl	(%rax), %ecx
               	movl	%ecx, 0x8(%rax)
               	movl	(%rax), %ecx
               	movl	%ecx, 0xc(%rax)
               	movl	(%rax), %ecx
               	movl	%ecx, 0x10(%rax)
               	leaq	-0x48(%rbp), %rax
               	movl	(%rax), %ecx
               	movl	%ecx, 0x14(%rax)
               	movl	%ecx, 0x18(%rax)
               	movl	%ecx, 0x1c(%rax)
               	movl	%ecx, 0x20(%rax)
               	movl	%ecx, 0x24(%rax)
               	movl	(%rax), %ecx
               	movl	%ecx, 0x28(%rax)
               	leaq	-0x48(%rbp), %rax
               	movl	(%rax), %ecx
               	movl	%ecx, 0x2c(%rax)
               	movl	%ecx, 0x30(%rax)
               	movl	%ecx, 0x34(%rax)
               	movl	%ecx, 0x38(%rax)
               	movl	%ecx, 0x3c(%rax)
               	movl	(%rax), %ecx
               	movl	%ecx, 0x40(%rax)
               	movslq	(%rdx), %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x65, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x48(%rbp), %rdx
               	movslq	(%rdx,%rcx,4), %rdx
               	cmpq	$0xb, %rdx
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x11, %rcx
               	jl	<addr>
               	xorq	%rax, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq

<check_resume_and_gap>:
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	retq

<check_override>:
               	leaq	<rip>, %rcx
               	xorq	%rax, %rax
               	movl	%eax, (%rcx)
               	leaq	<rip>, %rdx
               	movslq	(%rdx), %rsi
               	incq	%rsi
               	movl	%esi, (%rdx)
               	leaq	<rip>, %rdx
               	movslq	(%rdx), %rsi
               	incq	%rsi
               	movl	%esi, (%rdx)
               	movslq	(%rcx), %rcx
               	cmpq	$0x2, %rcx
               	je	<addr>
               	movl	$0x66, %eax
               	retq
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	retq

<check_widths>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	movl	$0xc, %edx
               	leaq	<rip>, %rsi
               	xorq	%rcx, %rcx
               	movl	%ecx, (%rsi)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rdi
               	incq	%rdi
               	movl	%edi, (%rax)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rdi
               	incq	%rdi
               	movl	%edi, (%rax)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rdi
               	incq	%rdi
               	movl	%edi, (%rax)
               	movq	%rcx, -0x30(%rbp)
               	movq	%rcx, -0x28(%rbp)
               	movq	%rcx, -0x20(%rbp)
               	movq	%rcx, -0x18(%rbp)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rdi
               	incq	%rdi
               	movl	%edi, (%rax)
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rdx, %xmm0
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movq	%rax, %xmm15
               	movapd	%xmm0, %xmm1
               	divsd	%xmm15, %xmm1
               	movsd	%xmm1, -0x28(%rbp,%riz)
               	movq	-0x28(%rbp), %rax
               	movq	%rax, -0x20(%rbp)
               	leaq	-0x58(%rbp), %rax
               	movq	%rcx, (%rax)
               	movl	%ecx, 0x8(%rax)
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rdi
               	incq	%rdi
               	movl	%edi, (%rcx)
               	xorps	%xmm1, %xmm1
               	cvtsi2ss	%rdx, %xmm1
               	movl	$0x40800000, %ecx       # imm = 0x40800000
               	movq	%rcx, %xmm15
               	divss	%xmm15, %xmm1
               	movss	%xmm1, (%rax,%riz)
               	movl	(%rax), %ecx
               	movl	%ecx, 0x4(%rax)
               	movl	%ecx, 0x8(%rax)
               	movslq	(%rsi), %rax
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x67, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	movsd	-0x30(%rbp,%riz), %xmm1
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm1
               	movl	$0x1, %eax
               	jp	<addr>
               	jne	<addr>
               	movsd	-0x28(%rbp,%riz), %xmm1
               	movabsq	$0x4000000000000000, %rcx # imm = 0x4000000000000000
               	movq	%rcx, %xmm15
               	movapd	%xmm0, %xmm2
               	divsd	%xmm15, %xmm2
               	ucomisd	%xmm2, %xmm1
               	setne	%cl
               	movzbq	%cl, %rcx
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movsd	-0x20(%rbp,%riz), %xmm1
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movq	%rax, %xmm15
               	divsd	%xmm15, %xmm0
               	ucomisd	%xmm0, %xmm1
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movsd	-0x18(%rbp,%riz), %xmm0
               	xorq	%rax, %rax
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x58(%rbp), %rcx
               	movss	(%rcx,%riz), %xmm2
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rdx, %xmm0
               	movl	$0x40800000, %esi       # imm = 0x40800000
               	movq	%rsi, %xmm15
               	movapd	%xmm0, %xmm1
               	divss	%xmm15, %xmm1
               	ucomiss	%xmm1, %xmm2
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movss	0x8(%rcx,%riz), %xmm2
               	ucomiss	%xmm1, %xmm2
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>

<check_deferred>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	leaq	<rip>, %rdi
               	xorq	%rcx, %rcx
               	movl	%ecx, (%rdi)
               	leaq	-0x48(%rbp), %rax
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	%rcx, 0x10(%rax)
               	movq	%rcx, 0x18(%rax)
               	movq	%rcx, 0x20(%rax)
               	movq	%rcx, 0x28(%rax)
               	movq	%rcx, 0x30(%rax)
               	movq	%rcx, 0x38(%rax)
               	movl	%ecx, 0x40(%rax)
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rdx
               	incq	%rdx
               	movl	%edx, (%rcx)
               	movl	$0x13, %ecx
               	movl	%ecx, (%rax)
               	movl	(%rax), %ecx
               	movl	%ecx, 0x4(%rax)
               	movl	(%rax), %ecx
               	movl	%ecx, 0x8(%rax)
               	movl	(%rax), %ecx
               	movl	%ecx, 0xc(%rax)
               	movl	(%rax), %ecx
               	movl	%ecx, 0x10(%rax)
               	leaq	-0x48(%rbp), %rax
               	movl	(%rax), %ecx
               	movl	%ecx, 0x14(%rax)
               	movl	%ecx, 0x18(%rax)
               	movl	%ecx, 0x1c(%rax)
               	movl	%ecx, 0x20(%rax)
               	movl	%ecx, 0x24(%rax)
               	movl	(%rax), %ecx
               	movl	%ecx, 0x28(%rax)
               	leaq	-0x48(%rbp), %rax
               	movl	(%rax), %ecx
               	movl	%ecx, 0x2c(%rax)
               	movl	%ecx, 0x30(%rax)
               	movl	%ecx, 0x34(%rax)
               	movl	%ecx, 0x38(%rax)
               	movl	%ecx, 0x3c(%rax)
               	movl	(%rax), %ecx
               	movl	%ecx, 0x40(%rax)
               	movslq	(%rdi), %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x69, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x48(%rbp), %rdx
               	movl	(%rdx,%rcx,4), %edx
               	cmpq	$0x13, %rdx
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x11, %rcx
               	jl	<addr>
               	movslq	(%rdi), %rax
               	incq	%rax
               	movl	%eax, (%rdi)
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movl	$0xe, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0xb, %edi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	popq	%rbp
               	retq
               	movl	$0x17, %edi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	popq	%rbp
               	retq
               	movl	$0x1f, %edi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	popq	%rbp
               	retq
               	movl	$0xc, %edi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	popq	%rbp
               	retq
               	movl	$0x13, %edi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
