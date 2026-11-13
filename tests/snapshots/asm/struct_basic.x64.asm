
struct_basic.x64:	file format elf64-x86-64

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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x8, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movabsq	$0x400000003, %rcx      # imm = 0x400000003
               	movq	%rcx, (%rax)
               	movl	$0x19, %eax
               	popq	%rbp
               	retq
