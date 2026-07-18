
inline_local_array_callee.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<f1>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	leaq	-0x8(%rbp), %rcx
               	leaq	-0x30(%rbp), %rax
               	movl	%edi, (%rax)
               	leaq	-0x30(%rbp), %rdx
               	leaq	0x1(%rdi), %rax
               	movl	%eax, 0x4(%rdx)
               	leaq	-0x30(%rbp), %rdx
               	movq	%rdi, %rax
               	shlq	%rax
               	movl	%eax, 0x8(%rdx)
               	leaq	-0x30(%rbp), %rdx
               	leaq	-0x1(%rdi), %rax
               	movl	%eax, 0xc(%rdx)
               	leaq	-0x30(%rbp), %rax
               	addq	$0x0, %rax
               	movslq	(%rax), %rdx
               	leaq	-0x30(%rbp), %rax
               	movslq	0x8(%rax), %rax
               	movq	%rax, %r10
               	movq	%rdx, %rax
               	subq	%r10, %rax
               	movslq	%eax, %rax
               	movl	%eax, (%rcx)
               	leaq	-0x30(%rbp), %rax
               	addq	$0x0, %rax
               	movslq	(%rax), %rax
               	movl	%eax, 0x4(%rcx)
               	leaq	-0x8(%rbp), %rax
               	movslq	(%rax), %rax
               	imulq	$0x64, %rax, %rax
               	leaq	-0x8(%rbp), %rcx
               	movslq	0x4(%rcx), %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq

<f2>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	leaq	-0x8(%rbp), %rax
               	leaq	-0x30(%rbp), %rcx
               	movl	%edi, (%rcx)
               	leaq	-0x30(%rbp), %rdx
               	leaq	0x1(%rdi), %rcx
               	movl	%ecx, 0x4(%rdx)
               	leaq	-0x30(%rbp), %rdx
               	movq	%rdi, %rcx
               	shlq	%rcx
               	movl	%ecx, 0x8(%rdx)
               	leaq	-0x30(%rbp), %rdx
               	leaq	-0x1(%rdi), %rcx
               	movl	%ecx, 0xc(%rdx)
               	leaq	-0x30(%rbp), %rcx
               	movslq	0x4(%rcx), %rdx
               	leaq	-0x30(%rbp), %rcx
               	movslq	0x8(%rcx), %rcx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	movl	%ecx, (%rax)
               	leaq	-0x30(%rbp), %rcx
               	movslq	0x4(%rcx), %rcx
               	movl	%ecx, 0x4(%rax)
               	leaq	-0x8(%rbp), %rax
               	movslq	(%rax), %rax
               	imulq	$0x64, %rax, %rax
               	leaq	-0x8(%rbp), %rcx
               	movslq	0x4(%rcx), %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq

<f3>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	leaq	-0x8(%rbp), %rcx
               	leaq	-0x30(%rbp), %rax
               	movl	%edi, (%rax)
               	leaq	-0x30(%rbp), %rdx
               	leaq	0x1(%rdi), %rax
               	movl	%eax, 0x4(%rdx)
               	leaq	-0x30(%rbp), %rdx
               	movq	%rdi, %rax
               	shlq	%rax
               	movl	%eax, 0x8(%rdx)
               	leaq	-0x30(%rbp), %rdx
               	leaq	-0x1(%rdi), %rax
               	movl	%eax, 0xc(%rdx)
               	leaq	-0x30(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	shlq	%rax
               	movslq	%eax, %rax
               	movl	%eax, (%rcx)
               	leaq	-0x30(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	movl	%eax, 0x4(%rcx)
               	leaq	-0x8(%rbp), %rax
               	movslq	(%rax), %rax
               	imulq	$0x64, %rax, %rax
               	leaq	-0x8(%rbp), %rcx
               	movslq	0x4(%rcx), %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x220, %rsp            # imm = 0x220
               	movl	$0xa, %edi
               	callq	<addr>
               	cmpq	$-0x3de, %rax           # imm = 0xFC22
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x220, %rsp            # imm = 0x220
               	popq	%rbp
               	retq
               	movl	$0xa, %edi
               	callq	<addr>
               	cmpq	$0xc27, %rax            # imm = 0xC27
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x220, %rsp            # imm = 0x220
               	popq	%rbp
               	retq
               	movl	$0xa, %edi
               	callq	<addr>
               	cmpq	$0x8a3, %rax            # imm = 0x8A3
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x220, %rsp            # imm = 0x220
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rcx
               	movl	$0x3, %eax
               	leaq	-0x68(%rbp), %rdx
               	movl	%eax, (%rdx)
               	leaq	-0x68(%rbp), %rax
               	movl	$0x4, %edx
               	movl	%edx, 0x4(%rax)
               	leaq	-0x68(%rbp), %rax
               	movl	$0x6, %edx
               	movl	%edx, 0x8(%rax)
               	leaq	-0x68(%rbp), %rax
               	movl	$0x2, %edx
               	movl	%edx, 0xc(%rax)
               	leaq	-0x68(%rbp), %rax
               	movslq	0x4(%rax), %rdx
               	leaq	-0x68(%rbp), %rax
               	movslq	0xc(%rax), %rax
               	movq	%rax, %r10
               	movq	%rdx, %rax
               	subq	%r10, %rax
               	movslq	%eax, %rax
               	movl	%eax, (%rcx)
               	leaq	-0x68(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	movl	%eax, 0x4(%rcx)
               	leaq	-0x10(%rbp), %rax
               	movl	$0x8, %ecx
               	leaq	-0x88(%rbp), %rdx
               	movl	%ecx, (%rdx)
               	leaq	-0x88(%rbp), %rcx
               	movl	$0x9, %edx
               	movl	%edx, 0x4(%rcx)
               	leaq	-0x88(%rbp), %rcx
               	movl	$0x10, %edx
               	movl	%edx, 0x8(%rcx)
               	leaq	-0x88(%rbp), %rcx
               	movl	$0x7, %edx
               	movl	%edx, 0xc(%rcx)
               	leaq	-0x88(%rbp), %rcx
               	movslq	0x8(%rcx), %rdx
               	leaq	-0x88(%rbp), %rcx
               	movslq	0xc(%rcx), %rcx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	movl	%ecx, (%rax)
               	leaq	-0x88(%rbp), %rcx
               	movslq	0x8(%rcx), %rcx
               	movl	%ecx, 0x4(%rax)
               	leaq	-0x8(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x2, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x8(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	cmpq	$0x4, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x220, %rsp            # imm = 0x220
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x17, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x10(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	cmpq	$0x10, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x220, %rsp            # imm = 0x220
               	popq	%rbp
               	retq
               	xorq	%rdx, %rdx
               	movabsq	$-0x4, %rax
               	jmp	<addr>
               	leaq	-0x28(%rbp), %rsi
               	leaq	-0xa8(%rbp), %rcx
               	movl	%eax, (%rcx)
               	leaq	-0xa8(%rbp), %r8
               	leaq	0x1(%rax), %rcx
               	movl	%ecx, 0x4(%r8)
               	leaq	-0xa8(%rbp), %r8
               	movq	%rax, %rcx
               	shlq	%rcx
               	movl	%ecx, 0x8(%r8)
               	leaq	-0xa8(%rbp), %r8
               	leaq	-0x1(%rax), %rcx
               	movl	%ecx, 0xc(%r8)
               	leaq	-0xa8(%rbp), %rcx
               	addq	$0x0, %rcx
               	movslq	(%rcx), %r8
               	leaq	-0xa8(%rbp), %rcx
               	movslq	0x8(%rcx), %rcx
               	movq	%rcx, %r10
               	movq	%r8, %rcx
               	subq	%r10, %rcx
               	movslq	%ecx, %rcx
               	movl	%ecx, (%rsi)
               	leaq	-0xa8(%rbp), %rcx
               	addq	$0x0, %rcx
               	movslq	(%rcx), %rcx
               	movl	%ecx, 0x4(%rsi)
               	imulq	$0xf4243, %rdx, %rsi    # imm = 0xF4243
               	leaq	-0x28(%rbp), %rcx
               	movslq	(%rcx), %rcx
               	imulq	$0x7, %rcx, %rcx
               	leaq	-0x28(%rbp), %rdx
               	movslq	0x4(%rdx), %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	movl	%ecx, %ecx
               	leaq	(%rsi,%rcx), %r8
               	leaq	-0x28(%rbp), %rdx
               	leaq	-0xc8(%rbp), %rcx
               	movl	%eax, (%rcx)
               	leaq	-0xc8(%rbp), %rsi
               	leaq	0x1(%rax), %rcx
               	movl	%ecx, 0x4(%rsi)
               	leaq	-0xc8(%rbp), %rsi
               	movq	%rax, %rcx
               	shlq	%rcx
               	movl	%ecx, 0x8(%rsi)
               	leaq	-0xc8(%rbp), %rsi
               	leaq	-0x1(%rax), %rcx
               	movl	%ecx, 0xc(%rsi)
               	leaq	-0xc8(%rbp), %rcx
               	movslq	0x4(%rcx), %rsi
               	leaq	-0xc8(%rbp), %rcx
               	movslq	0xc(%rcx), %rcx
               	movq	%rcx, %r10
               	movq	%rsi, %rcx
               	subq	%r10, %rcx
               	movslq	%ecx, %rcx
               	movl	%ecx, (%rdx)
               	leaq	-0xc8(%rbp), %rcx
               	movslq	0x4(%rcx), %rcx
               	movl	%ecx, 0x4(%rdx)
               	imulq	$0xf4243, %r8, %rsi     # imm = 0xF4243
               	leaq	-0x28(%rbp), %rcx
               	movslq	(%rcx), %rcx
               	imulq	$0x7, %rcx, %rcx
               	leaq	-0x28(%rbp), %rdx
               	movslq	0x4(%rdx), %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	movl	%ecx, %ecx
               	leaq	(%rsi,%rcx), %r8
               	leaq	-0x28(%rbp), %rdx
               	leaq	-0xe8(%rbp), %rcx
               	movl	%eax, (%rcx)
               	leaq	-0xe8(%rbp), %rsi
               	leaq	0x1(%rax), %rcx
               	movl	%ecx, 0x4(%rsi)
               	leaq	-0xe8(%rbp), %rsi
               	movq	%rax, %rcx
               	shlq	%rcx
               	movl	%ecx, 0x8(%rsi)
               	leaq	-0xe8(%rbp), %rsi
               	leaq	-0x1(%rax), %rcx
               	movl	%ecx, 0xc(%rsi)
               	leaq	-0xe8(%rbp), %rcx
               	movslq	0x8(%rcx), %rcx
               	leaq	-0xe8(%rbp), %rsi
               	addq	$0x0, %rsi
               	movslq	(%rsi), %rsi
               	subq	%rsi, %rcx
               	movslq	%ecx, %rcx
               	movl	%ecx, (%rdx)
               	leaq	-0xe8(%rbp), %rcx
               	movslq	0x8(%rcx), %rcx
               	movl	%ecx, 0x4(%rdx)
               	imulq	$0xf4243, %r8, %rsi     # imm = 0xF4243
               	leaq	-0x28(%rbp), %rcx
               	movslq	(%rcx), %rcx
               	imulq	$0x7, %rcx, %rcx
               	leaq	-0x28(%rbp), %rdx
               	movslq	0x4(%rdx), %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	movl	%ecx, %ecx
               	leaq	(%rsi,%rcx), %r8
               	leaq	-0x28(%rbp), %rdx
               	leaq	-0x108(%rbp), %rcx
               	movl	%eax, (%rcx)
               	leaq	-0x108(%rbp), %rsi
               	leaq	0x1(%rax), %rcx
               	movl	%ecx, 0x4(%rsi)
               	leaq	-0x108(%rbp), %rsi
               	movq	%rax, %rcx
               	shlq	%rcx
               	movl	%ecx, 0x8(%rsi)
               	leaq	-0x108(%rbp), %rsi
               	leaq	-0x1(%rax), %rcx
               	movl	%ecx, 0xc(%rsi)
               	leaq	-0x108(%rbp), %rcx
               	movslq	0xc(%rcx), %rsi
               	leaq	-0x108(%rbp), %rcx
               	movslq	0x4(%rcx), %rcx
               	movq	%rcx, %r10
               	movq	%rsi, %rcx
               	subq	%r10, %rcx
               	movslq	%ecx, %rcx
               	movl	%ecx, (%rdx)
               	leaq	-0x108(%rbp), %rcx
               	movslq	0xc(%rcx), %rcx
               	movl	%ecx, 0x4(%rdx)
               	imulq	$0xf4243, %r8, %rsi     # imm = 0xF4243
               	leaq	-0x28(%rbp), %rcx
               	movslq	(%rcx), %rcx
               	imulq	$0x7, %rcx, %rcx
               	leaq	-0x28(%rbp), %rdx
               	movslq	0x4(%rdx), %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	movl	%ecx, %ecx
               	leaq	(%rsi,%rcx), %r8
               	leaq	-0x28(%rbp), %rcx
               	leaq	-0x128(%rbp), %rdx
               	movl	%eax, (%rdx)
               	leaq	-0x128(%rbp), %rsi
               	leaq	0x1(%rax), %rdx
               	movl	%edx, 0x4(%rsi)
               	leaq	-0x128(%rbp), %rsi
               	movq	%rax, %rdx
               	shlq	%rdx
               	movl	%edx, 0x8(%rsi)
               	leaq	-0x128(%rbp), %rsi
               	leaq	-0x1(%rax), %rdx
               	movl	%edx, 0xc(%rsi)
               	leaq	-0x128(%rbp), %rdx
               	addq	$0x0, %rdx
               	movslq	(%rdx), %rsi
               	leaq	-0x128(%rbp), %rdx
               	movslq	0x4(%rdx), %rdx
               	addq	%rsi, %rdx
               	movslq	%edx, %rdx
               	movl	%edx, (%rcx)
               	leaq	-0x128(%rbp), %rdx
               	addq	$0x0, %rdx
               	movslq	(%rdx), %rdx
               	movl	%edx, 0x4(%rcx)
               	imulq	$0xf4243, %r8, %rsi     # imm = 0xF4243
               	leaq	-0x28(%rbp), %rcx
               	movslq	(%rcx), %rcx
               	imulq	$0x7, %rcx, %rcx
               	leaq	-0x28(%rbp), %rdx
               	movslq	0x4(%rdx), %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	movl	%ecx, %ecx
               	leaq	(%rsi,%rcx), %r8
               	leaq	-0x28(%rbp), %rcx
               	leaq	-0x148(%rbp), %rdx
               	movl	%eax, (%rdx)
               	leaq	-0x148(%rbp), %rsi
               	leaq	0x1(%rax), %rdx
               	movl	%edx, 0x4(%rsi)
               	leaq	-0x148(%rbp), %rsi
               	movq	%rax, %rdx
               	shlq	%rdx
               	movl	%edx, 0x8(%rsi)
               	leaq	-0x148(%rbp), %rsi
               	leaq	-0x1(%rax), %rdx
               	movl	%edx, 0xc(%rsi)
               	leaq	-0x148(%rbp), %rdx
               	movslq	0x4(%rdx), %rsi
               	leaq	-0x148(%rbp), %rdx
               	movslq	0x8(%rdx), %rdx
               	addq	%rsi, %rdx
               	movslq	%edx, %rdx
               	movl	%edx, (%rcx)
               	leaq	-0x148(%rbp), %rdx
               	movslq	0x4(%rdx), %rdx
               	movl	%edx, 0x4(%rcx)
               	imulq	$0xf4243, %r8, %rsi     # imm = 0xF4243
               	leaq	-0x28(%rbp), %rcx
               	movslq	(%rcx), %rcx
               	imulq	$0x7, %rcx, %rcx
               	leaq	-0x28(%rbp), %rdx
               	movslq	0x4(%rdx), %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	movl	%ecx, %ecx
               	leaq	(%rsi,%rcx), %r8
               	leaq	-0x28(%rbp), %rcx
               	leaq	-0x168(%rbp), %rdx
               	movl	%eax, (%rdx)
               	leaq	-0x168(%rbp), %rsi
               	leaq	0x1(%rax), %rdx
               	movl	%edx, 0x4(%rsi)
               	leaq	-0x168(%rbp), %rsi
               	movq	%rax, %rdx
               	shlq	%rdx
               	movl	%edx, 0x8(%rsi)
               	leaq	-0x168(%rbp), %rsi
               	leaq	-0x1(%rax), %rdx
               	movl	%edx, 0xc(%rsi)
               	leaq	-0x168(%rbp), %rdx
               	movslq	0x8(%rdx), %rsi
               	leaq	-0x168(%rbp), %rdx
               	movslq	0xc(%rdx), %rdx
               	addq	%rsi, %rdx
               	movslq	%edx, %rdx
               	movl	%edx, (%rcx)
               	leaq	-0x168(%rbp), %rdx
               	movslq	0x8(%rdx), %rdx
               	movl	%edx, 0x4(%rcx)
               	imulq	$0xf4243, %r8, %rsi     # imm = 0xF4243
               	leaq	-0x28(%rbp), %rcx
               	movslq	(%rcx), %rcx
               	imulq	$0x7, %rcx, %rcx
               	leaq	-0x28(%rbp), %rdx
               	movslq	0x4(%rdx), %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	movl	%ecx, %ecx
               	leaq	(%rsi,%rcx), %r8
               	leaq	-0x28(%rbp), %rcx
               	leaq	-0x188(%rbp), %rdx
               	movl	%eax, (%rdx)
               	leaq	-0x188(%rbp), %rsi
               	leaq	0x1(%rax), %rdx
               	movl	%edx, 0x4(%rsi)
               	leaq	-0x188(%rbp), %rsi
               	movq	%rax, %rdx
               	shlq	%rdx
               	movl	%edx, 0x8(%rsi)
               	leaq	-0x188(%rbp), %rsi
               	leaq	-0x1(%rax), %rdx
               	movl	%edx, 0xc(%rsi)
               	leaq	-0x188(%rbp), %rdx
               	movslq	0xc(%rdx), %rdx
               	leaq	-0x188(%rbp), %rsi
               	addq	$0x0, %rsi
               	movslq	(%rsi), %rsi
               	addq	%rsi, %rdx
               	movslq	%edx, %rdx
               	movl	%edx, (%rcx)
               	leaq	-0x188(%rbp), %rdx
               	movslq	0xc(%rdx), %rdx
               	movl	%edx, 0x4(%rcx)
               	imulq	$0xf4243, %r8, %rsi     # imm = 0xF4243
               	leaq	-0x28(%rbp), %rcx
               	movslq	(%rcx), %rcx
               	imulq	$0x7, %rcx, %rcx
               	leaq	-0x28(%rbp), %rdx
               	movslq	0x4(%rdx), %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	movl	%ecx, %ecx
               	leaq	(%rsi,%rcx), %r8
               	leaq	-0x28(%rbp), %rdx
               	leaq	-0x1a8(%rbp), %rcx
               	movl	%eax, (%rcx)
               	leaq	-0x1a8(%rbp), %rsi
               	leaq	0x1(%rax), %rcx
               	movl	%ecx, 0x4(%rsi)
               	leaq	-0x1a8(%rbp), %rsi
               	movq	%rax, %rcx
               	shlq	%rcx
               	movl	%ecx, 0x8(%rsi)
               	leaq	-0x1a8(%rbp), %rsi
               	leaq	-0x1(%rax), %rcx
               	movl	%ecx, 0xc(%rsi)
               	leaq	-0x1a8(%rbp), %rcx
               	addq	$0x0, %rcx
               	movslq	(%rcx), %rcx
               	shlq	%rcx
               	movslq	%ecx, %rcx
               	movl	%ecx, (%rdx)
               	leaq	-0x1a8(%rbp), %rcx
               	addq	$0x0, %rcx
               	movslq	(%rcx), %rcx
               	movl	%ecx, 0x4(%rdx)
               	imulq	$0xf4243, %r8, %rsi     # imm = 0xF4243
               	leaq	-0x28(%rbp), %rcx
               	movslq	(%rcx), %rcx
               	imulq	$0x7, %rcx, %rcx
               	leaq	-0x28(%rbp), %rdx
               	movslq	0x4(%rdx), %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	movl	%ecx, %ecx
               	leaq	(%rsi,%rcx), %r8
               	leaq	-0x28(%rbp), %rdx
               	leaq	-0x1c8(%rbp), %rcx
               	movl	%eax, (%rcx)
               	leaq	-0x1c8(%rbp), %rsi
               	leaq	0x1(%rax), %rcx
               	movl	%ecx, 0x4(%rsi)
               	leaq	-0x1c8(%rbp), %rsi
               	movq	%rax, %rcx
               	shlq	%rcx
               	movl	%ecx, 0x8(%rsi)
               	leaq	-0x1c8(%rbp), %rsi
               	leaq	-0x1(%rax), %rcx
               	movl	%ecx, 0xc(%rsi)
               	leaq	-0x1c8(%rbp), %rcx
               	movslq	0x4(%rcx), %rcx
               	shlq	%rcx
               	movslq	%ecx, %rcx
               	movl	%ecx, (%rdx)
               	leaq	-0x1c8(%rbp), %rcx
               	movslq	0x4(%rcx), %rcx
               	movl	%ecx, 0x4(%rdx)
               	imulq	$0xf4243, %r8, %rsi     # imm = 0xF4243
               	leaq	-0x28(%rbp), %rcx
               	movslq	(%rcx), %rcx
               	imulq	$0x7, %rcx, %rcx
               	leaq	-0x28(%rbp), %rdx
               	movslq	0x4(%rdx), %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	movl	%ecx, %ecx
               	leaq	(%rsi,%rcx), %r8
               	leaq	-0x28(%rbp), %rdx
               	leaq	-0x1e8(%rbp), %rcx
               	movl	%eax, (%rcx)
               	leaq	-0x1e8(%rbp), %rsi
               	leaq	0x1(%rax), %rcx
               	movl	%ecx, 0x4(%rsi)
               	leaq	-0x1e8(%rbp), %rsi
               	movq	%rax, %rcx
               	shlq	%rcx
               	movl	%ecx, 0x8(%rsi)
               	leaq	-0x1e8(%rbp), %rsi
               	leaq	-0x1(%rax), %rcx
               	movl	%ecx, 0xc(%rsi)
               	leaq	-0x1e8(%rbp), %rcx
               	movslq	0x8(%rcx), %rcx
               	shlq	%rcx
               	movslq	%ecx, %rcx
               	movl	%ecx, (%rdx)
               	leaq	-0x1e8(%rbp), %rcx
               	movslq	0x8(%rcx), %rcx
               	movl	%ecx, 0x4(%rdx)
               	imulq	$0xf4243, %r8, %rsi     # imm = 0xF4243
               	leaq	-0x28(%rbp), %rcx
               	movslq	(%rcx), %rcx
               	imulq	$0x7, %rcx, %rcx
               	leaq	-0x28(%rbp), %rdx
               	movslq	0x4(%rdx), %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	movl	%ecx, %ecx
               	leaq	(%rsi,%rcx), %r8
               	leaq	-0x28(%rbp), %rdx
               	leaq	-0x208(%rbp), %rcx
               	movl	%eax, (%rcx)
               	leaq	-0x208(%rbp), %rsi
               	leaq	0x1(%rax), %rcx
               	movl	%ecx, 0x4(%rsi)
               	leaq	-0x208(%rbp), %rsi
               	movq	%rax, %rcx
               	shlq	%rcx
               	movl	%ecx, 0x8(%rsi)
               	leaq	-0x208(%rbp), %rsi
               	leaq	-0x1(%rax), %rcx
               	movl	%ecx, 0xc(%rsi)
               	leaq	-0x208(%rbp), %rcx
               	movslq	0xc(%rcx), %rcx
               	shlq	%rcx
               	movslq	%ecx, %rcx
               	movl	%ecx, (%rdx)
               	leaq	-0x208(%rbp), %rcx
               	movslq	0xc(%rcx), %rcx
               	movl	%ecx, 0x4(%rdx)
               	imulq	$0xf4243, %r8, %rsi     # imm = 0xF4243
               	leaq	-0x28(%rbp), %rcx
               	movslq	(%rcx), %rcx
               	imulq	$0x7, %rcx, %rcx
               	leaq	-0x28(%rbp), %rdx
               	movslq	0x4(%rdx), %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	movl	%ecx, %ecx
               	leaq	(%rsi,%rcx), %rdx
               	leaq	0x1(%rdi), %rax
               	movslq	%eax, %rdi
               	cmpq	$0x4, %rdi
               	jle	<addr>
               	movl	%edx, %eax
               	cmpq	$0x33f7f8d8, %rax       # imm = 0x33F7F8D8
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x220, %rsp            # imm = 0x220
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x220, %rsp            # imm = 0x220
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	addb	%al, (%rax)
