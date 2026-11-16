
long_double_leaf_sp_asm_borrow.x64:	file format elf64-x86-64

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

<narrow>:
               	leaq	<rip>, %rax # <addr>
               	fldt	(%rax)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	retq

<widen>:
               	leaq	<rip>, %rax # <addr>
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	(%rax)
               	retq

<narrows>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	xorl	%eax, %eax
               	leaq	-0x80(%rbp), %rcx
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rcx
               	leaq	0xb(%rax), %rdx
               	movq	%rdx, (%rcx)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	callq	<addr>
               	movsd	%xmm0, <rip> # <addr>
               	leaq	-0x80(%rbp), %rdx
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	movq	%rax, %rsi
               	shlq	$0x3, %rsi
               	addq	%rdx, %rsi
               	movq	(%rsi), %rsi
               	addq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, %rax
               	leave
               	retq

<widens>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	xorl	%eax, %eax
               	leaq	-0x80(%rbp), %rcx
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rcx
               	leaq	0xb(%rax), %rdx
               	movq	%rdx, (%rcx)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	callq	<addr>
               	leaq	-0x80(%rbp), %rdx
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	movq	%rax, %rsi
               	shlq	$0x3, %rsi
               	addq	%rdx, %rsi
               	movq	(%rsi), %rsi
               	addq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, %rax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	callq	<addr>
               	cmpq	$0x128, %rax            # imm = 0x128
               	jne	<addr>
               	movsd	<rip>, %xmm0 # <addr>
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movsd	<rip>, %xmm0
               	callq	<addr>
               	cmpq	$0x128, %rax            # imm = 0x128
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	fldt	(%rax)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	movl	$0x2a, %eax
               	popq	%rbp
               	retq
