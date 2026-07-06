
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
               	movq	%rdi, %r14
               	movq	%rcx, %r12
               	movq	%rsi, %rbx
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x40(%rbp), %rdi
               	leaq	(%rax,%rax,4), %rcx
               	movslq	%ecx, %r8
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	movslq	%ecx, %rcx
               	addq	%r12, %rcx
               	movzbq	0x3(%rcx), %r9
               	movl	%r9d, %r9d
               	shlq	$0x8, %r9
               	movl	%r9d, %r9d
               	movzbq	0x2(%rcx), %r13
               	orq	%r13, %r9
               	movl	%r9d, %r9d
               	shlq	$0x8, %r9
               	movl	%r9d, %r9d
               	movzbq	0x1(%rcx), %r13
               	orq	%r13, %r9
               	movl	%r9d, %r9d
               	shlq	$0x8, %r9
               	movl	%r9d, %r9d
               	movzbq	(%rcx), %rcx
               	orq	%r9, %rcx
               	movl	%ecx, (%rdi,%r8,4)
               	leaq	-0x40(%rbp), %rdi
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %r8
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	movslq	%ecx, %rcx
               	addq	%rdx, %rcx
               	movzbq	0x3(%rcx), %r9
               	movl	%r9d, %r9d
               	shlq	$0x8, %r9
               	movl	%r9d, %r9d
               	movzbq	0x2(%rcx), %r13
               	orq	%r13, %r9
               	movl	%r9d, %r9d
               	shlq	$0x8, %r9
               	movl	%r9d, %r9d
               	movzbq	0x1(%rcx), %r13
               	orq	%r13, %r9
               	movl	%r9d, %r9d
               	shlq	$0x8, %r9
               	movl	%r9d, %r9d
               	movzbq	(%rcx), %rcx
               	orq	%r9, %rcx
               	movl	%ecx, (%rdi,%r8,4)
               	leaq	-0x40(%rbp), %rdi
               	leaq	0x6(%rax), %rcx
               	movslq	%ecx, %r8
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	movslq	%ecx, %rcx
               	addq	%rbx, %rcx
               	movzbq	0x3(%rcx), %r9
               	movl	%r9d, %r9d
               	shlq	$0x8, %r9
               	movl	%r9d, %r9d
               	movzbq	0x2(%rcx), %r13
               	orq	%r13, %r9
               	movl	%r9d, %r9d
               	shlq	$0x8, %r9
               	movl	%r9d, %r9d
               	movzbq	0x1(%rcx), %r13
               	orq	%r13, %r9
               	movl	%r9d, %r9d
               	shlq	$0x8, %r9
               	movl	%r9d, %r9d
               	movzbq	(%rcx), %rcx
               	orq	%r9, %rcx
               	movl	%ecx, (%rdi,%r8,4)
               	leaq	-0x40(%rbp), %rdi
               	leaq	0xb(%rax), %rcx
               	movslq	%ecx, %r8
               	leaq	0x10(%rdx), %r9
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	movslq	%ecx, %rcx
               	addq	%r9, %rcx
               	movzbq	0x3(%rcx), %r9
               	movl	%r9d, %r9d
               	shlq	$0x8, %r9
               	movl	%r9d, %r9d
               	movzbq	0x2(%rcx), %r13
               	orq	%r13, %r9
               	movl	%r9d, %r9d
               	shlq	$0x8, %r9
               	movl	%r9d, %r9d
               	movzbq	0x1(%rcx), %r13
               	orq	%r13, %r9
               	movl	%r9d, %r9d
               	shlq	$0x8, %r9
               	movl	%r9d, %r9d
               	movzbq	(%rcx), %rcx
               	orq	%r9, %rcx
               	movl	%ecx, (%rdi,%r8,4)
               	leaq	0x1(%rsi), %rax
               	movslq	%eax, %rsi
               	cmpq	$0x4, %rsi
               	jl	<addr>
               	xorq	%rcx, %rcx
               	leaq	-0x40(%rbp), %rax
               	movl	(%rax), %edx
               	leaq	-0x40(%rbp), %rax
               	movl	0x14(%rax), %eax
               	xorq	%rax, %rdx
               	leaq	-0x40(%rbp), %rax
               	movl	0x28(%rax), %eax
               	xorq	%rax, %rdx
               	leaq	-0x40(%rbp), %rax
               	movl	0x3c(%rax), %eax
               	xorq	%rdx, %rax
               	andq	$0xff, %rax
               	movb	%al, (%r14)
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	%rcx, %rax
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
               	movq	%r8, %r14
               	movq	%rdx, %r13
               	movq	%rsi, %rbx
               	testq	%r13, %r13
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
               	movq	%r14, %rdx
               	callq	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	movl	%eax, %ecx
               	leaq	(%r12,%rcx), %rdx
               	testq	%rbx, %rbx
               	je	<addr>
               	movl	%eax, %ecx
               	addq	%rbx, %rcx
               	movzbq	(%rcx), %rcx
               	leaq	-0x50(%rbp), %rsi
               	movl	%eax, %edi
               	addq	%rdi, %rsi
               	movzbq	(%rsi), %rsi
               	xorq	%rsi, %rcx
               	movb	%cl, (%rdx)
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	%eax, %eax
               	incq	%rax
               	movl	%eax, %ecx
               	cmpq	$0x40, %rcx
               	jb	<addr>
               	subq	$0x40, %r13
               	addq	$0x40, %r12
               	testq	%rbx, %rbx
               	je	<addr>
               	addq	$0x40, %rbx
               	jmp	<addr>
               	cmpq	$0x40, %r13
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
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x68(%rbp), %rdx
               	addq	%rcx, %rdx
               	movq	%rcx, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, (%rdx)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x20, %rcx
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
               	xorq	%rax, %rax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
