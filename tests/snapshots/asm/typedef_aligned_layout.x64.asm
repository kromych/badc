
typedef_aligned_layout.x64:	file format elf64-x86-64

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

<locals_at_shifted_slots>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	subq	$0x60, %rsp
               	andq	$-0x20, %rsp
               	movl	$0x1, %eax
               	movl	%eax, 0x10(%rsp)
               	leaq	0x20(%rsp), %rax
               	movl	$0x2, %ecx
               	movb	%cl, (%rax)
               	leaq	(%rsp), %rax
               	movl	$0x3, %ecx
               	movb	%cl, (%rax)
               	leaq	0x30(%rsp), %rax
               	movl	$0x4, %ecx
               	movb	%cl, (%rax)
               	leaq	0x40(%rsp), %rax
               	movl	$0x5, %ecx
               	movl	%ecx, (%rax)
               	leaq	0x50(%rsp), %rax
               	movl	$0x6, %ecx
               	movb	%cl, (%rax)
               	leaq	-0x58(%rbp), %rax
               	movl	$0x7, %ecx
               	movb	%cl, (%rax)
               	leaq	-0x58(%rbp), %rax
               	incq	%rax
               	movl	$0x8, %ecx
               	movl	%ecx, (%rax)
               	leaq	0x10(%rsp), %rax
               	andq	$0xf, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1e, %eax
               	leaq	-0x60(%rbp), %rsp
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	0x20(%rsp), %rax
               	andq	$0xf, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1f, %eax
               	leaq	-0x60(%rbp), %rsp
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	(%rsp), %rax
               	andq	$0x1f, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x20, %eax
               	leaq	-0x60(%rbp), %rsp
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	0x30(%rsp), %rax
               	andq	$0xf, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x21, %eax
               	leaq	-0x60(%rbp), %rsp
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	0x40(%rsp), %rax
               	andq	$0xf, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x22, %eax
               	leaq	-0x60(%rbp), %rsp
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	0x50(%rsp), %rax
               	andq	$0xf, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x23, %eax
               	leaq	-0x60(%rbp), %rsp
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x58(%rbp), %rax
               	andq	$0x7, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x24, %eax
               	leaq	-0x60(%rbp), %rsp
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movslq	0x10(%rsp), %rax
               	addq	$0x9, %rax
               	leaq	0x20(%rsp), %rcx
               	movsbq	(%rcx), %rcx
               	addq	%rcx, %rax
               	leaq	(%rsp), %rcx
               	movsbq	(%rcx), %rcx
               	addq	%rcx, %rax
               	leaq	0x30(%rsp), %rcx
               	movsbq	(%rcx), %rcx
               	addq	%rcx, %rax
               	leaq	0x40(%rsp), %rcx
               	movslq	(%rcx), %rcx
               	addq	%rcx, %rax
               	leaq	0x50(%rsp), %rcx
               	movsbq	(%rcx), %rcx
               	addq	%rcx, %rax
               	leaq	-0x58(%rbp), %rcx
               	movsbq	(%rcx), %rcx
               	addq	%rcx, %rax
               	leaq	-0x58(%rbp), %rcx
               	incq	%rcx
               	movslq	(%rcx), %rcx
               	addq	%rcx, %rax
               	subq	$0x9, %rax
               	subq	$0x24, %rax
               	movslq	%eax, %rax
               	leaq	-0x60(%rbp), %rsp
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq

<declarator_vs_typedef>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movl	$0x1, %eax
               	movl	%eax, -0x10(%rbp)
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x20(%rbp,%riz)
               	movabsq	$0x4008000000000000, %rax # imm = 0x4008000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x30(%rbp,%riz)
               	leaq	-0x10(%rbp), %rcx
               	leaq	-0x30(%rbp), %rax
               	andq	$0xf, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x35, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movslq	-0x10(%rbp), %rax
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rax, %xmm0
               	movsd	-0x20(%rbp,%riz), %xmm1
               	addsd	%xmm1, %xmm0
               	movsd	-0x30(%rbp,%riz), %xmm1
               	addsd	%xmm1, %xmm0
               	cvttsd2si	%xmm0, %rax
               	subq	$0x6, %rax
               	movslq	(%rcx), %rcx
               	decq	%rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	<rip>, %rax
               	andq	$0xf, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x40, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	andq	$0x1f, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x41, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	andq	$0xf, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x42, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	andq	$0xf, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x43, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	andq	$0xf, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x44, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x45, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movl	$0x3, %ecx
               	movl	%ecx, (%rax)
               	andq	$0xf, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4c, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x3, %rax
               	movslq	%eax, %rax
               	cmpq	$0x6, %rax
               	je	<addr>
               	movl	$0x4e, %eax
               	popq	%rbp
               	retq
               	movl	$0x9, %edi
               	callq	<addr>
               	movq	%rax, %rcx
               	movslq	%ecx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbp
               	retq
               	callq	<addr>
               	movq	%rax, %rcx
               	movslq	%ecx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
