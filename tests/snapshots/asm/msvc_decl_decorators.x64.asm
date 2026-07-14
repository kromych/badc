
msvc_decl_decorators.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

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
