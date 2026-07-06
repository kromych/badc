
ssa_bail_fixup_rollback.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<ld32>:
               	movzbq	0x3(%rdi), %rax
               	movl	%eax, %eax
               	shlq	$0x8, %rax
               	movl	%eax, %eax
               	movzbq	0x2(%rdi), %rcx
               	orq	%rcx, %rax
               	movl	%eax, %eax
               	shlq	$0x8, %rax
               	movl	%eax, %eax
               	movzbq	0x1(%rdi), %rcx
               	orq	%rcx, %rax
               	movl	%eax, %eax
               	shlq	$0x8, %rax
               	movl	%eax, %eax
               	movzbq	(%rdi), %rcx
               	orq	%rcx, %rax
               	retq

<core>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	xorq	%r8, %r8
               	jmp	<addr>
               	leaq	-0x40(%rbp), %r9
               	leaq	(%r8,%r8,4), %rbx
               	movslq	%ebx, %rbx
               	movq	%r8, %r12
               	shlq	$0x2, %r12
               	movslq	%r12d, %r12
               	addq	%rcx, %r12
               	movzbq	0x3(%r12), %r13
               	movl	%r13d, %r13d
               	shlq	$0x8, %r13
               	movl	%r13d, %r13d
               	movzbq	0x2(%r12), %r14
               	orq	%r14, %r13
               	movl	%r13d, %r13d
               	shlq	$0x8, %r13
               	movl	%r13d, %r13d
               	movzbq	0x1(%r12), %r14
               	orq	%r14, %r13
               	movl	%r13d, %r13d
               	shlq	$0x8, %r13
               	movl	%r13d, %r13d
               	movzbq	(%r12), %r12
               	orq	%r13, %r12
               	movl	%r12d, (%r9,%rbx,4)
               	leaq	-0x40(%rbp), %r9
               	leaq	0x1(%r8), %rbx
               	movslq	%ebx, %rbx
               	movq	%r8, %r12
               	shlq	$0x2, %r12
               	movslq	%r12d, %r12
               	addq	%rdx, %r12
               	movzbq	0x3(%r12), %r13
               	movl	%r13d, %r13d
               	shlq	$0x8, %r13
               	movl	%r13d, %r13d
               	movzbq	0x2(%r12), %r14
               	orq	%r14, %r13
               	movl	%r13d, %r13d
               	shlq	$0x8, %r13
               	movl	%r13d, %r13d
               	movzbq	0x1(%r12), %r14
               	orq	%r14, %r13
               	movl	%r13d, %r13d
               	shlq	$0x8, %r13
               	movl	%r13d, %r13d
               	movzbq	(%r12), %r12
               	orq	%r13, %r12
               	movl	%r12d, (%r9,%rbx,4)
               	leaq	-0x40(%rbp), %r9
               	leaq	0x6(%r8), %rbx
               	movslq	%ebx, %rbx
               	movq	%r8, %r12
               	shlq	$0x2, %r12
               	movslq	%r12d, %r12
               	addq	%rsi, %r12
               	movzbq	0x3(%r12), %r13
               	movl	%r13d, %r13d
               	shlq	$0x8, %r13
               	movl	%r13d, %r13d
               	movzbq	0x2(%r12), %r14
               	orq	%r14, %r13
               	movl	%r13d, %r13d
               	shlq	$0x8, %r13
               	movl	%r13d, %r13d
               	movzbq	0x1(%r12), %r14
               	orq	%r14, %r13
               	movl	%r13d, %r13d
               	shlq	$0x8, %r13
               	movl	%r13d, %r13d
               	movzbq	(%r12), %r12
               	orq	%r13, %r12
               	movl	%r12d, (%r9,%rbx,4)
               	leaq	-0x40(%rbp), %r9
               	leaq	0xb(%r8), %rbx
               	movslq	%ebx, %rbx
               	leaq	0x10(%rdx), %r12
               	movq	%r8, %r13
               	shlq	$0x2, %r13
               	movslq	%r13d, %r13
               	addq	%r13, %r12
               	movzbq	0x3(%r12), %r13
               	movl	%r13d, %r13d
               	shlq	$0x8, %r13
               	movl	%r13d, %r13d
               	movzbq	0x2(%r12), %r14
               	orq	%r14, %r13
               	movl	%r13d, %r13d
               	shlq	$0x8, %r13
               	movl	%r13d, %r13d
               	movzbq	0x1(%r12), %r14
               	orq	%r14, %r13
               	movl	%r13d, %r13d
               	shlq	$0x8, %r13
               	movl	%r13d, %r13d
               	movzbq	(%r12), %r12
               	orq	%r13, %r12
               	movl	%r12d, (%r9,%rbx,4)
               	leaq	0x1(%rax), %r8
               	movslq	%r8d, %rax
               	cmpq	$0x4, %rax
               	jl	<addr>
               	xorq	%rax, %rax
               	leaq	-0x40(%rbp), %rcx
               	movl	(%rcx), %ecx
               	leaq	-0x40(%rbp), %rdx
               	movl	0x14(%rdx), %edx
               	xorq	%rdx, %rcx
               	leaq	-0x40(%rbp), %rdx
               	movl	0x28(%rdx), %edx
               	xorq	%rdx, %rcx
               	leaq	-0x40(%rbp), %rdx
               	movl	0x3c(%rdx), %edx
               	xorq	%rdx, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, (%rdi)
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq

<stream_xor>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xa0, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movq	%rdi, %r12
               	movq	%r8, %rbx
               	movq	%rdx, %r14
               	movq	%rsi, %r13
               	testq	%r14, %r14
               	jne	<addr>
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	addq	$0x0, %rax
               	xorq	%rdx, %rdx
               	movb	%dl, (%rax)
               	leaq	-0x10(%rbp), %rax
               	xorq	%rdx, %rdx
               	movb	%dl, 0x1(%rax)
               	leaq	-0x10(%rbp), %rax
               	xorq	%rdx, %rdx
               	movb	%dl, 0x2(%rax)
               	leaq	-0x10(%rbp), %rax
               	xorq	%rdx, %rdx
               	movb	%dl, 0x3(%rax)
               	leaq	-0x10(%rbp), %rax
               	xorq	%rdx, %rdx
               	movb	%dl, 0x4(%rax)
               	leaq	-0x10(%rbp), %rax
               	xorq	%rdx, %rdx
               	movb	%dl, 0x5(%rax)
               	leaq	-0x10(%rbp), %rax
               	xorq	%rdx, %rdx
               	movb	%dl, 0x6(%rax)
               	leaq	-0x10(%rbp), %rax
               	xorq	%rdx, %rdx
               	movb	%dl, 0x7(%rax)
               	leaq	-0x10(%rbp), %rax
               	xorq	%rdx, %rdx
               	movb	%dl, 0x8(%rax)
               	leaq	-0x10(%rbp), %rax
               	xorq	%rdx, %rdx
               	movb	%dl, 0x9(%rax)
               	leaq	-0x10(%rbp), %rax
               	xorq	%rdx, %rdx
               	movb	%dl, 0xa(%rax)
               	leaq	-0x10(%rbp), %rax
               	xorq	%rdx, %rdx
               	movb	%dl, 0xb(%rax)
               	leaq	-0x10(%rbp), %rax
               	xorq	%rdx, %rdx
               	movb	%dl, 0xc(%rax)
               	leaq	-0x10(%rbp), %rax
               	xorq	%rdx, %rdx
               	movb	%dl, 0xd(%rax)
               	leaq	-0x10(%rbp), %rax
               	xorq	%rdx, %rdx
               	movb	%dl, 0xe(%rax)
               	leaq	-0x10(%rbp), %rax
               	xorq	%rdx, %rdx
               	movb	%dl, 0xf(%rax)
               	leaq	-0x10(%rbp), %rax
               	addq	$0x0, %rax
               	leaq	(%rcx), %rdx
               	movzbq	(%rdx), %rdx
               	movb	%dl, (%rax)
               	leaq	-0x10(%rbp), %rax
               	movzbq	0x1(%rcx), %rdx
               	movb	%dl, 0x1(%rax)
               	leaq	-0x10(%rbp), %rax
               	movzbq	0x2(%rcx), %rdx
               	movb	%dl, 0x2(%rax)
               	leaq	-0x10(%rbp), %rax
               	movzbq	0x3(%rcx), %rdx
               	movb	%dl, 0x3(%rax)
               	leaq	-0x10(%rbp), %rax
               	movzbq	0x4(%rcx), %rdx
               	movb	%dl, 0x4(%rax)
               	leaq	-0x10(%rbp), %rax
               	movzbq	0x5(%rcx), %rdx
               	movb	%dl, 0x5(%rax)
               	leaq	-0x10(%rbp), %rax
               	movzbq	0x6(%rcx), %rdx
               	movb	%dl, 0x6(%rax)
               	leaq	-0x10(%rbp), %rax
               	movzbq	0x7(%rcx), %rcx
               	movb	%cl, 0x7(%rax)
               	jmp	<addr>
               	leaq	-0x50(%rbp), %rdi
               	leaq	-0x10(%rbp), %rsi
               	leaq	<rip>, %rcx
               	movq	%rbx, %rdx
               	callq	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	%ecx, %eax
               	addq	%r12, %rax
               	testq	%r13, %r13
               	je	<addr>
               	movl	%ecx, %edx
               	addq	%r13, %rdx
               	movzbq	(%rdx), %rsi
               	leaq	-0x50(%rbp), %rdx
               	movl	%ecx, %edi
               	addq	%rdi, %rdx
               	movzbq	(%rdx), %rdx
               	xorq	%rsi, %rdx
               	movb	%dl, (%rax)
               	jmp	<addr>
               	xorq	%rsi, %rsi
               	jmp	<addr>
               	movl	%ecx, %eax
               	leaq	0x1(%rax), %rcx
               	movl	%ecx, %eax
               	cmpq	$0x40, %rax
               	jb	<addr>
               	subq	$0x40, %r14
               	addq	$0x40, %r12
               	testq	%r13, %r13
               	je	<addr>
               	addq	$0x40, %r13
               	jmp	<addr>
               	cmpq	$0x40, %r14
               	jae	<addr>
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xa0, %rsp
               	leaq	-0x48(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	popq	%rdx
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	leaq	-0x68(%rbp), %rdx
               	addq	%rax, %rdx
               	movq	%rax, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, (%rdx)
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x20, %rax
               	jl	<addr>
               	leaq	-0x40(%rbp), %rdi
               	xorq	%rsi, %rsi
               	movl	$0x40, %edx
               	leaq	-0x48(%rbp), %rcx
               	leaq	-0x68(%rbp), %r8
               	callq	<addr>
               	leaq	-0x40(%rbp), %rax
               	movzbq	(%rax), %rax
               	xorq	$0x4d, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %ecx
               	jmp	<addr>
