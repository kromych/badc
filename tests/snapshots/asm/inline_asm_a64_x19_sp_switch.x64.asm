
inline_asm_a64_x19_sp_switch.x64:	file format elf64-x86-64

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

<switched>:
               	subq	$0x228, %rsp            # imm = 0x228
               	movq	$0x5, 0x18(%rsp)
               	movq	$0xa, 0x10(%rsp)
               	movq	$0xf, 0x8(%rsp)
               	movb	$0x1, 0x20(%rsp)
               	movq	0x18(%rsp), %rax
               	movq	0x10(%rsp), %rcx
               	movq	0x8(%rsp), %rdx
               	addq	%rdx, %rcx
               	addq	%rcx, %rax
               	movq	%rax, 0x18(%rsp)
               	movq	0x10(%rsp), %rax
               	movq	0x18(%rsp), %rcx
               	addq	%rcx, %rax
               	movq	%rax, 0x10(%rsp)
               	movq	0x8(%rsp), %rax
               	movq	0x10(%rsp), %rcx
               	addq	%rcx, %rax
               	movq	%rax, 0x8(%rsp)
               	movq	0x18(%rsp), %rax
               	movq	0x10(%rsp), %rcx
               	addq	%rcx, %rax
               	movq	0x8(%rsp), %rcx
               	addq	%rcx, %rax
               	movsbq	0x20(%rsp), %rcx
               	addq	%rcx, %rax
               	addq	$0x228, %rsp            # imm = 0x228
               	retq

<main>:
               	pushq	%rax
               	movl	$0x5, %edi
               	callq	<addr>
               	movl	$0x2a, %ecx
               	movl	$0x1, %edx
               	cmpq	$0x7e, %rax
               	cmovneq	%rdx, %rcx
               	movq	%rcx, %rax
               	popq	%r11
               	retq
