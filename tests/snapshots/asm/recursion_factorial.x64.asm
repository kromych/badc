
recursion_factorial.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<fact>:
               	movslq	%edi, %rdi
               	movl	$0x1, %eax
               	jmp	<addr>
               	leaq	-0x1(%rdi), %rcx
               	movslq	%ecx, %rcx
               	imulq	%rdi, %rax
               	movq	%rcx, %rdi
               	cmpq	$0x2, %rdi
               	jge	<addr>
               	shlq	$0x0, %rax
               	movslq	%eax, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x5, %edi
               	popq	%rbp
               	jmp	<addr>
