
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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	movslq	%edi, %rdi
               	movq	%rdi, %rbx
               	movl	%ebx, %eax
               	popq	%rbx
               	leave
               	retq

<add_mixed>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movq	%rsi, %rcx
               	movq	%rbx, %rax
               	addq	%rcx, %rax
               	popq	%rbx
               	leave
               	retq

<modifier_named>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	movslq	%edi, %rdi
               	movq	%rdi, %rbx
               	movl	%ebx, %eax
               	addl	%ebx, %eax
               	popq	%rbx
               	leave
               	retq

<rw_named>:
               	movl	%edi, %eax
               	addl	$0x5, %eax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	movl	$0x7, %ebx
               	movl	%ebx, %eax
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x1e, %ebx
               	movl	$0xc, %ecx
               	movq	%rbx, %rax
               	addq	%rcx, %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x15, %ebx
               	movl	%ebx, %eax
               	addl	%ebx, %eax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x25, %eax
               	addl	$0x5, %eax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x2a, %eax
               	popq	%rbx
               	leave
               	retq
