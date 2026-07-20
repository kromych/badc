
alloca_alignment.x64:	file format elf64-x86-64

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
               	subq	$0x50, %rsp
               	movl	$0x1, %eax
               	movq	%rax, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %rax
               	subq	%r11, %rax
               	movq	%rax, %rsp
               	movq	%rax, -0x8(%rbp)
               	movl	$0x7, %eax
               	movq	%rax, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %rax
               	subq	%r11, %rax
               	movq	%rax, %rsp
               	movq	%rax, -0x10(%rbp)
               	movl	$0x21, %eax
               	movq	%rax, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %rax
               	subq	%r11, %rax
               	movq	%rax, %rsp
               	movq	%rax, -0x18(%rbp)
               	movl	$0x64, %eax
               	movq	%rax, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %rax
               	subq	%r11, %rax
               	movq	%rax, %rsp
               	movq	%rax, -0x20(%rbp)
               	movq	-0x8(%rbp), %rax
               	andq	$0xf, %rax
               	movq	-0x10(%rbp), %rcx
               	andq	$0xf, %rcx
               	orq	%rcx, %rax
               	movq	-0x18(%rbp), %rcx
               	andq	$0xf, %rcx
               	orq	%rcx, %rax
               	movq	-0x20(%rbp), %rcx
               	andq	$0xf, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leaq	-0x50(%rbp), %rsp
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movq	-0x8(%rbp), %rax
               	xorq	%rcx, %rcx
               	movl	$0xb, %edx
               	movb	%dl, (%rax)
               	movq	-0x10(%rbp), %rax
               	movl	$0x16, %edx
               	movb	%dl, 0x6(%rax)
               	movq	-0x18(%rbp), %rax
               	movl	$0x21, %edx
               	movb	%dl, 0x20(%rax)
               	movq	-0x20(%rbp), %rax
               	movl	$0x2c, %edx
               	movb	%dl, 0x63(%rax)
               	movq	-0x8(%rbp), %rax
               	movsbq	(%rax), %rax
               	cmpq	$0xb, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movq	%rcx, -0x48(%rbp)
               	testq	%rax, %rax
               	je	<addr>
               	movq	-0x10(%rbp), %rax
               	movsbq	0x6(%rax), %rax
               	cmpq	$0x16, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x48(%rbp)
               	movq	-0x48(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, -0x40(%rbp)
               	testq	%rax, %rax
               	je	<addr>
               	movq	-0x18(%rbp), %rax
               	movsbq	0x20(%rax), %rax
               	cmpq	$0x21, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x40(%rbp)
               	movq	-0x40(%rbp), %rax
               	movq	%rax, -0x38(%rbp)
               	testq	%rax, %rax
               	je	<addr>
               	movq	-0x20(%rbp), %rax
               	movsbq	0x63(%rax), %rax
               	cmpq	$0x2c, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x38(%rbp)
               	movq	-0x38(%rbp), %rax
               	testq	%rax, %rax
               	je	<addr>
               	xorq	%rax, %rax
               	movq	%rax, -0x50(%rbp)
               	movq	-0x50(%rbp), %rax
               	movslq	%eax, %rax
               	leaq	-0x50(%rbp), %rsp
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	movq	%rax, -0x50(%rbp)
               	jmp	<addr>
