
macro_paste_empty_arg_placemarker.x64:	file format elf64-x86-64

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

<int32_to_x>:
               	leaq	0x1(%rdi), %rax
               	movslq	%eax, %rax
               	retq

<uint32_to_x>:
               	leaq	0x2(%rdi), %rax
               	movslq	%eax, %rax
               	retq

<main>:
               	leaq	<rip>, %rax
               	movl	$0x9, %ecx
               	movl	%ecx, (%rax)
               	xorq	%rax, %rax
               	retq
