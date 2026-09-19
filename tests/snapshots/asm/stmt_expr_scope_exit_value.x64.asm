
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
               	movl	$0x29, (%rax)
               	movl	$0x1, 0xc(%rax)
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
               	movl	$0x5, -0x10(%rbp)
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
               	movl	$0x5, (%rdx)
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
               	subq	$0x10, %rsp
               	leaq	<rip>, %rax
               	movl	$0x0, (%rax)
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	leaq	<rip>, %rcx
               	movl	$0xffffffff, (%rcx)     # imm = 0xFFFFFFFF
               	movslq	(%rax), %rsi
               	cmpl	$0x1, %esi
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movslq	(%rcx), %rsi
               	cmpl	$-0x1, %esi
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movslq	(%rax), %rsi
               	incq	%rsi
               	movl	%esi, (%rax)
               	movl	$0x0, (%rcx)
               	movl	$0x4, %edi
               	callq	<addr>
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movl	$0x3, %edi
               	callq	<addr>
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movl	$0x0, (%rax)
               	movl	$0x1, -0x10(%rbp)
               	movl	$0x2, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rsi
               	movslq	(%rax), %rdx
               	incq	%rdx
               	movl	%edx, (%rax)
               	leaq	<rip>, %rdx
               	movslq	(%rsi), %rdi
               	movl	%edi, (%rdx)
               	leaq	-0x10(%rbp), %rdi
               	movslq	(%rax), %r8
               	incq	%r8
               	movl	%r8d, (%rax)
               	movslq	(%rdi), %rdi
               	movl	%edi, (%rdx)
               	movslq	(%rax), %rdx
               	cmpl	$0x2, %edx
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	movl	$0x0, (%rax)
               	movl	$0xb, -0x8(%rbp)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	leaq	<rip>, %rdx
               	movslq	(%rsi), %rcx
               	movl	%ecx, (%rdx)
               	movslq	(%rax), %rcx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movslq	(%rdx), %rcx
               	cmpl	$0xb, %ecx
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	movl	$0x0, (%rax)
               	movl	$0x0, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rsi
               	movslq	(%rax), %rdi
               	incq	%rdi
               	movl	%edi, (%rax)
               	movslq	(%rsi), %rdi
               	movl	%edi, (%rdx)
               	movslq	(%rax), %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movl	$0x0, (%rax)
               	movl	$0x0, -0x10(%rbp)
               	movl	$0x4, -0x8(%rbp)
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	leaq	<rip>, %rcx
               	movslq	(%rsi), %rdx
               	movl	%edx, (%rcx)
               	leaq	-0x10(%rbp), %rdx
               	movslq	(%rax), %rsi
               	incq	%rsi
               	movl	%esi, (%rax)
               	movslq	(%rdx), %rdx
               	movl	%edx, (%rcx)
               	movslq	(%rax), %rax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0xe, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
