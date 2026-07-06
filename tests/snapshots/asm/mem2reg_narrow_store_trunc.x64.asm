
mem2reg_narrow_store_trunc.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<check>:
               	movsbq	%dil, %rax
               	cmpq	$0x2c, %rax
               	jne	<addr>
               	xorq	%rax, %rax
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x12c, %edi            # imm = 0x12C
               	popq	%rbp
               	jmp	<addr>
               	addb	%al, 0x41(%rdx)
