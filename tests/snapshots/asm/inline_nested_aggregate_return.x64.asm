
inline_nested_aggregate_return.x64:	file format elf64-x86-64

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

<make_pair>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x10(%rbp), %rax
               	movq	%rdi, (%rax)
               	leaq	(%rdi,%rdi,2), %rcx
               	incq	%rcx
               	movq	%rcx, 0x8(%rax)
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rdx
               	incq	%rdx
               	movl	%edx, (%rcx)
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<make_mixed>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x10(%rbp), %rax
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rdi, %xmm0
               	movabsq	$0x4000000000000000, %rcx # imm = 0x4000000000000000
               	movq	%rcx, %xmm15
               	divsd	%xmm15, %xmm0
               	movsd	%xmm0, (%rax,%riz)
               	movq	%rdi, 0x8(%rax)
               	movq	%rax, %rcx
               	movsd	(%rcx,%riz), %xmm0
               	movq	0x8(%rcx), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xd0, %rsp
               	movq	%rbx, (%rsp)
               	xorq	%rbx, %rbx
               	movl	$0x4, %edi
               	callq	<addr>
               	movq	%rax, -0xa0(%rbp)
               	movq	%rdx, -0x98(%rbp)
               	leaq	-0xa0(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rdx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rsi
               	incq	%rsi
               	movl	%esi, (%rax)
               	leaq	(%rcx,%rdx), %rax
               	addq	$0x4, %rax
               	addq	$0x5, %rax
               	addq	$0x6, %rax
               	addq	$0x7, %rax
               	addq	$0x8, %rax
               	addq	$0x9, %rax
               	cmpq	$0x38, %rax
               	je	<addr>
               	movl	$0x1, %ebx
               	xorq	%rdi, %rdi
               	callq	<addr>
               	movq	%rax, -0xa0(%rbp)
               	movq	%rdx, -0x98(%rbp)
               	leaq	-0xa0(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rdx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rsi
               	incq	%rsi
               	movl	%esi, (%rax)
               	leaq	(%rcx,%rdx), %rax
               	addq	$0x0, %rax
               	incq	%rax
               	addq	$0x2, %rax
               	addq	$0x3, %rax
               	addq	$0x4, %rax
               	addq	$0x5, %rax
               	cmpq	$0x10, %rax
               	je	<addr>
               	orq	$0x2, %rbx
               	movl	$0x4, %edi
               	callq	<addr>
               	movq	%rax, -0x40(%rbp)
               	movq	%rdx, -0x38(%rbp)
               	leaq	-0x40(%rbp), %rcx
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rcx
               	leaq	0x5(%rax), %rdx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rsi
               	incq	%rsi
               	movl	%esi, (%rax)
               	leaq	(%rcx,%rdx), %rax
               	cmpq	$0x16, %rax
               	je	<addr>
               	orq	$0x4, %rbx
               	movl	$0x5, %edi
               	callq	<addr>
               	movq	%rax, -0xa0(%rbp)
               	movq	%rdx, -0x98(%rbp)
               	leaq	-0xa0(%rbp), %rcx
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rcx
               	leaq	0x5(%rax), %rdx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rsi
               	incq	%rsi
               	movl	%esi, (%rax)
               	leaq	(%rcx,%rdx), %rax
               	cmpq	$0x1a, %rax
               	je	<addr>
               	orq	$0x8, %rbx
               	movl	$0x5, %edi
               	callq	<addr>
               	movq	%rax, -0x40(%rbp)
               	movq	%rdx, -0x38(%rbp)
               	leaq	-0x40(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	shlq	%rcx
               	addq	%rcx, %rax
               	cmpq	$0x1a, %rax
               	je	<addr>
               	orq	$0x10, %rbx
               	movl	$0x6, %edi
               	callq	<addr>
               	movsd	%xmm0, -0x40(%rbp,%riz)
               	movq	%rax, -0x38(%rbp)
               	leaq	-0x40(%rbp), %rcx
               	leaq	-0x70(%rbp), %rax
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	movq	%rax, %rcx
               	movsd	(%rax,%riz), %xmm0
               	movq	0x8(%rax), %rax
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rax, %xmm1
               	movapd	%xmm1, %xmm15
               	movapd	%xmm0, %xmm1
               	addsd	%xmm15, %xmm1
               	movabsq	$0x4008000000000000, %rax # imm = 0x4008000000000000
               	movabsq	$0x4018000000000000, %rcx # imm = 0x4018000000000000
               	movq	%rcx, %xmm15
               	movq	%rax, %xmm0
               	addsd	%xmm15, %xmm0
               	ucomisd	%xmm0, %xmm1
               	jp	<addr>
               	je	<addr>
               	orq	$0x20, %rbx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0xa, %eax
               	je	<addr>
               	orq	$0x80, %rbx
               	movslq	%ebx, %rax
               	movq	(%rsp), %rbx
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
