
fn_ptr_decay_inside_block.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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

<adder>:
               	leaq	0x64(%rdi), %rax
               	retq

<main>:
               	pushq	%rax
               	movl	$0x3, %edi
               	callq	<addr>
               	addq	$0xcb, %rax
               	addq	$0x68, %rax
               	xorl	%ecx, %ecx
               	movl	$0x2, %edx
               	cmpl	$0x19a, %eax            # imm = 0x19A
               	cmovneq	%rdx, %rcx
               	movq	%rcx, %rax
               	popq	%r11
               	retq
