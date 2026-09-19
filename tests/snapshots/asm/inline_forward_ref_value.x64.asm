
inline_forward_ref_value.x64:	file format elf64-x86-64

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

<compute>:
               	leaq	0x1(%rdi), %rsi
               	movslq	%esi, %rcx
               	testq	%rdi, %rdi
               	je	<addr>
               	leaq	0x64(%rdi), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	$-0x1, %rax
               	retq
               	shlq	%rax
               	leaq	<rip>, %rdi
               	leaq	0x1(%rax), %rdx
               	movl	%edx, (%rdi)
               	addq	%rsi, %rax
               	addq	%rcx, %rax
               	retq
               	movq	$-0x2, %rax
               	retq

<main>:
               	leaq	<rip>, %rax
               	movl	$0xd3, %ecx
               	movl	%ecx, (%rax)
               	xorl	%eax, %eax
               	retq
