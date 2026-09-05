
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
               	subq	$0x20, %rsp
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
               	leaq	-0x20(%rbp), %rsp
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	leaq	<rip>, %rbx
               	xorq	%rax, %rax
               	movl	%eax, (%rbx)
               	movl	$0x7, %ecx
               	movslq	(%rbx), %rcx
               	incq	%rcx
               	movl	%ecx, (%rbx)
               	leaq	<rip>, %rcx
               	movabsq	$-0x1, %rdx
               	movl	%edx, (%rcx)
               	movslq	(%rbx), %rcx
               	cmpl	$0x1, %ecx
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	$-0x1, %ecx
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movslq	(%rbx), %rcx
               	incq	%rcx
               	movl	%ecx, (%rbx)
               	leaq	<rip>, %rcx
               	movl	%eax, (%rcx)
               	movl	$0x4, %edi
               	callq	<addr>
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0x3, %edi
               	callq	<addr>
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	xorq	%rax, %rax
               	movl	%eax, (%rbx)
               	movl	$0x1, %ecx
               	movl	%ecx, -0x28(%rbp)
               	movl	$0x2, %ecx
               	movl	%ecx, -0x18(%rbp)
               	leaq	-0x18(%rbp), %rcx
               	movslq	(%rbx), %rdx
               	incq	%rdx
               	movl	%edx, (%rbx)
               	leaq	<rip>, %rdx
               	movslq	(%rcx), %rsi
               	movl	%esi, (%rdx)
               	leaq	-0x28(%rbp), %rdx
               	movslq	(%rbx), %rsi
               	incq	%rsi
               	movl	%esi, (%rbx)
               	leaq	<rip>, %rsi
               	movslq	(%rdx), %rdx
               	movl	%edx, (%rsi)
               	movslq	(%rbx), %rdx
               	cmpl	$0x2, %edx
               	je	<addr>
               	movl	$0x8, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	%eax, (%rbx)
               	movl	$0xb, %edx
               	movl	%edx, -0x18(%rbp)
               	movslq	(%rbx), %rdx
               	incq	%rdx
               	movl	%edx, (%rbx)
               	leaq	<rip>, %rdx
               	movslq	(%rcx), %rsi
               	movl	%esi, (%rdx)
               	movslq	(%rbx), %rdx
               	cmpl	$0x1, %edx
               	jne	<addr>
               	leaq	<rip>, %rdx
               	movslq	(%rdx), %rdx
               	cmpl	$0xb, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0xa, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	%eax, (%rbx)
               	movl	%eax, -0x18(%rbp)
               	movq	%rax, %rdx
               	movslq	(%rbx), %rdx
               	incq	%rdx
               	movl	%edx, (%rbx)
               	leaq	<rip>, %rdx
               	movslq	(%rcx), %rcx
               	movl	%ecx, (%rdx)
               	movslq	(%rbx), %rcx
               	cmpl	$0x1, %ecx
               	je	<addr>
               	movl	$0xc, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	%eax, (%rbx)
               	movl	%eax, -0x28(%rbp)
               	movl	$0x4, %eax
               	movl	%eax, -0x18(%rbp)
               	leaq	-0x18(%rbp), %rax
               	movslq	(%rbx), %rcx
               	incq	%rcx
               	movl	%ecx, (%rbx)
               	leaq	<rip>, %rcx
               	movslq	(%rax), %rax
               	movl	%eax, (%rcx)
               	leaq	-0x28(%rbp), %rax
               	movslq	(%rbx), %rcx
               	incq	%rcx
               	movl	%ecx, (%rbx)
               	leaq	<rip>, %rcx
               	movslq	(%rax), %rax
               	movl	%eax, (%rcx)
               	movslq	(%rbx), %rax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0xe, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	leave
               	retq
