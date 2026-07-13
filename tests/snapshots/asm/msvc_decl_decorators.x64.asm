
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
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	retq

<exported>:
               	movl	$0x3, %eax
               	retq

<halt>:
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movq	%fs:0x0, %rcx
               	addq	$-0x8, %rcx
               	movslq	(%rcx), %rax
               	incq	%rax
               	addq	$0x3, %rax
               	movl	%eax, (%rcx)
               	movslq	%eax, %rax
               	cmpq	$0xb, %rax
               	je	<addr>
               	callq	<addr>
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
