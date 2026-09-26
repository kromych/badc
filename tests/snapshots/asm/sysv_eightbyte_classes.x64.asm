
sysv_eightbyte_classes.x64:	file format elf64-x86-64

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

<take_b1>:
               	movabsq	$0x4024000000000000, %rax # imm = 0x4024000000000000
               	movq	%rax, %xmm15
               	mulsd	%xmm15, %xmm0
               	cvttsd2si	%xmm0, %rax
               	addq	$0xbb8, %rax            # imm = 0xBB8
               	addq	$0x2, %rax
               	retq

<take_b2>:
               	imulq	$0x64, %rdi, %rax
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rax, %xmm1
               	movabsq	$0x4024000000000000, %rax # imm = 0x4024000000000000
               	movapd	%xmm0, %xmm14
               	movq	%rax, %xmm15
               	movapd	%xmm1, %xmm0
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	cvttsd2si	%xmm0, %rax
               	addq	$0x2, %rax
               	retq

<make_b1>:
               	retq

<make_b2>:
               	movl	$0x9, %eax
               	retq

<take_a1>:
               	movabsq	$0x4059000000000000, %rax # imm = 0x4059000000000000
               	movq	%rax, %xmm15
               	mulsd	%xmm15, %xmm0
               	cvttsd2si	%xmm0, %rax
               	addq	%rdi, %rax
               	retq

<take_a3>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movsd	-0x10(%rbp), %xmm0
               	movabsq	$0x4059000000000000, %rax # imm = 0x4059000000000000
               	movq	%rax, %xmm15
               	mulsd	%xmm15, %xmm0
               	cvttsd2si	%xmm0, %rax
               	addq	%rsi, %rax
               	leave
               	retq

<take_a5>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movups	%xmm0, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rax
               	movss	(%rax), %xmm0
               	movl	$0x42c80000, %ecx       # imm = 0x42C80000
               	movss	0xc(%rax), %xmm2
               	movl	$0x41200000, %eax       # imm = 0x41200000
               	movq	%rax, %xmm15
               	mulss	%xmm15, %xmm2
               	movapd	%xmm0, %xmm14
               	movq	%rcx, %xmm15
               	movapd	%xmm2, %xmm0
               	vfmadd231ss	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	cvtss2sd	%xmm0, %xmm0
               	addsd	%xmm1, %xmm0
               	leave
               	retq

<after_a1>:
               	movq	%rdi, %rax
               	retq

<after_a3>:
               	movq	%rsi, %rax
               	retq

<after_a5>:
               	movaps	%xmm1, %xmm0
               	retq

<ret_a1>:
               	movabsq	$0x4004000000000000, %rax # imm = 0x4004000000000000
               	movq	%rax, %xmm0
               	movq	$-0x1, %rax
               	movq	%rax, %xmm1
               	retq

<ret_a3>:
               	movabsq	$0x4004000000000000, %rax # imm = 0x4004000000000000
               	movq	$-0x1, %rdx
               	retq

<ret_a5>:
               	movabsq	$0x3fc00000, %rax       # imm = 0x3FC00000
               	movq	%rax, %xmm0
               	movabsq	$0x4020000000000000, %rax # imm = 0x4020000000000000
               	movq	%rax, %xmm1
               	punpcklqdq	%xmm1, %xmm0    # xmm0 = xmm0[0],xmm1[0]
               	movq	$-0x1, %rax
               	movq	%rax, %xmm1
               	retq

<via_a1>:
               	movq	%rdi, %r11
               	movabsq	$0x4008000000000000, %rax # imm = 0x4008000000000000
               	movq	%rax, %xmm0
               	movq	$0x2a, %rdi
               	movq	$-0x1, %rsi
               	jmpq	*%r11

<via_a3>:
               	movq	%rdi, %r11
               	movabsq	$0x4008000000000000, %rdi # imm = 0x4008000000000000
               	movq	$0x2a, %rsi
               	movq	$-0x1, %rdx
               	jmpq	*%r11

<via_a5>:
               	movq	%rdi, %r11
               	movabsq	$0x3f800000, %rax       # imm = 0x3F800000
               	movq	%rax, %xmm0
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movq	%rax, %xmm1
               	punpcklqdq	%xmm1, %xmm0    # xmm0 = xmm0[0],xmm1[0]
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	movq	%rax, %xmm1
               	jmpq	*%r11

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	leaq	-0x60(%rbp), %r9
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	movabsq	$0x4008000000000000, %rax # imm = 0x4008000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x50(%rbp)
               	leaq	-0x40(%rbp), %rcx
               	leaq	-0x30(%rbp), %rax
               	leaq	<rip>, %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movl	$0x2a, %edi
               	movq	%r9, %r10
               	movsd	(%r10), %xmm0
               	callq	<addr>
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	-0x50(%rbp), %rdi
               	movl	$0x2a, %esi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	-0x40(%rbp), %r9
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	movq	%rax, %xmm1
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	callq	<addr>
               	movsd	%xmm0, -0x10(%rbp)
               	movsd	-0x10(%rbp), %xmm0
               	movabsq	$0x4004000000000000, %rax # imm = 0x4004000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	callq	<addr>
               	movq	%rax, -0x10(%rbp)
               	movsd	-0x10(%rbp), %xmm0
               	movabsq	$0x4004000000000000, %rax # imm = 0x4004000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	callq	<addr>
               	movups	%xmm0, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rax
               	leaq	-0x40(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x40(%rbp), %rax
               	movss	(%rax), %xmm0
               	movl	$0x3fc00000, %ecx       # imm = 0x3FC00000
               	movq	%rcx, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	0xc(%rax), %xmm0
               	movl	$0x40200000, %eax       # imm = 0x40200000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	leaq	-<rip>, %rdi      # <addr>
               	callq	<addr>
               	cmpq	$0x156, %rax            # imm = 0x156
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	leaq	-<rip>, %rdi      # <addr>
               	callq	<addr>
               	cmpq	$0x156, %rax            # imm = 0x156
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	leaq	-<rip>, %rdi      # <addr>
               	callq	<addr>
               	movabsq	$0x405e200000000000, %rax # imm = 0x405E200000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	leaq	-0x20(%rbp), %r9
               	movabsq	$0x4012000000000000, %rax # imm = 0x4012000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, 0x8(%r9)
               	leaq	-0x10(%rbp), %rax
               	movq	$0x7, 0x8(%rax)
               	movl	$0x3, %edi
               	movl	$0x2, %esi
               	movq	%r9, %r10
               	movsd	0x8(%r10), %xmm0
               	callq	<addr>
               	cmpq	$0xbe7, %rax            # imm = 0xBE7
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	leaq	-0x10(%rbp), %rdi
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	movl	$0x2, %esi
               	movq	%rax, %xmm0
               	movq	0x8(%rdi), %rdi
               	callq	<addr>
               	cmpq	$0x2c3, %rax            # imm = 0x2C3
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	movabsq	$0x4004000000000000, %rax # imm = 0x4004000000000000
               	movq	%rax, %xmm0
               	callq	<addr>
               	movabsq	$0x4004000000000000, %rax # imm = 0x4004000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	movl	$0x9, %edi
               	callq	<addr>
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
