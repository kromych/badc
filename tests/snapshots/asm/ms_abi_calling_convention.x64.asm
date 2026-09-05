
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
               	movsd	%xmm0, -0x8(%rbp,%riz)
               	movsd	-0x8(%rbp,%riz), %xmm0
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movq	%r15, 0x20(%rsp)
               	movl	$0x1, %edi
               	callq	<addr>
               	movq	%rax, %rbx
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %r12
               	movl	$0x3, %edi
               	callq	<addr>
               	movq	%rax, %r13
               	movl	$0x4, %edi
               	callq	<addr>
               	movq	%rax, %r14
               	movl	$0x5, %edi
               	callq	<addr>
               	movq	%rax, %r15
               	movl	$0x6, %edi
               	callq	<addr>
               	movq	%r12, %rcx
               	shlq	%rcx
               	addq	%rbx, %rcx
               	leaq	(%r13,%r13,2), %rdx
               	addq	%rdx, %rcx
               	movq	%r14, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %rcx
               	leaq	(%r15,%r15,4), %rdx
               	addq	%rdx, %rcx
               	imulq	$0x6, %rax, %rax
               	addq	%rcx, %rax
               	cmpq	$0x5b, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
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
               	movq	%rax, %r13
               	movl	$0x4, %edi
               	callq	<addr>
               	imulq	$0xa, %rbx, %rcx
               	addq	%r12, %rcx
               	imulq	$0xa, %r13, %rdx
               	addq	%rdx, %rax
               	addq	%rcx, %rax
               	cmpq	$0x2e, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	movl	$0x1, %edi
               	callq	<addr>
               	movq	%rax, %rbx
               	movabsq	$0x4000000000000000, %rdi # imm = 0x4000000000000000
               	movq	%rdi, %xmm0
               	callq	<addr>
               	movsd	%xmm0, 0x58(%rsp)
               	movl	$0x3, %edi
               	callq	<addr>
               	movq	%rax, %r12
               	movabsq	$0x4010000000000000, %rdi # imm = 0x4010000000000000
               	movq	%rdi, %xmm0
               	callq	<addr>
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rbx, %xmm1
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movsd	0x58(%rsp), %xmm14
               	movq	%rax, %xmm15
               	movapd	%xmm1, %xmm2
               	vfmadd231sd	%xmm15, %xmm14, %xmm2 # xmm2 = (xmm14 * xmm15) + xmm2
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%r12, %xmm1
               	movabsq	$0x4008000000000000, %rax # imm = 0x4008000000000000
               	movapd	%xmm1, %xmm14
               	movq	%rax, %xmm15
               	movapd	%xmm2, %xmm1
               	vfmadd231sd	%xmm15, %xmm14, %xmm1 # xmm1 = (xmm14 * xmm15) + xmm1
               	movabsq	$0x4010000000000000, %rax # imm = 0x4010000000000000
               	movapd	%xmm0, %xmm14
               	movq	%rax, %xmm15
               	movapd	%xmm1, %xmm0
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	movabsq	$0x403e000000000000, %rax # imm = 0x403E000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
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
               	movq	%rax, %r13
               	movl	$0x4, %edi
               	callq	<addr>
               	movq	%rax, %rcx
               	subq	$0x20, %rsp
               	movq	%r12, %rdx
               	movq	%rcx, %r9
               	movq	%r13, %r8
               	movq	%rbx, %rcx
               	callq	<addr>
               	addq	$0x20, %rsp
               	cmpq	$0x4d2, %rax            # imm = 0x4D2
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	movl	$0x5, %edi
               	callq	<addr>
               	movq	%rax, %rbx
               	movl	$0x6, %edi
               	callq	<addr>
               	movq	%rax, %rsi
               	subq	$0x20, %rsp
               	movq	%rbx, %rcx
               	movq	%rsi, %rdx
               	callq	<addr>
               	addq	$0x20, %rsp
               	cmpq	$0x1fa, %rax            # imm = 0x1FA
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	movl	$0x7, %edi
               	callq	<addr>
               	movq	%rax, %rbx
               	movl	$0x8, %edi
               	callq	<addr>
               	movq	%rax, %rsi
               	subq	$0x20, %rsp
               	movq	%rbx, %rcx
               	movq	%rsi, %rdx
               	callq	<addr>
               	addq	$0x20, %rsp
               	cmpq	$0x2c4, %rax            # imm = 0x2C4
               	je	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
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
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
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
               	movq	%rax, %r13
               	movl	$0x6, %edi
               	callq	<addr>
               	imulq	$0x3e8, %rbx, %rcx      # imm = 0x3E8
               	imulq	$0x64, %r12, %rdx
               	addq	%rdx, %rcx
               	imulq	$0xa, %r13, %rdx
               	addq	%rdx, %rcx
               	addq	%rcx, %rax
               	cmpq	$0x2694, %rax           # imm = 0x2694
               	je	<addr>
               	movl	$0x8, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rbx
               	movq	%rbx, %r12
               	shlq	%r12
               	leaq	(%rbx,%rbx,2), %r13
               	cmpl	$0x2, %ebx
               	movl	$0x1, %eax
               	jne	<addr>
               	cmpl	$0x4, %r12d
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpl	$0x6, %r13d
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	movl	$0x3, %edi
               	callq	<addr>
               	movq	%rax, %r14
               	movl	$0x4, %edi
               	callq	<addr>
               	movq	%rax, %r15
               	movl	$0x5, %edi
               	callq	<addr>
               	movq	%rax, %rdx
               	imulq	$0xa, %r15, %rax
               	addq	%r14, %rax
               	imulq	$0x64, %rbx, %rcx
               	addq	%rcx, %rax
               	imulq	$0x3e8, %r12, %rcx      # imm = 0x3E8
               	addq	%rcx, %rax
               	imulq	$0x2710, %r13, %rcx     # imm = 0x2710
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	imulq	$0x186a0, %rdx, %rcx    # imm = 0x186A0
               	addq	%rcx, %rax
               	cmpq	$0x89c13, %rax          # imm = 0x89C13
               	je	<addr>
               	movl	$0xa, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	jmp	<addr>
               	jmp	<addr>
