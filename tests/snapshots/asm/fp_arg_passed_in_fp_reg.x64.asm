
fp_arg_passed_in_fp_reg.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	movapd	%xmm1, %xmm15
               	movapd	%xmm0, %xmm1
               	mulsd	%xmm15, %xmm1
               	movapd	%xmm0, %xmm15
               	movapd	%xmm1, %xmm0
               	addsd	%xmm15, %xmm0
               	retq
               	movq	%rdi, %rax
               	movq	%rsi, %rcx
               	movslq	%eax, %rax
               	movslq	%ecx, %rcx
               	cvtsi2sd	%rax, %xmm2
               	mulsd	%xmm2, %xmm0
               	cvtsi2sd	%rcx, %xmm2
               	mulsd	%xmm2, %xmm1
               	addsd	%xmm1, %xmm0
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movabsq	$0x4008000000000000, %rcx # imm = 0x4008000000000000
               	movq	%rcx, %xmm15
               	movq	%rax, %xmm0
               	mulsd	%xmm15, %xmm0
               	movq	%rax, %xmm15
               	addsd	%xmm15, %xmm0
               	movabsq	$0x4020000000000000, %rax # imm = 0x4020000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3, %eax
               	movabsq	$0x3ff8000000000000, %rcx # imm = 0x3FF8000000000000
               	movl	$0x4, %edx
               	movabsq	$0x4004000000000000, %rsi # imm = 0x4004000000000000
               	cvtsi2sd	%rax, %xmm0
               	movapd	%xmm0, %xmm15
               	movq	%rcx, %xmm0
               	mulsd	%xmm15, %xmm0
               	cvtsi2sd	%rdx, %xmm1
               	movapd	%xmm1, %xmm15
               	movq	%rsi, %xmm1
               	mulsd	%xmm15, %xmm1
               	addsd	%xmm1, %xmm0
               	movabsq	$0x402d000000000000, %rax # imm = 0x402D000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x4019000000000000, %rax # imm = 0x4019000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x18(%rbp,%riz)
               	movsd	-0x18(%rbp,%riz), %xmm0
               	movabsq	$0x4010000000000000, %rax # imm = 0x4010000000000000
               	movq	%rax, %xmm15
               	movapd	%xmm0, %xmm1
               	mulsd	%xmm15, %xmm1
               	movapd	%xmm0, %xmm15
               	movapd	%xmm1, %xmm0
               	addsd	%xmm15, %xmm0
               	movabsq	$0x403f400000000000, %rax # imm = 0x403F400000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
