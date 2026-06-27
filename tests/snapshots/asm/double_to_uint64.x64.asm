
double_to_uint64.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movabsq	$0x43e158e460913d00, %rax # imm = 0x43E158E460913D00
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rbp,%riz)
               	movabsq	$0x43e0000000000000, %rax # imm = 0x43E0000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x10(%rbp,%riz)
               	movabsq	$0x43ef399b1438a100, %rax # imm = 0x43EF399B1438A100
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x18(%rbp,%riz)
               	movabsq	$0x4059000000000000, %rax # imm = 0x4059000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x20(%rbp,%riz)
               	movabsq	$0x4014000000000000, %rax # imm = 0x4014000000000000
               	movq	%rax, %xmm0
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movsd	-0x8(%rbp,%riz), %xmm1
               	movapd	%xmm1, %xmm14
               	movabsq	$0x43e0000000000000, %r11 # imm = 0x43E0000000000000
               	movq	%r11, %xmm15
               	ucomisd	%xmm15, %xmm14
               	jae	<addr>
               	cvttsd2si	%xmm14, %rax
               	jmp	<addr>
               	subsd	%xmm15, %xmm14
               	cvttsd2si	%xmm14, %rax
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	orq	%r11, %rax
               	movabsq	$-0x7538dcfb76180000, %r11 # imm = 0x8AC7230489E80000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movsd	-0x10(%rbp,%riz), %xmm1
               	movapd	%xmm1, %xmm14
               	movabsq	$0x43e0000000000000, %r11 # imm = 0x43E0000000000000
               	movq	%r11, %xmm15
               	ucomisd	%xmm15, %xmm14
               	jae	<addr>
               	cvttsd2si	%xmm14, %rax
               	jmp	<addr>
               	subsd	%xmm15, %xmm14
               	cvttsd2si	%xmm14, %rax
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	orq	%r11, %rax
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movsd	-0x18(%rbp,%riz), %xmm1
               	movapd	%xmm1, %xmm14
               	movabsq	$0x43e0000000000000, %r11 # imm = 0x43E0000000000000
               	movq	%r11, %xmm15
               	ucomisd	%xmm15, %xmm14
               	jae	<addr>
               	cvttsd2si	%xmm14, %rax
               	jmp	<addr>
               	subsd	%xmm15, %xmm14
               	cvttsd2si	%xmm14, %rax
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	orq	%r11, %rax
               	movabsq	$-0x633275e3af80000, %r11 # imm = 0xF9CCD8A1C5080000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movsd	-0x20(%rbp,%riz), %xmm1
               	movapd	%xmm1, %xmm14
               	movabsq	$0x43e0000000000000, %r11 # imm = 0x43E0000000000000
               	movq	%r11, %xmm15
               	ucomisd	%xmm15, %xmm14
               	jae	<addr>
               	cvttsd2si	%xmm14, %rax
               	jmp	<addr>
               	subsd	%xmm15, %xmm14
               	cvttsd2si	%xmm14, %rax
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	orq	%r11, %rax
               	cmpq	$0x64, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	cvttsd2si	%xmm0, %rax
               	cmpq	$-0x5, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movsd	-0x20(%rbp,%riz), %xmm0
               	cvttsd2si	%xmm0, %rax
               	cmpq	$0x64, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x7538dcfb76180000, %rax # imm = 0x8AC7230489E80000
               	movq	%rax, %r10
               	testq	%r10, %r10
               	js	<addr>
               	cvtsi2sd	%r10, %xmm0
               	jmp	<addr>
               	movq	%r10, %r11
               	shrq	$0x1, %r11
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
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
