
anon_union_nested_init.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<check_const>:
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpq	$0x6f, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	0x40(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpq	$0x74, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	xorq	%rax, %rax
               	retq
               	jmp	<addr>

<opaque>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<check_runtime>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%rdi, %rbx
               	movq	%rsi, %r12
               	movslq	%ebx, %rbx
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x10(%rbp), %rax
               	movb	%bl, (%rax)
               	leaq	-0x10(%rbp), %rax
               	movb	%r12b, 0x1(%rax)
               	leaq	(%rbx,%r12), %rax
               	leaq	-0x10(%rbp), %rcx
               	movb	%al, 0x2(%rcx)
               	movq	%rbx, %rax
               	imulq	%r12, %rax
               	leaq	-0x10(%rbp), %rcx
               	movb	%al, 0x3(%rcx)
               	leaq	-0x10(%rbp), %rdi
               	callq	<addr>
               	movq	%rax, %rcx
               	movzbq	(%rcx), %rax
               	movq	%rbx, %rdx
               	andq	$0xff, %rdx
               	cmpq	%rdx, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movzbq	0x3(%rcx), %rcx
               	movq	%rbx, %rax
               	imulq	%r12, %rax
               	movslq	%eax, %rax
               	andq	$0xff, %rax
               	cmpq	%rax, %rcx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	popq	%rdx
               	movl	$0x9, %eax
               	leaq	-0x20(%rbp), %rcx
               	movb	%al, (%rcx)
               	movl	$0x8, %ecx
               	leaq	-0x20(%rbp), %rax
               	movb	%cl, 0x1(%rax)
               	movl	$0x7, %ecx
               	leaq	-0x20(%rbp), %rax
               	movb	%cl, 0x2(%rax)
               	movl	$0x6, %ecx
               	leaq	-0x20(%rbp), %rax
               	movb	%cl, 0x3(%rax)
               	leaq	-0x20(%rbp), %rax
               	movl	%ebx, 0x4(%rax)
               	leaq	-0x20(%rbp), %rdi
               	callq	<addr>
               	movq	%rax, %rcx
               	movzbq	(%rcx), %rax
               	xorq	$0x9, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	movl	$0x1, %eax
               	testq	%rdx, %rdx
               	jne	<addr>
               	movzbq	0x3(%rcx), %rax
               	xorq	$0x6, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movslq	0x4(%rcx), %rax
               	cmpq	%rbx, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	callq	<addr>
               	movslq	%eax, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3, %eax
               	movl	%eax, -0x10(%rbp)
               	movl	$0x5, %eax
               	movl	%eax, -0x8(%rbp)
               	movslq	-0x10(%rbp), %rdi
               	movslq	-0x8(%rbp), %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
