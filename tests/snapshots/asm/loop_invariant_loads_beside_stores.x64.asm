
loop_invariant_loads_beside_stores.x64:	file format elf64-x86-64

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

<pull>:
               	xorl	%edi, %edi
               	leaq	<rip>, %rsi # <addr>
               	imulq	$0x38, %rdi, %rax
               	leaq	(%rsi,%rax), %rcx
               	leaq	0x1(%rdi), %rdx
               	movsd	(%rcx), %xmm5
               	movsd	0x8(%rcx), %xmm6
               	movsd	0x10(%rcx), %xmm7
               	movsd	0x30(%rcx), %xmm0
               	cmpl	$0x5, %edx
               	jge	<addr>
               	imulq	$0x38, %rdx, %rax
               	addq	%rsi, %rax
               	vsubsd	(%rax), %xmm5, %xmm2
               	vsubsd	0x8(%rax), %xmm6, %xmm3
               	vsubsd	0x10(%rax), %xmm7, %xmm4
               	movsd	0x18(%rcx), %xmm8
               	movsd	0x30(%rax), %xmm1
               	vfnmadd231sd	%xmm1, %xmm2, %xmm8 # xmm8 = -(xmm2 * xmm1) + xmm8
               	movsd	%xmm8, 0x18(%rcx)
               	movapd	%xmm3, %xmm8
               	vfnmadd213sd	0x20(%rcx), %xmm1, %xmm8 # xmm8 = -(xmm1 * xmm8) + mem
               	movsd	%xmm8, 0x20(%rcx)
               	vfnmadd213sd	0x28(%rcx), %xmm4, %xmm1 # xmm1 = -(xmm4 * xmm1) + mem
               	movsd	%xmm1, 0x28(%rcx)
               	movapd	%xmm2, %xmm1
               	vfmadd213sd	0x18(%rax), %xmm0, %xmm1 # xmm1 = (xmm0 * xmm1) + mem
               	movsd	%xmm1, 0x18(%rax)
               	movapd	%xmm3, %xmm1
               	vfmadd213sd	0x20(%rax), %xmm0, %xmm1 # xmm1 = (xmm0 * xmm1) + mem
               	movsd	%xmm1, 0x20(%rax)
               	movapd	%xmm4, %xmm1
               	vfmadd213sd	0x28(%rax), %xmm0, %xmm1 # xmm1 = (xmm0 * xmm1) + mem
               	movsd	%xmm1, 0x28(%rax)
               	incq	%rdx
               	cmpl	$0x5, %edx
               	jl	<addr>
               	incq	%rdi
               	nopw	(%rax,%rax)
               	cmpl	$0x5, %edi
               	jl	<addr>
               	retq

<next_row>:
               	movslq	%edi, %rdi
               	testl	%edi, %edi
               	jl	<addr>
               	cmpl	$0xe, %edi
               	jle	<addr>
               	movq	$-0x1, %rax
               	retq
               	xorl	%eax, %eax
               	leaq	<rip>, %rdx # <addr>
               	incq	%rdi
               	movq	%rax, %rcx
               	cmpl	%esi, %eax
               	jge	<addr>
               	movq	(%rdx,%rdi,8), %r8
               	addq	%r8, %rcx
               	imulq	$0xa, %rax, %r8
               	movslq	%r8d, %r8
               	movq	%r8, (%rdx,%rax,8)
               	incq	%rax
               	nop
               	cmpl	%esi, %eax
               	jl	<addr>
               	movq	%rcx, %rax
               	retq

<odd_even>:
               	movslq	%edi, %rdi
               	testl	%edi, %edi
               	jl	<addr>
               	cmpl	$0x7, %edi
               	jle	<addr>
               	movq	$-0x1, %rax
               	retq
               	xorl	%eax, %eax
               	leaq	<rip>, %rdx # <addr>
               	shlq	%rdi
               	leaq	0x1(%rdi), %rcx
               	movq	(%rdx,%rcx,8), %rdi
               	movq	%rax, %rcx
               	cmpl	%esi, %eax
               	jge	<addr>
               	addq	%rdi, %rcx
               	movq	%rax, %r8
               	shlq	%r8
               	movslq	%r8d, %r8
               	movq	%rax, (%rdx,%r8,8)
               	incq	%rax
               	cmpl	%esi, %eax
               	jl	<addr>
               	movq	%rcx, %rax
               	retq

<wrapped>:
               	movslq	%edi, %rdi
               	testl	%edi, %edi
               	jl	<addr>
               	cmpl	$0x7, %edi
               	jle	<addr>
               	movq	$-0x1, %rax
               	retq
               	xorl	%eax, %eax
               	leaq	<rip>, %rcx # <addr>
               	imulq	$0x38, %rdi, %rdi
               	addq	%rcx, %rdi
               	incq	%rsi
               	imulq	$0x38, %rsi, %rsi
               	addq	%rcx, %rsi
               	movq	%rax, %rcx
               	cmpl	%edx, %eax
               	jge	<addr>
               	movq	0x8(%rdi), %r8
               	addq	%r8, %rcx
               	leaq	0x64(%rax), %r8
               	movslq	%r8d, %r8
               	movq	%r8, (%rsi)
               	incq	%rax
               	cmpl	%edx, %eax
               	jl	<addr>
               	movq	%rcx, %rax
               	retq

<zero_trip>:
               	xorl	%eax, %eax
               	leaq	<rip>, %rcx # <addr>
               	xorps	%xmm0, %xmm0
               	cmpl	%esi, %eax
               	jge	<addr>
               	vaddsd	0x30(%rdi), %xmm0, %xmm0
               	imulq	$0x38, %rax, %rdx
               	addq	%rcx, %rdx
               	movsd	%xmm0, 0x18(%rdx)
               	incq	%rax
               	cmpl	%esi, %eax
               	jl	<addr>
               	cvttsd2si	%xmm0, %rax
               	retq

<through>:
               	xorl	%eax, %eax
               	xorps	%xmm0, %xmm0
               	cmpl	%esi, %eax
               	jge	<addr>
               	movsd	<rip>, %xmm1 # <addr>
               	addsd	%xmm1, %xmm0
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rax, %xmm1
               	movsd	%xmm1, (%rdi)
               	incq	%rax
               	cmpl	%esi, %eax
               	jl	<addr>
               	retq

<local_kept>:
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	cmpl	%esi, %eax
               	jge	<addr>
               	addq	$0x4, %rcx
               	movq	%rcx, (%rdi,%rax,8)
               	incq	%rax
               	cmpl	%esi, %eax
               	jl	<addr>
               	movq	%rcx, %rax
               	retq

<local_escaped>:
               	subq	$0x18, %rsp
               	leaq	(%rsp), %rcx
               	leaq	<rip>, %rax # <addr>
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	xorl	%eax, %eax
               	addq	$0x8, %rcx
               	movq	%rcx, (%rdi)
               	movq	%rax, %rcx
               	cmpl	%esi, %eax
               	jge	<addr>
               	movq	0x8(%rsp), %rdx
               	addq	%rdx, %rcx
               	movq	(%rdi), %rdx
               	movq	%rax, (%rdx)
               	incq	%rax
               	nopl	(%rax,%rax)
               	cmpl	%esi, %eax
               	jl	<addr>
               	movq	%rcx, %rax
               	addq	$0x18, %rsp
               	retq

<main>:
               	subq	$0x38, %rsp
               	callq	<addr>
               	xorl	%eax, %eax
               	leaq	<rip>, %rdx # <addr>
               	leaq	<rip>, %r8 # <addr>
               	imulq	$0x38, %rax, %rcx
               	addq	%r8, %rcx
               	movsd	0x18(%rcx), %xmm0
               	imulq	$0x18, %rax, %rsi
               	leaq	(%rdx,%rsi), %rdi
               	movsd	(%rdi), %xmm1
               	nopw	(%rax,%rax)
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movsd	0x20(%rcx), %xmm0
               	movsd	0x8(%rdi), %xmm1
               	nopw	(%rax,%rax)
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movsd	0x28(%rcx), %xmm0
               	leaq	(%rdx,%rsi), %rcx
               	movsd	0x10(%rcx), %xmm1
               	nop
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x5, %eax
               	jl	<addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movl	$0x2, %edi
               	movl	$0x6, %esi
               	callq	<addr>
               	cmpq	$0x40, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0x38, %rsp
               	retq
               	movq	$0x0, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0x2, <rip> # <addr>
               	movl	$0x3, %edi
               	movq	%rdi, <rip> # <addr>
               	movq	$0x4, <rip> # <addr>
               	movq	$0x5, <rip> # <addr>
               	movq	$0x6, <rip> # <addr>
               	movq	$0x7, <rip> # <addr>
               	movl	$0x8, %esi
               	movq	%rsi, <rip> # <addr>
               	movq	$0x9, <rip> # <addr>
               	movq	$0xa, <rip> # <addr>
               	movq	$0xb, <rip> # <addr>
               	movq	$0xc, <rip> # <addr>
               	movq	$0xd, <rip> # <addr>
               	movq	$0xe, <rip> # <addr>
               	movq	$0xf, <rip> # <addr>
               	callq	<addr>
               	cmpq	$0x38, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x38, %rsp
               	retq
               	movq	$0x9, <rip> # <addr>
               	movl	$0x3, %edi
               	movabsq	$0x6db6db6db6db6db9, %rsi # imm = 0x6DB6DB6DB6DB6DB9
               	movl	$0x4, %edx
               	callq	<addr>
               	cmpq	$0x138, %rax            # imm = 0x138
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x38, %rsp
               	retq
               	xorl	%edi, %edi
               	xorl	%esi, %esi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x38, %rsp
               	retq
               	leaq	<rip>, %rax # <addr>
               	leaq	0xa0(%rax), %rdi
               	movsd	<rip>, %xmm0 # <addr>
               	movsd	%xmm0, (%rdi)
               	movl	$0x4, %esi
               	callq	<addr>
               	ucomisd	<rip>, %xmm0 # <addr>
               	jp	<addr>
               	je	<addr>
               	movl	$0xe, %eax
               	addq	$0x38, %rsp
               	retq
               	leaq	0x10(%rsp), %rdi
               	movl	$0x4, %esi
               	callq	<addr>
               	cmpq	$0x10, %rax
               	jne	<addr>
               	movq	0x28(%rsp), %rax
               	cmpq	$0x10, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	addq	$0x38, %rsp
               	retq
               	leaq	0x8(%rsp), %rdi
               	movl	$0x4, %esi
               	callq	<addr>
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	addq	$0x38, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x38, %rsp
               	retq
               	incq	%rax
               	addq	$0x38, %rsp
               	retq
