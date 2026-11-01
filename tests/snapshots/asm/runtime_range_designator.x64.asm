
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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
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
               	testq	%rax, %rax
               	je	<addr>
               	leave
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movl	(%rcx), %eax
               	incq	%rax
               	movl	%eax, (%rcx)
               	xorl	%eax, %eax
               	movl	%eax, (%rcx)
               	movl	$0x1, (%rcx)
               	movl	(%rcx), %edx
               	incq	%rdx
               	movl	%edx, (%rcx)
               	cmpl	$0x2, %edx
               	je	<addr>
               	movl	$0x66, %edx
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	%rdx, %rax
               	leave
               	retq
               	movl	%eax, (%rcx)
               	leaq	<rip>, %rax # <addr>
               	movl	(%rax), %ecx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	movl	(%rax), %ecx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	movl	(%rax), %ecx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%ecx, %ecx
               	movq	%rcx, -0x48(%rbp)
               	movq	%rcx, -0x40(%rbp)
               	movl	(%rax), %edx
               	incq	%rdx
               	movl	%edx, (%rax)
               	movabsq	$0x4028000000000000, %rdx # imm = 0x4028000000000000
               	movabsq	$0x4000000000000000, %rsi # imm = 0x4000000000000000
               	movq	%rdx, %xmm14
               	movq	%rsi, %xmm15
               	vdivsd	%xmm15, %xmm14, %xmm0
               	movsd	%xmm0, -0x48(%rbp)
               	movq	-0x48(%rbp), %rsi
               	movq	%rsi, -0x40(%rbp)
               	leaq	-0x68(%rbp), %rsi
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
               	movss	%xmm0, -0x68(%rbp)
               	movl	-0x68(%rbp), %esi
               	movl	%esi, -0x60(%rbp)
               	movl	(%rax), %eax
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x67, %eax
               	testq	%rax, %rax
               	je	<addr>
               	leave
               	retq
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
               	testq	%rax, %rax
               	je	<addr>
               	leave
               	retq
               	xorl	%eax, %eax
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
               	jmp	<addr>
               	movl	$0xe, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	movq	%rcx, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	jp	<addr>
               	jne	<addr>
               	movsd	-0x48(%rbp), %xmm0
               	movabsq	$0x4000000000000000, %rsi # imm = 0x4000000000000000
               	movq	%rdx, %xmm14
               	movq	%rsi, %xmm15
               	vdivsd	%xmm15, %xmm14, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movsd	-0x40(%rbp), %xmm0
               	movabsq	$0x4028000000000000, %rdx # imm = 0x4028000000000000
               	movq	%rdx, %xmm14
               	movq	%rsi, %xmm15
               	vdivsd	%xmm15, %xmm14, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movq	%rcx, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	jp	<addr>
               	je	<addr>
               	movl	$0xc, %eax
               	jmp	<addr>
               	movss	-0x68(%rbp), %xmm1
               	movl	$0x41400000, %ecx       # imm = 0x41400000
               	movl	$0x40800000, %edx       # imm = 0x40800000
               	movq	%rcx, %xmm14
               	movq	%rdx, %xmm15
               	vdivss	%xmm15, %xmm14, %xmm0
               	ucomiss	%xmm0, %xmm1
               	jp	<addr>
               	jne	<addr>
               	movss	-0x60(%rbp), %xmm1
               	ucomiss	%xmm0, %xmm1
               	jp	<addr>
               	je	<addr>
               	movl	$0xd, %eax
               	jmp	<addr>
               	movq	%rax, %rdx
               	jmp	<addr>
               	xorl	%eax, %eax
               	movl	(%rcx,%rax,4), %edx
               	cmpl	$0xb, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x11, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
