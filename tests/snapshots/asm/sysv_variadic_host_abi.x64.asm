
sysv_variadic_host_abi.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
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
               	leaq	-0x18(%rbp), %rax
               	leaq	-0xd8(%rbp), %rcx
               	movl	$0x10, (%rax)
               	movl	$0x30, 0x4(%rax)
               	leaq	0x10(%rbp), %r10
               	movq	%r10, 0x8(%rax)
               	leaq	-0xe0(%rbp), %r10
               	movq	%r10, 0x10(%rax)
               	movslq	-0xe0(%rbp), %rax
               	movslq	-0xd8(%rbp), %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rdx
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movslq	%ecx, %rax
               	cmpq	$0xa, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rax
               	movq	%rax, %rcx
               	incq	%rcx
               	jmp	<addr>
               	movslq	%ecx, %rax
               	movl	$0x2, %esi
               	pushq	%rdx
               	cqto
               	idivq	%rsi
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	-0x18(%rbp), %rax
               	movq	%rdx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	movq	%rax, %r13
               	movl	(%r13), %r10d
               	cmpq	$0x30, %r10
               	jae	<addr>
               	addq	0x10(%r13), %r10
               	addl	$0x8, (%r13)
               	jmp	<addr>
               	movq	0x8(%r13), %r10
               	addq	$0x8, 0x8(%r13)
               	movq	%r10, %rax
               	movq	(%rax), %rax
               	addq	%rax, %rdx
               	jmp	<addr>
               	jmp	<addr>
               	leaq	-0x18(%rbp), %rax
               	movq	%rax, %r13
               	movl	0x4(%r13), %r10d
               	cmpq	$0xb0, %r10
               	jae	<addr>
               	addq	0x10(%r13), %r10
               	addl	$0x10, 0x4(%r13)
               	jmp	<addr>
               	movq	0x8(%r13), %r10
               	addq	$0x8, 0x8(%r13)
               	movq	%r10, %rax
               	movsd	(%rax,%riz), %xmm0
               	cvttsd2si	%xmm0, %rax
               	addq	%rax, %rdx
               	jmp	<addr>
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
               	leaq	-0x18(%rbp), %rax
               	leaq	-0xe0(%rbp), %rcx
               	movl	$0x8, (%rax)
               	movl	$0x30, 0x4(%rax)
               	leaq	0x10(%rbp), %r10
               	movq	%r10, 0x8(%rax)
               	leaq	-0xe0(%rbp), %r10
               	movq	%r10, 0x10(%rax)
               	xorq	%rcx, %rcx
               	cvtsi2sd	%rcx, %xmm0
               	jmp	<addr>
               	movslq	%ecx, %rax
               	movslq	-0xe0(%rbp), %rdx
               	cmpq	%rdx, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rax
               	movq	%rax, %rcx
               	incq	%rcx
               	jmp	<addr>
               	leaq	-0x18(%rbp), %rax
               	movq	%rax, %r13
               	movl	0x4(%r13), %r10d
               	cmpq	$0xb0, %r10
               	jae	<addr>
               	addq	0x10(%r13), %r10
               	addl	$0x10, 0x4(%r13)
               	jmp	<addr>
               	movq	0x8(%r13), %r10
               	addq	$0x8, 0x8(%r13)
               	movq	%r10, %rax
               	movsd	(%rax,%riz), %xmm1
               	addsd	%xmm1, %xmm0
               	jmp	<addr>
               	leaq	-0x18(%rbp), %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x90, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movl	$0x1, %edi
               	movl	$0x2, %esi
               	movabsq	$0x4000000000000000, %rcx # imm = 0x4000000000000000
               	movl	$0x3, %r8d
               	movabsq	$0x4010000000000000, %r9 # imm = 0x4010000000000000
               	movl	$0x5, %eax
               	movabsq	$0x4018000000000000, %rdx # imm = 0x4018000000000000
               	movl	$0x7, %r11d
               	movabsq	$0x4020000000000000, %rbx # imm = 0x4020000000000000
               	movl	$0x9, %r12d
               	movabsq	$0x4024000000000000, %r14 # imm = 0x4024000000000000
               	subq	$0x10, %rsp
               	movq	%r12, (%rsp)
               	movq	%rcx, %xmm0
               	movq	%r9, %xmm1
               	movq	%rdx, %xmm2
               	movq	%rbx, %xmm3
               	movq	%r14, %xmm4
               	movq	%rdi, %rdx
               	movq	%r11, %r9
               	movq	%r8, %rcx
               	movq	%rax, %r8
               	movb	$0x5, %al
               	callq	<addr>
               	addq	$0x10, %rsp
               	cmpq	$0x3a, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movl	$0x9, %edi
               	movabsq	$0x3ff0000000000000, %rsi # imm = 0x3FF0000000000000
               	movabsq	$0x4000000000000000, %rdx # imm = 0x4000000000000000
               	movabsq	$0x4008000000000000, %rcx # imm = 0x4008000000000000
               	movabsq	$0x4010000000000000, %r8 # imm = 0x4010000000000000
               	movabsq	$0x4014000000000000, %r9 # imm = 0x4014000000000000
               	movabsq	$0x4018000000000000, %rax # imm = 0x4018000000000000
               	movabsq	$0x401c000000000000, %r11 # imm = 0x401C000000000000
               	movabsq	$0x4020000000000000, %rbx # imm = 0x4020000000000000
               	movabsq	$0x4022000000000000, %r12 # imm = 0x4022000000000000
               	subq	$0x10, %rsp
               	movq	%r12, (%rsp)
               	movq	%rsi, %xmm0
               	movq	%rdx, %xmm1
               	movq	%rcx, %xmm2
               	movq	%r8, %xmm3
               	movq	%r9, %xmm4
               	movq	%rax, %xmm5
               	movq	%r11, %xmm6
               	movq	%rbx, %xmm7
               	movb	$0x8, %al
               	callq	<addr>
               	addq	$0x10, %rsp
               	movabsq	$0x4046800000000000, %rax # imm = 0x4046800000000000
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
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
