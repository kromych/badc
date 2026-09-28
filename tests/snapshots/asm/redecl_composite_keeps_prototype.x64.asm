
redecl_composite_keeps_prototype.x64:	file format elf64-x86-64

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

<take_wrap>:
               	leaq	0x1(%rdi), %rax
               	retq

<take_wrap2>:
               	leaq	0x2(%rdi), %rax
               	retq

<take_wrap3>:
               	leaq	0x3(%rdi), %rax
               	retq

<take_pairw>:
               	movq	%rdi, %rax
               	shrq	$0x20, %rax
               	shlq	$0x20, %rax
               	movl	%edi, %ecx
               	orq	%rcx, %rax
               	retq

<add2>:
               	leaq	(%rdi,%rsi), %rax
               	retq

<main>:
               	xorl	%eax, %eax
               	retq
