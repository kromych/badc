
fn_type_typedef_field.x64:	file format elf64-x86-64

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

<make>:
               	movslq	%edi, %rax
               	movq	%rax, %rcx
               	shlq	%rcx
               	movslq	%ecx, %rdx
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	$0x7, %edi
               	callq	<addr>
               	cmpq	$0x7, %rax
               	jne	<addr>
               	cmpq	$0xe, %rdx
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movl	$0x5, %edi
               	callq	<addr>
               	movq	%rax, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rax
               	movq	%rdx, 0x8(%rax)
               	movq	(%rax), %rax
               	cmpq	$0x5, %rax
               	jne	<addr>
               	movl	$0x5, %edi
               	callq	<addr>
               	movq	%rax, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rax
               	movq	%rdx, 0x8(%rax)
               	cmpq	$0xa, %rdx
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
