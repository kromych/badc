
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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xb0, %rsp
               	leaq	-0x88(%rbp), %rcx
               	movq	$0x0, (%rcx)
               	leaq	0x8(%rcx), %rax
               	movq	$0x1, (%rax)
               	movq	$0x0, 0x8(%rax)
               	movq	$0x2, 0x10(%rax)
               	addq	$0x10, %rax
               	movq	$0x1, 0x8(%rax)
               	leaq	-0x88(%rbp), %rcx
               	leaq	0x8(%rcx), %rax
               	movq	$0x3, 0x20(%rax)
               	leaq	0x20(%rax), %rsi
               	movq	$0x2, 0x8(%rsi)
               	movq	$0x4, 0x30(%rax)
               	addq	$0x30, %rax
               	movq	$0x3, 0x8(%rax)
               	leaq	-0x88(%rbp), %rcx
               	leaq	0x8(%rcx), %rax
               	movq	$0x5, 0x40(%rax)
               	leaq	0x40(%rax), %rsi
               	movq	$0x4, 0x8(%rsi)
               	movq	$0x6, 0x50(%rax)
               	addq	$0x50, %rax
               	movq	$0x5, 0x8(%rax)
               	leaq	-0x88(%rbp), %rcx
               	leaq	0x8(%rcx), %rax
               	movq	$0x7, 0x60(%rax)
               	leaq	0x60(%rax), %rsi
               	movq	$0x6, 0x8(%rsi)
               	movq	$0x8, 0x70(%rax)
               	addq	$0x70, %rax
               	movq	$0x7, 0x8(%rax)
               	leaq	-0x88(%rbp), %rcx
               	leaq	0x8(%rcx), %rax
               	addq	$0x30, %rax
               	leaq	<rip>, %rdx
               	movq	(%rax), %rsi
               	imulq	$0x3e8, %rsi, %rsi      # imm = 0x3E8
               	movq	0x8(%rax), %rax
               	imulq	$0xa, %rax, %rax
               	addq	%rsi, %rax
               	leaq	0x3(%rax), %rsi
               	testq	%rcx, %rcx
               	je	<addr>
               	xorl	%eax, %eax
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x1, %eax
               	addq	%rsi, %rax
               	cmpq	$0xfc2, %rax            # imm = 0xFC2
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	leaq	-0xa8(%rbp), %rcx
               	leaq	<rip>, %rax
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movl	$0x1, %esi
               	movsd	(%rcx,%riz), %xmm0
               	movabsq	$0x4010000000000000, %rax # imm = 0x4010000000000000
               	movsd	0x8(%rcx,%riz), %xmm1
               	movabsq	$0x4000000000000000, %rdx # imm = 0x4000000000000000
               	movq	%rdx, %xmm15
               	mulsd	%xmm15, %xmm1
               	movapd	%xmm0, %xmm14
               	movq	%rax, %xmm15
               	vfmadd231sd	%xmm15, %xmm14, %xmm1 # xmm1 = (xmm14 * xmm15) + xmm1
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rsi, %xmm0
               	addsd	%xmm0, %xmm1
               	movabsq	$0x3ff8000000000000, %rdi # imm = 0x3FF8000000000000
               	movabsq	$0x4002000000000000, %r8 # imm = 0x4002000000000000
               	movq	%rdx, %xmm15
               	movq	%r8, %xmm2
               	mulsd	%xmm15, %xmm2
               	movq	%rdi, %xmm14
               	movq	%rax, %xmm15
               	vfmadd231sd	%xmm15, %xmm14, %xmm2 # xmm2 = (xmm14 * xmm15) + xmm2
               	movabsq	$0x3ff0000000000000, %rdi # imm = 0x3FF0000000000000
               	movq	%rdi, %xmm15
               	addsd	%xmm15, %xmm2
               	ucomisd	%xmm2, %xmm1
               	jp	<addr>
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	leaq	-0x98(%rbp), %rdx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	movsd	(%rdx,%riz), %xmm1
               	movsd	0x8(%rdx,%riz), %xmm2
               	movabsq	$0x4000000000000000, %rcx # imm = 0x4000000000000000
               	movq	%rcx, %xmm15
               	mulsd	%xmm15, %xmm2
               	movapd	%xmm1, %xmm14
               	movq	%rax, %xmm15
               	movapd	%xmm2, %xmm1
               	vfmadd231sd	%xmm15, %xmm14, %xmm1 # xmm1 = (xmm14 * xmm15) + xmm1
               	movapd	%xmm0, %xmm15
               	movapd	%xmm1, %xmm0
               	addsd	%xmm15, %xmm0
               	movabsq	$0x3ff8000000000000, %rax # imm = 0x3FF8000000000000
               	movabsq	$0x4010000000000000, %rdx # imm = 0x4010000000000000
               	movabsq	$0x4002000000000000, %rsi # imm = 0x4002000000000000
               	movq	%rcx, %xmm15
               	movq	%rsi, %xmm1
               	mulsd	%xmm15, %xmm1
               	movq	%rax, %xmm14
               	movq	%rdx, %xmm15
               	vfmadd231sd	%xmm15, %xmm14, %xmm1 # xmm1 = (xmm14 * xmm15) + xmm1
               	movq	%rdi, %xmm15
               	addsd	%xmm15, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
