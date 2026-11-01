
compound_assign_int_fp.x64:	file format elf64-x86-64

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
               	movabsq	$0x4024000000000000, %rax # imm = 0x4024000000000000
               	movabsq	$0x400f333333333333, %rcx # imm = 0x400F333333333333
               	movq	%rax, %xmm14
               	movq	%rcx, %xmm15
               	vaddsd	%xmm15, %xmm14, %xmm0
               	cvttsd2si	%xmm0, %rcx
               	cmpq	$0xd, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movabsq	$0x4004000000000000, %rcx # imm = 0x4004000000000000
               	movq	%rax, %xmm14
               	movq	%rcx, %xmm15
               	vsubsd	%xmm15, %xmm14, %xmm0
               	cvttsd2si	%xmm0, %rdx
               	cmpq	$0x7, %rdx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movq	%rax, %xmm14
               	movq	%rcx, %xmm15
               	vmulsd	%xmm15, %xmm14, %xmm0
               	cvttsd2si	%xmm0, %rax
               	cmpq	$0x19, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movabsq	$0x4059000000000000, %rax # imm = 0x4059000000000000
               	movabsq	$0x4008000000000000, %rcx # imm = 0x4008000000000000
               	movq	%rax, %xmm14
               	movq	%rcx, %xmm15
               	vdivsd	%xmm15, %xmm14, %xmm0
               	cvttsd2si	%xmm0, %rdx
               	cmpq	$0x21, %rdx
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	movl	$0x40e00000, %edx       # imm = 0x40E00000
               	movl	$0x4039999a, %esi       # imm = 0x4039999A
               	movq	%rdx, %xmm14
               	movq	%rsi, %xmm15
               	vaddss	%xmm15, %xmm14, %xmm0
               	cvttss2si	%xmm0, %rdx
               	cmpl	$0x9, %edx
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	movabsq	$-0x3fdc000000000000, %rdx # imm = 0xC024000000000000
               	movabsq	$0x40592ccccccccccd, %rsi # imm = 0x40592CCCCCCCCCCD
               	movq	%rdx, %xmm14
               	movq	%rsi, %xmm15
               	vaddsd	%xmm15, %xmm14, %xmm0
               	cvttsd2si	%xmm0, %rdx
               	cmpq	$0x5a, %rdx
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	movabsq	$0x4014000000000000, %rdx # imm = 0x4014000000000000
               	movabsq	$0x400c000000000000, %rsi # imm = 0x400C000000000000
               	movq	%rdx, %xmm14
               	movq	%rsi, %xmm15
               	vmulsd	%xmm15, %xmm14, %xmm0
               	movapd	%xmm0, %xmm14
               	movabsq	$0x43e0000000000000, %r11 # imm = 0x43E0000000000000
               	movq	%r11, %xmm15
               	ucomisd	%xmm15, %xmm14
               	jae	<addr>
               	cvttsd2si	%xmm14, %rdx
               	jmp	<addr>
               	subsd	%xmm15, %xmm14
               	cvttsd2si	%xmm14, %rdx
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	orq	%r11, %rdx
               	cmpq	$0x11, %rdx
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	movabsq	$0x40494ccccccccccd, %rdx # imm = 0x40494CCCCCCCCCCD
               	movq	%rax, %xmm14
               	movq	%rdx, %xmm15
               	vaddsd	%xmm15, %xmm14, %xmm0
               	cvttsd2si	%xmm0, %rdx
               	movswq	%dx, %rdx
               	cmpl	$0x96, %edx
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	movabsq	$0x3ff0000000000000, %rdx # imm = 0x3FF0000000000000
               	movq	%rdx, %xmm14
               	movq	%rcx, %xmm15
               	vdivsd	%xmm15, %xmm14, %xmm0
               	movq	%rax, %xmm14
               	vaddsd	%xmm0, %xmm14, %xmm0
               	cvttsd2si	%xmm0, %rax
               	cmpq	$0x64, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	retq
               	movabsq	$0x3ff8000000000000, %rax # imm = 0x3FF8000000000000
               	movq	%rax, %xmm14
               	movq	%rcx, %xmm15
               	vaddsd	%xmm15, %xmm14, %xmm0
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movq	%rax, %xmm15
               	mulsd	%xmm15, %xmm0
               	movabsq	$0x4022000000000000, %rax # imm = 0x4022000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xa, %eax
               	retq
               	xorl	%eax, %eax
               	retq
