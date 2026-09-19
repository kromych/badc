
double_to_uint64.x64:	file format elf64-x86-64

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
               	movabsq	$0x43e158e460913d00, %rcx # imm = 0x43E158E460913D00
               	movabsq	$0x43e0000000000000, %rdx # imm = 0x43E0000000000000
               	movabsq	$0x43ef399b1438a100, %rsi # imm = 0x43EF399B1438A100
               	movabsq	$0x4059000000000000, %rax # imm = 0x4059000000000000
               	movabsq	$-0x3fec000000000000, %rdi # imm = 0xC014000000000000
               	movq	%rcx, %xmm14
               	movapd	%xmm14, %xmm14
               	movabsq	$0x43e0000000000000, %r11 # imm = 0x43E0000000000000
               	movq	%r11, %xmm15
               	ucomisd	%xmm15, %xmm14
               	jae	<addr>
               	cvttsd2si	%xmm14, %rcx
               	jmp	<addr>
               	subsd	%xmm15, %xmm14
               	cvttsd2si	%xmm14, %rcx
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	orq	%r11, %rcx
               	movabsq	$-0x7538dcfb76180000, %r11 # imm = 0x8AC7230489E80000
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movq	%rdx, %xmm14
               	movapd	%xmm14, %xmm14
               	movabsq	$0x43e0000000000000, %r11 # imm = 0x43E0000000000000
               	movq	%r11, %xmm15
               	ucomisd	%xmm15, %xmm14
               	jae	<addr>
               	cvttsd2si	%xmm14, %rcx
               	jmp	<addr>
               	subsd	%xmm15, %xmm14
               	cvttsd2si	%xmm14, %rcx
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	orq	%r11, %rcx
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movq	%rsi, %xmm14
               	movapd	%xmm14, %xmm14
               	movabsq	$0x43e0000000000000, %r11 # imm = 0x43E0000000000000
               	movq	%r11, %xmm15
               	ucomisd	%xmm15, %xmm14
               	jae	<addr>
               	cvttsd2si	%xmm14, %rcx
               	jmp	<addr>
               	subsd	%xmm15, %xmm14
               	cvttsd2si	%xmm14, %rcx
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	orq	%r11, %rcx
               	movabsq	$-0x633275e3af80000, %r11 # imm = 0xF9CCD8A1C5080000
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movq	%rax, %xmm14
               	movapd	%xmm14, %xmm14
               	movabsq	$0x43e0000000000000, %r11 # imm = 0x43E0000000000000
               	movq	%r11, %xmm15
               	ucomisd	%xmm15, %xmm14
               	jae	<addr>
               	cvttsd2si	%xmm14, %rcx
               	jmp	<addr>
               	subsd	%xmm15, %xmm14
               	cvttsd2si	%xmm14, %rcx
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	orq	%r11, %rcx
               	cmpq	$0x64, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	movq	%rdi, %xmm14
               	cvttsd2si	%xmm14, %rcx
               	cmpq	$-0x5, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	movq	%rax, %xmm14
               	cvttsd2si	%xmm14, %rax
               	cmpq	$0x64, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	movabsq	$-0x7538dcfb76180000, %rax # imm = 0x8AC7230489E80000
               	xorps	%xmm0, %xmm0
               	movq	%rax, %r10
               	testq	%r10, %r10
               	js	<addr>
               	cvtsi2sd	%r10, %xmm0
               	jmp	<addr>
               	movq	%r10, %r11
               	shrq	%r11
               	andq	$0x1, %r10
               	orq	%r10, %r11
               	cvtsi2sd	%r11, %xmm0
               	addsd	%xmm0, %xmm0
               	movapd	%xmm0, %xmm14
               	movabsq	$0x43e0000000000000, %r11 # imm = 0x43E0000000000000
               	movq	%r11, %xmm15
               	ucomisd	%xmm15, %xmm14
               	jae	<addr>
               	cvttsd2si	%xmm14, %rcx
               	jmp	<addr>
               	subsd	%xmm15, %xmm14
               	cvttsd2si	%xmm14, %rcx
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	orq	%r11, %rcx
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	xorl	%eax, %eax
               	retq
