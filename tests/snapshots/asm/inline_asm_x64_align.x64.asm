
inline_asm_x64_align.x64:	file format elf64-x86-64

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
               	movl	$0x1, %eax
               	nopl	(%rax)
               	addl	$0x2, %eax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movl	$0x5, %eax
               	nopl	(%rax,%rax)
               	addl	$0x6, %eax
               	cmpl	$0xb, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movl	$0x7, %eax
               	nop
               	nopw	%cs:(%rax,%rax)
               	addl	$0x8, %eax
               	cmpl	$0xf, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movl	$0x9, %eax
               	addl	$0x4, %eax
               	cmpl	$0xd, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	movl	$0x2a, %eax
               	retq
