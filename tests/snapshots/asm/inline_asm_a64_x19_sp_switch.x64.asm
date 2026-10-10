
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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x220, %rsp            # imm = 0x220
               	movq	$0x5, -0x218(%rbp)
               	movq	$0xa, -0x210(%rbp)
               	movq	$0xf, -0x208(%rbp)
               	leaq	-0x200(%rbp), %rcx
               	movl	$0x1, %eax
               	movb	%al, (%rcx)
               	movq	-0x218(%rbp), %rdx
               	movq	-0x210(%rbp), %rsi
               	movq	-0x208(%rbp), %rdi
               	addq	%rdi, %rsi
               	addq	%rsi, %rdx
               	movq	%rdx, -0x218(%rbp)
               	movq	-0x210(%rbp), %rdx
               	movq	-0x218(%rbp), %rsi
               	addq	%rsi, %rdx
               	movq	%rdx, -0x210(%rbp)
               	movq	-0x208(%rbp), %rdx
               	movq	-0x210(%rbp), %rsi
               	addq	%rsi, %rdx
               	movq	%rdx, -0x208(%rbp)
               	movq	-0x218(%rbp), %rdx
               	movq	-0x210(%rbp), %rsi
               	addq	%rsi, %rdx
               	movq	-0x208(%rbp), %rsi
               	addq	%rsi, %rdx
               	movsbq	(%rcx), %rcx
               	addq	%rdx, %rcx
               	cmpq	$0x7e, %rcx
               	jne	<addr>
               	movl	$0x2a, %eax
               	leave
               	retq
