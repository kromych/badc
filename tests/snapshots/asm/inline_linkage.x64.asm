
inline_linkage.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<inl>:
               	leaq	0x1(%rdi), %rax
               	movslq	%eax, %rax
               	retq

<sinl>:
               	leaq	0x2(%rdi), %rax
               	movslq	%eax, %rax
               	retq

<einl>:
               	leaq	0x3(%rdi), %rax
               	movslq	%eax, %rax
               	retq

<main>:
               	xorq	%rdx, %rdx
               	movl	$0x1, %edx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x1, %edx
               	testq	%rdx, %rdx
               	je	<addr>
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	retq
               	movl	$0x1, %ecx
               	jmp	<addr>
               	jmp	<addr>
               	addb	%al, 0x41(%rdx)
