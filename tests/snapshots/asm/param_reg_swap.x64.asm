
param_reg_swap.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	movq	%rdi, %rax
               	movq	%rax, %rcx
               	addq	$0x3, %rcx
               	movzbq	(%rcx), %rcx
               	movl	%ecx, %ecx
               	shlq	$0x8, %rcx
               	movl	%ecx, %ecx
               	movq	%rax, %rdx
               	addq	$0x2, %rdx
               	movzbq	(%rdx), %rdx
               	orq	%rdx, %rcx
               	movl	%ecx, %ecx
               	shlq	$0x8, %rcx
               	movl	%ecx, %ecx
               	movq	%rax, %rdx
               	addq	$0x1, %rdx
               	movzbq	(%rdx), %rdx
               	orq	%rdx, %rcx
               	movl	%ecx, %ecx
               	shlq	$0x8, %rcx
               	movl	%ecx, %ecx
               	movzbq	(%rax), %rax
               	orq	%rcx, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rdi, %rax
               	movq	%rcx, %r10
               	movq	%rsi, %rcx
               	movq	%r10, %rsi
               	xorq	%rdi, %rdi
               	movl	%edi, -0x48(%rbp)
               	jmp	<addr>
               	movslq	-0x48(%rbp), %rdi
               	cmpq	$0x4, %rdi
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x48(%rbp), %rdi
               	movslq	(%rdi), %r8
               	addq	$0x1, %r8
               	movl	%r8d, (%rdi)
               	jmp	<addr>
               	leaq	-0x40(%rbp), %rdi
               	movslq	-0x48(%rbp), %r8
               	imulq	$0x5, %r8, %r9
               	movslq	%r9d, %r9
               	shlq	$0x2, %r9
               	addq	%r9, %rdi
               	shlq	$0x2, %r8
               	movslq	%r8d, %r8
               	addq	%rsi, %r8
               	movq	%r8, %r9
               	addq	$0x3, %r9
               	movzbq	(%r9), %r9
               	movl	%r9d, %r9d
               	shlq	$0x8, %r9
               	movl	%r9d, %r9d
               	movq	%r8, %r11
               	addq	$0x2, %r11
               	movzbq	(%r11), %r11
               	orq	%r11, %r9
               	movl	%r9d, %r9d
               	shlq	$0x8, %r9
               	movl	%r9d, %r9d
               	movq	%r8, %r11
               	addq	$0x1, %r11
               	movzbq	(%r11), %r11
               	orq	%r11, %r9
               	movl	%r9d, %r9d
               	shlq	$0x8, %r9
               	movl	%r9d, %r9d
               	movzbq	(%r8), %r8
               	orq	%r9, %r8
               	movl	%r8d, (%rdi)
               	leaq	-0x40(%rbp), %rdi
               	movslq	-0x48(%rbp), %r8
               	movq	%r8, %r9
               	addq	$0x1, %r9
               	movslq	%r9d, %r9
               	shlq	$0x2, %r9
               	addq	%r9, %rdi
               	shlq	$0x2, %r8
               	movslq	%r8d, %r8
               	addq	%rdx, %r8
               	movq	%r8, %r9
               	addq	$0x3, %r9
               	movzbq	(%r9), %r9
               	movl	%r9d, %r9d
               	shlq	$0x8, %r9
               	movl	%r9d, %r9d
               	movq	%r8, %r11
               	addq	$0x2, %r11
               	movzbq	(%r11), %r11
               	orq	%r11, %r9
               	movl	%r9d, %r9d
               	shlq	$0x8, %r9
               	movl	%r9d, %r9d
               	movq	%r8, %r11
               	addq	$0x1, %r11
               	movzbq	(%r11), %r11
               	orq	%r11, %r9
               	movl	%r9d, %r9d
               	shlq	$0x8, %r9
               	movl	%r9d, %r9d
               	movzbq	(%r8), %r8
               	orq	%r9, %r8
               	movl	%r8d, (%rdi)
               	leaq	-0x40(%rbp), %rdi
               	movslq	-0x48(%rbp), %r8
               	movq	%r8, %r9
               	addq	$0x6, %r9
               	movslq	%r9d, %r9
               	shlq	$0x2, %r9
               	addq	%r9, %rdi
               	shlq	$0x2, %r8
               	movslq	%r8d, %r8
               	addq	%rcx, %r8
               	movq	%r8, %r9
               	addq	$0x3, %r9
               	movzbq	(%r9), %r9
               	movl	%r9d, %r9d
               	shlq	$0x8, %r9
               	movl	%r9d, %r9d
               	movq	%r8, %r11
               	addq	$0x2, %r11
               	movzbq	(%r11), %r11
               	orq	%r11, %r9
               	movl	%r9d, %r9d
               	shlq	$0x8, %r9
               	movl	%r9d, %r9d
               	movq	%r8, %r11
               	addq	$0x1, %r11
               	movzbq	(%r11), %r11
               	orq	%r11, %r9
               	movl	%r9d, %r9d
               	shlq	$0x8, %r9
               	movl	%r9d, %r9d
               	movzbq	(%r8), %r8
               	orq	%r9, %r8
               	movl	%r8d, (%rdi)
               	leaq	-0x40(%rbp), %rdi
               	movslq	-0x48(%rbp), %r8
               	movq	%r8, %r9
               	addq	$0xb, %r9
               	movslq	%r9d, %r9
               	shlq	$0x2, %r9
               	addq	%r9, %rdi
               	movq	%rdx, %r9
               	addq	$0x10, %r9
               	shlq	$0x2, %r8
               	movslq	%r8d, %r8
               	addq	%r9, %r8
               	movq	%r8, %r9
               	addq	$0x3, %r9
               	movzbq	(%r9), %r9
               	movl	%r9d, %r9d
               	shlq	$0x8, %r9
               	movl	%r9d, %r9d
               	movq	%r8, %r11
               	addq	$0x2, %r11
               	movzbq	(%r11), %r11
               	orq	%r11, %r9
               	movl	%r9d, %r9d
               	shlq	$0x8, %r9
               	movl	%r9d, %r9d
               	movq	%r8, %r11
               	addq	$0x1, %r11
               	movzbq	(%r11), %r11
               	orq	%r11, %r9
               	movl	%r9d, %r9d
               	shlq	$0x8, %r9
               	movl	%r9d, %r9d
               	movzbq	(%r8), %r8
               	orq	%r9, %r8
               	movl	%r8d, (%rdi)
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	leaq	-0x40(%rbp), %rdx
               	movl	(%rdx), %edx
               	leaq	-0x40(%rbp), %rsi
               	addq	$0x14, %rsi
               	movl	(%rsi), %esi
               	xorq	%rsi, %rdx
               	leaq	-0x40(%rbp), %rsi
               	addq	$0x28, %rsi
               	movl	(%rsi), %esi
               	xorq	%rsi, %rdx
               	leaq	-0x40(%rbp), %rsi
               	addq	$0x3c, %rsi
               	movl	(%rsi), %esi
               	xorq	%rsi, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%rax)
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	xorq	%rax, %rax
               	movl	%eax, -0x40(%rbp)
               	jmp	<addr>
               	movslq	-0x40(%rbp), %rax
               	cmpq	$0x10, %rax
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x40(%rbp), %rax
               	movslq	(%rax), %rcx
               	addq	$0x1, %rcx
               	movl	%ecx, (%rax)
               	jmp	<addr>
               	leaq	-0x18(%rbp), %rax
               	movslq	-0x40(%rbp), %rcx
               	addq	%rcx, %rax
               	andq	$0xff, %rcx
               	movb	%cl, (%rax)
               	jmp	<addr>
               	xorq	%rax, %rax
               	movl	%eax, -0x40(%rbp)
               	jmp	<addr>
               	movslq	-0x40(%rbp), %rax
               	cmpq	$0x20, %rax
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x40(%rbp), %rax
               	movslq	(%rax), %rcx
               	addq	$0x1, %rcx
               	movl	%ecx, (%rax)
               	jmp	<addr>
               	leaq	-0x38(%rbp), %rax
               	movslq	-0x40(%rbp), %rcx
               	addq	%rcx, %rax
               	andq	$0xff, %rcx
               	movb	%cl, (%rax)
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
