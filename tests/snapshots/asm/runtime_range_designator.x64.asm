
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
               	leaq	<rip>, %rcx
               	movl	$0x0, (%rcx)
               	leaq	-0x48(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	movups	%xmm14, 0x30(%rax)
               	movl	$0x0, 0x40(%rax)
               	movslq	(%rcx), %rdx
               	incq	%rdx
               	movl	%edx, (%rcx)
               	movl	$0xb, (%rax)
               	movl	(%rax), %ecx
               	movl	%ecx, 0x4(%rax)
               	movl	(%rax), %ecx
               	movl	%ecx, 0x8(%rax)
               	movl	(%rax), %ecx
               	movl	%ecx, 0xc(%rax)
               	movl	(%rax), %ecx
               	movl	%ecx, 0x10(%rax)
               	movl	(%rax), %ecx
               	movl	%ecx, 0x14(%rax)
               	leaq	-0x48(%rbp), %rax
               	movl	(%rax), %ecx
               	movl	%ecx, 0x18(%rax)
               	movl	%ecx, 0x1c(%rax)
               	movl	%ecx, 0x20(%rax)
               	movl	%ecx, 0x24(%rax)
               	movl	%ecx, 0x28(%rax)
               	movl	(%rax), %ecx
               	movl	%ecx, 0x2c(%rax)
               	movl	(%rax), %ecx
               	movl	%ecx, 0x30(%rax)
               	leaq	-0x48(%rbp), %rcx
               	movl	(%rcx), %eax
               	movl	%eax, 0x34(%rcx)
               	movl	%eax, 0x38(%rcx)
               	movl	%eax, 0x3c(%rcx)
               	movl	%eax, 0x40(%rcx)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x65, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	movslq	(%rcx,%rax,4), %rdx
               	cmpl	$0xb, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x11, %eax
               	jl	<addr>
               	xorl	%eax, %eax
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
               	xorl	%eax, %eax
               	retq

<check_override>:
               	leaq	<rip>, %rcx
               	xorl	%eax, %eax
               	movl	%eax, (%rcx)
               	movq	%rax, %rdx
               	incq	%rdx
               	movl	%edx, (%rcx)
               	movslq	(%rcx), %rdx
               	incq	%rdx
               	movl	%edx, (%rcx)
               	movq	%rdx, %rcx
               	cmpl	$0x2, %ecx
               	je	<addr>
               	movl	$0x66, %eax
               	retq
               	retq

<check_widths>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movl	$0xc, %esi
               	leaq	<rip>, %rax
               	xorl	%ecx, %ecx
               	movl	%ecx, (%rax)
               	movq	%rcx, %rdx
               	incq	%rdx
               	movl	%edx, (%rax)
               	movslq	(%rax), %rdx
               	incq	%rdx
               	movl	%edx, (%rax)
               	movslq	(%rax), %rdx
               	incq	%rdx
               	movl	%edx, (%rax)
               	movq	%rcx, -0x18(%rbp)
               	xorl	%edi, %edi
               	movq	%rdi, -0x10(%rbp)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rdx
               	incq	%rdx
               	movl	%edx, (%rax)
               	movl	$0xc, %r8d
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%r8, %xmm0
               	movabsq	$0x4000000000000000, %rdx # imm = 0x4000000000000000
               	movq	%rdx, %xmm15
               	divsd	%xmm15, %xmm0
               	movsd	%xmm0, -0x18(%rbp)
               	movq	-0x18(%rbp), %rdx
               	movq	%rdx, -0x10(%rbp)
               	leaq	-0x30(%rbp), %rdx
               	movq	$0x0, (%rdx)
               	movl	$0x0, 0x8(%rdx)
               	movslq	(%rax), %r9
               	incq	%r9
               	movl	%r9d, (%rax)
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%r8, %xmm0
               	movl	$0x40800000, %r8d       # imm = 0x40800000
               	movq	%r8, %xmm15
               	divss	%xmm15, %xmm0
               	movss	%xmm0, (%rdx)
               	movl	(%rdx), %eax
               	movl	%eax, 0x8(%rdx)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x67, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	movq	%rcx, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	jp	<addr>
               	jne	<addr>
               	movsd	-0x18(%rbp), %xmm1
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rsi, %xmm0
               	movabsq	$0x4000000000000000, %rcx # imm = 0x4000000000000000
               	movq	%rcx, %xmm15
               	divsd	%xmm15, %xmm0
               	ucomisd	%xmm0, %xmm1
               	jp	<addr>
               	jne	<addr>
               	movsd	-0x10(%rbp), %xmm1
               	ucomisd	%xmm0, %xmm1
               	jp	<addr>
               	jne	<addr>
               	movq	%rdi, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	jp	<addr>
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	leaq	-0x30(%rbp), %rcx
               	movss	(%rcx), %xmm1
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rsi, %xmm0
               	movq	%r8, %xmm15
               	divss	%xmm15, %xmm0
               	ucomiss	%xmm0, %xmm1
               	jp	<addr>
               	jne	<addr>
               	movss	0x8(%rcx), %xmm1
               	ucomiss	%xmm0, %xmm1
               	jp	<addr>
               	je	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	leave
               	retq

<check_deferred>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	leaq	<rip>, %rcx
               	movl	$0x0, (%rcx)
               	leaq	-0x48(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	movups	%xmm14, 0x30(%rax)
               	movl	$0x0, 0x40(%rax)
               	movslq	(%rcx), %rdx
               	incq	%rdx
               	movl	%edx, (%rcx)
               	movl	$0x13, (%rax)
               	movl	(%rax), %ecx
               	movl	%ecx, 0x4(%rax)
               	movl	(%rax), %ecx
               	movl	%ecx, 0x8(%rax)
               	movl	(%rax), %ecx
               	movl	%ecx, 0xc(%rax)
               	movl	(%rax), %ecx
               	movl	%ecx, 0x10(%rax)
               	movl	(%rax), %ecx
               	movl	%ecx, 0x14(%rax)
               	leaq	-0x48(%rbp), %rax
               	movl	(%rax), %ecx
               	movl	%ecx, 0x18(%rax)
               	movl	%ecx, 0x1c(%rax)
               	movl	%ecx, 0x20(%rax)
               	movl	%ecx, 0x24(%rax)
               	movl	%ecx, 0x28(%rax)
               	movl	(%rax), %ecx
               	movl	%ecx, 0x2c(%rax)
               	movl	(%rax), %ecx
               	movl	%ecx, 0x30(%rax)
               	leaq	-0x48(%rbp), %rcx
               	movl	(%rcx), %eax
               	movl	%eax, 0x34(%rcx)
               	movl	%eax, 0x38(%rcx)
               	movl	%eax, 0x3c(%rcx)
               	movl	%eax, 0x40(%rcx)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x69, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	movl	(%rcx,%rax,4), %edx
               	cmpl	$0x13, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x11, %eax
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%eax, %eax
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
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
