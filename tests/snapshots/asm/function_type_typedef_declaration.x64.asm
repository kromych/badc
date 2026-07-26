
function_type_typedef_declaration.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<add>:
               	leaq	(%rdi,%rsi), %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	retq

<sub>:
               	movq	%rdi, %rax
               	subq	%rsi, %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	-<rip>, %rax       # <addr>
               	movl	$0x2, %edi
               	movl	$0x5, %esi
               	callq	*%rax
               	movslq	%eax, %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	leaq	-<rip>, %rax       # <addr>
               	movl	$0x9, %edi
               	movl	$0x2, %esi
               	callq	*%rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	leaq	-<rip>, %rax       # <addr>
               	movl	$0x8, %edi
               	movl	$0x3, %esi
               	callq	*%rax
               	movslq	%eax, %rax
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
