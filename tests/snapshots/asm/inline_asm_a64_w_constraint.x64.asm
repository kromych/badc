
inline_asm_a64_w_constraint.x64:	file format elf64-x86-64

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
               	subq	$0x10, %rsp
               	movabsq	$0x4045000000000000, %rcx # imm = 0x4045000000000000
               	xorl	%eax, %eax
               	movq	%rax, -0x8(%rbp)
               	movq	%rcx, -0x8(%rbp)
               	movsd	-0x8(%rbp), %xmm0
               	movq	%rax, -0x8(%rbp)
               	movsd	%xmm0, -0x8(%rbp)
               	movq	-0x8(%rbp), %rcx
               	movabsq	$0x4045000000000000, %r11 # imm = 0x4045000000000000
               	cmpq	%r11, %rcx
               	jne	<addr>
               	movl	$0x2a, %eax
               	leave
               	retq
