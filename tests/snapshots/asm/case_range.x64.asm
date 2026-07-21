
case_range.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	movl	$0x1, %eax
               	movl	$0x1, %eax
               	xorq	%rax, %rax
               	movl	$0x1, %eax
               	xorq	%rax, %rax
               	movl	$0x2, %eax
               	movl	$0x2, %eax
               	xorq	%rax, %rax
               	movl	$0x2, %eax
               	xorq	%rax, %rax
               	movl	$0x2, %eax
               	movl	$0x2, %eax
               	xorq	%rax, %rax
               	movl	$0x3, %eax
               	movl	$0x3, %eax
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	movl	$0xa, %eax
               	movl	$0xb, %eax
               	movl	$0xa, %eax
               	movl	$0xb, %eax
               	xorq	%rax, %rax
               	movl	$0xa, %eax
               	movl	$0xb, %eax
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	movl	$0x1, %eax
               	movabsq	$-0x1, %rax
               	xorq	%rax, %rax
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
