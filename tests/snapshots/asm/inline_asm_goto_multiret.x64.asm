
inline_asm_goto_multiret.x64:	file format elf64-x86-64

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
               	jmp	<addr>
               	movl	$0x1, %eax
               	retq
               	nop
               	jmp	<addr>
               	movl	$0x3, %eax
               	retq
               	movq	<rip>, %rcx # <addr>
               	movq	<rip>, %rax # <addr>
               	jmp	<addr>
               	incq	%rcx
               	cmpq	$0xa, %rcx
               	jne	<addr>
               	cmpq	$0x16, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	cmpq	$0xa, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x14, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	movl	$0x2a, %eax
               	retq
               	addq	$0x2, %rax
               	jmp	<addr>
               	movl	$0x2, %eax
               	retq
