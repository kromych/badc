
float_param_stack_overflow.x64:	file format elf64-x86-64

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

<wsum>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movss	0x10(%rbp), %xmm8
               	movss	0x18(%rbp), %xmm9
               	movl	$0x3f800000, %eax       # imm = 0x3F800000
               	movl	$0x40000000, %ecx       # imm = 0x40000000
               	movq	%rcx, %xmm15
               	mulss	%xmm15, %xmm1
               	movq	%rax, %xmm15
               	vfmadd132ss	%xmm15, %xmm1, %xmm0 # xmm0 = (xmm0 * xmm15) + xmm1
               	movl	$0x40800000, %eax       # imm = 0x40800000
               	movq	%rax, %xmm15
               	vfmadd231ss	%xmm15, %xmm2, %xmm0 # xmm0 = (xmm2 * xmm15) + xmm0
               	movl	$0x41000000, %eax       # imm = 0x41000000
               	movq	%rax, %xmm15
               	vfmadd231ss	%xmm15, %xmm3, %xmm0 # xmm0 = (xmm3 * xmm15) + xmm0
               	movl	$0x41800000, %eax       # imm = 0x41800000
               	movq	%rax, %xmm15
               	vfmadd231ss	%xmm15, %xmm4, %xmm0 # xmm0 = (xmm4 * xmm15) + xmm0
               	movl	$0x42000000, %eax       # imm = 0x42000000
               	movq	%rax, %xmm15
               	vfmadd231ss	%xmm15, %xmm5, %xmm0 # xmm0 = (xmm5 * xmm15) + xmm0
               	movl	$0x42800000, %eax       # imm = 0x42800000
               	movq	%rax, %xmm15
               	vfmadd231ss	%xmm15, %xmm6, %xmm0 # xmm0 = (xmm6 * xmm15) + xmm0
               	movl	$0x43000000, %eax       # imm = 0x43000000
               	movq	%rax, %xmm15
               	vfmadd231ss	%xmm15, %xmm7, %xmm0 # xmm0 = (xmm7 * xmm15) + xmm0
               	movl	$0x43800000, %eax       # imm = 0x43800000
               	movq	%rax, %xmm15
               	vfmadd231ss	%xmm15, %xmm8, %xmm0 # xmm0 = (xmm8 * xmm15) + xmm0
               	movl	$0x44000000, %eax       # imm = 0x44000000
               	movq	%rax, %xmm15
               	vfmadd231ss	%xmm15, %xmm9, %xmm0 # xmm0 = (xmm9 * xmm15) + xmm0
               	cvttss2si	%xmm0, %rax
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	<rip>, %rax      # <addr>
               	movss	(%rax), %xmm14
               	movsd	%xmm14, 0x8(%rsp)
               	subq	$0x10, %rsp
               	movq	0x18(%rsp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rsp), %r10
               	movq	%r10, 0x8(%rsp)
               	movsd	0x18(%rsp), %xmm0
               	movsd	0x18(%rsp), %xmm1
               	movsd	0x18(%rsp), %xmm2
               	movsd	0x18(%rsp), %xmm3
               	movsd	0x18(%rsp), %xmm4
               	movsd	0x18(%rsp), %xmm5
               	movsd	0x18(%rsp), %xmm6
               	movsd	0x18(%rsp), %xmm7
               	callq	<addr>
               	addq	$0x10, %rsp
               	cmpl	$0x3ff, %eax            # imm = 0x3FF
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movl	$0x3fc00000, %eax       # imm = 0x3FC00000
               	movl	$0x3f000000, %ecx       # imm = 0x3F000000
               	subq	$0x10, %rsp
               	movq	%rax, (%rsp)
               	movq	%rcx, 0x8(%rsp)
               	movsd	0x18(%rsp), %xmm0
               	movsd	0x18(%rsp), %xmm1
               	movsd	0x18(%rsp), %xmm2
               	movsd	0x18(%rsp), %xmm3
               	movsd	0x18(%rsp), %xmm4
               	movsd	0x18(%rsp), %xmm5
               	movsd	0x18(%rsp), %xmm6
               	movsd	0x18(%rsp), %xmm7
               	callq	<addr>
               	addq	$0x10, %rsp
               	cmpl	$0x37f, %eax            # imm = 0x37F
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
