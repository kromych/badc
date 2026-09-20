
constfold_or_dispatch_inline.x64:	file format elf64-x86-64

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

<c0>:
               	leaq	0x1(%rdi), %rax
               	shlq	%rax
               	retq

<c1>:
               	leaq	0x2(%rdi), %rax
               	shlq	%rax
               	incq	%rax
               	retq

<c2>:
               	leaq	0x1(%rdi), %rax
               	shlq	%rax
               	addq	$0x2, %rax
               	retq

<c3>:
               	leaq	0x4(%rdi), %rax
               	shlq	%rax
               	addq	$0x3, %rax
               	retq

<main>:
               	xorl	%eax, %eax
               	retq
