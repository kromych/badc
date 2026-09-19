
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
               	leaq	<rip>, %rdx
               	movq	%rax, %rcx
               	cmpb	$0x0, (%rcx)
               	je	<addr>
               	movsbq	(%rcx), %rsi
               	movsbq	(%rdx), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rcx
               	incq	%rdx
               	cmpb	$0x0, (%rcx)
               	jne	<addr>
               	movsbq	(%rcx), %rcx
               	movsbq	(%rdx), %rdx
               	cmpl	%edx, %ecx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %rcx
               	cmpb	$0x0, (%rax)
               	je	<addr>
               	movsbq	(%rax), %rdx
               	movsbq	(%rcx), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	incq	%rax
               	incq	%rcx
               	cmpb	$0x0, (%rax)
               	jne	<addr>
               	movsbq	(%rax), %rax
               	movsbq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	xorl	%eax, %eax
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
