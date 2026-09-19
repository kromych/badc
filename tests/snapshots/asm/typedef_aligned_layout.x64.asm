
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
               	movl	$0x1, 0x10(%rsp)
               	leaq	0x20(%rsp), %rax
               	movb	$0x2, (%rax)
               	leaq	(%rsp), %rcx
               	movb	$0x3, (%rcx)
               	leaq	0x30(%rsp), %rdx
               	movb	$0x4, (%rdx)
               	leaq	0x40(%rsp), %rsi
               	movl	$0x5, (%rsi)
               	leaq	0x50(%rsp), %rdi
               	movb	$0x6, (%rdi)
               	leaq	-0x58(%rbp), %r8
               	movb	$0x7, (%r8)
               	incq	%r8
               	movl	$0x8, (%r8)
               	leaq	0x10(%rsp), %r8
               	testb	$0xf, %r8b
               	je	<addr>
               	movl	$0x1e, %eax
               	leaq	-0x60(%rbp), %rsp
               	leave
               	retq
               	testb	$0xf, %al
               	je	<addr>
               	movl	$0x1f, %eax
               	leaq	-0x60(%rbp), %rsp
               	leave
               	retq
               	testb	$0x1f, %cl
               	je	<addr>
               	movl	$0x20, %eax
               	leaq	-0x60(%rbp), %rsp
               	leave
               	retq
               	testb	$0xf, %dl
               	je	<addr>
               	movl	$0x21, %eax
               	leaq	-0x60(%rbp), %rsp
               	leave
               	retq
               	testb	$0xf, %sil
               	je	<addr>
               	movl	$0x22, %eax
               	leaq	-0x60(%rbp), %rsp
               	leave
               	retq
               	testb	$0xf, %dil
               	je	<addr>
               	movl	$0x23, %eax
               	leaq	-0x60(%rbp), %rsp
               	leave
               	retq
               	leaq	-0x58(%rbp), %rax
               	testb	$0x7, %al
               	je	<addr>
               	movl	$0x24, %eax
               	leaq	-0x60(%rbp), %rsp
               	leave
               	retq
               	movslq	0x10(%rsp), %rcx
               	addq	$0x9, %rcx
               	leaq	0x20(%rsp), %rdx
               	movsbq	(%rdx), %rdx
               	addq	%rdx, %rcx
               	leaq	(%rsp), %rdx
               	movsbq	(%rdx), %rdx
               	addq	%rdx, %rcx
               	leaq	0x30(%rsp), %rdx
               	movsbq	(%rdx), %rdx
               	addq	%rdx, %rcx
               	leaq	0x40(%rsp), %rdx
               	movslq	(%rdx), %rdx
               	addq	%rdx, %rcx
               	leaq	0x50(%rsp), %rdx
               	movsbq	(%rdx), %rdx
               	addq	%rdx, %rcx
               	movsbq	(%rax), %rdx
               	addq	%rdx, %rcx
               	incq	%rax
               	movslq	(%rax), %rax
               	addq	%rcx, %rax
               	subq	$0x9, %rax
               	subq	$0x24, %rax
               	movslq	%eax, %rax
               	leaq	-0x60(%rbp), %rsp
               	leave
               	retq

<declarator_vs_typedef>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movl	$0x1, %eax
               	movl	%eax, -0x10(%rbp)
               	movabsq	$0x4000000000000000, %rcx # imm = 0x4000000000000000
               	movabsq	$0x4008000000000000, %rdx # imm = 0x4008000000000000
               	movq	%rdx, %xmm14
               	movsd	%xmm14, -0x20(%rbp,%riz)
               	leaq	-0x10(%rbp), %rdx
               	leaq	-0x20(%rbp), %rsi
               	testb	$0xf, %sil
               	je	<addr>
               	movl	$0x35, %eax
               	leave
               	retq
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rax, %xmm0
               	movq	%rcx, %xmm15
               	addsd	%xmm15, %xmm0
               	movsd	-0x20(%rbp,%riz), %xmm1
               	addsd	%xmm1, %xmm0
               	cvttsd2si	%xmm0, %rax
               	subq	$0x6, %rax
               	movslq	(%rdx), %rcx
               	decq	%rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	<rip>, %rax
               	testb	$0xf, %al
               	je	<addr>
               	movl	$0x40, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	testb	$0x1f, %al
               	je	<addr>
               	movl	$0x41, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	testb	$0xf, %al
               	je	<addr>
               	movl	$0x42, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	testb	$0xf, %al
               	je	<addr>
               	movl	$0x43, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	testb	$0xf, %cl
               	je	<addr>
               	movl	$0x44, %eax
               	popq	%rbp
               	retq
               	movslq	(%rax), %rax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x45, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movl	$0x3, (%rax)
               	testb	$0xf, %al
               	je	<addr>
               	movl	$0x4c, %eax
               	popq	%rbp
               	retq
               	movslq	(%rax), %rax
               	addq	$0x3, %rax
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0x4e, %eax
               	popq	%rbp
               	retq
               	movl	$0x9, %edi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movslq	%eax, %rax
               	popq	%rbp
               	retq
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movslq	%eax, %rax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
