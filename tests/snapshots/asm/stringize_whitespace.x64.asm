
stringize_whitespace.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rdx
               	movsbq	(%rcx), %rsi
               	xorq	%rax, %rax
               	testq	%rsi, %rsi
               	je	<addr>
               	movsbq	(%rdx), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movsbq	(%rcx), %rax
               	movsbq	(%rdx), %rsi
               	cmpq	%rsi, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	incq	%rcx
               	incq	%rdx
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movsbq	(%rcx), %rax
               	testq	%rax, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorq	%rax, %rax
               	testq	%rcx, %rcx
               	je	<addr>
               	movsbq	(%rdx), %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rdx
               	movsbq	(%rcx), %rsi
               	xorq	%rax, %rax
               	testq	%rsi, %rsi
               	je	<addr>
               	movsbq	(%rdx), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movsbq	(%rcx), %rax
               	movsbq	(%rdx), %rsi
               	cmpq	%rsi, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	incq	%rcx
               	incq	%rdx
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movsbq	(%rcx), %rax
               	testq	%rax, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorq	%rax, %rax
               	testq	%rcx, %rcx
               	je	<addr>
               	movsbq	(%rdx), %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rdx
               	movsbq	(%rcx), %rsi
               	xorq	%rax, %rax
               	testq	%rsi, %rsi
               	je	<addr>
               	movsbq	(%rdx), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movsbq	(%rcx), %rax
               	movsbq	(%rdx), %rsi
               	cmpq	%rsi, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	incq	%rcx
               	incq	%rdx
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movsbq	(%rcx), %rax
               	testq	%rax, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorq	%rax, %rax
               	testq	%rcx, %rcx
               	je	<addr>
               	movsbq	(%rdx), %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x3, %eax
               	retq
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rdx
               	movsbq	(%rcx), %rsi
               	xorq	%rax, %rax
               	testq	%rsi, %rsi
               	je	<addr>
               	movsbq	(%rdx), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movsbq	(%rcx), %rax
               	movsbq	(%rdx), %rsi
               	cmpq	%rsi, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	incq	%rcx
               	incq	%rdx
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movsbq	(%rcx), %rax
               	testq	%rax, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorq	%rax, %rax
               	testq	%rcx, %rcx
               	je	<addr>
               	movsbq	(%rdx), %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x4, %eax
               	retq
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rdx
               	movsbq	(%rcx), %rsi
               	xorq	%rax, %rax
               	testq	%rsi, %rsi
               	je	<addr>
               	movsbq	(%rdx), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movsbq	(%rcx), %rax
               	movsbq	(%rdx), %rsi
               	cmpq	%rsi, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	incq	%rcx
               	incq	%rdx
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movsbq	(%rcx), %rax
               	testq	%rax, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorq	%rax, %rax
               	testq	%rcx, %rcx
               	je	<addr>
               	movsbq	(%rdx), %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x5, %eax
               	retq
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rdx
               	movsbq	(%rcx), %rsi
               	xorq	%rax, %rax
               	testq	%rsi, %rsi
               	je	<addr>
               	movsbq	(%rdx), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movsbq	(%rcx), %rax
               	movsbq	(%rdx), %rsi
               	cmpq	%rsi, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	incq	%rcx
               	incq	%rdx
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movsbq	(%rcx), %rax
               	testq	%rax, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorq	%rax, %rax
               	testq	%rcx, %rcx
               	je	<addr>
               	movsbq	(%rdx), %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x6, %eax
               	retq
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rdx
               	movsbq	(%rcx), %rsi
               	xorq	%rax, %rax
               	testq	%rsi, %rsi
               	je	<addr>
               	movsbq	(%rdx), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movsbq	(%rcx), %rax
               	movsbq	(%rdx), %rsi
               	cmpq	%rsi, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	incq	%rcx
               	incq	%rdx
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movsbq	(%rcx), %rax
               	testq	%rax, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorq	%rax, %rax
               	testq	%rcx, %rcx
               	je	<addr>
               	movsbq	(%rdx), %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x7, %eax
               	retq
               	xorq	%rax, %rax
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
