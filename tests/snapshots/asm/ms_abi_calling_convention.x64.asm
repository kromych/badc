
ms_abi_calling_convention.x64:	file format elf64-x86-64

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

<four>:
               	imulq	$0x3e8, %rcx, %rax      # imm = 0x3E8
               	imulq	$0x64, %rdx, %rcx
               	addq	%rcx, %rax
               	imulq	$0xa, %r8, %rcx
               	addq	%rcx, %rax
               	addq	%r9, %rax
               	retq

<two>:
               	imulq	$0x64, %rcx, %rax
               	addq	%rdx, %rax
               	retq

<rt>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	leave
               	retq

<rtd>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movsd	%xmm0, -0x8(%rbp)
               	movsd	-0x8(%rbp), %xmm0
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	pushq	%r12
               	pushq	%rbx
               	movl	$0x1, %edi
               	callq	<addr>
               	movq	%rax, %rbx
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %r12
               	movl	$0x3, %edi
               	callq	<addr>
               	movq	%rax, 0x28(%rsp)
               	movl	$0x4, %edi
               	callq	<addr>
               	movq	%rax, 0x20(%rsp)
               	movl	$0x5, %edi
               	callq	<addr>
               	movq	%rax, 0x18(%rsp)
               	movl	$0x6, %edi
               	callq	<addr>
               	shlq	%r12
               	leaq	(%rbx,%r12), %rcx
               	movq	0x28(%rsp), %rdx
               	leaq	(%rdx,%rdx,2), %rdx
               	addq	%rdx, %rcx
               	movq	0x20(%rsp), %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %rcx
               	movq	0x18(%rsp), %rdx
               	leaq	(%rdx,%rdx,4), %rdx
               	addq	%rdx, %rcx
               	imulq	$0x6, %rax, %rax
               	addq	%rcx, %rax
               	cmpq	$0x5b, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x1, %edi
               	callq	<addr>
               	movq	%rax, %rbx
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %r12
               	movl	$0x3, %edi
               	callq	<addr>
               	movq	%rax, 0x28(%rsp)
               	movl	$0x4, %edi
               	callq	<addr>
               	imulq	$0xa, %rbx, %rcx
               	addq	%r12, %rcx
               	movq	0x28(%rsp), %rdx
               	imulq	$0xa, %rdx, %rdx
               	addq	%rdx, %rax
               	addq	%rcx, %rax
               	cmpq	$0x2e, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x1, %edi
               	callq	<addr>
               	movq	%rax, %rbx
               	movsd	<rip>, %xmm0
               	callq	<addr>
               	movsd	%xmm0, 0x28(%rsp)
               	movl	$0x3, %edi
               	callq	<addr>
               	movq	%rax, %r12
               	movsd	<rip>, %xmm0
               	callq	<addr>
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rbx, %xmm1
               	movsd	<rip>, %xmm2
               	vfmadd231sd	0x28(%rsp), %xmm2, %xmm1 # xmm1 = (xmm2 * mem) + xmm1
               	xorps	%xmm2, %xmm2
               	cvtsi2sd	%r12, %xmm2
               	movsd	<rip>, %xmm3
               	vfmadd231sd	%xmm3, %xmm2, %xmm1 # xmm1 = (xmm2 * xmm3) + xmm1
               	movsd	<rip>, %xmm2
               	vfmadd213sd	%xmm1, %xmm2, %xmm0 # xmm0 = (xmm2 * xmm0) + xmm1
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x1, %edi
               	callq	<addr>
               	movq	%rax, %rbx
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %r12
               	movl	$0x3, %edi
               	callq	<addr>
               	movq	%rax, 0x28(%rsp)
               	movl	$0x4, %edi
               	callq	<addr>
               	movq	%rax, %r9
               	subq	$0x20, %rsp
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	movq	0x48(%rsp), %r8
               	callq	<addr>
               	addq	$0x20, %rsp
               	cmpq	$0x4d2, %rax            # imm = 0x4D2
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x5, %edi
               	callq	<addr>
               	movq	%rax, %rbx
               	movl	$0x6, %edi
               	callq	<addr>
               	movq	%rax, %rdx
               	subq	$0x20, %rsp
               	movq	%rbx, %rcx
               	callq	<addr>
               	addq	$0x20, %rsp
               	cmpq	$0x1fa, %rax            # imm = 0x1FA
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x7, %edi
               	callq	<addr>
               	movq	%rax, %rbx
               	movl	$0x8, %edi
               	callq	<addr>
               	movq	%rax, %rdx
               	subq	$0x20, %rsp
               	movq	%rbx, %rcx
               	callq	<addr>
               	addq	$0x20, %rsp
               	cmpq	$0x2c4, %rax            # imm = 0x2C4
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x9, %edi
               	callq	<addr>
               	leaq	0x1(%rax), %rcx
               	imulq	$0x64, %rax, %rax
               	addq	%rcx, %rax
               	cmpq	$0x38e, %rax            # imm = 0x38E
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x9, %edi
               	callq	<addr>
               	movq	%rax, %rbx
               	movl	$0x8, %edi
               	callq	<addr>
               	movq	%rax, %r12
               	movl	$0x7, %edi
               	callq	<addr>
               	movq	%rax, 0x28(%rsp)
               	movl	$0x6, %edi
               	callq	<addr>
               	imulq	$0x3e8, %rbx, %rcx      # imm = 0x3E8
               	imulq	$0x64, %r12, %rdx
               	addq	%rdx, %rcx
               	movq	0x28(%rsp), %rdx
               	imulq	$0xa, %rdx, %rdx
               	addq	%rdx, %rcx
               	addq	%rcx, %rax
               	cmpq	$0x2694, %rax           # imm = 0x2694
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, 0x28(%rsp)
               	movq	%rax, %r10
               	shlq	%r10
               	movq	%r10, 0x20(%rsp)
               	leaq	(%rax,%rax,2), %r10
               	movq	%r10, 0x18(%rsp)
               	cmpl	$0x2, %eax
               	jne	<addr>
               	movq	0x20(%rsp), %rax
               	cmpl	$0x4, %eax
               	jne	<addr>
               	movq	0x18(%rsp), %rax
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x3, %edi
               	callq	<addr>
               	movq	%rax, %rbx
               	movl	$0x4, %edi
               	callq	<addr>
               	movq	%rax, %r12
               	movl	$0x5, %edi
               	callq	<addr>
               	imulq	$0xa, %r12, %rcx
               	addq	%rbx, %rcx
               	movq	0x28(%rsp), %rdx
               	imulq	$0x64, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x20(%rsp), %rdx
               	imulq	$0x3e8, %rdx, %rdx      # imm = 0x3E8
               	addq	%rdx, %rcx
               	movq	0x18(%rsp), %rdx
               	imulq	$0x2710, %rdx, %rdx     # imm = 0x2710
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	imulq	$0x186a0, %rax, %rax    # imm = 0x186A0
               	addq	%rcx, %rax
               	cmpq	$0x89c13, %rax          # imm = 0x89C13
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
