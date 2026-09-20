
float_single_precision.x64:	file format elf64-x86-64

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
               	movl	$0x3f800000, %eax       # imm = 0x3F800000
               	movl	$0x40400000, %ecx       # imm = 0x40400000
               	movq	%rcx, %xmm15
               	movq	%rax, %xmm0
               	divss	%xmm15, %xmm0
               	movl	$0x3eaaaaab, %eax       # imm = 0x3EAAAAAB
               	movq	%rax, %xmm15
               	subss	%xmm15, %xmm0
               	xorl	%ecx, %ecx
               	movq	%rcx, %xmm15
               	ucomiss	%xmm0, %xmm15
               	jbe	<addr>
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movl	$0x33d6bf95, %eax       # imm = 0x33D6BF95
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jbe	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	je	<addr>
               	retq
               	movl	$0x3dcccccd, %eax       # imm = 0x3DCCCCCD
               	movq	%rax, %xmm15
               	movq	%rcx, %xmm0
               	addss	%xmm15, %xmm0
               	movq	%rax, %xmm15
               	addss	%xmm15, %xmm0
               	movq	%rax, %xmm15
               	addss	%xmm15, %xmm0
               	movq	%rax, %xmm15
               	addss	%xmm15, %xmm0
               	movq	%rax, %xmm15
               	addss	%xmm15, %xmm0
               	movq	%rax, %xmm15
               	addss	%xmm15, %xmm0
               	movq	%rax, %xmm15
               	addss	%xmm15, %xmm0
               	movl	$0x3dcccccd, %eax       # imm = 0x3DCCCCCD
               	movq	%rax, %xmm15
               	addss	%xmm15, %xmm0
               	movq	%rax, %xmm15
               	addss	%xmm15, %xmm0
               	movq	%rax, %xmm15
               	movapd	%xmm0, %xmm1
               	addss	%xmm15, %xmm1
               	movl	$0x3f800001, %eax       # imm = 0x3F800001
               	movq	%rax, %xmm15
               	movapd	%xmm1, %xmm0
               	subss	%xmm15, %xmm0
               	xorl	%ecx, %ecx
               	movq	%rcx, %xmm15
               	ucomiss	%xmm0, %xmm15
               	jbe	<addr>
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movl	$0x358637bd, %eax       # imm = 0x358637BD
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jbe	<addr>
               	movl	$0x2, %eax
               	testl	%eax, %eax
               	je	<addr>
               	retq
               	movl	$0x3f8ccccd, %eax       # imm = 0x3F8CCCCD
               	movq	%rax, %xmm15
               	movq	%rax, %xmm0
               	mulss	%xmm15, %xmm0
               	movq	%rax, %xmm15
               	mulss	%xmm15, %xmm0
               	movl	$0x3fbb67a2, %edx       # imm = 0x3FBB67A2
               	movapd	%xmm0, %xmm14
               	movq	%rax, %xmm15
               	movq	%rdx, %xmm0
               	vfmsub231ss	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) - xmm0
               	movq	%rcx, %xmm15
               	ucomiss	%xmm0, %xmm15
               	jbe	<addr>
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movl	$0x3727c5ac, %eax       # imm = 0x3727C5AC
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jbe	<addr>
               	movl	$0x4, %eax
               	testl	%eax, %eax
               	je	<addr>
               	retq
               	xorl	%eax, %eax
               	retq
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	$0x3f800000, %eax       # imm = 0x3F800000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm1
               	jp	<addr>
               	jne	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
