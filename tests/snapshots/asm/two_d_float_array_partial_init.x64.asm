
two_d_float_array_partial_init.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<__c5_lazy_stream>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%rdi, %rbx
               	movslq	%ebx, %rbx
               	leaq	<rip>, %r12
               	movq	(%r12,%rbx,8), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movq	(%r12,%rbx,8), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	xorq	%rdi, %rdi
               	leaq	<rip>, %rcx
               	movq	%rcx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	%rcx, 0x10(%rax)
               	leaq	-0x18(%rbp), %rax
               	movq	(%rax,%rbx,8), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movq	(%rax), %rax
               	movq	%rax, (%r12,%rbx,8)
               	movq	(%r12,%rbx,8), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	xorq	%r12, %r12
               	jmp	<addr>
               	xorq	%rbx, %rbx
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	movq	%rsi, %rcx
               	shlq	$0x4, %rcx
               	leaq	(%rdx,%rcx), %rdi
               	movq	%rax, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %rdi
               	movss	(%rdi,%riz), %xmm0
               	leaq	<rip>, %rdi
               	addq	%rdi, %rcx
               	addq	%rdx, %rcx
               	movss	(%rcx,%riz), %xmm1
               	ucomiss	%xmm1, %xmm0
               	setne	%cl
               	movzbq	%cl, %rcx
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	0x1(%rax), %rbx
               	movslq	%ebx, %rax
               	cmpq	$0x4, %rax
               	jl	<addr>
               	leaq	0x1(%rsi), %r12
               	movslq	%r12d, %rsi
               	cmpq	$0xc, %rsi
               	jl	<addr>
               	xorq	%rax, %rax
               	movq	%rax, %xmm14
               	movss	%xmm14, -0x18(%rbp,%riz)
               	movss	-0x18(%rbp,%riz), %xmm0
               	leaq	<rip>, %rax
               	addq	$0x0, %rax
               	movss	(%rax,%riz), %xmm1
               	movss	0x4(%rax,%riz), %xmm2
               	addss	%xmm2, %xmm1
               	movss	0x8(%rax,%riz), %xmm2
               	addss	%xmm2, %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, -0x18(%rbp,%riz)
               	movss	-0x18(%rbp,%riz), %xmm0
               	leaq	<rip>, %rax
               	addq	$0x10, %rax
               	movss	(%rax,%riz), %xmm1
               	movss	0x4(%rax,%riz), %xmm2
               	addss	%xmm2, %xmm1
               	movss	0x8(%rax,%riz), %xmm2
               	addss	%xmm2, %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, -0x18(%rbp,%riz)
               	movss	-0x18(%rbp,%riz), %xmm0
               	leaq	<rip>, %rax
               	addq	$0x20, %rax
               	movss	(%rax,%riz), %xmm1
               	movss	0x4(%rax,%riz), %xmm2
               	addss	%xmm2, %xmm1
               	movss	0x8(%rax,%riz), %xmm2
               	addss	%xmm2, %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, -0x18(%rbp,%riz)
               	movss	-0x18(%rbp,%riz), %xmm0
               	leaq	<rip>, %rax
               	addq	$0x30, %rax
               	movss	(%rax,%riz), %xmm1
               	movss	0x4(%rax,%riz), %xmm2
               	addss	%xmm2, %xmm1
               	movss	0x8(%rax,%riz), %xmm2
               	addss	%xmm2, %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, -0x18(%rbp,%riz)
               	movss	-0x18(%rbp,%riz), %xmm0
               	leaq	<rip>, %rax
               	addq	$0x40, %rax
               	movss	(%rax,%riz), %xmm1
               	movss	0x4(%rax,%riz), %xmm2
               	addss	%xmm2, %xmm1
               	movss	0x8(%rax,%riz), %xmm2
               	addss	%xmm2, %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, -0x18(%rbp,%riz)
               	movss	-0x18(%rbp,%riz), %xmm0
               	leaq	<rip>, %rax
               	addq	$0x50, %rax
               	movss	(%rax,%riz), %xmm1
               	movss	0x4(%rax,%riz), %xmm2
               	addss	%xmm2, %xmm1
               	movss	0x8(%rax,%riz), %xmm2
               	addss	%xmm2, %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, -0x18(%rbp,%riz)
               	movss	-0x18(%rbp,%riz), %xmm0
               	leaq	<rip>, %rax
               	addq	$0x60, %rax
               	movss	(%rax,%riz), %xmm1
               	movss	0x4(%rax,%riz), %xmm2
               	addss	%xmm2, %xmm1
               	movss	0x8(%rax,%riz), %xmm2
               	addss	%xmm2, %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, -0x18(%rbp,%riz)
               	movss	-0x18(%rbp,%riz), %xmm0
               	leaq	<rip>, %rax
               	addq	$0x70, %rax
               	movss	(%rax,%riz), %xmm1
               	movss	0x4(%rax,%riz), %xmm2
               	addss	%xmm2, %xmm1
               	movss	0x8(%rax,%riz), %xmm2
               	addss	%xmm2, %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, -0x18(%rbp,%riz)
               	movss	-0x18(%rbp,%riz), %xmm0
               	leaq	<rip>, %rax
               	addq	$0x80, %rax
               	movss	(%rax,%riz), %xmm1
               	movss	0x4(%rax,%riz), %xmm2
               	addss	%xmm2, %xmm1
               	movss	0x8(%rax,%riz), %xmm2
               	addss	%xmm2, %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, -0x18(%rbp,%riz)
               	movss	-0x18(%rbp,%riz), %xmm0
               	leaq	<rip>, %rax
               	addq	$0x90, %rax
               	movss	(%rax,%riz), %xmm1
               	movss	0x4(%rax,%riz), %xmm2
               	addss	%xmm2, %xmm1
               	movss	0x8(%rax,%riz), %xmm2
               	addss	%xmm2, %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, -0x18(%rbp,%riz)
               	movss	-0x18(%rbp,%riz), %xmm0
               	leaq	<rip>, %rax
               	addq	$0xa0, %rax
               	movss	(%rax,%riz), %xmm1
               	movss	0x4(%rax,%riz), %xmm2
               	addss	%xmm2, %xmm1
               	movss	0x8(%rax,%riz), %xmm2
               	addss	%xmm2, %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, -0x18(%rbp,%riz)
               	movss	-0x18(%rbp,%riz), %xmm0
               	leaq	<rip>, %rax
               	addq	$0xb0, %rax
               	movss	(%rax,%riz), %xmm1
               	movss	0x4(%rax,%riz), %xmm2
               	addss	%xmm2, %xmm1
               	movss	0x8(%rax,%riz), %xmm2
               	addss	%xmm2, %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, -0x18(%rbp,%riz)
               	movss	-0x18(%rbp,%riz), %xmm0
               	xorq	%rax, %rax
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %ebx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	movss	-0x18(%rbp,%riz), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movb	$0x1, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rbx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x50, %rsp
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
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	addb	%al, 0x41(%rdx)
