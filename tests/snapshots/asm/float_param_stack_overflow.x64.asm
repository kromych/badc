
float_param_stack_overflow.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<wsum>:
               	popq	%r10
               	subq	$0xa0, %rsp
               	movq	0xa0(%rsp), %rax
               	movq	%rax, 0x80(%rsp)
               	movq	0xa8(%rsp), %rax
               	movq	%rax, 0x90(%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movsd	%xmm1, 0x10(%rsp)
               	movss	0x90(%rbp,%riz), %xmm1
               	movss	0xa0(%rbp,%riz), %xmm14
               	movsd	%xmm14, 0x18(%rsp)
               	movl	$0x3f800000, %eax       # imm = 0x3F800000
               	movl	$0x40000000, %ecx       # imm = 0x40000000
               	movq	%rcx, %xmm15
               	movsd	0x10(%rsp), %xmm14
               	mulss	%xmm15, %xmm14
               	movsd	%xmm14, 0x10(%rsp)
               	movapd	%xmm0, %xmm14
               	movq	%rax, %xmm15
               	movsd	0x10(%rsp), %xmm0
               	vfmadd231ss	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	movl	$0x40800000, %eax       # imm = 0x40800000
               	movapd	%xmm2, %xmm14
               	movq	%rax, %xmm15
               	vfmadd231ss	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	movl	$0x41000000, %eax       # imm = 0x41000000
               	movapd	%xmm3, %xmm14
               	movq	%rax, %xmm15
               	vfmadd231ss	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	movl	$0x41800000, %eax       # imm = 0x41800000
               	movapd	%xmm4, %xmm14
               	movq	%rax, %xmm15
               	vfmadd231ss	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	movl	$0x42000000, %eax       # imm = 0x42000000
               	movapd	%xmm5, %xmm14
               	movq	%rax, %xmm15
               	vfmadd231ss	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	movl	$0x42800000, %eax       # imm = 0x42800000
               	movapd	%xmm6, %xmm14
               	movq	%rax, %xmm15
               	vfmadd231ss	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	movl	$0x43000000, %eax       # imm = 0x43000000
               	movapd	%xmm7, %xmm14
               	movq	%rax, %xmm15
               	vfmadd231ss	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	movl	$0x43800000, %eax       # imm = 0x43800000
               	movapd	%xmm1, %xmm14
               	movq	%rax, %xmm15
               	vfmadd231ss	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	movl	$0x44000000, %eax       # imm = 0x44000000
               	movsd	0x18(%rsp), %xmm14
               	movq	%rax, %xmm15
               	vfmadd231ss	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	cvttss2si	%xmm0, %rax
               	movslq	%eax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0xa0, %rsp
               	pushq	%r11
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	<rip>, %rax
               	movss	(%rax,%riz), %xmm14
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
               	movslq	%eax, %rax
               	cmpq	$0x3ff, %rax            # imm = 0x3FF
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	-<rip>, %rax      # <addr>
               	movl	$0x3fc00000, %edi       # imm = 0x3FC00000
               	movl	$0x3f000000, %esi       # imm = 0x3F000000
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	movq	%rsi, 0x8(%rsp)
               	movsd	0x18(%rsp), %xmm0
               	movsd	0x18(%rsp), %xmm1
               	movsd	0x18(%rsp), %xmm2
               	movsd	0x18(%rsp), %xmm3
               	movsd	0x18(%rsp), %xmm4
               	movsd	0x18(%rsp), %xmm5
               	movsd	0x18(%rsp), %xmm6
               	movsd	0x18(%rsp), %xmm7
               	callq	*%rax
               	addq	$0x10, %rsp
               	movslq	%eax, %rax
               	cmpq	$0x37f, %rax            # imm = 0x37F
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
