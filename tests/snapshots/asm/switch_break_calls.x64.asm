
switch_break_calls.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<f1>:
               	movl	$0x64, %eax
               	retq

<f2>:
               	movl	$0xc8, %eax
               	retq

<f3>:
               	movl	$0x12c, %eax            # imm = 0x12C
               	retq

<f4>:
               	movl	$0x190, %eax            # imm = 0x190
               	retq

<driver>:
               	movslq	%edi, %rdi
               	cmpq	$0x1, %rdi
               	jl	<addr>
               	cmpq	$0x2, %rdi
               	jl	<addr>
               	cmpq	$0x2, %rdi
               	je	<addr>
               	movl	$0x190, %eax            # imm = 0x190
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	retq
               	movl	$0x12c, %eax            # imm = 0x12C
               	jmp	<addr>
               	cmpq	$0x1, %rdi
               	jne	<addr>
               	movl	$0xc8, %eax
               	jmp	<addr>
               	testq	%rdi, %rdi
               	jne	<addr>
               	movl	$0x64, %eax
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x2, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	popq	%rbp
               	retq
