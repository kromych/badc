
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
               	leaq	<rip>, %rax # <addr>
               	movl	$0x0, (%rax)
               	leaq	-0x48(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movups	%xmm14, 0x10(%rcx)
               	movups	%xmm14, 0x20(%rcx)
               	movups	%xmm14, 0x30(%rcx)
               	movl	$0x0, 0x40(%rcx)
               	movl	(%rax), %ecx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	movl	$0xb, -0x48(%rbp)
               	movl	-0x48(%rbp), %eax
               	movl	%eax, -0x44(%rbp)
               	movl	%eax, -0x40(%rbp)
               	movl	%eax, -0x3c(%rbp)
               	movl	%eax, -0x38(%rbp)
               	movl	%eax, -0x34(%rbp)
               	movl	-0x48(%rbp), %eax
               	movl	%eax, -0x30(%rbp)
               	movl	%eax, -0x2c(%rbp)
               	movl	%eax, -0x28(%rbp)
               	movl	%eax, -0x24(%rbp)
               	movl	%eax, -0x20(%rbp)
               	movl	-0x48(%rbp), %eax
               	movl	%eax, -0x1c(%rbp)
               	movl	%eax, -0x18(%rbp)
               	leaq	-0x48(%rbp), %rcx
               	movl	%eax, -0x14(%rbp)
               	movl	%eax, -0x10(%rbp)
               	movl	%eax, -0xc(%rbp)
               	movl	-0x48(%rbp), %eax
               	movl	%eax, -0x8(%rbp)
               	leaq	<rip>, %rax # <addr>
               	movl	(%rax), %eax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x65, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	movl	(%rcx,%rax,4), %edx
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
               	leaq	<rip>, %rax # <addr>
               	movl	(%rax), %ecx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%eax, %eax
               	retq

<check_override>:
               	leaq	<rip>, %rcx # <addr>
               	xorl	%eax, %eax
               	movl	%eax, (%rcx)
               	movl	$0x1, (%rcx)
               	movl	(%rcx), %edx
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
               	leaq	<rip>, %rax # <addr>
               	xorl	%ecx, %ecx
               	movl	%ecx, (%rax)
               	movl	$0x1, (%rax)
               	movl	(%rax), %edx
               	incq	%rdx
               	movl	%edx, (%rax)
               	movl	(%rax), %edx
               	incq	%rdx
               	movl	%edx, (%rax)
               	movq	%rcx, -0x18(%rbp)
               	movq	%rcx, -0x10(%rbp)
               	xorl	%edx, %edx
               	leaq	<rip>, %rax # <addr>
               	movl	(%rax), %esi
               	incq	%rsi
               	movl	%esi, (%rax)
               	movabsq	$0x4028000000000000, %rsi # imm = 0x4028000000000000
               	movabsq	$0x4000000000000000, %rdi # imm = 0x4000000000000000
               	movq	%rsi, %xmm14
               	movq	%rdi, %xmm15
               	vdivsd	%xmm15, %xmm14, %xmm0
               	movsd	%xmm0, -0x18(%rbp)
               	movq	-0x18(%rbp), %rsi
               	movq	%rsi, -0x10(%rbp)
               	leaq	-0x30(%rbp), %rsi
               	movq	$0x0, (%rsi)
               	movl	$0x0, 0x8(%rsi)
               	movl	(%rax), %esi
               	incq	%rsi
               	movl	%esi, (%rax)
               	movl	$0x41400000, %esi       # imm = 0x41400000
               	movl	$0x40800000, %edi       # imm = 0x40800000
               	movq	%rsi, %xmm14
               	movq	%rdi, %xmm15
               	vdivss	%xmm15, %xmm14, %xmm0
               	movss	%xmm0, -0x30(%rbp)
               	movl	-0x30(%rbp), %esi
               	movl	%esi, -0x28(%rbp)
               	movl	(%rax), %eax
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x67, %eax
               	leave
               	retq
               	movq	%rcx, %xmm14
               	movq	%rdx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	jp	<addr>
               	jne	<addr>
               	movsd	-0x18(%rbp), %xmm1
               	movabsq	$0x4028000000000000, %rax # imm = 0x4028000000000000
               	movabsq	$0x4000000000000000, %rcx # imm = 0x4000000000000000
               	movq	%rax, %xmm14
               	movq	%rcx, %xmm15
               	vdivsd	%xmm15, %xmm14, %xmm0
               	ucomisd	%xmm0, %xmm1
               	jp	<addr>
               	jne	<addr>
               	movsd	-0x10(%rbp), %xmm1
               	ucomisd	%xmm0, %xmm1
               	jp	<addr>
               	jne	<addr>
               	xorl	%eax, %eax
               	movq	%rdx, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	jp	<addr>
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	movss	-0x30(%rbp), %xmm1
               	movl	$0x41400000, %ecx       # imm = 0x41400000
               	movl	$0x40800000, %edx       # imm = 0x40800000
               	movq	%rcx, %xmm14
               	movq	%rdx, %xmm15
               	vdivss	%xmm15, %xmm14, %xmm0
               	ucomiss	%xmm0, %xmm1
               	jp	<addr>
               	jne	<addr>
               	movss	-0x28(%rbp), %xmm1
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
               	leaq	<rip>, %rax # <addr>
               	movl	$0x0, (%rax)
               	leaq	-0x48(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movups	%xmm14, 0x10(%rcx)
               	movups	%xmm14, 0x20(%rcx)
               	movups	%xmm14, 0x30(%rcx)
               	movl	$0x0, 0x40(%rcx)
               	movl	(%rax), %ecx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	movl	$0x13, -0x48(%rbp)
               	movl	-0x48(%rbp), %eax
               	movl	%eax, -0x44(%rbp)
               	movl	%eax, -0x40(%rbp)
               	movl	%eax, -0x3c(%rbp)
               	movl	%eax, -0x38(%rbp)
               	movl	%eax, -0x34(%rbp)
               	movl	-0x48(%rbp), %eax
               	movl	%eax, -0x30(%rbp)
               	movl	%eax, -0x2c(%rbp)
               	movl	%eax, -0x28(%rbp)
               	movl	%eax, -0x24(%rbp)
               	movl	%eax, -0x20(%rbp)
               	movl	-0x48(%rbp), %eax
               	movl	%eax, -0x1c(%rbp)
               	movl	%eax, -0x18(%rbp)
               	leaq	-0x48(%rbp), %rcx
               	movl	%eax, -0x14(%rbp)
               	movl	%eax, -0x10(%rbp)
               	movl	%eax, -0xc(%rbp)
               	movl	-0x48(%rbp), %eax
               	movl	%eax, -0x8(%rbp)
               	leaq	<rip>, %rax # <addr>
               	movl	(%rax), %eax
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
               	leaq	<rip>, %rax # <addr>
               	movl	(%rax), %ecx
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
               	testl	%eax, %eax
               	je	<addr>
               	popq	%rbp
               	retq
               	movl	$0x17, %edi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	popq	%rbp
               	retq
               	movl	$0x1f, %edi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	popq	%rbp
               	retq
               	movl	$0xc, %edi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	popq	%rbp
               	retq
               	movl	$0x13, %edi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
