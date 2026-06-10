
switch_statement.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$0x220, %esi            # imm = 0x220
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	$0x2, %eax
               	xorq	%rdx, %rdx
               	cmpq	$0x1, %rax
               	je	<addr>
               	jmp	<addr>
               	movslq	%eax, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0xa, %eax
               	jmp	<addr>
               	movl	$0x14, %edx
               	movslq	%edx, %rax
               	addq	$0x5, %rax
               	movslq	%eax, %rax
               	jmp	<addr>
               	movl	$0x64, %eax
               	jmp	<addr>
               	cmpq	$0x2, %rax
               	je	<addr>
               	cmpq	$0x3, %rax
               	je	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
