
tailrec_narrow_param.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<sum_to>:
               	movsbq	%dil, %rdi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x1(%rdi), %rcx
               	movslq	%ecx, %rcx
               	movsbq	%cl, %rcx
               	addq	%rdi, %rax
               	movq	%rcx, %rdi
               	testq	%rdi, %rdi
               	jg	<addr>
               	addq	$0x0, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x64, %edi
               	callq	<addr>
               	cmpq	$0x13ba, %rax           # imm = 0x13BA
               	jne	<addr>
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
               	addb	%al, (%rax)
