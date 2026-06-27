
msvc_decl_decorators.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<add1>:
               	leaq	0x1(%rdi), %rax
               	movslq	%eax, %rax
               	retq

<exported>:
               	movl	$0x3, %eax
               	retq

<halt>:
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	xorq	%rax, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movq	%fs:0x0, %rax
               	subq	$0x8, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	$0x3, %edx
               	addq	%rdx, %rcx
               	movl	%ecx, (%rax)
               	movslq	%ecx, %rax
               	cmpq	$0xb, %rax
               	je	<addr>
               	jmp	<addr>
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	addb	%al, 0x41(%rdx)
