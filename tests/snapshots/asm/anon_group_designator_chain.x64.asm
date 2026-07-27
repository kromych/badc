
anon_group_designator_chain.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<check_runtime>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	movl	$0x14, %eax
               	movl	$0x16, %ecx
               	leaq	-0x30(%rbp), %rdx
               	leaq	<rip>, %rsi
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rdx)
               	movq	0x10(%rsi), %rax
               	movq	%rax, 0x10(%rdx)
               	movq	0x18(%rsi), %rax
               	movq	%rax, 0x18(%rdx)
               	movq	0x20(%rsi), %rax
               	movq	%rax, 0x20(%rdx)
               	movq	0x28(%rsi), %rax
               	movq	%rax, 0x28(%rdx)
               	popq	%rax
               	movl	$0x1, %edx
               	leaq	-0x30(%rbp), %rsi
               	movl	%edx, (%rsi)
               	leaq	-0x30(%rbp), %rdx
               	movl	%eax, 0x8(%rdx)
               	leaq	-0x30(%rbp), %rdx
               	movl	%ecx, 0xc(%rdx)
               	leaq	-0x68(%rbp), %rdx
               	leaq	<rip>, %rsi
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rdx)
               	movq	0x10(%rsi), %rax
               	movq	%rax, 0x10(%rdx)
               	movq	0x18(%rsi), %rax
               	movq	%rax, 0x18(%rdx)
               	movq	0x20(%rsi), %rax
               	movq	%rax, 0x20(%rdx)
               	movq	0x28(%rsi), %rax
               	movq	%rax, 0x28(%rdx)
               	movzbq	0x30(%rsi), %rax
               	movb	%al, 0x30(%rdx)
               	movzbq	0x31(%rsi), %rax
               	movb	%al, 0x31(%rdx)
               	movzbq	0x32(%rsi), %rax
               	movb	%al, 0x32(%rdx)
               	movzbq	0x33(%rsi), %rax
               	movb	%al, 0x33(%rdx)
               	popq	%rax
               	movl	$0x2, %edx
               	leaq	-0x68(%rbp), %rsi
               	movl	%edx, (%rsi)
               	leaq	-0x68(%rbp), %rdx
               	movl	%eax, 0xc(%rdx)
               	leaq	-0x68(%rbp), %rdx
               	movl	%ecx, 0x10(%rdx)
               	leaq	-0x68(%rbp), %rcx
               	movl	%eax, 0x2c(%rcx)
               	movl	$0x1, %eax
               	movl	$0x1, %eax
               	leaq	-0x30(%rbp), %rax
               	movslq	0x10(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	movl	$0x1, %eax
               	leaq	-0x68(%rbp), %rcx
               	xorq	%rax, %rax
               	movslq	0x4(%rcx), %rcx
               	testq	%rcx, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x4, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	leaq	-0x30(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	movq	0x10(%rcx), %rdx
               	movq	%rdx, 0x10(%rax)
               	movq	0x18(%rcx), %rdx
               	movq	%rdx, 0x18(%rax)
               	movq	0x20(%rcx), %rdx
               	movq	%rdx, 0x20(%rax)
               	movq	0x28(%rcx), %rdx
               	movq	%rdx, 0x28(%rax)
               	popq	%rdx
               	leaq	-0x30(%rbp), %rax
               	movl	(%rax), %eax
               	xorq	$0x1, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorq	%rax, %rax
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	-0x30(%rbp), %rax
               	movslq	0x8(%rax), %rax
               	cmpq	$0x3, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	xorq	%rcx, %rcx
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-0x30(%rbp), %rax
               	movl	0xc(%rax), %eax
               	xorq	$0x9, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x5, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rax
               	movslq	0x10(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x68(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	movq	0x10(%rcx), %rdx
               	movq	%rdx, 0x10(%rax)
               	movq	0x18(%rcx), %rdx
               	movq	%rdx, 0x18(%rax)
               	movq	0x20(%rcx), %rdx
               	movq	%rdx, 0x20(%rax)
               	movq	0x28(%rcx), %rdx
               	movq	%rdx, 0x28(%rax)
               	movzbq	0x30(%rcx), %rdx
               	movb	%dl, 0x30(%rax)
               	movzbq	0x31(%rcx), %rdx
               	movb	%dl, 0x31(%rax)
               	movzbq	0x32(%rcx), %rdx
               	movb	%dl, 0x32(%rax)
               	movzbq	0x33(%rcx), %rdx
               	movb	%dl, 0x33(%rax)
               	popq	%rdx
               	leaq	-0x68(%rbp), %rax
               	movl	(%rax), %eax
               	xorq	$0x2, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorq	%rax, %rax
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	-0x68(%rbp), %rax
               	movslq	0xc(%rax), %rax
               	cmpq	$0x7, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	xorq	%rcx, %rcx
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-0x68(%rbp), %rax
               	movl	0x10(%rax), %eax
               	xorq	$0x8, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x7, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x68(%rbp), %rcx
               	xorq	%rax, %rax
               	movslq	0x4(%rcx), %rcx
               	testq	%rcx, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	-0x68(%rbp), %rax
               	movslq	0x2c(%rax), %rax
               	cmpq	$0xb, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x8, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movl	$0x14, %edi
               	movl	$0x16, %esi
               	callq	<addr>
               	movslq	%eax, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
