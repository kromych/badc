
inline_asm_goto_multiret.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	$0xb, %eax
               	movq	%rax, -0x10(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x3, %eax
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x16, %eax
               	movq	%rax, -0x10(%rbp)
               	nop
               	movl	$0x5, %eax
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x21, %eax
               	movq	%rax, -0x10(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x8, %eax
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x7, %eax
               	movl	$0x2a, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x9, %eax
               	jmp	<addr>
               	movl	$0x6, %eax
               	jmp	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>
               	jmp	<addr>
