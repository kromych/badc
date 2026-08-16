
ssa_bail_fixup_rollback.x64:	file format elf64-x86-64

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

<core>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%rdi, %r12
               	leaq	(%rcx), %rax
               	movzbq	0x3(%rax), %rdi
               	movl	%edi, %edi
               	shlq	$0x8, %rdi
               	movl	%edi, %edi
               	movzbq	0x2(%rax), %r8
               	orq	%r8, %rdi
               	movl	%edi, %edi
               	shlq	$0x8, %rdi
               	movl	%edi, %edi
               	movzbq	0x1(%rax), %r8
               	orq	%r8, %rdi
               	movl	%edi, %edi
               	shlq	$0x8, %rdi
               	movl	%edi, %edi
               	movzbq	(%rax), %rax
               	orq	%rdi, %rax
               	movl	%eax, %edi
               	leaq	0x4(%rcx), %rax
               	movzbq	0x3(%rax), %r8
               	movl	%r8d, %r8d
               	shlq	$0x8, %r8
               	movl	%r8d, %r8d
               	movzbq	0x2(%rax), %r9
               	orq	%r9, %r8
               	movl	%r8d, %r8d
               	shlq	$0x8, %r8
               	movl	%r8d, %r8d
               	movzbq	0x1(%rax), %r9
               	orq	%r9, %r8
               	movl	%r8d, %r8d
               	shlq	$0x8, %r8
               	movl	%r8d, %r8d
               	movzbq	(%rax), %rax
               	orq	%r8, %rax
               	movl	%eax, %r8d
               	leaq	0x8(%rcx), %rax
               	movzbq	0x3(%rax), %r9
               	movl	%r9d, %r9d
               	shlq	$0x8, %r9
               	movl	%r9d, %r9d
               	movzbq	0x2(%rax), %rbx
               	orq	%rbx, %r9
               	movl	%r9d, %r9d
               	shlq	$0x8, %r9
               	movl	%r9d, %r9d
               	movzbq	0x1(%rax), %rbx
               	orq	%rbx, %r9
               	movl	%r9d, %r9d
               	shlq	$0x8, %r9
               	movl	%r9d, %r9d
               	movzbq	(%rax), %rax
               	orq	%r9, %rax
               	movl	%eax, %r9d
               	leaq	0xc(%rcx), %rax
               	movzbq	0x3(%rax), %rcx
               	movl	%ecx, %ecx
               	shlq	$0x8, %rcx
               	movl	%ecx, %ecx
               	movzbq	0x2(%rax), %rbx
               	orq	%rbx, %rcx
               	movl	%ecx, %ecx
               	shlq	$0x8, %rcx
               	movl	%ecx, %ecx
               	movzbq	0x1(%rax), %rbx
               	orq	%rbx, %rcx
               	movl	%ecx, %ecx
               	shlq	$0x8, %rcx
               	movl	%ecx, %ecx
               	movzbq	(%rax), %rax
               	orq	%rcx, %rax
               	movl	%eax, %ecx
               	xorq	%rax, %rax
               	movl	%edi, %edx
               	movl	%r8d, %esi
               	xorq	%rsi, %rdx
               	movl	%r9d, %esi
               	xorq	%rsi, %rdx
               	movl	%ecx, %ecx
               	xorq	%rdx, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, (%r12)
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq

<stream_xor>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movq	%rdi, %r12
               	movq	%r8, %r14
               	xorq	%rbx, %rbx
               	movl	$0x40, %r13d
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
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	leaq	-0x68(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	popq	%rdx
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x20(%rbp), %rdx
               	addq	%rcx, %rdx
               	movq	%rcx, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, (%rdx)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x20, %rcx
               	jl	<addr>
               	leaq	-0x60(%rbp), %rdi
               	xorq	%rsi, %rsi
               	movl	$0x40, %edx
               	leaq	-0x68(%rbp), %rcx
               	leaq	-0x20(%rbp), %r8
               	callq	<addr>
               	leaq	-0x60(%rbp), %rax
               	movzbq	(%rax), %rax
               	xorq	$0x4d, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	xorq	%rax, %rax
               	movslq	%eax, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
