
tentative_array_definition.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3

<take_never>:
               	leaq	<rip>, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	xorq	%rcx, %rcx
               	leaq	<rip>, %rax
               	movsbq	(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leaq	<rip>, %rdx
               	movsbq	(%rdx), %rdx
               	cmpl	$0x68, %edx
               	je	<addr>
               	orq	$0x4, %rax
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	addq	%rdx, %rsi
               	movsbq	(%rsi), %rsi
               	leaq	<rip>, %rdi
               	addq	%rdx, %rdi
               	movsbq	(%rdi), %rdi
               	cmpl	%edi, %esi
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
               	movslq	%eax, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	leaq	<rip>, %rdi
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
               	movq	%rcx, %rax
               	jmp	<addr>
