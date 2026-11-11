
inline_asm_a64_x19_sp_switch.x64:	file format elf64-x86-64

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

<switched>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x220, %rsp            # imm = 0x220
               	movq	$0x5, -0x208(%rbp)
               	movq	$0xa, -0x210(%rbp)
               	movq	$0xf, -0x218(%rbp)
               	movb	$0x1, -0x200(%rbp)
               	movq	-0x208(%rbp), %rax
               	movq	-0x210(%rbp), %rcx
               	movq	-0x218(%rbp), %rdx
               	addq	%rdx, %rcx
               	addq	%rcx, %rax
               	movq	%rax, -0x208(%rbp)
               	movq	-0x210(%rbp), %rax
               	movq	-0x208(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	%rax, -0x210(%rbp)
               	movq	-0x218(%rbp), %rax
               	movq	-0x210(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	%rax, -0x218(%rbp)
               	movq	-0x208(%rbp), %rax
               	movq	-0x210(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	-0x218(%rbp), %rcx
               	addq	%rcx, %rax
               	movsbq	-0x200(%rbp), %rcx
               	addq	%rcx, %rax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x5, %edi
               	callq	<addr>
               	movl	$0x2a, %ecx
               	movl	$0x1, %edx
               	cmpq	$0x7e, %rax
               	movq	%rdx, %rax
               	cmoveq	%rcx, %rax
               	popq	%rbp
               	retq
