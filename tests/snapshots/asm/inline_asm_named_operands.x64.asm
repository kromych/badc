
inline_asm_named_operands.x64:	file format elf64-x86-64

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

<move_named>:
               	movslq	%edi, %rdi
               	movl	%edi, %eax
               	retq

<add_mixed>:
               	movq	%rdi, %rax
               	addq	%rsi, %rax
               	retq

<modifier_named>:
               	movslq	%edi, %rdi
               	movl	%edi, %eax
               	addl	%edi, %eax
               	retq

<rw_named>:
               	movl	%edi, %eax
               	addl	$0x5, %eax
               	retq

<main>:
               	movl	$0x7, %r10d
               	movl	%r10d, %eax
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movl	$0x1e, %r10d
               	movl	$0xc, %r11d
               	movq	%r10, %rax
               	addq	%r11, %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movl	$0x15, %r10d
               	movl	%r10d, %eax
               	addl	%r10d, %eax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movl	$0x25, %eax
               	addl	$0x5, %eax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	movl	$0x2a, %eax
               	retq
