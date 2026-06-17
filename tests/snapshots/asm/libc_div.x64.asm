
libc_div.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<div>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%r13, (%rsp)
               	movslq	%edi, %rdi
               	movslq	%esi, %rsi
               	leaq	-0x8(%rbp), %rax
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%rsi
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movl	%ecx, (%rax)
               	leaq	-0x8(%rbp), %rax
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%rsi
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movl	%ecx, 0x4(%rax)
               	leaq	-0x8(%rbp), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	(%rcx), %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq

<ldiv>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%r13, (%rsp)
               	leaq	-0x10(%rbp), %rax
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%rsi
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movq	%rcx, (%rax)
               	leaq	-0x10(%rbp), %rax
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%rsi
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x10(%rbp), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq

<lldiv>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%r13, (%rsp)
               	leaq	-0x10(%rbp), %rax
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%rsi
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movq	%rcx, (%rax)
               	leaq	-0x10(%rbp), %rax
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%rsi
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x10(%rbp), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xd0, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r13, 0x8(%rsp)
               	movl	$0x11, %edi
               	movl	$0x5, %esi
               	callq	<addr>
               	movq	%rax, -0x78(%rbp)
               	leaq	-0x78(%rbp), %rax
               	leaq	-0x8(%rbp), %rcx
               	pushq	%r11
               	movq	(%rax), %r11
               	movq	%r11, (%rcx)
               	popq	%r11
               	movq	%rcx, %rax
               	leaq	-0x8(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x3, %rax
               	setne	%bl
               	movzbq	%bl, %rbx
               	testq	%rbx, %rbx
               	jne	<addr>
               	leaq	-0x8(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	cmpq	$0x2, %rax
               	setne	%bl
               	movzbq	%bl, %rbx
               	testq	%rbx, %rbx
               	je	<addr>
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x11, %rdi
               	movl	$0x5, %esi
               	callq	<addr>
               	movq	%rax, -0x88(%rbp)
               	leaq	-0x88(%rbp), %rax
               	leaq	-0x18(%rbp), %rcx
               	pushq	%r11
               	movq	(%rax), %r11
               	movq	%r11, (%rcx)
               	popq	%r11
               	movq	%rcx, %rax
               	leaq	-0x18(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$-0x3, %rax
               	setne	%bl
               	movzbq	%bl, %rbx
               	testq	%rbx, %rbx
               	jne	<addr>
               	leaq	-0x18(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	cmpq	$-0x2, %rax
               	setne	%bl
               	movzbq	%bl, %rbx
               	testq	%rbx, %rbx
               	je	<addr>
               	movl	$0x2, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	movslq	(%rax), %rax
               	leaq	(%rax,%rax,4), %rax
               	movslq	%eax, %rax
               	leaq	-0x18(%rbp), %rcx
               	movslq	0x4(%rcx), %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	cmpq	$-0x11, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x64, %edi
               	movl	$0x7, %esi
               	callq	<addr>
               	movq	%rax, -0xa0(%rbp)
               	movq	%rdx, -0x98(%rbp)
               	leaq	-0xa0(%rbp), %rax
               	leaq	-0x30(%rbp), %rcx
               	pushq	%r11
               	movq	(%rax), %r11
               	movq	%r11, (%rcx)
               	movq	0x8(%rax), %r11
               	movq	%r11, 0x8(%rcx)
               	popq	%r11
               	movq	%rcx, %rax
               	leaq	-0x30(%rbp), %rax
               	movq	(%rax), %rax
               	cmpq	$0xe, %rax
               	setne	%bl
               	movzbq	%bl, %rbx
               	testq	%rbx, %rbx
               	jne	<addr>
               	leaq	-0x30(%rbp), %rax
               	movq	0x8(%rax), %rax
               	cmpq	$0x2, %rax
               	setne	%bl
               	movzbq	%bl, %rbx
               	testq	%rbx, %rbx
               	je	<addr>
               	movl	$0x4, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3e8, %edi            # imm = 0x3E8
               	movl	$0x3, %esi
               	callq	<addr>
               	movq	%rax, -0xb8(%rbp)
               	movq	%rdx, -0xb0(%rbp)
               	leaq	-0xb8(%rbp), %rax
               	leaq	-0x50(%rbp), %rcx
               	pushq	%r11
               	movq	(%rax), %r11
               	movq	%r11, (%rcx)
               	movq	0x8(%rax), %r11
               	movq	%r11, 0x8(%rcx)
               	popq	%r11
               	movq	%rcx, %rax
               	leaq	-0x50(%rbp), %rax
               	movq	(%rax), %rax
               	cmpq	$0x14d, %rax            # imm = 0x14D
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x50(%rbp), %rax
               	movq	0x8(%rax), %rax
               	cmpq	$0x1, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
