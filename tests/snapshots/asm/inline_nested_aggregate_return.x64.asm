
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

<make_wide>:
               	popq	%r10
               	subq	$0x20, %rsp
               	movq	%rdi, (%rsp)
               	movq	%rsi, 0x10(%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	leaq	-0x30(%rbp), %rax
               	leaq	(%rax), %rdx
               	movq	0x20(%rbp), %rcx
               	leaq	(%rcx), %rsi
               	movq	%rsi, (%rdx)
               	incq	%rcx
               	movq	%rcx, 0x8(%rax)
               	movq	0x20(%rbp), %rcx
               	addq	$0x2, %rcx
               	movq	%rcx, 0x10(%rax)
               	movq	0x20(%rbp), %rcx
               	addq	$0x3, %rcx
               	movq	%rcx, 0x18(%rax)
               	movq	0x20(%rbp), %rcx
               	addq	$0x4, %rcx
               	movq	%rcx, 0x20(%rax)
               	movq	0x20(%rbp), %rcx
               	addq	$0x5, %rcx
               	movq	%rcx, 0x28(%rax)
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rdx
               	incq	%rdx
               	movl	%edx, (%rcx)
               	movq	0x10(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	movq	0x10(%rax), %rdx
               	movq	%rdx, 0x10(%rcx)
               	movq	0x18(%rax), %rdx
               	movq	%rdx, 0x18(%rcx)
               	movq	0x20(%rax), %rdx
               	movq	%rdx, 0x20(%rcx)
               	movq	0x28(%rax), %rdx
               	movq	%rdx, 0x28(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
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
               	subq	$0x110, %rsp            # imm = 0x110
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	xorq	%rbx, %rbx
               	movl	$0x4, %r12d
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%rax, -0xd0(%rbp)
               	movq	%rdx, -0xc8(%rbp)
               	leaq	-0xd0(%rbp), %rax
               	movq	(%rax), %r13
               	movq	0x8(%rax), %r14
               	leaq	-0x90(%rbp), %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	leaq	-0x90(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rdx
               	movq	0x10(%rax), %rsi
               	movq	0x18(%rax), %rdi
               	movq	0x20(%rax), %r8
               	movq	0x28(%rax), %rax
               	leaq	(%r13,%r14), %r9
               	addq	%r9, %rcx
               	addq	%rdx, %rcx
               	addq	%rsi, %rcx
               	addq	%rdi, %rcx
               	addq	%r8, %rcx
               	addq	%rcx, %rax
               	cmpq	$0x38, %rax
               	je	<addr>
               	movl	$0x1, %ebx
               	xorq	%r12, %r12
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%rax, -0xd0(%rbp)
               	movq	%rdx, -0xc8(%rbp)
               	leaq	-0xd0(%rbp), %rax
               	movq	(%rax), %r13
               	movq	0x8(%rax), %r14
               	leaq	-0x90(%rbp), %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	leaq	-0x90(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rdx
               	movq	0x10(%rax), %rsi
               	movq	0x18(%rax), %rdi
               	movq	0x20(%rax), %r8
               	movq	0x28(%rax), %rax
               	leaq	(%r13,%r14), %r9
               	addq	%r9, %rcx
               	addq	%rdx, %rcx
               	addq	%rsi, %rcx
               	addq	%rdi, %rcx
               	addq	%r8, %rcx
               	addq	%rcx, %rax
               	cmpq	$0x10, %rax
               	je	<addr>
               	orq	$0x2, %rbx
               	movl	$0x4, %edi
               	callq	<addr>
               	movq	%rax, -0xa0(%rbp)
               	movq	%rdx, -0x98(%rbp)
               	leaq	-0xa0(%rbp), %rax
               	movq	(%rax), %rsi
               	movq	0x8(%rax), %r12
               	leaq	-0x60(%rbp), %rdi
               	callq	<addr>
               	leaq	-0x60(%rbp), %rax
               	movq	0x28(%rax), %rax
               	addq	%r12, %rax
               	cmpq	$0x16, %rax
               	je	<addr>
               	orq	$0x4, %rbx
               	movl	$0x5, %edi
               	callq	<addr>
               	movq	%rax, -0xd0(%rbp)
               	movq	%rdx, -0xc8(%rbp)
               	leaq	-0xd0(%rbp), %rax
               	movq	(%rax), %rsi
               	movq	0x8(%rax), %r12
               	leaq	-0x60(%rbp), %rdi
               	callq	<addr>
               	leaq	-0x60(%rbp), %rax
               	movq	0x28(%rax), %rax
               	addq	%r12, %rax
               	cmpq	$0x1a, %rax
               	je	<addr>
               	orq	$0x8, %rbx
               	movl	$0x5, %edi
               	callq	<addr>
               	movq	%rax, -0xa0(%rbp)
               	movq	%rdx, -0x98(%rbp)
               	leaq	-0xa0(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	shlq	%rcx
               	addq	%rcx, %rax
               	cmpq	$0x1a, %rax
               	je	<addr>
               	orq	$0x10, %rbx
               	movl	$0x6, %edi
               	callq	<addr>
               	movsd	%xmm0, -0xa0(%rbp,%riz)
               	movq	%rax, -0x98(%rbp)
               	leaq	-0xa0(%rbp), %rcx
               	leaq	-0xd0(%rbp), %rax
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
               	movl	$0xa, %esi
               	leaq	-0x30(%rbp), %rdi
               	callq	<addr>
               	leaq	-0x30(%rbp), %rax
               	movq	0x18(%rax), %rax
               	cmpq	$0xd, %rax
               	je	<addr>
               	orq	$0x40, %rbx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0xa, %eax
               	je	<addr>
               	orq	$0x80, %rbx
               	movslq	%ebx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
