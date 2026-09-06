
block_scope_function_declaration.x64:	file format elf64-x86-64

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

<main>:
               	leaq	<rip>, %rax
               	leaq	<rip>, %rcx
               	jmp	<addr>
               	movsbq	(%rax), %rdx
               	movsbq	(%rcx), %rsi
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	incq	%rax
               	incq	%rcx
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movsbq	(%rax), %rax
               	movsbq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	sete	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %rax
               	leaq	<rip>, %rcx
               	jmp	<addr>
               	movsbq	(%rax), %rdx
               	movsbq	(%rcx), %rsi
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	incq	%rax
               	incq	%rcx
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movsbq	(%rax), %rax
               	movsbq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	sete	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	xorq	%rax, %rax
               	retq

<sum3>:
               	leaq	(%rdi,%rsi), %rax
               	addq	%rdx, %rax
               	movslq	%eax, %rax
               	retq

<add>:
               	leaq	(%rdi,%rsi), %rax
               	movslq	%eax, %rax
               	retq

<label>:
               	leaq	<rip>, %rax
               	retq
