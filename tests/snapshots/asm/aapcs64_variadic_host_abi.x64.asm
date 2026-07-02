
aapcs64_variadic_host_abi.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<isum>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xe0, %rsp
               	movq	%rdi, -0xe0(%rbp)
               	movq	%rsi, -0xd8(%rbp)
               	movq	%rdx, -0xd0(%rbp)
               	movq	%rcx, -0xc8(%rbp)
               	movq	%r8, -0xc0(%rbp)
               	movq	%r9, -0xb8(%rbp)
               	testb	%al, %al
               	je	<addr>
               	movsd	%xmm0, -0xb0(%rbp,%riz)
               	movsd	%xmm1, -0xa0(%rbp,%riz)
               	movsd	%xmm2, -0x90(%rbp,%riz)
               	movsd	%xmm3, -0x80(%rbp,%riz)
               	movsd	%xmm4, -0x70(%rbp,%riz)
               	movsd	%xmm5, -0x60(%rbp,%riz)
               	movsd	%xmm6, -0x50(%rbp,%riz)
               	movsd	%xmm7, -0x40(%rbp,%riz)
               	xorq	%rdx, %rdx
               	leaq	-0x18(%rbp), %rax
               	leaq	-0xe0(%rbp), %rcx
               	movl	$0x8, (%rax)
               	movl	$0x30, 0x4(%rax)
               	leaq	0x10(%rbp), %r10
               	movq	%r10, 0x8(%rax)
               	leaq	-0xe0(%rbp), %r10
               	movq	%r10, 0x10(%rax)
               	movq	%rdx, %rax
               	movslq	%edx, %rcx
               	movslq	-0xe0(%rbp), %rsi
               	cmpq	%rsi, %rcx
               	jge	<addr>
               	jmp	<addr>
               	movslq	%edx, %rcx
               	leaq	0x1(%rcx), %rdx
               	jmp	<addr>
               	leaq	-0x18(%rbp), %rcx
               	movq	%rcx, %r11
               	movl	(%r11), %r10d
               	cmpq	$0x30, %r10
               	jae	<addr>
               	addq	0x10(%r11), %r10
               	addl	$0x8, (%r11)
               	jmp	<addr>
               	movq	0x8(%r11), %r10
               	addq	$0x8, 0x8(%r11)
               	movq	%r10, %rcx
               	movslq	(%rcx), %rcx
               	addq	%rcx, %rax
               	jmp	<addr>
               	leaq	-0x18(%rbp), %rcx
               	movslq	%eax, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq

<dsum>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xe0, %rsp
               	movq	%rdi, -0xe0(%rbp)
               	movq	%rsi, -0xd8(%rbp)
               	movq	%rdx, -0xd0(%rbp)
               	movq	%rcx, -0xc8(%rbp)
               	movq	%r8, -0xc0(%rbp)
               	movq	%r9, -0xb8(%rbp)
               	testb	%al, %al
               	je	<addr>
               	movsd	%xmm0, -0xb0(%rbp,%riz)
               	movsd	%xmm1, -0xa0(%rbp,%riz)
               	movsd	%xmm2, -0x90(%rbp,%riz)
               	movsd	%xmm3, -0x80(%rbp,%riz)
               	movsd	%xmm4, -0x70(%rbp,%riz)
               	movsd	%xmm5, -0x60(%rbp,%riz)
               	movsd	%xmm6, -0x50(%rbp,%riz)
               	movsd	%xmm7, -0x40(%rbp,%riz)
               	xorq	%rdx, %rdx
               	cvtsi2sd	%rdx, %xmm0
               	leaq	-0x18(%rbp), %rax
               	leaq	-0xe0(%rbp), %rcx
               	movl	$0x8, (%rax)
               	movl	$0x30, 0x4(%rax)
               	leaq	0x10(%rbp), %r10
               	movq	%r10, 0x8(%rax)
               	leaq	-0xe0(%rbp), %r10
               	movq	%r10, 0x10(%rax)
               	movslq	%edx, %rax
               	movslq	-0xe0(%rbp), %rcx
               	cmpq	%rcx, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%edx, %rax
               	leaq	0x1(%rax), %rdx
               	jmp	<addr>
               	leaq	-0x18(%rbp), %rax
               	movq	%rax, %r11
               	movl	0x4(%r11), %r10d
               	cmpq	$0xb0, %r10
               	jae	<addr>
               	addq	0x10(%r11), %r10
               	addl	$0x10, 0x4(%r11)
               	jmp	<addr>
               	movq	0x8(%r11), %r10
               	addq	$0x8, 0x8(%r11)
               	movq	%r10, %rax
               	movsd	(%rax,%riz), %xmm1
               	addsd	%xmm1, %xmm0
               	jmp	<addr>
               	leaq	-0x18(%rbp), %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq

<mixed>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xe0, %rsp
               	movq	%rdi, -0xe0(%rbp)
               	movq	%rsi, -0xd8(%rbp)
               	movq	%rdx, -0xd0(%rbp)
               	movq	%rcx, -0xc8(%rbp)
               	movq	%r8, -0xc0(%rbp)
               	movq	%r9, -0xb8(%rbp)
               	testb	%al, %al
               	je	<addr>
               	movsd	%xmm0, -0xb0(%rbp,%riz)
               	movsd	%xmm1, -0xa0(%rbp,%riz)
               	movsd	%xmm2, -0x90(%rbp,%riz)
               	movsd	%xmm3, -0x80(%rbp,%riz)
               	movsd	%xmm4, -0x70(%rbp,%riz)
               	movsd	%xmm5, -0x60(%rbp,%riz)
               	movsd	%xmm6, -0x50(%rbp,%riz)
               	movsd	%xmm7, -0x40(%rbp,%riz)
               	xorq	%rdx, %rdx
               	cvtsi2sd	%rdx, %xmm0
               	leaq	-0x18(%rbp), %rax
               	leaq	-0xe0(%rbp), %rcx
               	movl	$0x8, (%rax)
               	movl	$0x30, 0x4(%rax)
               	leaq	0x10(%rbp), %r10
               	movq	%r10, 0x8(%rax)
               	leaq	-0xe0(%rbp), %r10
               	movq	%r10, 0x10(%rax)
               	movslq	%edx, %rax
               	movslq	-0xe0(%rbp), %rcx
               	cmpq	%rcx, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%edx, %rax
               	leaq	0x1(%rax), %rdx
               	jmp	<addr>
               	movslq	%edx, %rax
               	andq	$0x1, %rax
               	testq	%rax, %rax
               	je	<addr>
               	jmp	<addr>
               	leaq	-0x18(%rbp), %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	movq	%rax, %r11
               	movl	0x4(%r11), %r10d
               	cmpq	$0xb0, %r10
               	jae	<addr>
               	addq	0x10(%r11), %r10
               	addl	$0x10, 0x4(%r11)
               	jmp	<addr>
               	movq	0x8(%r11), %r10
               	addq	$0x8, 0x8(%r11)
               	movq	%r10, %rax
               	movsd	(%rax,%riz), %xmm1
               	addsd	%xmm1, %xmm0
               	jmp	<addr>
               	leaq	-0x18(%rbp), %rax
               	movq	%rax, %r11
               	movl	(%r11), %r10d
               	cmpq	$0x30, %r10
               	jae	<addr>
               	addq	0x10(%r11), %r10
               	addl	$0x8, (%r11)
               	jmp	<addr>
               	movq	0x8(%r11), %r10
               	addq	$0x8, 0x8(%r11)
               	movq	%r10, %rax
               	movslq	(%rax), %rax
               	cvtsi2sd	%rax, %xmm1
               	addsd	%xmm1, %xmm0
               	jmp	<addr>

<icopy>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xf0, %rsp
               	movq	%rdi, -0xf0(%rbp)
               	movq	%rsi, -0xe8(%rbp)
               	movq	%rdx, -0xe0(%rbp)
               	movq	%rcx, -0xd8(%rbp)
               	movq	%r8, -0xd0(%rbp)
               	movq	%r9, -0xc8(%rbp)
               	testb	%al, %al
               	je	<addr>
               	movsd	%xmm0, -0xc0(%rbp,%riz)
               	movsd	%xmm1, -0xb0(%rbp,%riz)
               	movsd	%xmm2, -0xa0(%rbp,%riz)
               	movsd	%xmm3, -0x90(%rbp,%riz)
               	movsd	%xmm4, -0x80(%rbp,%riz)
               	movsd	%xmm5, -0x70(%rbp,%riz)
               	movsd	%xmm6, -0x60(%rbp,%riz)
               	movsd	%xmm7, -0x50(%rbp,%riz)
               	xorq	%rdx, %rdx
               	leaq	-0x18(%rbp), %rax
               	leaq	-0xf0(%rbp), %rcx
               	movl	$0x8, (%rax)
               	movl	$0x30, 0x4(%rax)
               	leaq	0x10(%rbp), %r10
               	movq	%r10, 0x8(%rax)
               	leaq	-0xf0(%rbp), %r10
               	movq	%r10, 0x10(%rax)
               	leaq	-0x30(%rbp), %rax
               	leaq	-0x18(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	movq	0x10(%rcx), %rdx
               	movq	%rdx, 0x10(%rax)
               	popq	%rdx
               	movq	%rdx, %rax
               	movslq	%edx, %rcx
               	movslq	-0xf0(%rbp), %rsi
               	cmpq	%rsi, %rcx
               	jge	<addr>
               	jmp	<addr>
               	movslq	%edx, %rcx
               	leaq	0x1(%rcx), %rdx
               	jmp	<addr>
               	leaq	-0x18(%rbp), %rcx
               	movq	%rcx, %r11
               	movl	(%r11), %r10d
               	cmpq	$0x30, %r10
               	jae	<addr>
               	addq	0x10(%r11), %r10
               	addl	$0x8, (%r11)
               	jmp	<addr>
               	movq	0x8(%r11), %r10
               	addq	$0x8, 0x8(%r11)
               	movq	%r10, %rcx
               	movslq	(%rcx), %rcx
               	addq	%rcx, %rax
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	movslq	%edx, %rcx
               	movslq	-0xf0(%rbp), %rsi
               	cmpq	%rsi, %rcx
               	jge	<addr>
               	jmp	<addr>
               	movslq	%edx, %rcx
               	leaq	0x1(%rcx), %rdx
               	jmp	<addr>
               	leaq	-0x30(%rbp), %rcx
               	movq	%rcx, %r11
               	movl	(%r11), %r10d
               	cmpq	$0x30, %r10
               	jae	<addr>
               	addq	0x10(%r11), %r10
               	addl	$0x8, (%r11)
               	jmp	<addr>
               	movq	0x8(%r11), %r10
               	addq	$0x8, 0x8(%r11)
               	movq	%r10, %rcx
               	movslq	(%rcx), %rcx
               	addq	%rcx, %rax
               	jmp	<addr>
               	leaq	-0x30(%rbp), %rcx
               	leaq	-0x18(%rbp), %rcx
               	movslq	%eax, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq

<named_overflow>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xd0, %rsp
               	movq	%rdi, -0xd0(%rbp)
               	movq	%rsi, -0xc8(%rbp)
               	movq	%rdx, -0xc0(%rbp)
               	movq	%rcx, -0xb8(%rbp)
               	movq	%r8, -0xb0(%rbp)
               	movq	%r9, -0xa8(%rbp)
               	testb	%al, %al
               	je	<addr>
               	movsd	%xmm0, -0xa0(%rbp,%riz)
               	movsd	%xmm1, -0x90(%rbp,%riz)
               	movsd	%xmm2, -0x80(%rbp,%riz)
               	movsd	%xmm3, -0x70(%rbp,%riz)
               	movsd	%xmm4, -0x60(%rbp,%riz)
               	movsd	%xmm5, -0x50(%rbp,%riz)
               	movsd	%xmm6, -0x40(%rbp,%riz)
               	movsd	%xmm7, -0x30(%rbp,%riz)
               	movslq	-0xd0(%rbp), %rax
               	movslq	-0xc8(%rbp), %rcx
               	addq	%rcx, %rax
               	movslq	-0xc0(%rbp), %rcx
               	addq	%rcx, %rax
               	movslq	-0xb8(%rbp), %rcx
               	addq	%rcx, %rax
               	movslq	-0xb0(%rbp), %rcx
               	addq	%rcx, %rax
               	movslq	-0xa8(%rbp), %rcx
               	addq	%rcx, %rax
               	movslq	0x10(%rbp), %rcx
               	addq	%rcx, %rax
               	movslq	0x18(%rbp), %rcx
               	addq	%rcx, %rax
               	movslq	0x20(%rbp), %rcx
               	addq	%rcx, %rax
               	movslq	0x28(%rbp), %rcx
               	addq	%rcx, %rax
               	leaq	-0x18(%rbp), %rcx
               	leaq	0x28(%rbp), %rdx
               	movl	$0x30, (%rcx)
               	movl	$0x30, 0x4(%rcx)
               	leaq	0x30(%rbp), %r10
               	movq	%r10, 0x8(%rcx)
               	leaq	-0xd0(%rbp), %r10
               	movq	%r10, 0x10(%rcx)
               	leaq	-0x18(%rbp), %rcx
               	movq	%rcx, %r11
               	movl	(%r11), %r10d
               	cmpq	$0x30, %r10
               	jae	<addr>
               	addq	0x10(%r11), %r10
               	addl	$0x8, (%r11)
               	jmp	<addr>
               	movq	0x8(%r11), %r10
               	addq	$0x8, 0x8(%r11)
               	movq	%r10, %rcx
               	movslq	(%rcx), %rcx
               	addq	%rcx, %rax
               	leaq	-0x18(%rbp), %rcx
               	movq	%rcx, %r11
               	movl	(%r11), %r10d
               	cmpq	$0x30, %r10
               	jae	<addr>
               	addq	0x10(%r11), %r10
               	addl	$0x8, (%r11)
               	jmp	<addr>
               	movq	0x8(%r11), %r10
               	addq	$0x8, 0x8(%r11)
               	movq	%r10, %rcx
               	movslq	(%rcx), %rcx
               	addq	%rcx, %rax
               	leaq	-0x18(%rbp), %rcx
               	movq	%rcx, %r11
               	movl	(%r11), %r10d
               	cmpq	$0x30, %r10
               	jae	<addr>
               	addq	0x10(%r11), %r10
               	addl	$0x8, (%r11)
               	jmp	<addr>
               	movq	0x8(%r11), %r10
               	addq	$0x8, 0x8(%r11)
               	movq	%r10, %rcx
               	movslq	(%rcx), %rcx
               	addq	%rcx, %rax
               	leaq	-0x18(%rbp), %rcx
               	movslq	%eax, %rax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xb0, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movq	%r15, 0x20(%rsp)
               	xorq	%rbx, %rbx
               	movl	$0x5, %edi
               	movl	$0x1, %esi
               	movl	$0x2, %edx
               	movl	$0x3, %ecx
               	movl	$0x4, %r8d
               	movq	%rdi, %r9
               	movb	$0x0, %al
               	callq	<addr>
               	cmpq	$0xf, %rax
               	je	<addr>
               	orq	$0x1, %rbx
               	movl	$0xc, %edi
               	movl	$0x1, %esi
               	movl	$0x2, %edx
               	movl	$0x3, %ecx
               	movl	$0x4, %r8d
               	movl	$0x5, %r9d
               	movl	$0x6, %eax
               	movl	$0x7, %r12d
               	movl	$0x8, %r13d
               	movl	$0x9, %r14d
               	movl	$0xa, %r15d
               	movl	$0xb, %r10d
               	movq	%r10, 0x38(%rsp)
               	subq	$0x40, %rsp
               	movq	%rax, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movq	%r15, 0x20(%rsp)
               	movq	0x78(%rsp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	%rdi, 0x30(%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	addq	$0x40, %rsp
               	cmpq	$0x4e, %rax
               	je	<addr>
               	orq	$0x2, %rbx
               	movl	$0x4, %edi
               	movabsq	$0x3ff8000000000000, %rsi # imm = 0x3FF8000000000000
               	movabsq	$0x4004000000000000, %rdx # imm = 0x4004000000000000
               	movabsq	$0x4008000000000000, %rcx # imm = 0x4008000000000000
               	movabsq	$0x4010000000000000, %r8 # imm = 0x4010000000000000
               	movq	%rsi, %xmm0
               	movq	%rdx, %xmm1
               	movq	%rcx, %xmm2
               	movq	%r8, %xmm3
               	movb	$0x4, %al
               	callq	<addr>
               	movabsq	$0x4026000000000000, %rax # imm = 0x4026000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	orq	$0x4, %rbx
               	movl	$0xa, %edi
               	movabsq	$0x3ff0000000000000, %rsi # imm = 0x3FF0000000000000
               	movabsq	$0x4000000000000000, %rdx # imm = 0x4000000000000000
               	movabsq	$0x4008000000000000, %rcx # imm = 0x4008000000000000
               	movabsq	$0x4010000000000000, %r8 # imm = 0x4010000000000000
               	movabsq	$0x4014000000000000, %r9 # imm = 0x4014000000000000
               	movabsq	$0x4018000000000000, %rax # imm = 0x4018000000000000
               	movabsq	$0x401c000000000000, %r12 # imm = 0x401C000000000000
               	movabsq	$0x4020000000000000, %r13 # imm = 0x4020000000000000
               	movabsq	$0x4022000000000000, %r14 # imm = 0x4022000000000000
               	movabsq	$0x4024000000000000, %r15 # imm = 0x4024000000000000
               	subq	$0x10, %rsp
               	movq	%r14, (%rsp)
               	movq	%r15, 0x8(%rsp)
               	movq	%rsi, %xmm0
               	movq	%rdx, %xmm1
               	movq	%rcx, %xmm2
               	movq	%r8, %xmm3
               	movq	%r9, %xmm4
               	movq	%rax, %xmm5
               	movq	%r12, %xmm6
               	movq	%r13, %xmm7
               	movb	$0x8, %al
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
               	testq	%rax, %rax
               	je	<addr>
               	orq	$0x8, %rbx
               	movl	$0x4, %edi
               	movl	$0xa, %esi
               	movabsq	$0x3ff8000000000000, %rdx # imm = 0x3FF8000000000000
               	movl	$0x14, %ecx
               	movabsq	$0x4004000000000000, %r8 # imm = 0x4004000000000000
               	movq	%rdx, %xmm0
               	movq	%r8, %xmm1
               	movq	%rcx, %rdx
               	movb	$0x2, %al
               	callq	<addr>
               	movabsq	$0x4041000000000000, %rax # imm = 0x4041000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	orq	$0x10, %rbx
               	movl	$0x5, %edi
               	movl	$0x2, %esi
               	movl	$0x4, %edx
               	movl	$0x6, %ecx
               	movl	$0x8, %r8d
               	movl	$0xa, %r9d
               	movb	$0x0, %al
               	callq	<addr>
               	cmpq	$0x3c, %rax
               	je	<addr>
               	orq	$0x20, %rbx
               	movl	$0x1, %edi
               	movl	$0x2, %esi
               	movl	$0x3, %edx
               	movl	$0x4, %ecx
               	movl	$0x5, %r8d
               	movl	$0x6, %r9d
               	movl	$0x7, %eax
               	movl	$0x8, %r12d
               	movl	$0x9, %r13d
               	movl	$0xa, %r14d
               	movl	$0x64, %r15d
               	movl	$0xc8, %r10d
               	movq	%r10, 0x38(%rsp)
               	movl	$0x12c, %r10d           # imm = 0x12C
               	movq	%r10, 0x30(%rsp)
               	subq	$0x40, %rsp
               	movq	%rax, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movq	%r15, 0x20(%rsp)
               	movq	0x78(%rsp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x70(%rsp), %r10
               	movq	%r10, 0x30(%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	addq	$0x40, %rsp
               	cmpq	$0x28f, %rax            # imm = 0x28F
               	je	<addr>
               	orq	$0x40, %rbx
               	movslq	%ebx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	addb	%al, (%rax)
