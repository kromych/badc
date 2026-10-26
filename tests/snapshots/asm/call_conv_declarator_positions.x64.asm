
call_conv_declarator_positions.x64:	file format elf64-x86-64

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

<msf>:
               	leaq	(%rcx,%rcx,4), %rax
               	addq	%rdx, %rax
               	retq

<svf>:
               	leaq	(%rdi,%rdi,2), %rax
               	subq	%rsi, %rax
               	retq

<plainf>:
               	shlq	%rdi
               	leaq	(%rdi,%rsi), %rax
               	retq

<msf6>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	shlq	%rdx
               	leaq	(%rcx,%rdx), %rax
               	leaq	(%r8,%r8,2), %rcx
               	addq	%rcx, %rax
               	shlq	$0x2, %r9
               	addq	%r9, %rax
               	movq	0x30(%rbp), %rcx
               	leaq	(%rcx,%rcx,4), %rcx
               	addq	%rcx, %rax
               	movq	0x38(%rbp), %rcx
               	imulq	$0x6, %rcx, %rcx
               	addq	%rcx, %rax
               	popq	%rbp
               	retq

<svf6>:
               	shlq	%rsi
               	subq	%rsi, %rdi
               	leaq	(%rdx,%rdx,2), %rax
               	addq	%rdi, %rax
               	shlq	$0x2, %rcx
               	subq	%rcx, %rax
               	leaq	(%r8,%r8,4), %rcx
               	addq	%rcx, %rax
               	imulq	$0x6, %r9, %rcx
               	subq	%rcx, %rax
               	retq

<msd>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movups	%xmm14, (%rsp)
               	movups	%xmm15, 0x10(%rsp)
               	movslq	%ecx, %rcx
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rcx, %xmm0
               	movabsq	$0x4024000000000000, %rax # imm = 0x4024000000000000
               	movq	%rax, %xmm15
               	vfmadd231sd	%xmm15, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm15) + xmm0
               	imulq	$0x64, %r8, %rax
               	movslq	%eax, %rax
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rax, %xmm1
               	addsd	%xmm1, %xmm0
               	movabsq	$0x408f400000000000, %rax # imm = 0x408F400000000000
               	movq	%rax, %xmm15
               	vfmadd231sd	%xmm15, %xmm3, %xmm0 # xmm0 = (xmm3 * xmm15) + xmm0
               	movups	(%rsp), %xmm14
               	movups	0x10(%rsp), %xmm15
               	leave
               	retq

<svd>:
               	movslq	%edi, %rdi
               	xorps	%xmm2, %xmm2
               	cvtsi2sd	%rdi, %xmm2
               	movabsq	$0x4024000000000000, %rax # imm = 0x4024000000000000
               	movq	%rax, %xmm15
               	vfnmadd132sd	%xmm15, %xmm2, %xmm0 # xmm0 = -(xmm0 * xmm15) + xmm2
               	imulq	$0x64, %rsi, %rax
               	movslq	%eax, %rax
               	xorps	%xmm2, %xmm2
               	cvtsi2sd	%rax, %xmm2
               	addsd	%xmm2, %xmm0
               	movabsq	$0x408f400000000000, %rax # imm = 0x408F400000000000
               	movq	%rax, %xmm15
               	vfnmadd231sd	%xmm15, %xmm1, %xmm0 # xmm0 = -(xmm1 * xmm15) + xmm0
               	retq

<positions>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movq	%rsi, %r12
               	subq	$0x20, %rsp
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	callq	<addr>
               	addq	$0x20, %rsp
               	cmpq	$0x17, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	subq	$0x20, %rsp
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	callq	<addr>
               	addq	$0x20, %rsp
               	cmpq	$0x17, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	subq	$0x20, %rsp
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	callq	<addr>
               	addq	$0x20, %rsp
               	cmpq	$0x17, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	-<rip>, %rax # <addr>
               	movq	%rax, -0x8(%rbp)
               	subq	$0x20, %rsp
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	callq	<addr>
               	addq	$0x20, %rsp
               	cmpq	$0x17, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	subq	$0x20, %rsp
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	callq	<addr>
               	addq	$0x20, %rsp
               	cmpq	$0x17, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	subq	$0x20, %rsp
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	callq	<addr>
               	addq	$0x20, %rsp
               	cmpq	$0x17, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax), %rax
               	subq	$0x20, %rsp
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	callq	*%rax
               	addq	$0x20, %rsp
               	cmpq	$0x17, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	subq	$0x20, %rsp
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	callq	<addr>
               	addq	$0x20, %rsp
               	cmpq	$0x17, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	movq	%rax, %r13
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	imulq	$0x64, %rax, %rax
               	addq	%r13, %rax
               	cmpq	$0x38d, %rax            # imm = 0x38D
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	imulq	$0x64, %rax, %r13
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	addq	%r13, %rax
               	cmpq	$0x38f, %rax            # imm = 0x38F
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	imulq	$0x64, %rax, %r13
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	addq	%r13, %rax
               	cmpq	$0x38f, %rax            # imm = 0x38F
               	je	<addr>
               	movl	$0xc, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	imulq	$0x64, %rax, %r13
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	addq	%r13, %rax
               	cmpq	$0x455, %rax            # imm = 0x455
               	je	<addr>
               	movl	$0xd, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	subq	$0x20, %rsp
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	callq	<addr>
               	addq	$0x20, %rsp
               	cmpq	$0x17, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	subq	$0x20, %rsp
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	callq	<addr>
               	addq	$0x20, %rsp
               	imulq	$0x64, %rax, %r13
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	addq	%r13, %rax
               	cmpq	$0x905, %rax            # imm = 0x905
               	je	<addr>
               	movl	$0xf, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movq	-0x8(%rbp), %rax
               	subq	$0x20, %rsp
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	callq	*%rax
               	addq	$0x20, %rsp
               	cmpq	$0x17, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	subq	$0x20, %rsp
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	callq	<addr>
               	addq	$0x20, %rsp
               	cmpq	$0x17, %rax
               	je	<addr>
               	movl	$0x11, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x1, %ecx
               	movl	$0x2, %edx
               	movl	$0x3, %r8d
               	movl	$0x4, %r9d
               	movl	$0x5, %eax
               	movl	$0x6, %esi
               	subq	$0x30, %rsp
               	movq	%rax, 0x20(%rsp)
               	movq	%rsi, 0x28(%rsp)
               	callq	<addr>
               	addq	$0x30, %rsp
               	cmpq	$0x5b, %rax
               	je	<addr>
               	movl	$0x12, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x1, %edi
               	movl	$0x2, %esi
               	movl	$0x3, %edx
               	movl	$0x4, %ecx
               	movl	$0x5, %r8d
               	movl	$0x6, %r9d
               	callq	<addr>
               	cmpq	$-0x15, %rax
               	je	<addr>
               	movl	$0x13, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x1, %ecx
               	movabsq	$0x4004000000000000, %rax # imm = 0x4004000000000000
               	movl	$0x3, %r8d
               	movabsq	$0x4012000000000000, %rdx # imm = 0x4012000000000000
               	subq	$0x20, %rsp
               	movq	%rax, %xmm1
               	movq	%rdx, %xmm3
               	callq	<addr>
               	addq	$0x20, %rsp
               	movabsq	$0x40b2da0000000000, %rax # imm = 0x40B2DA0000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x14, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x1, %edi
               	movabsq	$0x4004000000000000, %rax # imm = 0x4004000000000000
               	movl	$0x3, %esi
               	movabsq	$0x4012000000000000, %rcx # imm = 0x4012000000000000
               	movq	%rax, %xmm0
               	movq	%rcx, %xmm1
               	callq	<addr>
               	movabsq	$-0x3f4f800000000000, %rax # imm = 0xC0B0800000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x15, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	subq	$0x20, %rsp
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	callq	<addr>
               	addq	$0x20, %rsp
               	cmpq	$0x17, %rax
               	je	<addr>
               	movl	$0x16, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x17, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	subq	$0x20, %rsp
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	callq	<addr>
               	addq	$0x20, %rsp
               	cmpq	$0x17, %rax
               	je	<addr>
               	movl	$0x18, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq

<casts>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movq	%rsi, %r12
               	leaq	<rip>, %rax # <addr>
               	leaq	-<rip>, %rcx # <addr>
               	movq	%rcx, (%rax)
               	movq	(%rax), %rax
               	subq	$0x20, %rsp
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	callq	*%rax
               	addq	$0x20, %rsp
               	cmpq	$0x17, %rax
               	je	<addr>
               	movl	$0x1f, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax), %rax
               	subq	$0x20, %rsp
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	callq	*%rax
               	addq	$0x20, %rsp
               	cmpq	$0x17, %rax
               	je	<addr>
               	movl	$0x20, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax), %rax
               	subq	$0x20, %rsp
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	callq	*%rax
               	addq	$0x20, %rsp
               	cmpq	$0x17, %rax
               	je	<addr>
               	movl	$0x21, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax # <addr>
               	leaq	-<rip>, %rcx # <addr>
               	movq	%rcx, (%rax)
               	movq	(%rax), %rax
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	*%rax
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x22, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax), %rax
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	*%rax
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x23, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x4, %edi
               	movl	$0x3, %esi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbp
               	retq
               	movl	$0x4, %edi
               	movl	$0x3, %esi
               	callq	<addr>
               	jmp	<addr>
