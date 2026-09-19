
stmt_expr_scope_exit_value.x64:	file format elf64-x86-64

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

<vla_value>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rsp, %rcx
               	movl	$0x10, %eax
               	movq	%rax, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %rax
               	subq	%r11, %rax
               	shrq	$0xc, %r11
               	testq	%r11, %r11
               	je	<addr>
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r11
               	jne	<addr>
               	movq	%rax, %rsp
               	movl	$0x29, %edx
               	movl	%edx, (%rax)
               	movl	$0x1, %edx
               	movl	%edx, 0xc(%rax)
               	movq	%rcx, %rsp
               	movl	$0x2a, %eax
               	leaq	-0x10(%rbp), %rsp
               	leave
               	retq

<vla_and_guard>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rsp, %rcx
               	movl	$0x5, %eax
               	movl	%eax, -0x10(%rbp)
               	movl	$0xc, %edx
               	movq	%rdx, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %rdx
               	subq	%r11, %rdx
               	shrq	$0xc, %r11
               	testq	%r11, %r11
               	je	<addr>
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r11
               	jne	<addr>
               	movq	%rdx, %rsp
               	movl	%eax, (%rdx)
               	leaq	-0x10(%rbp), %rdx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rsi
               	incq	%rsi
               	movl	%esi, (%rax)
               	leaq	<rip>, %rax
               	movslq	(%rdx), %rdx
               	movl	%edx, (%rax)
               	movq	%rcx, %rsp
               	movl	$0x7, %eax
               	leaq	-0x10(%rbp), %rsp
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	leaq	<rip>, %rbx
               	xorq	%rax, %rax
               	movl	%eax, (%rbx)
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rdx
               	incq	%rdx
               	movl	%edx, (%rcx)
               	leaq	<rip>, %r12
               	movabsq	$-0x1, %rcx
               	movl	%ecx, (%r12)
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	$0x1, %ecx
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movslq	(%r12), %rcx
               	cmpl	$-0x1, %ecx
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movslq	(%rbx), %rcx
               	incq	%rcx
               	movl	%ecx, (%rbx)
               	movl	%eax, (%r12)
               	movl	$0x4, %edi
               	callq	<addr>
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movl	$0x3, %edi
               	callq	<addr>
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	xorq	%rax, %rax
               	movl	%eax, (%rbx)
               	movl	$0x1, %ecx
               	movl	%ecx, -0x10(%rbp)
               	movl	$0x2, %ecx
               	movl	%ecx, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rcx
               	movslq	(%rbx), %rdx
               	incq	%rdx
               	movl	%edx, (%rbx)
               	movslq	(%rcx), %rdx
               	movl	%edx, (%r12)
               	leaq	-0x10(%rbp), %rdx
               	movslq	(%rbx), %rsi
               	incq	%rsi
               	movl	%esi, (%rbx)
               	movslq	(%rdx), %rdx
               	movl	%edx, (%r12)
               	movslq	(%rbx), %rdx
               	cmpl	$0x2, %edx
               	je	<addr>
               	movl	$0x8, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movl	%eax, (%rbx)
               	movl	$0xb, %edx
               	movl	%edx, -0x8(%rbp)
               	movslq	(%rbx), %rdx
               	incq	%rdx
               	movl	%edx, (%rbx)
               	movslq	(%rcx), %rdx
               	movl	%edx, (%r12)
               	movslq	(%rbx), %rdx
               	cmpl	$0x1, %edx
               	jne	<addr>
               	movslq	(%r12), %rdx
               	cmpl	$0xb, %edx
               	je	<addr>
               	movl	$0xa, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movl	%eax, (%rbx)
               	movl	%eax, -0x8(%rbp)
               	movslq	(%rbx), %rax
               	incq	%rax
               	movl	%eax, (%rbx)
               	movslq	(%rcx), %rax
               	movl	%eax, (%r12)
               	movslq	(%rbx), %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0xc, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	xorq	%rax, %rax
               	movl	%eax, (%rbx)
               	movl	%eax, -0x10(%rbp)
               	movl	$0x4, %ecx
               	movl	%ecx, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rcx
               	movslq	(%rbx), %rdx
               	incq	%rdx
               	movl	%edx, (%rbx)
               	movslq	(%rcx), %rcx
               	movl	%ecx, (%r12)
               	leaq	-0x10(%rbp), %rcx
               	movslq	(%rbx), %rdx
               	incq	%rdx
               	movl	%edx, (%rbx)
               	movslq	(%rcx), %rcx
               	movl	%ecx, (%r12)
               	movslq	(%rbx), %rcx
               	cmpl	$0x2, %ecx
               	je	<addr>
               	movl	$0xe, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
