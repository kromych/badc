
fp_param_ternary.x64:	file format elf64-x86-64

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

<pick>:
               	testb	$0x1, %dil
               	je	<addr>
               	retq
               	vxorpd	<rip>, %xmm0, %xmm0
               	jmp	<addr>

<grad_dot>:
               	testb	$0x1, %dil
               	je	<addr>
               	testb	$0x2, %dil
               	je	<addr>
               	addss	%xmm1, %xmm0
               	retq
               	vxorpd	<rip>, %xmm1, %xmm1
               	jmp	<addr>
               	vxorpd	<rip>, %xmm0, %xmm0
               	jmp	<addr>

<main>:
               	movl	$0x3fc00000, %r11d      # imm = 0x3FC00000
               	movq	%r11, %xmm0
               	movl	$0xc0200000, %r11d      # imm = 0xC0200000
               	movq	%r11, %xmm1
               	addss	%xmm1, %xmm0
               	movss	<rip>, %xmm1
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	movl	$0xc0e80000, %r11d      # imm = 0xC0E80000
               	movq	%r11, %xmm0
               	movl	$0x3e000000, %r11d      # imm = 0x3E000000
               	movq	%r11, %xmm1
               	addss	%xmm1, %xmm0
               	movss	<rip>, %xmm1
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	movl	$0x40400000, %r11d      # imm = 0x40400000
               	movq	%r11, %xmm0
               	movl	$0x40800000, %r11d      # imm = 0x40800000
               	movq	%r11, %xmm1
               	addss	%xmm1, %xmm0
               	movss	<rip>, %xmm1
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	xorl	%eax, %eax
               	retq
