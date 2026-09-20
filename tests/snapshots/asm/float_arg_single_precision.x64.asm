
float_arg_single_precision.x64:	file format elf64-x86-64

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
               	movl	$0x3fc00000, %ecx       # imm = 0x3FC00000
               	movl	$0x3e800000, %eax       # imm = 0x3E800000
               	movq	%rax, %xmm15
               	movq	%rcx, %xmm0
               	mulss	%xmm15, %xmm0
               	movl	$0x3ec00000, %ecx       # imm = 0x3EC00000
               	movq	%rcx, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movl	$0xc0200000, %ecx       # imm = 0xC0200000
               	movl	$0x40800000, %edx       # imm = 0x40800000
               	movq	%rdx, %xmm15
               	movq	%rcx, %xmm0
               	mulss	%xmm15, %xmm0
               	movl	$0xc1200000, %ecx       # imm = 0xC1200000
               	movq	%rcx, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movl	$0x3f000000, %ecx       # imm = 0x3F000000
               	movl	$0x3e000000, %edx       # imm = 0x3E000000
               	movq	%rax, %xmm15
               	movq	%rcx, %xmm0
               	addss	%xmm15, %xmm0
               	movq	%rdx, %xmm15
               	addss	%xmm15, %xmm0
               	movl	$0x3f600000, %eax       # imm = 0x3F600000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movl	$0x3f800000, %eax       # imm = 0x3F800000
               	movl	$0x41000000, %ecx       # imm = 0x41000000
               	movq	%rcx, %xmm15
               	movq	%rax, %xmm0
               	divss	%xmm15, %xmm0
               	movl	$0x41800000, %eax       # imm = 0x41800000
               	movq	%rax, %xmm15
               	mulss	%xmm15, %xmm0
               	movl	$0x40000000, %eax       # imm = 0x40000000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	xorl	%eax, %eax
               	retq
