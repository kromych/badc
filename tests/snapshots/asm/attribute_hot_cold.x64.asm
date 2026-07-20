
attribute_hot_cold.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<fast_path>:
               	leaq	0x1(%rdi), %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	retq

<error_path>:
               	movl	$0x29, %eax
               	retq

<hot_decl>:
               	movq	%rdi, %rax
               	shlq	$0x1, %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	retq

<main>:
               	xorq	%rax, %rax
               	retq
               	addb	%al, 0x41(%rdx)
