
inner_binding_keeps_outer_array_shape.x64:	file format elf64-x86-64

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

<main>:
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	jmp	<addr>
               	movl	$0x1, %eax
               	movslq	%eax, %rcx
               	cmpq	$0x1, %rcx
               	jl	<addr>
               	movl	$0x1, %eax
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	xorq	%rax, %rax
               	retq
