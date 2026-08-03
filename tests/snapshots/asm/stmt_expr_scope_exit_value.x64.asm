
stmt_expr_scope_exit_value.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<vla_value>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rsp, %rsi
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
               	movl	$0x29, %ecx
               	movl	%ecx, (%rax)
               	movl	$0x1, %edx
               	movl	%edx, 0xc(%rax)
               	movslq	%ecx, %rcx
               	movslq	%edx, %rax
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	movq	%rsi, %rsp
               	leaq	-0x20(%rbp), %rsp
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq

<vla_and_guard>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rsp, %rdx
               	movl	$0x5, %eax
               	movl	%eax, -0x8(%rbp)
               	movl	$0xc, %eax
               	movq	%rax, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %rcx
               	subq	%r11, %rcx
               	shrq	$0xc, %r11
               	testq	%r11, %r11
               	je	<addr>
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r11
               	jne	<addr>
               	movq	%rcx, %rsp
               	movslq	-0x8(%rbp), %rax
               	movl	%eax, (%rcx)
               	movslq	%eax, %rax
               	addq	$0x2, %rax
               	movslq	%eax, %rax
               	leaq	-0x8(%rbp), %rsi
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rdi
               	incq	%rdi
               	movl	%edi, (%rcx)
               	leaq	<rip>, %rcx
               	movslq	(%rsi), %rsi
               	movl	%esi, (%rcx)
               	movq	%rdx, %rsp
               	leaq	-0x30(%rbp), %rsp
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	movq	%rbx, (%rsp)
               	leaq	<rip>, %rbx
               	xorq	%rax, %rax
               	movl	%eax, (%rbx)
               	movl	$0x7, %eax
               	movslq	(%rbx), %rax
               	incq	%rax
               	movl	%eax, (%rbx)
               	leaq	<rip>, %rax
               	movabsq	$-0x1, %rcx
               	movl	%ecx, (%rax)
               	movslq	(%rbx), %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movslq	(%rbx), %rax
               	incq	%rax
               	movl	%eax, (%rbx)
               	leaq	<rip>, %rax
               	xorq	%rcx, %rcx
               	movl	%ecx, (%rax)
               	movl	$0x4, %edi
               	callq	<addr>
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3, %edi
               	callq	<addr>
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movl	%eax, (%rbx)
               	movl	$0x1, %eax
               	movl	%eax, -0x50(%rbp)
               	movl	$0x2, %ecx
               	movl	%ecx, -0x48(%rbp)
               	movslq	%eax, %rax
               	movslq	%ecx, %rcx
               	addq	%rcx, %rax
               	addq	$0x6, %rax
               	movslq	%eax, %rax
               	leaq	-0x48(%rbp), %rcx
               	movslq	(%rbx), %rdx
               	incq	%rdx
               	movl	%edx, (%rbx)
               	leaq	<rip>, %rdx
               	movslq	(%rcx), %rcx
               	movl	%ecx, (%rdx)
               	leaq	-0x50(%rbp), %rcx
               	movslq	(%rbx), %rdx
               	incq	%rdx
               	movl	%edx, (%rbx)
               	leaq	<rip>, %rdx
               	movslq	(%rcx), %rcx
               	movl	%ecx, (%rdx)
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movslq	(%rbx), %rax
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	movq	(%rsp), %rbx
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movl	%eax, (%rbx)
               	movl	$0xb, %eax
               	movl	%eax, -0x40(%rbp)
               	movslq	%eax, %rax
               	leaq	-0x40(%rbp), %rcx
               	movslq	(%rbx), %rdx
               	incq	%rdx
               	movl	%edx, (%rbx)
               	leaq	<rip>, %rdx
               	movslq	(%rcx), %rcx
               	movl	%ecx, (%rdx)
               	cmpq	$0xb, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	movq	(%rsp), %rbx
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movslq	(%rbx), %rax
               	cmpq	$0x1, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpq	$0xb, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	movq	(%rsp), %rbx
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movl	%eax, (%rbx)
               	movl	%eax, -0x38(%rbp)
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movslq	-0x38(%rbp), %rax
               	addq	$0x3, %rax
               	movslq	%eax, %rax
               	leaq	-0x38(%rbp), %rcx
               	movslq	(%rbx), %rdx
               	incq	%rdx
               	movl	%edx, (%rbx)
               	leaq	<rip>, %rdx
               	movslq	(%rcx), %rcx
               	movl	%ecx, (%rdx)
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	movq	(%rsp), %rbx
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movslq	(%rbx), %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	movq	(%rsp), %rbx
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movl	%eax, (%rbx)
               	movl	%eax, -0x30(%rbp)
               	movslq	%eax, %rcx
               	movl	$0x4, %eax
               	movl	%eax, -0x28(%rbp)
               	movslq	%eax, %rax
               	leaq	(%rax,%rax,4), %rax
               	leaq	-0x28(%rbp), %rdx
               	movslq	(%rbx), %rsi
               	incq	%rsi
               	movl	%esi, (%rbx)
               	leaq	<rip>, %rsi
               	movslq	(%rdx), %rdx
               	movl	%edx, (%rsi)
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	leaq	-0x30(%rbp), %rcx
               	movslq	(%rbx), %rdx
               	incq	%rdx
               	movl	%edx, (%rbx)
               	leaq	<rip>, %rdx
               	movslq	(%rcx), %rcx
               	movl	%ecx, (%rdx)
               	cmpq	$0x14, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	movq	(%rsp), %rbx
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movslq	(%rbx), %rax
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	movq	(%rsp), %rbx
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movl	$0x63, %eax
               	movl	%eax, -0x38(%rbp)
               	jmp	<addr>
               	jmp	<addr>
