
inline_linkage.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<inl>:
               	leaq	0x1(%rdi), %rax
               	movslq	%eax, %rax
               	retq

<sinl>:
               	leaq	0x2(%rdi), %rax
               	movslq	%eax, %rax
               	retq

<einl>:
               	leaq	0x3(%rdi), %rax
               	movslq	%eax, %rax
               	retq

<main>:
               	movl	$0xa, %eax
               	incq	%rax
               	movslq	%eax, %rax
               	cmpq	$0xb, %rax
               	sete	%al
               	movzbq	%al, %rax
               	xorq	%rdx, %rdx
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0x2, %rax
               	movslq	%eax, %rax
               	cmpq	$0xc, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0x3, %rax
               	movslq	%eax, %rax
               	cmpq	$0xd, %rax
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0x1, %ecx
               	movq	%rcx, %rax
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
