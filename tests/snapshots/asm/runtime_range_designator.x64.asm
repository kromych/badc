
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
               	cmpl	$0x11, %eax
               	jge	<addr>
               	leaq	-0x48(%rbp), %rcx
               	movslq	%eax, %rdx
               	movslq	(%rcx,%rdx,4), %rcx
               	cmpl	$0xb, %ecx
               	jne	<addr>
               	incq	%rax
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
               	retq

<check_override>:
               	leaq	<rip>, %rax
               	xorq	%rcx, %rcx
               	movl	%ecx, (%rax)
               	leaq	<rip>, %rdx
               	movslq	(%rdx), %rsi
               	incq	%rsi
               	movl	%esi, (%rdx)
               	leaq	<rip>, %rdx
               	movslq	(%rdx), %rsi
               	incq	%rsi
               	movl	%esi, (%rdx)
               	movslq	(%rax), %rax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x66, %eax
               	retq
               	movq	%rcx, %rax
               	retq

<check_widths>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movl	$0xc, %ecx
               	leaq	<rip>, %rsi
               	xorq	%rax, %rax
               	movl	%eax, (%rsi)
               	leaq	<rip>, %rdx
               	movslq	(%rdx), %rdi
               	incq	%rdi
               	movl	%edi, (%rdx)
               	leaq	<rip>, %rdx
               	movslq	(%rdx), %rdi
               	incq	%rdi
               	movl	%edi, (%rdx)
               	leaq	<rip>, %rdx
               	movslq	(%rdx), %rdi
               	incq	%rdi
               	movl	%edi, (%rdx)
               	movq	%rax, -0x18(%rbp)
               	movq	%rax, -0x10(%rbp)
               	leaq	<rip>, %rdx
               	movslq	(%rdx), %rdi
               	incq	%rdi
               	movl	%edi, (%rdx)
               	movl	$0xc, %edx
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rdx, %xmm0
               	movabsq	$0x4000000000000000, %rdi # imm = 0x4000000000000000
               	movq	%rdi, %xmm15
               	divsd	%xmm15, %xmm0
               	movsd	%xmm0, -0x18(%rbp,%riz)
               	movq	-0x18(%rbp), %rdi
               	movq	%rdi, -0x10(%rbp)
               	leaq	-0x30(%rbp), %rdi
               	movq	$0x0, (%rdi)
               	movl	$0x0, 0x8(%rdi)
               	leaq	<rip>, %r8
               	movslq	(%r8), %r9
               	incq	%r9
               	movl	%r9d, (%r8)
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rdx, %xmm0
               	movl	$0x40800000, %r8d       # imm = 0x40800000
               	movq	%r8, %xmm15
               	divss	%xmm15, %xmm0
               	movss	%xmm0, (%rdi,%riz)
               	leaq	-0x30(%rbp), %rdx
               	movl	(%rdx), %edi
               	movl	%edi, 0x8(%rdx)
               	movslq	(%rsi), %rsi
               	cmpl	$0x5, %esi
               	je	<addr>
               	movl	$0x67, %eax
               	leave
               	retq
               	xorq	%rsi, %rsi
               	movq	%rax, %xmm14
               	movq	%rsi, %xmm15
               	ucomisd	%xmm15, %xmm14
               	jp	<addr>
               	jne	<addr>
               	movsd	-0x18(%rbp,%riz), %xmm2
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rcx, %xmm0
               	movabsq	$0x4000000000000000, %rdi # imm = 0x4000000000000000
               	movq	%rdi, %xmm15
               	movapd	%xmm0, %xmm1
               	divsd	%xmm15, %xmm1
               	ucomisd	%xmm1, %xmm2
               	jp	<addr>
               	jne	<addr>
               	movsd	-0x10(%rbp,%riz), %xmm2
               	ucomisd	%xmm1, %xmm2
               	jp	<addr>
               	jne	<addr>
               	movq	%rax, %xmm14
               	movq	%rsi, %xmm15
               	ucomisd	%xmm15, %xmm14
               	jp	<addr>
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	movss	(%rdx,%riz), %xmm1
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rcx, %xmm0
               	movq	%r8, %xmm15
               	movapd	%xmm0, %xmm2
               	divss	%xmm15, %xmm2
               	ucomiss	%xmm2, %xmm1
               	jp	<addr>
               	jne	<addr>
               	leaq	-0x30(%rbp), %rax
               	movss	0x8(%rax,%riz), %xmm1
               	movl	$0x40800000, %eax       # imm = 0x40800000
               	movq	%rax, %xmm15
               	divss	%xmm15, %xmm0
               	ucomiss	%xmm0, %xmm1
               	jp	<addr>
               	je	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	movq	%rsi, %rax
               	leave
               	retq

<check_deferred>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	leaq	<rip>, %rdi
               	xorq	%rax, %rax
               	movl	%eax, (%rdi)
               	leaq	-0x48(%rbp), %rax
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
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x69, %eax
               	leave
               	retq
               	xorq	%rax, %rax
               	cmpl	$0x11, %eax
               	jge	<addr>
               	leaq	-0x48(%rbp), %rcx
               	movslq	%eax, %rdx
               	movl	(%rcx,%rdx,4), %ecx
               	cmpl	$0x13, %ecx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x11, %eax
               	jl	<addr>
               	movslq	(%rdi), %rax
               	incq	%rax
               	movl	%eax, (%rdi)
               	xorq	%rax, %rax
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
