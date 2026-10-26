
inline_asm_a64_fp_arith.x64:	file format elf64-x86-64

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
               	movabsq	$0x4018000000000000, %rax # imm = 0x4018000000000000
               	movabsq	$0x4020000000000000, %rcx # imm = 0x4020000000000000
               	movq	%rax, %xmm14
               	movq	%rcx, %xmm15
               	vmulsd	%xmm15, %xmm14, %xmm0
               	movabsq	$-0x3fe8000000000000, %rax # imm = 0xC018000000000000
               	movq	%rax, %xmm15
               	addsd	%xmm15, %xmm0
               	cvttsd2si	%xmm0, %rax
               	retq
