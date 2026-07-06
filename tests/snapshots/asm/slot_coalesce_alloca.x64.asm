
slot_coalesce_alloca.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<burn>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xe0, %rsp
               	movslq	%edi, %rdi
               	xorq	%r9, %r9
               	movq	%r9, %rax
               	jmp	<addr>
               	leaq	-0xc0(%rbp), %rdx
               	movq	%rcx, %rsi
               	shlq	$0x3, %rsi
               	addq	%rsi, %rdx
               	leaq	0x1(%rcx), %rsi
               	movslq	%esi, %rsi
               	imulq	%rdi, %rsi
               	movq	%rsi, (%rdx)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x18, %rcx
               	jl	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	leaq	-0xc0(%rbp), %rdx
               	movq	%rax, %rsi
               	shlq	$0x3, %rsi
               	addq	%rsi, %rdx
               	movq	(%rdx), %rdx
               	addq	%rdx, %r9
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x18, %rax
               	jl	<addr>
               	movq	%r9, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x2090, %rsp           # imm = 0x2090
               	leaq	-0x90(%rbp), %r10
               	movq	%r10, (%r10)
               	movl	$0x1, %eax
               	movq	%rax, -0x8(%rbp)
               	movl	$0x2, %eax
               	movq	%rax, -0x10(%rbp)
               	movq	-0x8(%rbp), %rax
               	movq	-0x10(%rbp), %rcx
               	imulq	%rax, %rcx
               	addq	%rcx, %rax
               	movq	%rax, -0x18(%rbp)
               	movl	$0x3, %eax
               	movq	%rax, -0x20(%rbp)
               	movl	$0x4, %eax
               	movq	%rax, -0x28(%rbp)
               	movq	-0x20(%rbp), %rax
               	movq	-0x28(%rbp), %rcx
               	imulq	%rax, %rcx
               	addq	%rcx, %rax
               	movq	%rax, -0x30(%rbp)
               	movl	$0x5, %eax
               	movq	%rax, -0x38(%rbp)
               	movl	$0x6, %eax
               	movq	%rax, -0x40(%rbp)
               	movq	-0x38(%rbp), %rax
               	movq	-0x40(%rbp), %rcx
               	imulq	%rax, %rcx
               	addq	%rcx, %rax
               	movq	%rax, -0x48(%rbp)
               	movl	$0x7, %eax
               	movq	%rax, -0x50(%rbp)
               	movl	$0x8, %eax
               	movq	%rax, -0x58(%rbp)
               	movq	-0x50(%rbp), %rax
               	movq	-0x58(%rbp), %rcx
               	imulq	%rax, %rcx
               	addq	%rcx, %rax
               	movq	%rax, -0x60(%rbp)
               	movq	-0x18(%rbp), %rax
               	movq	-0x30(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	-0x48(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	-0x60(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	%rax, -0x68(%rbp)
               	movl	$0x40, %eax
               	movq	%rax, %r10
               	addq	$0xf, %r10
               	andq	$-0x10, %r10
               	leaq	-0x90(%rbp), %r11
               	movq	(%r11), %rax
               	subq	%r10, %rax
               	leaq	-0x2000(%r11), %r10
               	cmpq	%r10, %rax
               	jae	<addr>
               	ud2
               	movq	%rax, (%r11)
               	movq	%rax, -0x70(%rbp)
               	xorq	%rax, %rax
               	movl	%eax, -0x78(%rbp)
               	jmp	<addr>
               	movq	-0x70(%rbp), %rax
               	movslq	-0x78(%rbp), %rcx
               	movq	-0x68(%rbp), %rdx
               	addq	%rcx, %rdx
               	movq	%rdx, (%rax,%rcx,8)
               	movslq	-0x78(%rbp), %rax
               	incq	%rax
               	movl	%eax, -0x78(%rbp)
               	movslq	-0x78(%rbp), %rax
               	cmpq	$0x8, %rax
               	jl	<addr>
               	movq	-0x68(%rbp), %rdi
               	callq	<addr>
               	movq	%rax, -0x80(%rbp)
               	movq	-0x80(%rbp), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2, %eax
               	addq	$0x2090, %rsp           # imm = 0x2090
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movl	%eax, -0x88(%rbp)
               	jmp	<addr>
               	movq	-0x70(%rbp), %rax
               	movslq	-0x88(%rbp), %rcx
               	movq	(%rax,%rcx,8), %rax
               	movq	-0x68(%rbp), %rdx
               	addq	%rdx, %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movslq	-0x88(%rbp), %rax
               	incq	%rax
               	movl	%eax, -0x88(%rbp)
               	movslq	-0x88(%rbp), %rax
               	cmpq	$0x8, %rax
               	jl	<addr>
               	xorq	%rax, %rax
               	addq	$0x2090, %rsp           # imm = 0x2090
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	addq	$0x2090, %rsp           # imm = 0x2090
               	popq	%rbp
               	retq
               	jmp	<addr>
               	addb	%al, 0x41(%rdx)
