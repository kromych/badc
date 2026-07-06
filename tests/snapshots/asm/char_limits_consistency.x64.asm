
char_limits_consistency.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	xorq	%rax, %rax
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	jmp	<addr>
