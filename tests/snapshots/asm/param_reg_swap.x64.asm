
param_reg_swap.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xc0, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movq	%rdi, %rbx
               	movq	%rcx, %r15
               	movq	%rdx, %r14
               	movq	%rsi, %r12
               	xorq	%r10, %r10
               	movq	%r10, 0x68(%rsp)
               	jmp	<addr>
               	movq	0x68(%rsp), %rax
               	movslq	%eax, %rax
               	cmpq	$0x4, %rax
               	jge	<addr>
               	jmp	<addr>
               	movq	0x68(%rsp), %rax
               	movslq	%eax, %rax
               	movq	%rax, %r10
               	incq	%r10
               	movq	%r10, 0x68(%rsp)
               	jmp	<addr>
               	leaq	-0x40(%rbp), %r10
               	movq	%r10, 0x60(%rsp)
               	movq	0x68(%rsp), %rax
               	movslq	%eax, %rax
               	leaq	(%rax,%rax,4), %rcx
               	movslq	%ecx, %r10
               	movq	%r10, 0x58(%rsp)
               	shlq	$0x2, %rax
               	movslq	%eax, %rax
               	movq	%r15, %rdi
               	addq	%rax, %rdi
               	callq	<addr>
               	movq	0x60(%rsp), %r10
               	movq	0x58(%rsp), %r13
               	movl	%eax, (%r10,%r13,4)
               	leaq	-0x40(%rbp), %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0x68(%rsp), %rax
               	movslq	%eax, %rax
               	movq	%rax, %rcx
               	incq	%rcx
               	movslq	%ecx, %r10
               	movq	%r10, 0x48(%rsp)
               	shlq	$0x2, %rax
               	movslq	%eax, %rax
               	movq	%r14, %rdi
               	addq	%rax, %rdi
               	callq	<addr>
               	movq	0x50(%rsp), %r10
               	movq	0x48(%rsp), %r13
               	movl	%eax, (%r10,%r13,4)
               	leaq	-0x40(%rbp), %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x68(%rsp), %rax
               	movslq	%eax, %rax
               	movq	%rax, %rcx
               	addq	$0x6, %rcx
               	movslq	%ecx, %r10
               	movq	%r10, 0x38(%rsp)
               	shlq	$0x2, %rax
               	movslq	%eax, %rax
               	movq	%r12, %rdi
               	addq	%rax, %rdi
               	callq	<addr>
               	movq	0x40(%rsp), %r10
               	movq	0x38(%rsp), %r13
               	movl	%eax, (%r10,%r13,4)
               	leaq	-0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x68(%rsp), %rax
               	movslq	%eax, %rax
               	movq	%rax, %rcx
               	addq	$0xb, %rcx
               	movslq	%ecx, %r10
               	movq	%r10, 0x28(%rsp)
               	movq	%r14, %rcx
               	addq	$0x10, %rcx
               	shlq	$0x2, %rax
               	movslq	%eax, %rax
               	movq	%rcx, %rdi
               	addq	%rax, %rdi
               	callq	<addr>
               	movq	0x30(%rsp), %r10
               	movq	0x28(%rsp), %r13
               	movl	%eax, (%r10,%r13,4)
               	jmp	<addr>
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
               	movb	%cl, (%rbx)
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movslq	%ecx, %rax
               	cmpq	$0x10, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rax
               	movq	%rax, %rcx
               	incq	%rcx
               	jmp	<addr>
               	leaq	-0x18(%rbp), %rax
               	movslq	%ecx, %rdx
               	addq	%rdx, %rax
               	andq	$0xff, %rdx
               	movb	%dl, (%rax)
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movslq	%ecx, %rax
               	cmpq	$0x20, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rax
               	movq	%rax, %rcx
               	incq	%rcx
               	jmp	<addr>
               	leaq	-0x38(%rbp), %rax
               	movslq	%ecx, %rdx
               	addq	%rdx, %rax
               	andq	$0xff, %rdx
               	movb	%dl, (%rax)
               	jmp	<addr>
               	leaq	-0x8(%rbp), %rdi
               	leaq	-0x18(%rbp), %rsi
               	leaq	-0x38(%rbp), %rdx
               	leaq	<rip>, %rcx
               	callq	<addr>
               	leaq	-0x8(%rbp), %rax
               	movzbq	(%rax), %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
