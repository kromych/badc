
pointer_arithmetic.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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
               	pushq	%rax
               	movl	$0x8, %edi
               	callq	<addr>
               	movabsq	$0x200000001, %rcx      # imm = 0x200000001
               	movq	%rcx, (%rax)
               	movl	$0x3, %eax
               	popq	%r11
               	retq
