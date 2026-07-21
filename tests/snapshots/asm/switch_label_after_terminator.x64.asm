
switch_label_after_terminator.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<outer>:
               	movslq	%edi, %rdi
               	cmpq	$0x2, %rdi
               	jl	<addr>
               	cmpq	$0x3, %rdi
               	jl	<addr>
               	cmpq	$0x3, %rdi
               	je	<addr>
               	movabsq	$-0x1, %rax
               	retq
               	movl	$0x3, %eax
               	addq	$0x64, %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	retq
               	cmpq	$0x2, %rdi
               	jne	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	cmpq	$0x1, %rdi
               	jne	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>

<main>:
               	movl	$0x1, %eax
               	movl	$0x65, %eax
               	movl	$0x2, %eax
               	movl	$0x66, %eax
               	movl	$0x3, %eax
               	movl	$0x67, %eax
               	movabsq	$-0x1, %rax
               	xorq	%rax, %rax
               	retq
