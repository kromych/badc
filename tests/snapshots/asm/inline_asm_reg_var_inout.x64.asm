
inline_asm_reg_var_inout.x64:	file format elf64-x86-64

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
               	movl	$0x4, %eax
               	addq	$0x1, %rax
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movl	$0x1, %eax
               	movl	$0x2, %ecx
               	movl	$0x3, %edx
               	movl	$0x4, %esi
               	movl	$0x5, %r8d
               	movl	$0x6, %r9d
               	addq	%r8, %rax
               	addq	%r9, %rcx
               	addq	$0x2, %rdx
               	addq	$0x3, %rsi
               	addq	%rcx, %rax
               	addq	%rdx, %rax
               	addq	%rsi, %rax
               	cmpq	$0x1a, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movl	$0x2a, %eax
               	retq
