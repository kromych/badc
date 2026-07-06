
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
               	xorq	%rdx, %rdx
               	leaq	<rip>, %rax
               	movsbq	(%rax), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	orq	$0x1, %rdx
               	cmpq	%rax, %rax
               	je	<addr>
               	orq	$0x2, %rdx
               	leaq	<rip>, %rax
               	movsbq	(%rax), %rax
               	cmpq	$0x68, %rax
               	je	<addr>
               	orq	$0x4, %rdx
               	xorq	%rcx, %rcx
               	leaq	<rip>, %rax
               	movslq	%ecx, %rsi
               	addq	%rsi, %rax
               	movsbq	(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rax
               	leaq	0x1(%rax), %rcx
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movslq	%ecx, %rsi
               	addq	%rsi, %rax
               	movsbq	(%rax), %rax
               	leaq	<rip>, %rdi
               	addq	%rdi, %rsi
               	movsbq	(%rsi), %rsi
               	cmpq	%rsi, %rax
               	je	<addr>
               	jmp	<addr>
               	movslq	%edx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	jmp	<addr>
               	orq	$0x8, %rdx
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movslq	%edx, %rsi
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
               	jmp	<addr>
