
sizeof_with_write.x64:	file format elf64-x86-64

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
               	movl	$0x10, %edi
               	callq	<addr>
               	movq	%rax, %rsi
               	movl	$0x1, %edi
               	movabsq	$0x200000001, %rax      # imm = 0x200000001
               	movq	%rax, (%rsi)
               	leaq	<rip>, %rax
               	movq	%rax, 0x8(%rsi)
               	movl	$0x10, %edx
               	callq	<addr>
               	movl	$0x10, %eax
               	popq	%r11
               	retq
