
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
               	xorq	%rax, %rax
               	movl	%eax, (%rdx)
               	leaq	-0x48(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	movups	%xmm14, 0x30(%rax)
               	movl	$0x0, 0x40(%rax)
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
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x65, %eax
               	leave
               	retq
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x48(%rbp), %rdx
               	movslq	%eax, %rcx
               	movslq	(%rdx,%rcx,4), %rdx
               	cmpl	$0xb, %edx
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x11, %eax
               	jl	<addr>
               	xorq	%rax, %rax
               	leave
               	retq
               	movl	$0x1, %eax
               	leave
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
               	cmpl	$0x2, %ecx
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
               	leaq	<rip>, %rcx
               	xorq	%rax, %rax
               	movl	%eax, (%rcx)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rsi
               	incq	%rsi
               	movl	%esi, (%rax)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rsi
               	incq	%rsi
               	movl	%esi, (%rax)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rsi
               	incq	%rsi
               	movl	%esi, (%rax)
               	leaq	-0x38(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	leaq	<rip>, %rsi
               	movslq	(%rsi), %rdi
               	incq	%rdi
               	movl	%edi, (%rsi)
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rdx, %xmm0
               	movabsq	$0x4000000000000000, %rsi # imm = 0x4000000000000000
               	movq	%rsi, %xmm15
               	movapd	%xmm0, %xmm1
               	divsd	%xmm15, %xmm1
               	movsd	%xmm1, 0x8(%rax,%riz)
               	movq	0x8(%rax), %rsi
               	movq	%rsi, 0x10(%rax)
               	leaq	-0x60(%rbp), %rax
               	movq	$0x0, (%rax)
               	movl	$0x0, 0x8(%rax)
               	leaq	<rip>, %rsi
               	movslq	(%rsi), %rdi
               	incq	%rdi
               	movl	%edi, (%rsi)
               	xorps	%xmm1, %xmm1
               	cvtsi2ss	%rdx, %xmm1
               	movl	$0x40800000, %esi       # imm = 0x40800000
               	movq	%rsi, %xmm15
               	movapd	%xmm1, %xmm2
               	divss	%xmm15, %xmm2
               	movss	%xmm2, (%rax,%riz)
               	movl	(%rax), %esi
               	movl	%esi, 0x4(%rax)
               	movl	%esi, 0x8(%rax)
               	movslq	(%rcx), %rax
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x67, %eax
               	leave
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	leaq	-0x38(%rbp), %rcx
               	movsd	(%rcx,%riz), %xmm2
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm2
               	jp	<addr>
               	jne	<addr>
               	movsd	0x8(%rcx,%riz), %xmm3
               	movabsq	$0x4000000000000000, %rsi # imm = 0x4000000000000000
               	movq	%rsi, %xmm15
               	movapd	%xmm0, %xmm2
               	divsd	%xmm15, %xmm2
               	ucomisd	%xmm2, %xmm3
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movsd	0x10(%rcx,%riz), %xmm3
               	ucomisd	%xmm2, %xmm3
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movsd	0x18(%rcx,%riz), %xmm0
               	xorq	%rcx, %rcx
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	leaq	-0x60(%rbp), %rax
               	movss	(%rax,%riz), %xmm2
               	movl	$0x40800000, %esi       # imm = 0x40800000
               	movq	%rsi, %xmm15
               	movapd	%xmm1, %xmm0
               	divss	%xmm15, %xmm0
               	ucomiss	%xmm0, %xmm2
               	jp	<addr>
               	jne	<addr>
               	movss	0x8(%rax,%riz), %xmm2
               	ucomiss	%xmm0, %xmm2
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	movq	%rcx, %rax
               	leave
               	retq

<check_deferred>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	leaq	<rip>, %rdi
               	xorq	%rax, %rax
               	movl	%eax, (%rdi)
               	leaq	-0x68(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	movups	%xmm14, 0x30(%rax)
               	movl	$0x0, 0x40(%rax)
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
               	leaq	-0x68(%rbp), %rax
               	movl	(%rax), %ecx
               	movl	%ecx, 0x14(%rax)
               	movl	%ecx, 0x18(%rax)
               	movl	%ecx, 0x1c(%rax)
               	movl	%ecx, 0x20(%rax)
               	movl	%ecx, 0x24(%rax)
               	movl	(%rax), %ecx
               	movl	%ecx, 0x28(%rax)
               	leaq	-0x68(%rbp), %rax
               	movl	(%rax), %ecx
               	movl	%ecx, 0x2c(%rax)
               	movl	%ecx, 0x30(%rax)
               	movl	%ecx, 0x34(%rax)
               	movl	%ecx, 0x38(%rax)
               	movl	%ecx, 0x3c(%rax)
               	movl	(%rax), %ecx
               	movl	%ecx, 0x40(%rax)
               	movslq	(%rdi), %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x69, %eax
               	leave
               	retq
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x68(%rbp), %rdx
               	movslq	%eax, %rcx
               	movl	(%rdx,%rcx,4), %edx
               	cmpl	$0x13, %edx
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x11, %eax
               	jl	<addr>
               	movslq	(%rdi), %rax
               	incq	%rax
               	movl	%eax, (%rdi)
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	leave
               	retq
               	movl	$0xe, %eax
               	leave
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
