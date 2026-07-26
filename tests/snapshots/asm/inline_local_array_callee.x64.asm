
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
               	subq	$0x20, %rsp
               	leaq	-0x18(%rbp), %rax
               	movl	%edi, (%rax)
               	leaq	-0x18(%rbp), %rcx
               	leaq	0x1(%rdi), %rax
               	movl	%eax, 0x4(%rcx)
               	leaq	-0x18(%rbp), %rcx
               	movq	%rdi, %rax
               	shlq	%rax
               	movl	%eax, 0x8(%rcx)
               	leaq	-0x18(%rbp), %rcx
               	leaq	-0x1(%rdi), %rax
               	movl	%eax, 0xc(%rcx)
               	leaq	-0x18(%rbp), %rax
               	addq	$0x0, %rax
               	movslq	(%rax), %rcx
               	leaq	-0x18(%rbp), %rax
               	movslq	0x8(%rax), %rax
               	movq	%rax, %r10
               	movq	%rcx, %rax
               	subq	%r10, %rax
               	movslq	%eax, %rax
               	leaq	-0x18(%rbp), %rcx
               	addq	$0x0, %rcx
               	movslq	(%rcx), %rcx
               	imulq	$0x64, %rax, %rax
               	addq	%rcx, %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq

<f2>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	-0x18(%rbp), %rax
               	movl	%edi, (%rax)
               	leaq	-0x18(%rbp), %rcx
               	leaq	0x1(%rdi), %rax
               	movl	%eax, 0x4(%rcx)
               	leaq	-0x18(%rbp), %rcx
               	movq	%rdi, %rax
               	shlq	%rax
               	movl	%eax, 0x8(%rcx)
               	leaq	-0x18(%rbp), %rcx
               	leaq	-0x1(%rdi), %rax
               	movl	%eax, 0xc(%rcx)
               	leaq	-0x18(%rbp), %rax
               	movslq	0x4(%rax), %rcx
               	leaq	-0x18(%rbp), %rax
               	movslq	0x8(%rax), %rax
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	leaq	-0x18(%rbp), %rcx
               	movslq	0x4(%rcx), %rcx
               	imulq	$0x64, %rax, %rax
               	addq	%rcx, %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq

<f3>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	-0x18(%rbp), %rax
               	movl	%edi, (%rax)
               	leaq	-0x18(%rbp), %rcx
               	leaq	0x1(%rdi), %rax
               	movl	%eax, 0x4(%rcx)
               	leaq	-0x18(%rbp), %rcx
               	movq	%rdi, %rax
               	shlq	%rax
               	movl	%eax, 0x8(%rcx)
               	leaq	-0x18(%rbp), %rcx
               	leaq	-0x1(%rdi), %rax
               	movl	%eax, 0xc(%rcx)
               	leaq	-0x18(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	shlq	%rax
               	movslq	%eax, %rax
               	leaq	-0x18(%rbp), %rcx
               	movslq	0x4(%rcx), %rcx
               	imulq	$0x64, %rax, %rax
               	addq	%rcx, %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movl	$0xa, %edi
               	callq	<addr>
               	cmpq	$-0x3de, %rax           # imm = 0xFC22
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movl	$0xa, %edi
               	callq	<addr>
               	cmpq	$0xc27, %rax            # imm = 0xC27
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movl	$0xa, %edi
               	callq	<addr>
               	cmpq	$0x8a3, %rax            # imm = 0x8A3
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3, %eax
               	leaq	-0x18(%rbp), %rdx
               	movl	%eax, (%rdx)
               	leaq	-0x18(%rbp), %rax
               	movl	$0x4, %edx
               	movl	%edx, 0x4(%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	$0x6, %edx
               	movl	%edx, 0x8(%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	$0x2, %edx
               	movl	%edx, 0xc(%rax)
               	leaq	-0x18(%rbp), %rax
               	movslq	0x4(%rax), %rdx
               	leaq	-0x18(%rbp), %rax
               	movslq	0xc(%rax), %rax
               	movq	%rax, %r10
               	movq	%rdx, %rax
               	subq	%r10, %rax
               	movslq	%eax, %rax
               	movslq	%eax, %rsi
               	leaq	-0x18(%rbp), %rax
               	movslq	0x4(%rax), %rcx
               	movl	$0x8, %eax
               	leaq	-0x18(%rbp), %rdi
               	movl	%eax, (%rdi)
               	leaq	-0x18(%rbp), %rax
               	movl	$0x9, %edi
               	movl	%edi, 0x4(%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	$0x10, %edi
               	movl	%edi, 0x8(%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	$0x7, %edi
               	movl	%edi, 0xc(%rax)
               	leaq	-0x18(%rbp), %rax
               	movslq	0x8(%rax), %rdi
               	leaq	-0x18(%rbp), %rax
               	movslq	0xc(%rax), %rax
               	addq	%rdi, %rax
               	movslq	%eax, %rax
               	movslq	%eax, %rdi
               	leaq	-0x18(%rbp), %rax
               	movslq	0x8(%rax), %rdx
               	movslq	%esi, %rax
               	cmpq	$0x2, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpq	$0x4, %rcx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movslq	%edi, %rax
               	cmpq	$0x17, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpq	$0x10, %rdx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	xorq	%rdx, %rdx
               	movabsq	$-0x4, %rax
               	jmp	<addr>
               	leaq	-0x18(%rbp), %rcx
               	movl	%eax, (%rcx)
               	leaq	-0x18(%rbp), %rdi
               	leaq	0x1(%rax), %rcx
               	movl	%ecx, 0x4(%rdi)
               	leaq	-0x18(%rbp), %rdi
               	movq	%rax, %rcx
               	shlq	%rcx
               	movl	%ecx, 0x8(%rdi)
               	leaq	-0x18(%rbp), %rdi
               	leaq	-0x1(%rax), %rcx
               	movl	%ecx, 0xc(%rdi)
               	leaq	-0x18(%rbp), %rcx
               	addq	$0x0, %rcx
               	movslq	(%rcx), %rdi
               	leaq	-0x18(%rbp), %rcx
               	movslq	0x8(%rcx), %rcx
               	movq	%rcx, %r10
               	movq	%rdi, %rcx
               	subq	%r10, %rcx
               	movslq	%ecx, %rcx
               	leaq	-0x18(%rbp), %rdi
               	addq	$0x0, %rdi
               	movslq	(%rdi), %rdi
               	imulq	$0xf4243, %rdx, %rdx    # imm = 0xF4243
               	imulq	$0x7, %rcx, %rcx
               	addq	%rdi, %rcx
               	movslq	%ecx, %rcx
               	movl	%ecx, %ecx
               	leaq	(%rdx,%rcx), %rdi
               	leaq	-0x18(%rbp), %rcx
               	movl	%eax, (%rcx)
               	leaq	-0x18(%rbp), %rdx
               	leaq	0x1(%rax), %rcx
               	movl	%ecx, 0x4(%rdx)
               	leaq	-0x18(%rbp), %rdx
               	movq	%rax, %rcx
               	shlq	%rcx
               	movl	%ecx, 0x8(%rdx)
               	leaq	-0x18(%rbp), %rdx
               	leaq	-0x1(%rax), %rcx
               	movl	%ecx, 0xc(%rdx)
               	leaq	-0x18(%rbp), %rcx
               	movslq	0x4(%rcx), %rdx
               	leaq	-0x18(%rbp), %rcx
               	movslq	0xc(%rcx), %rcx
               	movq	%rcx, %r10
               	movq	%rdx, %rcx
               	subq	%r10, %rcx
               	movslq	%ecx, %rcx
               	leaq	-0x18(%rbp), %rdx
               	movslq	0x4(%rdx), %rdx
               	imulq	$0xf4243, %rdi, %rdi    # imm = 0xF4243
               	imulq	$0x7, %rcx, %rcx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	movl	%ecx, %ecx
               	addq	%rcx, %rdi
               	leaq	-0x18(%rbp), %rcx
               	movl	%eax, (%rcx)
               	leaq	-0x18(%rbp), %rdx
               	leaq	0x1(%rax), %rcx
               	movl	%ecx, 0x4(%rdx)
               	leaq	-0x18(%rbp), %rdx
               	movq	%rax, %rcx
               	shlq	%rcx
               	movl	%ecx, 0x8(%rdx)
               	leaq	-0x18(%rbp), %rdx
               	leaq	-0x1(%rax), %rcx
               	movl	%ecx, 0xc(%rdx)
               	leaq	-0x18(%rbp), %rcx
               	movslq	0x8(%rcx), %rcx
               	leaq	-0x18(%rbp), %rdx
               	addq	$0x0, %rdx
               	movslq	(%rdx), %rdx
               	subq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	leaq	-0x18(%rbp), %rdx
               	movslq	0x8(%rdx), %rdx
               	imulq	$0xf4243, %rdi, %rdi    # imm = 0xF4243
               	imulq	$0x7, %rcx, %rcx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	movl	%ecx, %ecx
               	addq	%rcx, %rdi
               	leaq	-0x18(%rbp), %rcx
               	movl	%eax, (%rcx)
               	leaq	-0x18(%rbp), %rdx
               	leaq	0x1(%rax), %rcx
               	movl	%ecx, 0x4(%rdx)
               	leaq	-0x18(%rbp), %rdx
               	movq	%rax, %rcx
               	shlq	%rcx
               	movl	%ecx, 0x8(%rdx)
               	leaq	-0x18(%rbp), %rdx
               	leaq	-0x1(%rax), %rcx
               	movl	%ecx, 0xc(%rdx)
               	leaq	-0x18(%rbp), %rcx
               	movslq	0xc(%rcx), %rdx
               	leaq	-0x18(%rbp), %rcx
               	movslq	0x4(%rcx), %rcx
               	movq	%rcx, %r10
               	movq	%rdx, %rcx
               	subq	%r10, %rcx
               	movslq	%ecx, %rcx
               	leaq	-0x18(%rbp), %rdx
               	movslq	0xc(%rdx), %rdx
               	imulq	$0xf4243, %rdi, %rdi    # imm = 0xF4243
               	imulq	$0x7, %rcx, %rcx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	movl	%ecx, %ecx
               	addq	%rcx, %rdi
               	leaq	-0x18(%rbp), %rcx
               	movl	%eax, (%rcx)
               	leaq	-0x18(%rbp), %rdx
               	leaq	0x1(%rax), %rcx
               	movl	%ecx, 0x4(%rdx)
               	leaq	-0x18(%rbp), %rdx
               	movq	%rax, %rcx
               	shlq	%rcx
               	movl	%ecx, 0x8(%rdx)
               	leaq	-0x18(%rbp), %rdx
               	leaq	-0x1(%rax), %rcx
               	movl	%ecx, 0xc(%rdx)
               	leaq	-0x18(%rbp), %rcx
               	addq	$0x0, %rcx
               	movslq	(%rcx), %rdx
               	leaq	-0x18(%rbp), %rcx
               	movslq	0x4(%rcx), %rcx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	leaq	-0x18(%rbp), %rdx
               	addq	$0x0, %rdx
               	movslq	(%rdx), %rdx
               	imulq	$0xf4243, %rdi, %rdi    # imm = 0xF4243
               	imulq	$0x7, %rcx, %rcx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	movl	%ecx, %ecx
               	addq	%rcx, %rdi
               	leaq	-0x18(%rbp), %rcx
               	movl	%eax, (%rcx)
               	leaq	-0x18(%rbp), %rdx
               	leaq	0x1(%rax), %rcx
               	movl	%ecx, 0x4(%rdx)
               	leaq	-0x18(%rbp), %rdx
               	movq	%rax, %rcx
               	shlq	%rcx
               	movl	%ecx, 0x8(%rdx)
               	leaq	-0x18(%rbp), %rdx
               	leaq	-0x1(%rax), %rcx
               	movl	%ecx, 0xc(%rdx)
               	leaq	-0x18(%rbp), %rcx
               	movslq	0x4(%rcx), %rdx
               	leaq	-0x18(%rbp), %rcx
               	movslq	0x8(%rcx), %rcx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	leaq	-0x18(%rbp), %rdx
               	movslq	0x4(%rdx), %rdx
               	imulq	$0xf4243, %rdi, %rdi    # imm = 0xF4243
               	imulq	$0x7, %rcx, %rcx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	movl	%ecx, %ecx
               	addq	%rcx, %rdi
               	leaq	-0x18(%rbp), %rcx
               	movl	%eax, (%rcx)
               	leaq	-0x18(%rbp), %rdx
               	leaq	0x1(%rax), %rcx
               	movl	%ecx, 0x4(%rdx)
               	leaq	-0x18(%rbp), %rdx
               	movq	%rax, %rcx
               	shlq	%rcx
               	movl	%ecx, 0x8(%rdx)
               	leaq	-0x18(%rbp), %rdx
               	leaq	-0x1(%rax), %rcx
               	movl	%ecx, 0xc(%rdx)
               	leaq	-0x18(%rbp), %rcx
               	movslq	0x8(%rcx), %rdx
               	leaq	-0x18(%rbp), %rcx
               	movslq	0xc(%rcx), %rcx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	leaq	-0x18(%rbp), %rdx
               	movslq	0x8(%rdx), %rdx
               	imulq	$0xf4243, %rdi, %rdi    # imm = 0xF4243
               	imulq	$0x7, %rcx, %rcx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	movl	%ecx, %ecx
               	addq	%rcx, %rdi
               	leaq	-0x18(%rbp), %rcx
               	movl	%eax, (%rcx)
               	leaq	-0x18(%rbp), %rdx
               	leaq	0x1(%rax), %rcx
               	movl	%ecx, 0x4(%rdx)
               	leaq	-0x18(%rbp), %rdx
               	movq	%rax, %rcx
               	shlq	%rcx
               	movl	%ecx, 0x8(%rdx)
               	leaq	-0x18(%rbp), %rdx
               	leaq	-0x1(%rax), %rcx
               	movl	%ecx, 0xc(%rdx)
               	leaq	-0x18(%rbp), %rcx
               	movslq	0xc(%rcx), %rcx
               	leaq	-0x18(%rbp), %rdx
               	addq	$0x0, %rdx
               	movslq	(%rdx), %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	leaq	-0x18(%rbp), %rdx
               	movslq	0xc(%rdx), %rdx
               	imulq	$0xf4243, %rdi, %rdi    # imm = 0xF4243
               	imulq	$0x7, %rcx, %rcx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	movl	%ecx, %ecx
               	addq	%rcx, %rdi
               	leaq	-0x18(%rbp), %rcx
               	movl	%eax, (%rcx)
               	leaq	-0x18(%rbp), %rdx
               	leaq	0x1(%rax), %rcx
               	movl	%ecx, 0x4(%rdx)
               	leaq	-0x18(%rbp), %rdx
               	movq	%rax, %rcx
               	shlq	%rcx
               	movl	%ecx, 0x8(%rdx)
               	leaq	-0x18(%rbp), %rdx
               	leaq	-0x1(%rax), %rcx
               	movl	%ecx, 0xc(%rdx)
               	leaq	-0x18(%rbp), %rcx
               	addq	$0x0, %rcx
               	movslq	(%rcx), %rcx
               	shlq	%rcx
               	movslq	%ecx, %rcx
               	leaq	-0x18(%rbp), %rdx
               	addq	$0x0, %rdx
               	movslq	(%rdx), %rdx
               	imulq	$0xf4243, %rdi, %rdi    # imm = 0xF4243
               	imulq	$0x7, %rcx, %rcx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	movl	%ecx, %ecx
               	addq	%rcx, %rdi
               	leaq	-0x18(%rbp), %rcx
               	movl	%eax, (%rcx)
               	leaq	-0x18(%rbp), %rdx
               	leaq	0x1(%rax), %rcx
               	movl	%ecx, 0x4(%rdx)
               	leaq	-0x18(%rbp), %rdx
               	movq	%rax, %rcx
               	shlq	%rcx
               	movl	%ecx, 0x8(%rdx)
               	leaq	-0x18(%rbp), %rdx
               	leaq	-0x1(%rax), %rcx
               	movl	%ecx, 0xc(%rdx)
               	leaq	-0x18(%rbp), %rcx
               	movslq	0x4(%rcx), %rcx
               	shlq	%rcx
               	movslq	%ecx, %rcx
               	leaq	-0x18(%rbp), %rdx
               	movslq	0x4(%rdx), %rdx
               	imulq	$0xf4243, %rdi, %rdi    # imm = 0xF4243
               	imulq	$0x7, %rcx, %rcx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	movl	%ecx, %ecx
               	addq	%rcx, %rdi
               	leaq	-0x18(%rbp), %rcx
               	movl	%eax, (%rcx)
               	leaq	-0x18(%rbp), %rdx
               	leaq	0x1(%rax), %rcx
               	movl	%ecx, 0x4(%rdx)
               	leaq	-0x18(%rbp), %rdx
               	movq	%rax, %rcx
               	shlq	%rcx
               	movl	%ecx, 0x8(%rdx)
               	leaq	-0x18(%rbp), %rdx
               	leaq	-0x1(%rax), %rcx
               	movl	%ecx, 0xc(%rdx)
               	leaq	-0x18(%rbp), %rcx
               	movslq	0x8(%rcx), %rcx
               	shlq	%rcx
               	movslq	%ecx, %rcx
               	leaq	-0x18(%rbp), %rdx
               	movslq	0x8(%rdx), %rdx
               	imulq	$0xf4243, %rdi, %rdi    # imm = 0xF4243
               	imulq	$0x7, %rcx, %rcx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	movl	%ecx, %ecx
               	addq	%rcx, %rdi
               	leaq	-0x18(%rbp), %rcx
               	movl	%eax, (%rcx)
               	leaq	-0x18(%rbp), %rdx
               	leaq	0x1(%rax), %rcx
               	movl	%ecx, 0x4(%rdx)
               	leaq	-0x18(%rbp), %rdx
               	movq	%rax, %rcx
               	shlq	%rcx
               	movl	%ecx, 0x8(%rdx)
               	leaq	-0x18(%rbp), %rdx
               	leaq	-0x1(%rax), %rcx
               	movl	%ecx, 0xc(%rdx)
               	leaq	-0x18(%rbp), %rcx
               	movslq	0xc(%rcx), %rcx
               	shlq	%rcx
               	movslq	%ecx, %rcx
               	leaq	-0x18(%rbp), %rdx
               	movslq	0xc(%rdx), %rdx
               	imulq	$0xf4243, %rdi, %rdi    # imm = 0xF4243
               	imulq	$0x7, %rcx, %rcx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	movl	%ecx, %ecx
               	leaq	(%rdi,%rcx), %rdx
               	leaq	0x1(%rsi), %rax
               	movslq	%eax, %rsi
               	cmpq	$0x4, %rsi
               	jle	<addr>
               	movl	%edx, %eax
               	cmpq	$0x33f7f8d8, %rax       # imm = 0x33F7F8D8
               	je	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
