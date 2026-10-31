
vla_parameter_bounds.x64:	file format elf64-x86-64

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

<pointer>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	pushq	%r12
               	pushq	%rbx
               	movslq	%edi, %rbx
               	movslq	%esi, %rsi
               	movq	%rsi, %r9
               	shlq	$0x2, %r9
               	movq	%rbx, %r12
               	imulq	%r9, %r12
               	xorl	%r8d, %r8d
               	movq	%r8, %rax
               	cmpl	%ebx, %r8d
               	jge	<addr>
               	xorl	%ecx, %ecx
               	cmpl	%esi, %ecx
               	jge	<addr>
               	movq	%r8, %rdi
               	imulq	%r9, %rdi
               	addq	%rdx, %rdi
               	movl	(%rdi,%rcx,4), %edi
               	addq	%rdi, %rax
               	incq	%rcx
               	cmpl	%esi, %ecx
               	jl	<addr>
               	incq	%r8
               	cmpl	%ebx, %r8d
               	jl	<addr>
               	movq	%rbx, %rcx
               	imulq	%rsi, %rcx
               	movslq	%ecx, %rcx
               	shlq	$0x2, %rcx
               	cmpq	%rcx, %r12
               	jne	<addr>
               	shlq	$0x2, %rsi
               	cmpq	%rsi, %r9
               	jne	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movq	$-0x1, %rax
               	jmp	<addr>

<rows>:
               	movslq	%edi, %rdi
               	movslq	%ecx, %rcx
               	movslq	%esi, %rsi
               	movq	%rsi, %rax
               	shlq	$0x2, %rax
               	movq	%rdi, %r8
               	imulq	%rax, %r8
               	movq	%rdi, %r9
               	imulq	%rsi, %r9
               	movslq	%r9d, %r9
               	shlq	$0x2, %r9
               	cmpq	%r9, %r8
               	jne	<addr>
               	cmpq	%rax, %rax
               	je	<addr>
               	movq	$-0x1, %rax
               	retq
               	imulq	%r8, %rcx
               	addq	%rdx, %rcx
               	decq	%rdi
               	movslq	%edi, %rdi
               	imulq	%rdi, %rax
               	addq	%rcx, %rax
               	leaq	-0x1(%rsi), %rcx
               	movslq	%ecx, %rcx
               	movl	(%rax,%rcx,4), %ecx
               	leaq	(%rdx,%r8), %rax
               	subq	%rdx, %rax
               	movq	%rax, %rdx
               	sarq	$0x3f, %rdx
               	shrq	$0x3e, %rdx
               	addq	%rdx, %rax
               	sarq	$0x2, %rax
               	addq	%rcx, %rax
               	retq

<mixed>:
               	movslq	%edi, %rdi
               	movq	%rdi, %rax
               	shlq	$0x2, %rax
               	leaq	(%rax,%rax,2), %rcx
               	leaq	(%rdi,%rdi,2), %rdx
               	movslq	%edx, %rdx
               	shlq	$0x2, %rdx
               	cmpq	%rdx, %rcx
               	jne	<addr>
               	addq	%rsi, %rcx
               	shlq	%rax
               	addq	%rcx, %rax
               	leaq	-0x1(%rdi), %rcx
               	movslq	%ecx, %rcx
               	movl	(%rax,%rcx,4), %eax
               	retq
               	movq	$-0x1, %rax
               	jmp	<addr>

<unnamed>:
               	movslq	%edi, %rdi
               	movslq	%esi, %rsi
               	movq	%rsi, %rax
               	shlq	$0x2, %rax
               	movq	%rdi, %rcx
               	imulq	%rax, %rcx
               	movq	%rdi, %r8
               	imulq	%rsi, %r8
               	movslq	%r8d, %r8
               	shlq	$0x2, %r8
               	cmpq	%r8, %rcx
               	jne	<addr>
               	leaq	-0x1(%rdi), %rcx
               	movslq	%ecx, %rcx
               	imulq	%rcx, %rax
               	addq	%rdx, %rax
               	leaq	-0x1(%rsi), %rcx
               	movslq	%ecx, %rcx
               	movl	(%rax,%rcx,4), %eax
               	retq
               	movq	$-0x1, %rax
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x110, %rsp            # imm = 0x110
               	leaq	-0x108(%rbp), %rax
               	movl	$0x0, -0x108(%rbp)
               	movl	$0x1, -0x104(%rbp)
               	movl	$0x2, -0x100(%rbp)
               	movl	$0x3, -0xfc(%rbp)
               	addq	$0x10, %rax
               	movl	$0xa, (%rax)
               	movl	$0xb, 0x4(%rax)
               	movl	$0xc, 0x8(%rax)
               	leaq	-0x108(%rbp), %rax
               	leaq	0x10(%rax), %rcx
               	movl	$0xd, 0xc(%rcx)
               	addq	$0x20, %rax
               	movl	$0x14, (%rax)
               	movl	$0x15, 0x4(%rax)
               	movl	$0x16, 0x8(%rax)
               	movl	$0x17, 0xc(%rax)
               	xorl	%eax, %eax
               	leaq	-0xd8(%rbp), %rcx
               	imulq	$0x30, %rax, %rdx
               	addq	%rdx, %rcx
               	imulq	$0x64, %rax, %rdx
               	movl	%edx, (%rcx)
               	leaq	0x1(%rdx), %rsi
               	movl	%esi, 0x4(%rcx)
               	addq	$0x2, %rdx
               	movl	%edx, 0x8(%rcx)
               	leaq	-0xd8(%rbp), %rcx
               	imulq	$0x30, %rax, %rdx
               	addq	%rdx, %rcx
               	imulq	$0x64, %rax, %rdx
               	leaq	0x3(%rdx), %rsi
               	movl	%esi, 0xc(%rcx)
               	addq	$0x10, %rcx
               	addq	$0xa, %rdx
               	movl	%edx, (%rcx)
               	incq	%rdx
               	movl	%edx, 0x4(%rcx)
               	leaq	-0xd8(%rbp), %rdx
               	imulq	$0x30, %rax, %rcx
               	addq	%rcx, %rdx
               	addq	$0x10, %rdx
               	imulq	$0x64, %rax, %rsi
               	leaq	0xa(%rsi), %rdi
               	leaq	0x2(%rdi), %r8
               	movl	%r8d, 0x8(%rdx)
               	addq	$0x3, %rdi
               	movl	%edi, 0xc(%rdx)
               	leaq	-0xd8(%rbp), %rdx
               	addq	%rdx, %rcx
               	addq	$0x20, %rcx
               	addq	$0x14, %rsi
               	movl	%esi, (%rcx)
               	imulq	$0x30, %rax, %rcx
               	addq	%rcx, %rdx
               	addq	$0x20, %rdx
               	imulq	$0x64, %rax, %rsi
               	leaq	0x14(%rsi), %rdi
               	leaq	0x1(%rdi), %r8
               	movl	%r8d, 0x4(%rdx)
               	addq	$0x2, %rdi
               	movl	%edi, 0x8(%rdx)
               	leaq	-0xd8(%rbp), %rdx
               	addq	%rdx, %rcx
               	addq	$0x20, %rcx
               	leaq	0x14(%rsi), %rdx
               	addq	$0x3, %rdx
               	movl	%edx, 0xc(%rcx)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	leaq	-0x78(%rbp), %rcx
               	imulq	$0x3c, %rax, %rdx
               	addq	%rdx, %rcx
               	imulq	$0x64, %rax, %rdx
               	movl	%edx, (%rcx)
               	leaq	0x1(%rdx), %rsi
               	movl	%esi, 0x4(%rcx)
               	addq	$0x2, %rdx
               	movl	%edx, 0x8(%rcx)
               	leaq	-0x78(%rbp), %rcx
               	imulq	$0x3c, %rax, %rdx
               	addq	%rdx, %rcx
               	imulq	$0x64, %rax, %rdx
               	leaq	0x3(%rdx), %rsi
               	movl	%esi, 0xc(%rcx)
               	leaq	0x4(%rdx), %rsi
               	movl	%esi, 0x10(%rcx)
               	addq	$0x14, %rcx
               	addq	$0xa, %rdx
               	movl	%edx, (%rcx)
               	leaq	-0x78(%rbp), %rdx
               	imulq	$0x3c, %rax, %rcx
               	addq	%rcx, %rdx
               	addq	$0x14, %rdx
               	imulq	$0x64, %rax, %rsi
               	leaq	0xa(%rsi), %rdi
               	leaq	0x1(%rdi), %r8
               	movl	%r8d, 0x4(%rdx)
               	addq	$0x2, %rdi
               	movl	%edi, 0x8(%rdx)
               	leaq	-0x78(%rbp), %rdx
               	addq	%rdx, %rcx
               	addq	$0x14, %rcx
               	addq	$0xa, %rsi
               	addq	$0x3, %rsi
               	movl	%esi, 0xc(%rcx)
               	imulq	$0x3c, %rax, %rcx
               	addq	%rdx, %rcx
               	leaq	0x14(%rcx), %rsi
               	imulq	$0x64, %rax, %rdx
               	leaq	0xa(%rdx), %rdi
               	addq	$0x4, %rdi
               	movl	%edi, 0x10(%rsi)
               	addq	$0x28, %rcx
               	addq	$0x14, %rdx
               	movl	%edx, (%rcx)
               	incq	%rdx
               	movl	%edx, 0x4(%rcx)
               	leaq	-0x78(%rbp), %rdx
               	imulq	$0x3c, %rax, %rcx
               	addq	%rcx, %rdx
               	addq	$0x28, %rdx
               	imulq	$0x64, %rax, %rsi
               	leaq	0x14(%rsi), %rdi
               	leaq	0x2(%rdi), %r8
               	movl	%r8d, 0x8(%rdx)
               	addq	$0x3, %rdi
               	movl	%edi, 0xc(%rdx)
               	leaq	-0x78(%rbp), %rdx
               	addq	%rdx, %rcx
               	addq	$0x28, %rcx
               	leaq	0x14(%rsi), %rdx
               	addq	$0x4, %rdx
               	movl	%edx, 0x10(%rcx)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	-0x108(%rbp), %rsi
               	xorl	%edx, %edx
               	movq	%rdx, %rcx
               	xorl	%eax, %eax
               	movq	%rdx, %rdi
               	shlq	$0x4, %rdi
               	addq	%rsi, %rdi
               	movl	(%rdi,%rax,4), %edi
               	addq	%rdi, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	incq	%rdx
               	cmpl	$0x3, %edx
               	jl	<addr>
               	cmpl	$0x8a, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	-0xd8(%rbp), %rax
               	leaq	0x30(%rax), %rcx
               	leaq	0x20(%rcx), %rdx
               	movl	0xc(%rdx), %edx
               	subq	%rax, %rcx
               	movq	%rcx, %rsi
               	sarq	$0x3f, %rsi
               	shrq	$0x3e, %rsi
               	addq	%rsi, %rcx
               	sarq	$0x2, %rcx
               	addq	%rdx, %rcx
               	cmpl	$0x87, %ecx
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	-0x78(%rbp), %rcx
               	addq	$0x3c, %rcx
               	addq	$0x28, %rcx
               	movl	0x10(%rcx), %ecx
               	cmpl	$0x7c, %ecx
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	addq	$0x20, %rax
               	movl	0xc(%rax), %eax
               	cmpl	$0x17, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
