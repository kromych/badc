
call_conv_declarator_positions.x64:	file format elf64-x86-64

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
               	vfmadd231sd	<rip>, %xmm1, %xmm0 # xmm0 = (xmm1 * mem) + xmm0
               	imulq	$0x64, %r8, %rax
               	movslq	%eax, %rax
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rax, %xmm1
               	addsd	%xmm1, %xmm0
               	vfmadd231sd	<rip>, %xmm3, %xmm0 # xmm0 = (xmm3 * mem) + xmm0
               	movups	(%rsp), %xmm14
               	movups	0x10(%rsp), %xmm15
               	leave
               	retq

<svd>:
               	movslq	%edi, %rdi
               	xorps	%xmm2, %xmm2
               	cvtsi2sd	%rdi, %xmm2
               	vfnmadd132sd	<rip>, %xmm2, %xmm0 # xmm0 = -(xmm0 * mem) + xmm2
               	imulq	$0x64, %rsi, %rax
               	movslq	%eax, %rax
               	xorps	%xmm2, %xmm2
               	cvtsi2sd	%rax, %xmm2
               	addsd	%xmm2, %xmm0
               	vfnmadd231sd	<rip>, %xmm1, %xmm0 # xmm0 = -(xmm1 * mem) + xmm0
               	retq

<positions>:
               	subq	$0x28, %rsp
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x30, %rsp
               	movq	%rdi, %rbx
               	movq	%rsi, %r12
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	callq	<addr>
               	cmpq	$0x17, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x30, %rsp
               	popq	%rbx
               	popq	%r12
               	addq	$0x28, %rsp
               	retq
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	callq	<addr>
               	cmpq	$0x17, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x30, %rsp
               	popq	%rbx
               	popq	%r12
               	addq	$0x28, %rsp
               	retq
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	callq	<addr>
               	cmpq	$0x17, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x30, %rsp
               	popq	%rbx
               	popq	%r12
               	addq	$0x28, %rsp
               	retq
               	leaq	-<rip>, %rax # <addr>
               	movq	%rax, 0x58(%rsp)
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	callq	<addr>
               	cmpq	$0x17, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x30, %rsp
               	popq	%rbx
               	popq	%r12
               	addq	$0x28, %rsp
               	retq
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	callq	<addr>
               	cmpq	$0x17, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x30, %rsp
               	popq	%rbx
               	popq	%r12
               	addq	$0x28, %rsp
               	retq
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	callq	<addr>
               	cmpq	$0x17, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x30, %rsp
               	popq	%rbx
               	popq	%r12
               	addq	$0x28, %rsp
               	retq
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x30, %rsp
               	popq	%rbx
               	popq	%r12
               	addq	$0x28, %rsp
               	retq
               	movq	<rip>, %rax # <addr>
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	callq	*%rax
               	cmpq	$0x17, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x30, %rsp
               	popq	%rbx
               	popq	%r12
               	addq	$0x28, %rsp
               	retq
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	callq	<addr>
               	cmpq	$0x17, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x30, %rsp
               	popq	%rbx
               	popq	%r12
               	addq	$0x28, %rsp
               	retq
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	movq	%rax, 0x48(%rsp)
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	imulq	$0x64, %rax, %rax
               	movq	%rax, %r10
               	movq	0x48(%rsp), %rax
               	addq	%r10, %rax
               	cmpq	$0x38d, %rax            # imm = 0x38D
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0x30, %rsp
               	popq	%rbx
               	popq	%r12
               	addq	$0x28, %rsp
               	retq
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	imulq	$0x64, %rax, %r10
               	movq	%r10, 0x48(%rsp)
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	movq	%rax, %r10
               	movq	0x48(%rsp), %rax
               	addq	%r10, %rax
               	cmpq	$0x38f, %rax            # imm = 0x38F
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x30, %rsp
               	popq	%rbx
               	popq	%r12
               	addq	$0x28, %rsp
               	retq
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	imulq	$0x64, %rax, %r10
               	movq	%r10, 0x48(%rsp)
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	movq	%rax, %r10
               	movq	0x48(%rsp), %rax
               	addq	%r10, %rax
               	cmpq	$0x38f, %rax            # imm = 0x38F
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x30, %rsp
               	popq	%rbx
               	popq	%r12
               	addq	$0x28, %rsp
               	retq
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	imulq	$0x64, %rax, %r10
               	movq	%r10, 0x48(%rsp)
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	movq	%rax, %r10
               	movq	0x48(%rsp), %rax
               	addq	%r10, %rax
               	cmpq	$0x455, %rax            # imm = 0x455
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x30, %rsp
               	popq	%rbx
               	popq	%r12
               	addq	$0x28, %rsp
               	retq
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	callq	<addr>
               	cmpq	$0x17, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	addq	$0x30, %rsp
               	popq	%rbx
               	popq	%r12
               	addq	$0x28, %rsp
               	retq
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	callq	<addr>
               	imulq	$0x64, %rax, %r10
               	movq	%r10, 0x48(%rsp)
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	movq	%rax, %r10
               	movq	0x48(%rsp), %rax
               	addq	%r10, %rax
               	cmpq	$0x905, %rax            # imm = 0x905
               	je	<addr>
               	movl	$0xf, %eax
               	addq	$0x30, %rsp
               	popq	%rbx
               	popq	%r12
               	addq	$0x28, %rsp
               	retq
               	movq	0x58(%rsp), %rax
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	callq	*%rax
               	cmpq	$0x17, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	addq	$0x30, %rsp
               	popq	%rbx
               	popq	%r12
               	addq	$0x28, %rsp
               	retq
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	callq	<addr>
               	cmpq	$0x17, %rax
               	je	<addr>
               	movl	$0x11, %eax
               	addq	$0x30, %rsp
               	popq	%rbx
               	popq	%r12
               	addq	$0x28, %rsp
               	retq
               	movq	$0x5, 0x20(%rsp)
               	movq	$0x6, 0x28(%rsp)
               	movl	$0x1, %ecx
               	movl	$0x2, %edx
               	movl	$0x3, %r8d
               	movl	$0x4, %r9d
               	callq	<addr>
               	cmpq	$0x5b, %rax
               	je	<addr>
               	movl	$0x12, %eax
               	addq	$0x30, %rsp
               	popq	%rbx
               	popq	%r12
               	addq	$0x28, %rsp
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
               	addq	$0x30, %rsp
               	popq	%rbx
               	popq	%r12
               	addq	$0x28, %rsp
               	retq
               	movsd	<rip>, %xmm1
               	movsd	<rip>, %xmm3
               	movl	$0x1, %ecx
               	movl	$0x3, %r8d
               	callq	<addr>
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x14, %eax
               	addq	$0x30, %rsp
               	popq	%rbx
               	popq	%r12
               	addq	$0x28, %rsp
               	retq
               	movsd	<rip>, %xmm0
               	movsd	<rip>, %xmm1
               	movl	$0x1, %edi
               	movl	$0x3, %esi
               	callq	<addr>
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x15, %eax
               	addq	$0x30, %rsp
               	popq	%rbx
               	popq	%r12
               	addq	$0x28, %rsp
               	retq
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	callq	<addr>
               	cmpq	$0x17, %rax
               	je	<addr>
               	movl	$0x16, %eax
               	addq	$0x30, %rsp
               	popq	%rbx
               	popq	%r12
               	addq	$0x28, %rsp
               	retq
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x17, %eax
               	addq	$0x30, %rsp
               	popq	%rbx
               	popq	%r12
               	addq	$0x28, %rsp
               	retq
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	callq	<addr>
               	cmpq	$0x17, %rax
               	je	<addr>
               	movl	$0x18, %eax
               	addq	$0x30, %rsp
               	popq	%rbx
               	popq	%r12
               	addq	$0x28, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x30, %rsp
               	popq	%rbx
               	popq	%r12
               	addq	$0x28, %rsp
               	retq

<casts>:
               	pushq	%rax
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x20, %rsp
               	movq	%rdi, %rbx
               	movq	%rsi, %r12
               	leaq	-<rip>, %rax # <addr>
               	movq	%rax, <rip> # <addr>
               	movq	<rip>, %rax # <addr>
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	callq	*%rax
               	cmpq	$0x17, %rax
               	je	<addr>
               	movl	$0x1f, %eax
               	addq	$0x20, %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r11
               	retq
               	movq	<rip>, %rax # <addr>
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	callq	*%rax
               	cmpq	$0x17, %rax
               	je	<addr>
               	movl	$0x20, %eax
               	addq	$0x20, %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r11
               	retq
               	movq	<rip>, %rax # <addr>
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	callq	*%rax
               	cmpq	$0x17, %rax
               	je	<addr>
               	movl	$0x21, %eax
               	addq	$0x20, %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r11
               	retq
               	leaq	-<rip>, %rax # <addr>
               	movq	%rax, <rip> # <addr>
               	movq	<rip>, %rax # <addr>
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	*%rax
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x22, %eax
               	addq	$0x20, %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r11
               	retq
               	movq	<rip>, %rax # <addr>
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	*%rax
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x23, %eax
               	addq	$0x20, %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r11
               	retq
               	xorl	%eax, %eax
               	addq	$0x20, %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r11
               	retq

<main>:
               	pushq	%rax
               	movl	$0x4, %edi
               	movl	$0x3, %esi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%r11
               	retq
               	movl	$0x4, %edi
               	movl	$0x3, %esi
               	callq	<addr>
               	jmp	<addr>
