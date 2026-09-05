
inline_asm_a64_fp_vector.x64:	file format elf64-x86-64

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
               	movl	$0x41a80000, %eax       # imm = 0x41A80000
               	xorq	%rcx, %rcx
               	movl	%ecx, -0x8(%rbp)
               	movl	%eax, -0x8(%rbp)
               	movss	-0x8(%rbp,%riz), %xmm0
               	movss	-0x8(%rbp,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, -0x8(%rbp,%riz)
               	movslq	-0x8(%rbp), %rax
               	movl	%eax, -0x8(%rbp)
               	movss	-0x8(%rbp,%riz), %xmm0
               	movl	$0x42280000, %eax       # imm = 0x42280000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movl	$0x2a, %eax
               	movslq	%eax, %rax
               	leave
               	retq
               	xorq	%rax, %rax
               	jmp	<addr>
