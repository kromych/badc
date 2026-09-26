
sysv_single_fp_vectors.x64:	file format elf64-x86-64

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

<take_f1>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movzbq	0x10(%rbp), %r10
               	movb	%r10b, -0x8(%rbp)
               	movzbq	0x11(%rbp), %r10
               	movb	%r10b, -0x7(%rbp)
               	movzbq	0x12(%rbp), %r10
               	movb	%r10b, -0x6(%rbp)
               	movzbq	0x13(%rbp), %r10
               	movb	%r10b, -0x5(%rbp)
               	movss	-0x8(%rbp), %xmm1
               	movl	$0x42c80000, %eax       # imm = 0x42C80000
               	movq	%rax, %xmm15
               	mulss	%xmm15, %xmm1
               	movabsq	$0x4024000000000000, %rax # imm = 0x4024000000000000
               	cvtss2sd	%xmm1, %xmm1
               	movapd	%xmm0, %xmm14
               	movq	%rax, %xmm15
               	movapd	%xmm1, %xmm0
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	cvttsd2si	%xmm0, %rax
               	addq	%rdi, %rax
               	leave
               	retq

<take_d1>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, -0x8(%rbp)
               	movsd	-0x8(%rbp), %xmm1
               	movabsq	$0x4059000000000000, %rax # imm = 0x4059000000000000
               	movabsq	$0x4024000000000000, %rcx # imm = 0x4024000000000000
               	movq	%rcx, %xmm15
               	mulsd	%xmm15, %xmm0
               	movapd	%xmm1, %xmm14
               	movq	%rax, %xmm15
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	cvttsd2si	%xmm0, %rax
               	addq	%rdi, %rax
               	leave
               	retq

<take_ff>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movss	(%rax), %xmm1
               	movl	$0x42c80000, %ecx       # imm = 0x42C80000
               	movss	0x4(%rax), %xmm2
               	movl	$0x447a0000, %eax       # imm = 0x447A0000
               	movq	%rax, %xmm15
               	mulss	%xmm15, %xmm2
               	movapd	%xmm1, %xmm14
               	movq	%rcx, %xmm15
               	movapd	%xmm2, %xmm1
               	vfmadd231ss	%xmm15, %xmm14, %xmm1 # xmm1 = (xmm14 * xmm15) + xmm1
               	movabsq	$0x4024000000000000, %rax # imm = 0x4024000000000000
               	cvtss2sd	%xmm1, %xmm1
               	movapd	%xmm0, %xmm14
               	movq	%rax, %xmm15
               	movapd	%xmm1, %xmm0
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	cvttsd2si	%xmm0, %rax
               	addq	%rdi, %rax
               	leave
               	retq

<make_f1>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rdi, -0x30(%rbp)
               	leaq	-0x8(%rbp), %rcx
               	movl	$0x0, (%rcx)
               	movss	%xmm0, (%rcx)
               	movq	-0x30(%rbp), %rax
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	leave
               	retq

<make_d1>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rdi, -0x20(%rbp)
               	movq	-0x20(%rbp), %rax
               	movsd	%xmm0, (%rax)
               	leave
               	retq

<peek_f1>:
               	xorl	%eax, %eax
               	cmpl	$0x3fc00000, 0x8(%rsp)  # imm = 0x3FC00000
               	jne	<addr>
               	orl	$0x1, %eax
               	movq	%xmm0, %rcx
               	movabsq	$0x4004000000000000, %rdx # imm = 0x4004000000000000
               	cmpq	%rdx, %rcx
               	jne	<addr>
               	orl	$0x2, %eax
               	cmpq	$0x7, %rdi
               	jne	<addr>
               	orl	$0x4, %eax
               	retq

<peek_d1>:
               	xorl	%eax, %eax
               	movabsq	$0x3ff8000000000000, %rdx # imm = 0x3FF8000000000000
               	cmpq	%rdx, 0x8(%rsp)
               	jne	<addr>
               	orl	$0x1, %eax
               	movq	%xmm0, %rcx
               	movabsq	$0x4004000000000000, %rdx # imm = 0x4004000000000000
               	cmpq	%rdx, %rcx
               	jne	<addr>
               	orl	$0x2, %eax
               	cmpq	$0x7, %rdi
               	jne	<addr>
               	orl	$0x4, %eax
               	retq

<peek_ff>:
               	xorl	%eax, %eax
               	movabsq	$0x404000003fc00000, %rdx # imm = 0x404000003FC00000
               	cmpq	%rdx, 0x8(%rsp)
               	jne	<addr>
               	orl	$0x1, %eax
               	movq	%xmm0, %rcx
               	movabsq	$0x4004000000000000, %rdx # imm = 0x4004000000000000
               	cmpq	%rdx, %rcx
               	jne	<addr>
               	orl	$0x2, %eax
               	cmpq	$0x7, %rdi
               	jne	<addr>
               	orl	$0x4, %eax
               	retq

<give_f1>:
               	movl	$0x3fc00000, (%rdi)     # imm = 0x3FC00000
               	movq	%rdi, %rax
               	retq

<give_d1>:
               	movabsq	$0x3ff8000000000000, %rax # imm = 0x3FF8000000000000
               	movq	%rax, (%rdi)
               	movq	%rdi, %rax
               	retq

<via_take_f1>:
               	movq	%rdi, %r11
               	subq	$0x18, %rsp
               	movl	$0x3fc00000, (%rsp)     # imm = 0x3FC00000
               	movabsq	$0x4004000000000000, %rax # imm = 0x4004000000000000
               	movq	%rax, %xmm0
               	movq	$0x7, %rdi
               	movq	$-0x1, %rsi
               	movq	%rsi, %xmm1
               	callq	*%r11
               	addq	$0x18, %rsp
               	retq

<via_take_d1>:
               	movq	%rdi, %r11
               	subq	$0x18, %rsp
               	movabsq	$0x3ff8000000000000, %rax # imm = 0x3FF8000000000000
               	movq	%rax, (%rsp)
               	movabsq	$0x4004000000000000, %rax # imm = 0x4004000000000000
               	movq	%rax, %xmm0
               	movq	$0x7, %rdi
               	movq	$-0x1, %rsi
               	movq	%rsi, %xmm1
               	callq	*%r11
               	addq	$0x18, %rsp
               	retq

<via_take_ff>:
               	movq	%rdi, %r11
               	subq	$0x18, %rsp
               	movabsq	$0x404000003fc00000, %rax # imm = 0x404000003FC00000
               	movq	%rax, (%rsp)
               	movabsq	$0x4004000000000000, %rax # imm = 0x4004000000000000
               	movq	%rax, %xmm0
               	movq	$0x7, %rdi
               	movq	$-0x1, %rsi
               	movq	%rsi, %xmm1
               	callq	*%r11
               	addq	$0x18, %rsp
               	retq

<via_make_f1>:
               	movq	%rdi, %r11
               	subq	$0x18, %rsp
               	movq	$-0x1, 0x8(%rsp)
               	leaq	0x8(%rsp), %rdi
               	movl	$0x3fc00000, %eax       # imm = 0x3FC00000
               	movd	%eax, %xmm0
               	callq	*%r11
               	leaq	0x8(%rsp), %rcx
               	cmpq	%rcx, %rax
               	movl	0x8(%rsp), %eax
               	je	<addr>
               	movq	$-0x2, %rax
               	addq	$0x18, %rsp
               	retq

<via_make_d1>:
               	movq	%rdi, %r11
               	subq	$0x18, %rsp
               	movq	$-0x1, 0x8(%rsp)
               	leaq	0x8(%rsp), %rdi
               	movabsq	$0x3ff8000000000000, %rax # imm = 0x3FF8000000000000
               	movq	%rax, %xmm0
               	callq	*%r11
               	leaq	0x8(%rsp), %rcx
               	cmpq	%rcx, %rax
               	movq	0x8(%rsp), %rax
               	je	<addr>
               	movq	$-0x2, %rax
               	addq	$0x18, %rsp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	leaq	-0x28(%rbp), %r9
               	leaq	<rip>, %rax
               	movl	(%rax), %r10d
               	movl	%r10d, (%r9)
               	leaq	-0x20(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movabsq	$0x4004000000000000, %rax # imm = 0x4004000000000000
               	movl	$0x7, %edi
               	subq	$0x10, %rsp
               	movq	%r9, %r10
               	movzbq	(%r10), %r11
               	movb	%r11b, (%rsp)
               	movzbq	0x1(%r10), %r11
               	movb	%r11b, 0x1(%rsp)
               	movzbq	0x2(%r10), %r11
               	movb	%r11b, 0x2(%rsp)
               	movzbq	0x3(%r10), %r11
               	movb	%r11b, 0x3(%rsp)
               	movq	%rax, %xmm0
               	callq	<addr>
               	addq	$0x10, %rsp
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	-0x20(%rbp), %r9
               	movabsq	$0x4004000000000000, %rax # imm = 0x4004000000000000
               	movl	$0x7, %edi
               	subq	$0x10, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	%rax, %xmm0
               	callq	<addr>
               	addq	$0x10, %rsp
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	-0x18(%rbp), %r9
               	movabsq	$0x4004000000000000, %rax # imm = 0x4004000000000000
               	movl	$0x7, %edi
               	subq	$0x10, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	%rax, %xmm0
               	callq	<addr>
               	addq	$0x10, %rsp
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	leaq	-0x10(%rbp), %rdi
               	callq	<addr>
               	movss	-0x10(%rbp), %xmm0
               	movl	$0x3fc00000, %eax       # imm = 0x3FC00000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	leaq	-0x8(%rbp), %rdi
               	callq	<addr>
               	movsd	-0x8(%rbp), %xmm0
               	movabsq	$0x3ff8000000000000, %rax # imm = 0x3FF8000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	leaq	-<rip>, %rdi      # <addr>
               	callq	<addr>
               	cmpq	$0xb6, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	leaq	-<rip>, %rdi      # <addr>
               	callq	<addr>
               	cmpq	$0xb6, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	leaq	-<rip>, %rdi      # <addr>
               	callq	<addr>
               	cmpq	$0xc6e, %rax            # imm = 0xC6E
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	leaq	-<rip>, %rdi      # <addr>
               	callq	<addr>
               	cmpq	$0x3fc00000, %rax       # imm = 0x3FC00000
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	leaq	-<rip>, %rdi      # <addr>
               	callq	<addr>
               	movabsq	$0x3ff8000000000000, %r11 # imm = 0x3FF8000000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
