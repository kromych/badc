
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
               	xorl	%eax, %eax
               	movl	%eax, -0x8(%rbp)
               	movl	$0x41a80000, -0x8(%rbp) # imm = 0x41A80000
               	movss	-0x8(%rbp), %xmm0
               	movss	-0x8(%rbp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, -0x8(%rbp)
               	movslq	-0x8(%rbp), %rcx
               	movl	%ecx, -0x8(%rbp)
               	movss	-0x8(%rbp), %xmm0
               	movl	$0x42280000, %ecx       # imm = 0x42280000
               	movq	%rcx, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movl	$0x2a, %eax
               	leave
               	retq
