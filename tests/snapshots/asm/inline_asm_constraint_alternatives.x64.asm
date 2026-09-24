
inline_asm_constraint_alternatives.x64:	file format elf64-x86-64

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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	movl	$0x14, %eax
               	movl	$0x5, %ebx
               	addq	%rbx, %rax
               	cmpq	$0x19, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x3, %eax
               	movl	$0x4, %ebx
               	addq	%rbx, %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x1, %eax
               	addq	$0x7, %rax
               	cmpq	$0x8, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0xa, %eax
               	movl	$0x20, %ebx
               	addq	%rbx, %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x2a, %eax
               	popq	%rbx
               	leave
               	retq
