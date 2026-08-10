
unnamed_field_tagged_type.x64:	file format elf64-x86-64

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
               	subq	$0xa0, %rsp
               	leaq	-0x68(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	%rcx, (%rax)
               	leaq	-0x68(%rbp), %rax
               	movl	$0x3, %ecx
               	movl	%ecx, 0x8(%rax)
               	leaq	-0x68(%rbp), %rax
               	xorq	%rcx, %rcx
               	movl	$0x61, %edx
               	movb	%dl, 0x10(%rax)
               	leaq	-0x68(%rbp), %rax
               	movb	%cl, 0x11(%rax)
               	leaq	-0x68(%rbp), %rax
               	movq	(%rax), %rax
               	leaq	<rip>, %rcx
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movsbq	(%rax), %rdx
               	movsbq	(%rcx), %rsi
               	cmpq	%rsi, %rdx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	incq	%rax
               	incq	%rcx
               	jmp	<addr>
               	jmp	<addr>
               	movsbq	(%rax), %rax
               	movsbq	(%rcx), %rcx
               	cmpq	%rcx, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x5, %eax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x68(%rbp), %rax
               	movslq	0x8(%rax), %rax
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x68(%rbp), %rax
               	addq	$0x10, %rax
               	leaq	<rip>, %rcx
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movsbq	(%rax), %rdx
               	movsbq	(%rcx), %rsi
               	cmpq	%rsi, %rdx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	incq	%rax
               	incq	%rcx
               	jmp	<addr>
               	jmp	<addr>
               	movsbq	(%rax), %rax
               	movsbq	(%rcx), %rcx
               	cmpq	%rcx, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x7, %eax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	leaq	-0x20(%rbp), %rax
               	movl	(%rax), %ecx
               	andq	$-0x8, %rcx
               	orq	$0x5, %rcx
               	movl	%ecx, (%rax)
               	leaq	-0x20(%rbp), %rdx
               	movl	%ecx, %eax
               	andq	$-0xf9, %rax
               	orq	$0xa8, %rax
               	movl	%eax, (%rdx)
               	leaq	-0x20(%rbp), %rcx
               	movl	$0x1234, %edx           # imm = 0x1234
               	movl	%edx, 0x4(%rcx)
               	movl	%eax, %ecx
               	andq	$0x7, %rcx
               	cmpq	$0x5, %rcx
               	je	<addr>
               	movl	$0x28, %eax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	movl	%eax, %eax
               	sarq	$0x3, %rax
               	andq	$0x1f, %rax
               	cmpq	$0x15, %rax
               	je	<addr>
               	movl	$0x29, %eax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	leaq	<rip>, %rcx
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movsbq	(%rax), %rdx
               	movsbq	(%rcx), %rsi
               	cmpq	%rsi, %rdx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	incq	%rax
               	incq	%rcx
               	jmp	<addr>
               	jmp	<addr>
               	movsbq	(%rax), %rax
               	movsbq	(%rcx), %rcx
               	cmpq	%rcx, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x32, %eax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	0x8(%rax), %rax
               	cmpq	$0xb, %rax
               	je	<addr>
               	movl	$0x33, %eax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	addq	$0x10, %rax
               	leaq	<rip>, %rcx
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movsbq	(%rax), %rdx
               	movsbq	(%rcx), %rsi
               	cmpq	%rsi, %rdx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	incq	%rax
               	incq	%rcx
               	jmp	<addr>
               	jmp	<addr>
               	movsbq	(%rax), %rax
               	movsbq	(%rcx), %rcx
               	cmpq	%rcx, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x34, %eax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	0x8(%rax), %rax
               	cmpq	$0x16, %rax
               	je	<addr>
               	movl	$0x35, %eax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	addq	$0x10, %rax
               	leaq	<rip>, %rcx
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movsbq	(%rax), %rdx
               	movsbq	(%rcx), %rsi
               	cmpq	%rsi, %rdx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	incq	%rax
               	incq	%rcx
               	jmp	<addr>
               	jmp	<addr>
               	movsbq	(%rax), %rax
               	movsbq	(%rcx), %rcx
               	cmpq	%rcx, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x36, %eax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x37, %eax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x38(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	movq	0x10(%rcx), %rdx
               	movq	%rdx, 0x10(%rax)
               	popq	%rdx
               	leaq	-0x50(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	movq	0x10(%rcx), %rdx
               	movq	%rdx, 0x10(%rax)
               	popq	%rdx
               	leaq	-0x38(%rbp), %rax
               	movq	(%rax), %rax
               	leaq	<rip>, %rcx
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movsbq	(%rax), %rdx
               	movsbq	(%rcx), %rsi
               	cmpq	%rsi, %rdx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	incq	%rax
               	incq	%rcx
               	jmp	<addr>
               	jmp	<addr>
               	movsbq	(%rax), %rax
               	movsbq	(%rcx), %rcx
               	cmpq	%rcx, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x38, %eax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x38(%rbp), %rax
               	movslq	0x8(%rax), %rax
               	cmpq	$0xd, %rax
               	je	<addr>
               	movl	$0x39, %eax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x38(%rbp), %rax
               	addq	$0x10, %rax
               	leaq	<rip>, %rcx
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movsbq	(%rax), %rdx
               	movsbq	(%rcx), %rsi
               	cmpq	%rsi, %rdx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	incq	%rax
               	incq	%rcx
               	jmp	<addr>
               	jmp	<addr>
               	movsbq	(%rax), %rax
               	movsbq	(%rcx), %rcx
               	cmpq	%rcx, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x3a, %eax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x50(%rbp), %rax
               	movslq	0x8(%rax), %rax
               	cmpq	$0x18, %rax
               	je	<addr>
               	movl	$0x3b, %eax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x50(%rbp), %rax
               	addq	$0x10, %rax
               	leaq	<rip>, %rcx
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movsbq	(%rax), %rdx
               	movsbq	(%rcx), %rsi
               	cmpq	%rsi, %rdx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	incq	%rax
               	incq	%rcx
               	jmp	<addr>
               	jmp	<addr>
               	movsbq	(%rax), %rax
               	movsbq	(%rcx), %rcx
               	cmpq	%rcx, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x3c, %eax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
