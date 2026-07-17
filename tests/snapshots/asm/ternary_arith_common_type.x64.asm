
ternary_arith_common_type.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	movl	$0x1, %eax
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	movabsq	$-0x1, %rax
               	xorq	%rax, %rax
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
