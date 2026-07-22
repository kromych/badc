
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
               	movq	%rsp, %rsi
               	subq	%r11, %rsi
               	movq	%rsi, %rsp
               	movl	$0x7, %eax
               	movq	%rax, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %rax
               	subq	%r11, %rax
               	movq	%rax, %rsp
               	movl	$0x21, %ecx
               	movq	%rcx, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %rcx
               	subq	%r11, %rcx
               	movq	%rcx, %rsp
               	movl	$0x64, %edx
               	movq	%rdx, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %rdx
               	subq	%r11, %rdx
               	movq	%rdx, %rsp
               	movq	%rsi, %rdi
               	andq	$0xf, %rdi
               	movq	%rax, %r8
               	andq	$0xf, %r8
               	orq	%r8, %rdi
               	movq	%rcx, %r8
               	andq	$0xf, %r8
               	orq	%r8, %rdi
               	movq	%rdx, %r8
               	andq	$0xf, %r8
               	orq	%r8, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	movl	$0x1, %eax
               	leaq	-0x50(%rbp), %rsp
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	xorq	%rdi, %rdi
               	movl	$0xb, %r8d
               	movb	%r8b, (%rsi)
               	movl	$0x16, %r8d
               	movb	%r8b, 0x6(%rax)
               	movl	$0x21, %r8d
               	movb	%r8b, 0x20(%rcx)
               	movl	$0x2c, %r8d
               	movb	%r8b, 0x63(%rdx)
               	movsbq	(%rsi), %rsi
               	cmpq	$0xb, %rsi
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movsbq	0x6(%rax), %rax
               	cmpq	$0x16, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%dil
               	movzbq	%dil, %rdi
               	xorq	%rax, %rax
               	testq	%rdi, %rdi
               	je	<addr>
               	movsbq	0x20(%rcx), %rax
               	cmpq	$0x21, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movsbq	0x63(%rdx), %rax
               	cmpq	$0x2c, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	xorq	%rax, %rax
               	movslq	%eax, %rax
               	leaq	-0x50(%rbp), %rsp
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
