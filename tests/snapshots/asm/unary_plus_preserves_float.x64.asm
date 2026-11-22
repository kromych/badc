
unary_plus_preserves_float.x64:	file format elf64-x86-64

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
               	movabsq	$0x3fe0000000000000, %r11 # imm = 0x3FE0000000000000
               	movq	%r11, %xmm0
               	vaddsd	<rip>, %xmm0, %xmm1
               	movsd	<rip>, %xmm0
               	ucomisd	%xmm0, %xmm1
               	jp	<addr>
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movabsq	$0x3fe0000000000000, %r11 # imm = 0x3FE0000000000000
               	movq	%r11, %xmm1
               	vaddsd	<rip>, %xmm1, %xmm1
               	ucomisd	%xmm0, %xmm1
               	jp	<addr>
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	movabsq	$0x3fe0000000000000, %r11 # imm = 0x3FE0000000000000
               	movq	%r11, %xmm0
               	vaddsd	<rip>, %xmm0, %xmm0
               	cvttsd2si	%xmm0, %rax
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	movabsq	$0x3fe0000000000000, %r11 # imm = 0x3FE0000000000000
               	movq	%r11, %xmm0
               	vaddsd	<rip>, %xmm0, %xmm0
               	roundsd	$0xb, %xmm0, %xmm0
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	movabsq	$-0x4020000000000000, %r11 # imm = 0xBFE0000000000000
               	movq	%r11, %xmm0
               	vaddsd	<rip>, %xmm0, %xmm0
               	roundsd	$0xb, %xmm0, %xmm0
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	xorl	%eax, %eax
               	retq
