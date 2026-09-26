
redecl_composite_arity_warning.x64:	file format elf64-x86-64

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
               	movq	%rdi, %rax
               	retq

<add2>:
               	leaq	(%rdi,%rsi), %rax
               	retq

<add3>:
               	leaq	(%rdi,%rsi), %rax
               	addq	%rdx, %rax
               	retq

<main>:
               	xorl	%eax, %eax
               	retq
