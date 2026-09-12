
auto_struct_array_multi_dim.x64:	file format elf64-x86-64

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

<runtime3d>:
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	movq	%rcx, %rax
               	movq	%rcx, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movl	$0x2, %edi
               	movl	$0x1000, %esi           # imm = 0x1000
               	movl	$0x9000, %edx           # imm = 0x9000
               	callq	<addr>
               	movslq	%eax, %rax
               	popq	%rbp
               	retq
