
int_to_float_assign_conversion.x64:	file format elf64-x86-64

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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x41200000, %eax       # imm = 0x41200000
               	movl	$0x42c80000, %ecx       # imm = 0x42C80000
               	movl	$0x43480000, %edx       # imm = 0x43480000
               	movq	%rax, %xmm14
               	movq	%rax, %xmm15
               	vmulss	%xmm15, %xmm14, %xmm0
               	cvttss2si	%xmm0, %rsi
               	cmpq	$0x64, %rsi
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movq	%rcx, %xmm14
               	movq	%rax, %xmm15
               	vmulss	%xmm15, %xmm14, %xmm0
               	cvttss2si	%xmm0, %rsi
               	cmpq	$0x3e8, %rsi            # imm = 0x3E8
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	movq	%rdx, %xmm14
               	movq	%rax, %xmm15
               	vmulss	%xmm15, %xmm14, %xmm0
               	cvttss2si	%xmm0, %rsi
               	cmpq	$0x7d0, %rsi            # imm = 0x7D0
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	movl	$0x42c80000, %esi       # imm = 0x42C80000
               	movq	%rcx, %xmm14
               	movq	%rsi, %xmm15
               	vmulss	%xmm15, %xmm14, %xmm0
               	cvttss2si	%xmm0, %rsi
               	cmpq	$0x2710, %rsi           # imm = 0x2710
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	movl	$0x3e991687, %esi       # imm = 0x3E991687
               	movl	$0x3f1645a2, %edi       # imm = 0x3F1645A2
               	movq	%rdi, %xmm14
               	movq	%rcx, %xmm15
               	vmulss	%xmm15, %xmm14, %xmm0
               	movq	%rsi, %xmm14
               	movq	%rax, %xmm15
               	vfmadd231ss	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	movl	$0x3de978d5, %eax       # imm = 0x3DE978D5
               	movq	%rax, %xmm14
               	movq	%rdx, %xmm15
               	vfmadd231ss	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	movl	$0x43000000, %eax       # imm = 0x43000000
               	movq	%rax, %xmm15
               	subss	%xmm15, %xmm0
               	movl	$0xc22c0000, %eax       # imm = 0xC22C0000
               	movq	%rax, %xmm15
               	comiss	%xmm15, %xmm0
               	ja	<addr>
               	movl	$0xc2300000, %eax       # imm = 0xC2300000
               	movq	%rax, %xmm15
               	comiss	%xmm0, %xmm15
               	jbe	<addr>
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
               	movl	$0x40e00000, %eax       # imm = 0x40E00000
               	movq	%rax, %xmm14
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm14
               	jp	<addr>
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
