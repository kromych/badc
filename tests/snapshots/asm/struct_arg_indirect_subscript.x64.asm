
struct_arg_indirect_subscript.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<take_pair>:
               	popq	%r10
               	subq	$0x40, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rsi, -0x10(%rbp)
               	movq	%rdx, -0x8(%rbp)
               	movq	%rcx, %rdx
               	movq	%r8, %rcx
               	movslq	%ecx, %rcx
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rax
               	imulq	$0x3e8, %rax, %rax      # imm = 0x3E8
               	leaq	-0x10(%rbp), %rsi
               	movq	0x8(%rsi), %rsi
               	imulq	$0xa, %rsi, %rsi
               	addq	%rsi, %rax
               	addq	%rcx, %rax
               	testq	%rdi, %rdi
               	je	<addr>
               	xorq	%rsi, %rsi
               	addq	%rsi, %rax
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x1, %edx
               	addq	%rdx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x40, %rsp
               	pushq	%r11
               	retq
               	xorq	%rdx, %rdx
               	jmp	<addr>
               	xorq	%rsi, %rsi
               	jmp	<addr>

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
               	movabsq	$0x4010000000000000, %rax # imm = 0x4010000000000000
               	leaq	-0x10(%rbp), %rcx
               	movsd	0x8(%rcx,%riz), %xmm1
               	movabsq	$0x4000000000000000, %rcx # imm = 0x4000000000000000
               	movq	%rcx, %xmm15
               	mulsd	%xmm15, %xmm1
               	movapd	%xmm0, %xmm14
               	movq	%rax, %xmm15
               	movapd	%xmm1, %xmm0
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	cvtsi2sd	%rsi, %xmm1
               	addsd	%xmm1, %xmm0
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq

<pair_via_ptr>:
               	popq	%r10
               	subq	$0x50, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rdx, -0x10(%rbp)
               	movq	%rcx, -0x8(%rbp)
               	movq	%r8, %rcx
               	movq	%r9, %r8
               	movslq	%r8d, %r8
               	leaq	-0x10(%rbp), %rax
               	movq	%rdi, %r9
               	movq	%rsi, %rdi
               	movq	%rax, %rsi
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	*%r9
               	addq	$0x30, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x50, %rsp
               	pushq	%r11
               	retq

<vec_via_ptr>:
               	popq	%r10
               	subq	$0x30, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movsd	%xmm0, -0x10(%rbp,%riz)
               	movsd	%xmm1, -0x8(%rbp,%riz)
               	movq	%rsi, %rdx
               	movslq	%edx, %rdx
               	leaq	-0x10(%rbp), %rax
               	movq	%rdi, %rcx
               	movq	%rax, %r10
               	movsd	(%r10,%riz), %xmm0
               	movsd	0x8(%r10,%riz), %xmm1
               	movq	%rdx, %rdi
               	callq	*%rcx
               	addq	$0x20, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x30, %rsp
               	pushq	%r11
               	retq

<pair_from_subscript>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movslq	%esi, %rsi
               	leaq	0x8(%rdi), %rax
               	movq	%rsi, %rcx
               	shlq	$0x4, %rcx
               	addq	%rcx, %rax
               	leaq	<rip>, %rdx
               	movq	%rdx, %rcx
               	movq	%rsi, %r8
               	movq	%rax, %rsi
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xd0, %rsp
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	xorq	%rdi, %rdi
               	leaq	-0x10(%rbp), %rsi
               	movl	$0x5, %ecx
               	movq	%rcx, %r8
               	movq	%rdi, %rcx
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	cmpq	$0x1b7b, %rax           # imm = 0x1B7B
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	leaq	-<rip>, %rdi      # <addr>
               	xorq	%rsi, %rsi
               	leaq	-0x10(%rbp), %rdx
               	movl	$0x1, %ecx
               	movl	$0x5, %r8d
               	movq	%r8, %r9
               	movq	%rcx, %r8
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	cmpq	$0x1b7c, %rax           # imm = 0x1B7C
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x98(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	leaq	-0x98(%rbp), %rax
               	addq	$0x8, %rax
               	addq	$0x0, %rax
               	movl	$0x1, %ecx
               	movq	%rcx, (%rax)
               	leaq	-0x98(%rbp), %rax
               	addq	$0x8, %rax
               	xorq	%rcx, %rcx
               	addq	$0x0, %rax
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x98(%rbp), %rax
               	addq	$0x8, %rax
               	movl	$0x2, %ecx
               	movq	%rcx, 0x10(%rax)
               	leaq	-0x98(%rbp), %rax
               	addq	$0x8, %rax
               	movl	$0x1, %ecx
               	addq	$0x10, %rax
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x98(%rbp), %rax
               	addq	$0x8, %rax
               	movl	$0x3, %ecx
               	movq	%rcx, 0x20(%rax)
               	leaq	-0x98(%rbp), %rax
               	addq	$0x8, %rax
               	movl	$0x2, %ecx
               	addq	$0x20, %rax
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x98(%rbp), %rax
               	addq	$0x8, %rax
               	movl	$0x4, %ecx
               	movq	%rcx, 0x30(%rax)
               	leaq	-0x98(%rbp), %rax
               	addq	$0x8, %rax
               	movl	$0x3, %ecx
               	addq	$0x30, %rax
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x98(%rbp), %rax
               	addq	$0x8, %rax
               	movl	$0x5, %ecx
               	movq	%rcx, 0x40(%rax)
               	leaq	-0x98(%rbp), %rax
               	addq	$0x8, %rax
               	movl	$0x4, %ecx
               	addq	$0x40, %rax
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x98(%rbp), %rax
               	addq	$0x8, %rax
               	movl	$0x6, %ecx
               	movq	%rcx, 0x50(%rax)
               	leaq	-0x98(%rbp), %rax
               	addq	$0x8, %rax
               	movl	$0x5, %ecx
               	addq	$0x50, %rax
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x98(%rbp), %rax
               	addq	$0x8, %rax
               	movl	$0x7, %ecx
               	movq	%rcx, 0x60(%rax)
               	leaq	-0x98(%rbp), %rax
               	addq	$0x8, %rax
               	movl	$0x6, %ecx
               	addq	$0x60, %rax
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x98(%rbp), %rax
               	addq	$0x8, %rax
               	movl	$0x8, %ecx
               	movq	%rcx, 0x70(%rax)
               	leaq	-0x98(%rbp), %rax
               	addq	$0x8, %rax
               	movl	$0x7, %ecx
               	addq	$0x70, %rax
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x98(%rbp), %rdi
               	movl	$0x3, %esi
               	callq	<addr>
               	cmpq	$0xfc2, %rax            # imm = 0xFC2
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xb0(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0xb0(%rbp), %rdi
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
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	leaq	-<rip>, %rdi      # <addr>
               	leaq	-0xb0(%rbp), %rsi
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
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
