
stmt_expr_local_aggregate_assign.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<deposit>:
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, 0x10(%rbp)
               	leaq	-0x8(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movzbq	(%rcx), %rdx
               	movb	%dl, (%rax)
               	movzbq	0x1(%rcx), %rdx
               	movb	%dl, 0x1(%rax)
               	movzbq	0x2(%rcx), %rdx
               	movb	%dl, 0x2(%rax)
               	movzbq	0x3(%rcx), %rdx
               	movb	%dl, 0x3(%rax)
               	popq	%rdx
               	movl	0x10(%rbp), %eax
               	movl	$0xfffffff0, %r11d      # imm = 0xFFFFFFF0
               	andq	%r11, %rax
               	leaq	-0x8(%rbp), %rcx
               	movl	(%rcx), %ecx
               	andq	$0xf, %rcx
               	orq	%rcx, %rax
               	movl	%eax, 0x10(%rbp)
               	movl	0x10(%rbp), %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	popq	%rdx
               	leaq	-0x10(%rbp), %rax
               	movslq	0x4(%rax), %rcx
               	leaq	-0x20(%rbp), %rax
               	leaq	<rip>, %rdx
               	pushq	%rcx
               	movzbq	(%rdx), %rcx
               	movb	%cl, (%rax)
               	movzbq	0x1(%rdx), %rcx
               	movb	%cl, 0x1(%rax)
               	movzbq	0x2(%rdx), %rcx
               	movb	%cl, 0x2(%rax)
               	movzbq	0x3(%rdx), %rcx
               	movb	%cl, 0x3(%rax)
               	popq	%rcx
               	leaq	-0x20(%rbp), %rax
               	movl	(%rax), %eax
               	andq	$0x1, %rax
               	addq	$0x7, %rax
               	movl	%eax, %eax
               	movslq	%eax, %rdx
               	leaq	-0x38(%rbp), %rax
               	leaq	<rip>, %rsi
               	pushq	%rcx
               	movq	(%rsi), %rcx
               	movq	%rcx, (%rax)
               	popq	%rcx
               	leaq	-0x40(%rbp), %rax
               	leaq	<rip>, %rsi
               	pushq	%rcx
               	movq	(%rsi), %rcx
               	movq	%rcx, (%rax)
               	popq	%rcx
               	leaq	-0x40(%rbp), %rsi
               	leaq	-0x48(%rbp), %rax
               	leaq	<rip>, %rdi
               	pushq	%rcx
               	movzbq	(%rdi), %rcx
               	movb	%cl, (%rax)
               	movzbq	0x1(%rdi), %rcx
               	movb	%cl, 0x1(%rax)
               	movzbq	0x2(%rdi), %rcx
               	movb	%cl, 0x2(%rax)
               	movzbq	0x3(%rdi), %rcx
               	movb	%cl, 0x3(%rax)
               	popq	%rcx
               	leaq	-0x48(%rbp), %rax
               	movl	(%rax), %eax
               	andq	$0x7, %rax
               	leaq	-0x48(%rbp), %rdi
               	movl	(%rdi), %edi
               	sarq	$0x3, %rdi
               	andq	$0x1f, %rdi
               	addq	%rdi, %rax
               	movl	%eax, %eax
               	movl	%eax, (%rsi)
               	cmpq	$0x2, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	cmpq	$0x8, %rdx
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x40(%rbp), %rax
               	movl	(%rax), %eax
               	xorq	$0xb, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x40(%rbp), %rax
               	movl	0x4(%rax), %eax
               	xorq	$0x2, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movl	$0xa0, %edi
               	callq	<addr>
               	xorq	$0xa5, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	addb	%al, (%rax)
