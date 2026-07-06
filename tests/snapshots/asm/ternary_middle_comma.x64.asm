
ternary_middle_comma.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xe0, %rsp
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
               	leaq	-0x8(%rbp), %rax
               	movl	$0x2a, %ecx
               	movb	%cl, (%rax)
               	movl	$0x1, %eax
               	movslq	%eax, %rcx
               	cmpq	$0x1, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x8(%rbp), %rcx
               	movzbq	(%rcx), %rcx
               	xorq	$0x2a, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	<rip>, %rdi
               	movslq	%eax, %rsi
               	leaq	-0x8(%rbp), %rax
               	movzbq	(%rax), %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
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
               	leaq	-0x20(%rbp), %rax
               	movl	$0x2a, %ecx
               	movb	%cl, (%rax)
               	movl	$0x1, %eax
               	movslq	%eax, %rcx
               	cmpq	$0x1, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x20(%rbp), %rcx
               	movzbq	(%rcx), %rcx
               	xorq	$0x2a, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	<rip>, %rdi
               	movslq	%eax, %rsi
               	leaq	-0x20(%rbp), %rax
               	movzbq	(%rax), %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x2, %eax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rax
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
               	leaq	-0x30(%rbp), %rax
               	movl	$0x2a, %ecx
               	movb	%cl, (%rax)
               	movl	$0x1, %eax
               	movslq	%eax, %rcx
               	cmpq	$0x1, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x30(%rbp), %rcx
               	movzbq	(%rcx), %rcx
               	xorq	$0x2a, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	<rip>, %rdi
               	movslq	%eax, %rsi
               	leaq	-0x30(%rbp), %rax
               	movzbq	(%rax), %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x3, %eax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movl	$0x1, %edi
               	movl	$0x2, %esi
               	movl	$0x3, %eax
               	movl	$0x6, %edx
               	movslq	%edx, %rcx
               	cmpq	$0x6, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %r8d
               	testq	%rcx, %rcx
               	jne	<addr>
               	movslq	%edi, %rcx
               	cmpq	$0x1, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	setne	%r8b
               	movzbq	%r8b, %r8
               	movl	$0x1, %ecx
               	testq	%r8, %r8
               	jne	<addr>
               	movslq	%esi, %rcx
               	cmpq	$0x2, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movslq	%eax, %rcx
               	cmpq	$0x3, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	<rip>, %rcx
               	movslq	%edx, %rdx
               	movslq	%edi, %rdi
               	movslq	%esi, %rsi
               	movslq	%eax, %r8
               	xchgq	%rcx, %rdi
               	xchgq	%rsi, %rcx
               	xchgq	%rsi, %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x4, %eax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x60(%rbp), %rax
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
               	movl	$0x63, %eax
               	movslq	%eax, %rcx
               	cmpq	$0x63, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x60(%rbp), %rcx
               	movzbq	(%rcx), %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	<rip>, %rdi
               	movslq	%eax, %rsi
               	leaq	-0x60(%rbp), %rax
               	movzbq	(%rax), %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x5, %eax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x63, %eax
               	jmp	<addr>
               	movl	$0x63, %eax
               	jmp	<addr>
               	movl	$0x63, %eax
               	jmp	<addr>
               	movabsq	$-0x1, %rdx
               	movq	%rax, %rsi
               	movq	%rax, %rdi
               	jmp	<addr>
               	leaq	-0x60(%rbp), %rax
               	movl	$0xc8, %ecx
               	movb	%cl, (%rax)
               	movl	$0x1, %eax
               	jmp	<addr>
               	addb	%al, 0x41(%rdx)
