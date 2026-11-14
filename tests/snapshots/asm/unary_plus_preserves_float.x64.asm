
unary_plus_preserves_float.x64:	file format elf64-x86-64

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
               	movsd	<rip>, %xmm0
               	movabsq	$0x3fe0000000000000, %r11 # imm = 0x3FE0000000000000
               	movq	%r11, %xmm1
               	vaddsd	%xmm1, %xmm0, %xmm2
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm2
               	jp	<addr>
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movabsq	$0x3fe0000000000000, %r11 # imm = 0x3FE0000000000000
               	movq	%r11, %xmm2
               	vaddsd	%xmm2, %xmm0, %xmm2
               	ucomisd	%xmm1, %xmm2
               	jp	<addr>
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	movabsq	$0x3fe0000000000000, %r11 # imm = 0x3FE0000000000000
               	movq	%r11, %xmm1
               	vaddsd	%xmm1, %xmm0, %xmm1
               	cvttsd2si	%xmm1, %rax
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	movabsq	$0x3fe0000000000000, %r11 # imm = 0x3FE0000000000000
               	movq	%r11, %xmm1
               	addsd	%xmm1, %xmm0
               	roundsd	$0xb, %xmm0, %xmm0
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	movsd	<rip>, %xmm0
               	movabsq	$-0x4020000000000000, %r11 # imm = 0xBFE0000000000000
               	movq	%r11, %xmm1
               	addsd	%xmm1, %xmm0
               	roundsd	$0xb, %xmm0, %xmm0
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	xorl	%eax, %eax
               	retq
