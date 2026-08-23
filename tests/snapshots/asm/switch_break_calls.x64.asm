
switch_break_calls.x64:	file format elf64-x86-64

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
               	cmpl	$0x1, %edi
               	jl	<addr>
               	cmpl	$0x2, %edi
               	jl	<addr>
               	cmpl	$0x2, %edi
               	je	<addr>
               	movl	$0x190, %eax            # imm = 0x190
               	movslq	%eax, %rax
               	retq
               	movl	$0x12c, %eax            # imm = 0x12C
               	jmp	<addr>
               	movl	$0xc8, %eax
               	jmp	<addr>
               	testq	%rdi, %rdi
               	jne	<addr>
               	movl	$0x64, %eax
               	jmp	<addr>

<main>:
               	movl	$0x12c, %eax            # imm = 0x12C
               	movl	$0x12c, %eax            # imm = 0x12C
               	retq
