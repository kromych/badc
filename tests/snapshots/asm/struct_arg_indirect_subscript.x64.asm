
struct_arg_indirect_subscript.x64:	file format elf64-x86-64

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

<take_vec>:
               	popq	%r10
               	subq	$0x20, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movsd	%xmm0, -0x10(%rbp,%riz)
               	movsd	%xmm1, -0x8(%rbp,%riz)
               	movq	%rdi, %rsi
               	movslq	%esi, %rsi
               	leaq	-0x10(%rbp), %rax
               	movsd	(%rax,%riz), %xmm0
               	movabsq	$0x4010000000000000, %rcx # imm = 0x4010000000000000
               	movsd	0x8(%rax,%riz), %xmm1
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movq	%rax, %xmm15
               	mulsd	%xmm15, %xmm1
               	movapd	%xmm0, %xmm14
               	movq	%rcx, %xmm15
               	movapd	%xmm1, %xmm0
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rsi, %xmm1
               	addsd	%xmm1, %xmm0
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq

<vec_via_ptr>:
               	popq	%r10
               	subq	$0x30, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movsd	%xmm0, -0x10(%rbp,%riz)
               	movsd	%xmm1, -0x8(%rbp,%riz)
               	movl	$0x1, %esi
               	leaq	-0x10(%rbp), %rax
               	movq	%rdi, %rcx
               	movq	%rax, %r10
               	movsd	(%r10,%riz), %xmm0
               	movsd	0x8(%r10,%riz), %xmm1
               	movq	%rsi, %rdi
               	callq	*%rcx
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x30, %rsp
               	pushq	%r11
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xa0, %rsp
               	xorq	%rax, %rax
               	movq	%rax, %rdx
               	movq	%rax, %rcx
               	movl	$0x1, %eax
               	leaq	-0x88(%rbp), %rax
               	xorq	%rsi, %rsi
               	movq	%rsi, (%rax)
               	leaq	0x8(%rax), %rcx
               	leaq	(%rcx), %rdx
               	movl	$0x1, %edi
               	movq	%rdi, (%rdx)
               	movq	%rsi, 0x8(%rdx)
               	movl	$0x2, %edx
               	movq	%rdx, 0x10(%rcx)
               	leaq	-0x88(%rbp), %rcx
               	leaq	0x8(%rcx), %rax
               	movl	$0x1, %edi
               	leaq	0x10(%rax), %rsi
               	movq	%rdi, 0x8(%rsi)
               	movl	$0x3, %esi
               	movq	%rsi, 0x20(%rax)
               	leaq	0x20(%rax), %rdi
               	movq	%rdx, 0x8(%rdi)
               	movl	$0x4, %edx
               	movq	%rdx, 0x30(%rax)
               	leaq	-0x88(%rbp), %rcx
               	leaq	0x8(%rcx), %rax
               	leaq	0x30(%rax), %rdi
               	movq	%rsi, 0x8(%rdi)
               	movl	$0x5, %esi
               	movq	%rsi, 0x40(%rax)
               	addq	$0x40, %rax
               	movq	%rdx, 0x8(%rax)
               	leaq	-0x88(%rbp), %rcx
               	leaq	0x8(%rcx), %rax
               	movl	$0x6, %edx
               	movq	%rdx, 0x50(%rax)
               	leaq	0x50(%rax), %rdx
               	movq	%rsi, 0x8(%rdx)
               	movl	$0x7, %edx
               	movq	%rdx, 0x60(%rax)
               	movl	$0x6, %ecx
               	addq	$0x60, %rax
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x88(%rbp), %rax
               	leaq	0x8(%rax), %rcx
               	movl	$0x8, %esi
               	movq	%rsi, 0x70(%rcx)
               	leaq	0x70(%rcx), %rsi
               	movq	%rdx, 0x8(%rsi)
               	addq	$0x30, %rcx
               	leaq	<rip>, %rdx
               	movq	(%rcx), %rsi
               	imulq	$0x3e8, %rsi, %rsi      # imm = 0x3E8
               	movq	0x8(%rcx), %rcx
               	imulq	$0xa, %rcx, %rcx
               	addq	%rsi, %rcx
               	addq	$0x3, %rcx
               	testq	%rax, %rax
               	je	<addr>
               	xorq	%rax, %rax
               	addq	$0x0, %rcx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x1, %eax
               	addq	%rcx, %rax
               	cmpq	$0xfc2, %rax            # imm = 0xFC2
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x98(%rbp), %rdi
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdi)
               	popq	%rcx
               	movq	%rdi, %rax
               	movl	$0x1, %esi
               	movq	%rdi, %r10
               	movsd	(%r10,%riz), %xmm0
               	movsd	0x8(%r10,%riz), %xmm1
               	movq	%rsi, %rdi
               	callq	<addr>
               	movabsq	$0x3ff8000000000000, %rax # imm = 0x3FF8000000000000
               	movabsq	$0x4010000000000000, %rcx # imm = 0x4010000000000000
               	movabsq	$0x4002000000000000, %rdx # imm = 0x4002000000000000
               	movabsq	$0x4000000000000000, %rsi # imm = 0x4000000000000000
               	movq	%rsi, %xmm15
               	movq	%rdx, %xmm1
               	mulsd	%xmm15, %xmm1
               	movq	%rax, %xmm14
               	movq	%rcx, %xmm15
               	vfmadd231sd	%xmm15, %xmm14, %xmm1 # xmm1 = (xmm14 * xmm15) + xmm1
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movq	%rax, %xmm15
               	addsd	%xmm15, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	leaq	-<rip>, %rdi      # <addr>
               	leaq	-0x98(%rbp), %rsi
               	movl	$0x1, %edx
               	movq	%rsi, %r10
               	movsd	(%r10,%riz), %xmm0
               	movsd	0x8(%r10,%riz), %xmm1
               	movq	%rdx, %rsi
               	callq	<addr>
               	movabsq	$0x3ff8000000000000, %rax # imm = 0x3FF8000000000000
               	movabsq	$0x4010000000000000, %rcx # imm = 0x4010000000000000
               	movabsq	$0x4002000000000000, %rdx # imm = 0x4002000000000000
               	movabsq	$0x4000000000000000, %rsi # imm = 0x4000000000000000
               	movq	%rsi, %xmm15
               	movq	%rdx, %xmm1
               	mulsd	%xmm15, %xmm1
               	movq	%rax, %xmm14
               	movq	%rcx, %xmm15
               	vfmadd231sd	%xmm15, %xmm14, %xmm1 # xmm1 = (xmm14 * xmm15) + xmm1
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movq	%rax, %xmm15
               	addsd	%xmm15, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
