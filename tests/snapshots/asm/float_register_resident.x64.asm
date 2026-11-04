
float_register_resident.x64:	file format elf64-x86-64

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
               	xorl	%edx, %edx
               	movl	$0x3f000000, %eax       # imm = 0x3F000000
               	movq	%rdx, %xmm14
               	movq	%rax, %xmm15
               	vmulss	%xmm15, %xmm14, %xmm0
               	movl	$0x40000000, %ecx       # imm = 0x40000000
               	movq	%rdx, %xmm14
               	movq	%rcx, %xmm15
               	vfmadd132ss	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm0 * xmm15) + xmm14
               	movl	$0x3f800000, %edx       # imm = 0x3F800000
               	movq	%rdx, %xmm14
               	movq	%rax, %xmm15
               	vmulss	%xmm15, %xmm14, %xmm1
               	movq	%rcx, %xmm15
               	vfmadd231ss	%xmm15, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm15) + xmm0
               	movq	%rcx, %xmm14
               	movq	%rax, %xmm15
               	vmulss	%xmm15, %xmm14, %xmm1
               	movq	%rcx, %xmm15
               	vfmadd231ss	%xmm15, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm15) + xmm0
               	movl	$0x40400000, %ecx       # imm = 0x40400000
               	movq	%rcx, %xmm14
               	movq	%rax, %xmm15
               	vmulss	%xmm15, %xmm14, %xmm1
               	movl	$0x40000000, %eax       # imm = 0x40000000
               	movq	%rax, %xmm15
               	vfmadd231ss	%xmm15, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm15) + xmm0
               	movl	$0x40800000, %edx       # imm = 0x40800000
               	movl	$0x3f000000, %ecx       # imm = 0x3F000000
               	movq	%rdx, %xmm14
               	movq	%rcx, %xmm15
               	vmulss	%xmm15, %xmm14, %xmm1
               	movq	%rax, %xmm15
               	vfmadd231ss	%xmm15, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm15) + xmm0
               	movl	$0x40a00000, %edx       # imm = 0x40A00000
               	movq	%rdx, %xmm14
               	movq	%rcx, %xmm15
               	vmulss	%xmm15, %xmm14, %xmm1
               	movq	%rax, %xmm15
               	vfmadd231ss	%xmm15, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm15) + xmm0
               	movl	$0x40c00000, %edx       # imm = 0x40C00000
               	movq	%rdx, %xmm14
               	movq	%rcx, %xmm15
               	vmulss	%xmm15, %xmm14, %xmm1
               	movq	%rax, %xmm15
               	vfmadd231ss	%xmm15, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm15) + xmm0
               	movl	$0x40e00000, %eax       # imm = 0x40E00000
               	movq	%rax, %xmm14
               	movq	%rcx, %xmm15
               	vmulss	%xmm15, %xmm14, %xmm1
               	movl	$0x40000000, %eax       # imm = 0x40000000
               	movq	%rax, %xmm15
               	vfmadd231ss	%xmm15, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm15) + xmm0
               	movl	$0x41000000, %edx       # imm = 0x41000000
               	movl	$0x3f000000, %ecx       # imm = 0x3F000000
               	movq	%rdx, %xmm14
               	movq	%rcx, %xmm15
               	vmulss	%xmm15, %xmm14, %xmm1
               	movq	%rax, %xmm15
               	vfmadd231ss	%xmm15, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm15) + xmm0
               	movl	$0x41100000, %edx       # imm = 0x41100000
               	movq	%rdx, %xmm14
               	movq	%rcx, %xmm15
               	vmulss	%xmm15, %xmm14, %xmm1
               	movq	%rax, %xmm15
               	vfmadd231ss	%xmm15, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm15) + xmm0
               	cvttss2si	%xmm0, %rax
               	retq
