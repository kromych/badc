
inline_asm_a64_fp_vector.x64:	file format elf64-x86-64

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

<main>:
               	subq	$0x18, %rsp
               	movl	$0x41a80000, 0x8(%rsp)  # imm = 0x41A80000
               	movss	0x8(%rsp), %xmm0
               	addss	%xmm0, %xmm0
               	movss	%xmm0, 0x8(%rsp)
               	movl	0x8(%rsp), %eax
               	movl	%eax, 0x8(%rsp)
               	movl	$0x2a, %eax
               	xorl	%ecx, %ecx
               	movss	0x8(%rsp), %xmm0
               	ucomiss	<rip>, %xmm0
               	cmovneq	%rcx, %rax
               	cmovpq	%rcx, %rax
               	addq	$0x18, %rsp
               	retq
