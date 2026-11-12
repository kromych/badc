
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
               	movl	$0x41a80000, -0x8(%rbp) # imm = 0x41A80000
               	movss	-0x8(%rbp), %xmm0
               	addss	%xmm0, %xmm0
               	movss	%xmm0, -0x8(%rbp)
               	movl	-0x8(%rbp), %eax
               	movl	%eax, -0x8(%rbp)
               	movl	$0x42280000, %eax       # imm = 0x42280000
               	movl	$0x2a, %ecx
               	xorl	%edx, %edx
               	movss	-0x8(%rbp), %xmm0
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	movq	%rcx, %rax
               	cmovneq	%rdx, %rax
               	cmovpq	%rdx, %rax
               	leave
               	retq
