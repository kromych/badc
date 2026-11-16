
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
               	leaq	0x1(%rdi), %rax
               	movslq	%eax, %rdx
               	testq	%rdi, %rdi
               	je	<addr>
               	movq	%rdi, %rcx
               	addq	$0x64, %rcx
               	jne	<addr>
               	movq	$-0x1, %rax
               	retq
               	shlq	%rcx
               	leaq	0x1(%rcx), %rsi
               	movl	%esi, <rip> # <addr>
               	addq	%rcx, %rax
               	addq	%rdx, %rax
               	retq
               	movq	$-0x2, %rax
               	retq

<main>:
               	movl	$0xd3, <rip> # <addr>
               	xorl	%eax, %eax
               	retq
