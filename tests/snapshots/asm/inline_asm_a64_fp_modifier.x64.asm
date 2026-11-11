
inline_asm_a64_fp_modifier.x64:	file format elf64-x86-64

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
               	movabsq	$0x4045000000000000, %rax # imm = 0x4045000000000000
               	movl	$0x2a, %ecx
               	xorl	%edx, %edx
               	movq	%rax, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	movq	%rcx, %rax
               	cmovneq	%rdx, %rax
               	cmovpq	%rdx, %rax
               	retq
