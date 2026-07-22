
constfold_branch_through_phi.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	movl	$0x1, %eax
               	movl	$0x8, %eax
               	movl	$0x1, %eax
               	movl	$0x2, %eax
               	movl	$0xa, %eax
               	movl	$0x64, %eax
               	movl	$0x8, %eax
               	movl	$0xa, %eax
               	movl	$0x64, %eax
               	movabsq	$-0x2, %rax
               	movl	$0x1, %eax
               	movl	$0xa, %eax
               	movl	$0x1, %eax
               	movl	$0x1, %eax
               	xorq	%rax, %rax
               	retq
