
many_fp_args.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	popq	%r10
               	subq	$0xa0, %rsp
               	movsd	%xmm6, 0x60(%rsp)
               	movsd	%xmm7, 0x70(%rsp)
               	movq	0xa0(%rsp), %rax
               	movq	%rax, 0x80(%rsp)
               	movq	0xa8(%rsp), %rax
               	movq	%rax, 0x90(%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	addsd	%xmm1, %xmm0
               	addsd	%xmm2, %xmm0
               	addsd	%xmm3, %xmm0
               	addsd	%xmm4, %xmm0
               	addsd	%xmm5, %xmm0
               	movsd	0x70(%rbp,%riz), %xmm1
               	addsd	%xmm1, %xmm0
               	movsd	0x80(%rbp,%riz), %xmm1
               	addsd	%xmm1, %xmm0
               	movsd	0x90(%rbp,%riz), %xmm1
               	addsd	%xmm1, %xmm0
               	movsd	0xa0(%rbp,%riz), %xmm1
               	addsd	%xmm1, %xmm0
               	popq	%rbp
               	popq	%r11
               	addq	$0xa0, %rsp
               	pushq	%r11
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movabsq	$0x3ff0000000000000, %rdi # imm = 0x3FF0000000000000
               	movabsq	$0x4000000000000000, %rsi # imm = 0x4000000000000000
               	movabsq	$0x4008000000000000, %rdx # imm = 0x4008000000000000
               	movabsq	$0x4010000000000000, %rcx # imm = 0x4010000000000000
               	movabsq	$0x4014000000000000, %r8 # imm = 0x4014000000000000
               	movabsq	$0x4018000000000000, %r9 # imm = 0x4018000000000000
               	movabsq	$0x401c000000000000, %rax # imm = 0x401C000000000000
               	movabsq	$0x4020000000000000, %r11 # imm = 0x4020000000000000
               	movabsq	$0x4022000000000000, %rbx # imm = 0x4022000000000000
               	movabsq	$0x4024000000000000, %r12 # imm = 0x4024000000000000
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%rdi, %xmm0
               	movq	%rsi, %xmm1
               	movq	%rdx, %xmm2
               	movq	%rcx, %xmm3
               	movq	%r8, %xmm4
               	movq	%r9, %xmm5
               	movq	%rax, %xmm6
               	movq	%r11, %xmm7
               	callq	<addr>
               	addq	$0x10, %rsp
               	movabsq	$0x404b800000000000, %rax # imm = 0x404B800000000000
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
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x3fe0000000000000, %rdi # imm = 0x3FE0000000000000
               	movabsq	$0x4059000000000000, %rax # imm = 0x4059000000000000
               	movabsq	$0x4069000000000000, %rcx # imm = 0x4069000000000000
               	subq	$0x10, %rsp
               	movq	%rax, (%rsp)
               	movq	%rcx, 0x8(%rsp)
               	movq	%rdi, %xmm0
               	movq	%rdi, %xmm1
               	movq	%rdi, %xmm2
               	movq	%rdi, %xmm3
               	movq	%rdi, %xmm4
               	movq	%rdi, %xmm5
               	movq	%rdi, %xmm6
               	movq	%rdi, %xmm7
               	callq	<addr>
               	addq	$0x10, %rsp
               	movabsq	$0x4073000000000000, %rax # imm = 0x4073000000000000
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
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
