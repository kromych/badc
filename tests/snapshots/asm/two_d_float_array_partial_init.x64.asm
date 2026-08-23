
two_d_float_array_partial_init.x64:	file format elf64-x86-64

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

<__c5_lazy_stream>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rbx, (%rsp)
               	leaq	<rip>, %rbx
               	movq	0x10(%rbx), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movq	0x10(%rbx), %rax
               	movq	(%rsp), %rbx
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	xorq	%rdi, %rdi
               	leaq	<rip>, %rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rcx
               	movq	%rcx, 0x8(%rax)
               	leaq	<rip>, %rsi
               	movq	%rsi, 0x10(%rax)
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movq	(%rax), %rax
               	movq	%rax, 0x10(%rbx)
               	movq	0x10(%rbx), %rax
               	movq	(%rsp), %rbx
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	xorq	%r12, %r12
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rdi
               	jmp	<addr>
               	xorq	%rbx, %rbx
               	jmp	<addr>
               	movslq	%r12d, %rax
               	shlq	$0x4, %rax
               	leaq	(%rdi,%rax), %r8
               	movslq	%ebx, %rcx
               	movq	%rcx, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %r8
               	movss	(%r8,%riz), %xmm0
               	addq	%rsi, %rax
               	addq	%rdx, %rax
               	movss	(%rax,%riz), %xmm1
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	leaq	0x1(%rcx), %rbx
               	cmpl	$0x4, %ebx
               	jl	<addr>
               	movslq	%r12d, %rax
               	leaq	0x1(%rax), %r12
               	cmpl	$0xc, %r12d
               	jl	<addr>
               	xorq	%rcx, %rcx
               	movq	%rcx, %xmm14
               	movss	%xmm14, -0x8(%rbp,%riz)
               	movss	-0x8(%rbp,%riz), %xmm0
               	leaq	<rip>, %rax
               	addq	$0x0, %rax
               	movss	(%rax,%riz), %xmm1
               	movss	0x4(%rax,%riz), %xmm2
               	addss	%xmm2, %xmm1
               	movss	0x8(%rax,%riz), %xmm2
               	addss	%xmm2, %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, -0x8(%rbp,%riz)
               	movss	-0x8(%rbp,%riz), %xmm0
               	leaq	<rip>, %rax
               	addq	$0x10, %rax
               	movss	(%rax,%riz), %xmm1
               	movss	0x4(%rax,%riz), %xmm2
               	addss	%xmm2, %xmm1
               	movss	0x8(%rax,%riz), %xmm2
               	addss	%xmm2, %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, -0x8(%rbp,%riz)
               	movss	-0x8(%rbp,%riz), %xmm0
               	leaq	<rip>, %rax
               	addq	$0x20, %rax
               	movss	(%rax,%riz), %xmm1
               	movss	0x4(%rax,%riz), %xmm2
               	addss	%xmm2, %xmm1
               	movss	0x8(%rax,%riz), %xmm2
               	addss	%xmm2, %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, -0x8(%rbp,%riz)
               	movss	-0x8(%rbp,%riz), %xmm0
               	leaq	<rip>, %rax
               	addq	$0x30, %rax
               	movss	(%rax,%riz), %xmm1
               	movss	0x4(%rax,%riz), %xmm2
               	addss	%xmm2, %xmm1
               	movss	0x8(%rax,%riz), %xmm2
               	addss	%xmm2, %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, -0x8(%rbp,%riz)
               	movss	-0x8(%rbp,%riz), %xmm0
               	leaq	<rip>, %rax
               	addq	$0x40, %rax
               	movss	(%rax,%riz), %xmm1
               	movss	0x4(%rax,%riz), %xmm2
               	addss	%xmm2, %xmm1
               	movss	0x8(%rax,%riz), %xmm2
               	addss	%xmm2, %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, -0x8(%rbp,%riz)
               	movss	-0x8(%rbp,%riz), %xmm0
               	leaq	<rip>, %rax
               	addq	$0x50, %rax
               	movss	(%rax,%riz), %xmm1
               	movss	0x4(%rax,%riz), %xmm2
               	addss	%xmm2, %xmm1
               	movss	0x8(%rax,%riz), %xmm2
               	addss	%xmm2, %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, -0x8(%rbp,%riz)
               	movss	-0x8(%rbp,%riz), %xmm0
               	leaq	<rip>, %rax
               	addq	$0x60, %rax
               	movss	(%rax,%riz), %xmm1
               	movss	0x4(%rax,%riz), %xmm2
               	addss	%xmm2, %xmm1
               	movss	0x8(%rax,%riz), %xmm2
               	addss	%xmm2, %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, -0x8(%rbp,%riz)
               	movss	-0x8(%rbp,%riz), %xmm0
               	leaq	<rip>, %rax
               	addq	$0x70, %rax
               	movss	(%rax,%riz), %xmm1
               	movss	0x4(%rax,%riz), %xmm2
               	addss	%xmm2, %xmm1
               	movss	0x8(%rax,%riz), %xmm2
               	addss	%xmm2, %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, -0x8(%rbp,%riz)
               	movss	-0x8(%rbp,%riz), %xmm0
               	leaq	<rip>, %rax
               	addq	$0x80, %rax
               	movss	(%rax,%riz), %xmm1
               	movss	0x4(%rax,%riz), %xmm2
               	addss	%xmm2, %xmm1
               	movss	0x8(%rax,%riz), %xmm2
               	addss	%xmm2, %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, -0x8(%rbp,%riz)
               	movss	-0x8(%rbp,%riz), %xmm0
               	leaq	<rip>, %rax
               	addq	$0x90, %rax
               	movss	(%rax,%riz), %xmm1
               	movss	0x4(%rax,%riz), %xmm2
               	addss	%xmm2, %xmm1
               	movss	0x8(%rax,%riz), %xmm2
               	addss	%xmm2, %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, -0x8(%rbp,%riz)
               	movss	-0x8(%rbp,%riz), %xmm0
               	leaq	<rip>, %rax
               	addq	$0xa0, %rax
               	movss	(%rax,%riz), %xmm1
               	movss	0x4(%rax,%riz), %xmm2
               	addss	%xmm2, %xmm1
               	movss	0x8(%rax,%riz), %xmm2
               	addss	%xmm2, %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, -0x8(%rbp,%riz)
               	movss	-0x8(%rbp,%riz), %xmm0
               	leaq	<rip>, %rax
               	addq	$0xb0, %rax
               	movss	(%rax,%riz), %xmm1
               	movss	0x4(%rax,%riz), %xmm2
               	addss	%xmm2, %xmm1
               	movss	0x8(%rax,%riz), %xmm2
               	addss	%xmm2, %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, -0x8(%rbp,%riz)
               	movss	-0x8(%rbp,%riz), %xmm0
               	movq	%rcx, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x2, %ebx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	movss	-0x8(%rbp,%riz), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movb	$0x1, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rbx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdi
               	leaq	<rip>, %r8
               	movslq	%r12d, %rdx
               	movslq	%ebx, %rcx
               	leaq	<rip>, %rsi
               	movq	%rdx, %rax
               	shlq	$0x4, %rax
               	leaq	(%rsi,%rax), %r9
               	movq	%rcx, %rsi
               	shlq	$0x2, %rsi
               	addq	%rsi, %r9
               	movss	(%r9,%riz), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	leaq	<rip>, %r9
               	addq	%r9, %rax
               	addq	%rsi, %rax
               	movss	(%rax,%riz), %xmm1
               	cvtss2sd	%xmm1, %xmm1
               	movq	%r8, %rsi
               	movb	$0x2, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
