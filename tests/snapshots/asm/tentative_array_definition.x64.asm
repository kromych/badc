
tentative_array_definition.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<take_never>:
               	leaq	<rip>, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	xorq	%rax, %rax
               	leaq	<rip>, %rcx
               	movsbq	(%rcx), %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x1, %eax
               	cmpq	%rcx, %rcx
               	je	<addr>
               	orq	$0x2, %rax
               	leaq	<rip>, %rcx
               	movsbq	(%rcx), %rcx
               	cmpq	$0x68, %rcx
               	je	<addr>
               	orq	$0x4, %rax
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	addq	%rdx, %rsi
               	movsbq	(%rsi), %rsi
               	leaq	<rip>, %rdi
               	addq	%rdx, %rdi
               	movsbq	(%rdi), %rdi
               	cmpq	%rdi, %rsi
               	je	<addr>
               	orq	$0x8, %rax
               	jmp	<addr>
               	jmp	<addr>
               	leaq	0x1(%rdx), %rcx
               	leaq	<rip>, %rsi
               	movslq	%ecx, %rdx
               	addq	%rdx, %rsi
               	movsbq	(%rsi), %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	movslq	%eax, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	<rip>, %rdi
               	movslq	%eax, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	addb	%al, (%rax)
