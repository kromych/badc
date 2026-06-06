
fma_numeric_kernels.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movapd	%xmm1, %xmm15
               	movapd	%xmm0, %xmm1
               	subsd	%xmm15, %xmm1
               	xorq	%rax, %rax
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm1
               	setb	%al
               	movzbq	%al, %rax
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	jmp	<addr>
               	movabsq	$0x3e112e0be826d695, %rax # imm = 0x3E112E0BE826D695
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm1
               	setb	%al
               	movzbq	%al, %rax
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, %rax
               	movq	%rsi, %rcx
               	movslq	%ecx, %rcx
               	movq	%rcx, %rdx
               	subq	$0x1, %rdx
               	movslq	%edx, %rdx
               	shlq	$0x3, %rdx
               	addq	%rax, %rdx
               	movsd	(%rdx,%riz), %xmm1
               	subq	$0x2, %rcx
               	movslq	%ecx, %rcx
               	movl	%ecx, -0x10(%rbp)
               	jmp	<addr>
               	movslq	-0x10(%rbp), %rcx
               	cmpq	$0x0, %rcx
               	jl	<addr>
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rcx
               	movslq	(%rcx), %rdx
               	addq	$-0x1, %rdx
               	movl	%edx, (%rcx)
               	jmp	<addr>
               	movslq	-0x10(%rbp), %rcx
               	shlq	$0x3, %rcx
               	addq	%rax, %rcx
               	movsd	(%rcx,%riz), %xmm2
               	movapd	%xmm1, %xmm14
               	movapd	%xmm0, %xmm15
               	movapd	%xmm2, %xmm1
               	vfmadd231sd	%xmm15, %xmm14, %xmm1 # xmm1 = (xmm14 * xmm15) + xmm1
               	jmp	<addr>
               	movapd	%xmm1, %xmm0
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, %rax
               	movq	%rcx, %r10
               	movq	%rsi, %rcx
               	movq	%r10, %rsi
               	movslq	%edx, %rdx
               	movslq	%esi, %rsi
               	xorq	%rdi, %rdi
               	movq	%rdi, %xmm14
               	movsd	%xmm14, -0x8(%rbp,%riz)
               	movl	%edi, -0x10(%rbp)
               	jmp	<addr>
               	movslq	-0x10(%rbp), %rdi
               	cmpq	$0x3, %rdi
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rdi
               	movslq	(%rdi), %r8
               	addq	$0x1, %r8
               	movl	%r8d, (%rdi)
               	jmp	<addr>
               	movsd	-0x8(%rbp,%riz), %xmm0
               	imulq	$0x18, %rdx, %rdi
               	addq	%rax, %rdi
               	movslq	-0x10(%rbp), %r8
               	movq	%r8, %r9
               	shlq	$0x3, %r9
               	addq	%r9, %rdi
               	movsd	(%rdi,%riz), %xmm1
               	imulq	$0x18, %r8, %rdi
               	addq	%rcx, %rdi
               	movq	%rsi, %r8
               	shlq	$0x3, %r8
               	addq	%r8, %rdi
               	movsd	(%rdi,%riz), %xmm2
               	movapd	%xmm1, %xmm14
               	movapd	%xmm2, %xmm15
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	movsd	%xmm0, -0x8(%rbp,%riz)
               	jmp	<addr>
               	movsd	-0x8(%rbp,%riz), %xmm0
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	movq	%rax, %xmm15
               	movapd	%xmm1, %xmm2
               	mulsd	%xmm15, %xmm2
               	movapd	%xmm2, %xmm14
               	movapd	%xmm0, %xmm15
               	movapd	%xmm0, %xmm3
               	vfmadd231sd	%xmm15, %xmm14, %xmm3 # xmm3 = (xmm14 * xmm15) + xmm3
               	movapd	%xmm2, %xmm14
               	movapd	%xmm3, %xmm15
               	movapd	%xmm0, %xmm2
               	vfmadd231sd	%xmm15, %xmm14, %xmm2 # xmm2 = (xmm14 * xmm15) + xmm2
               	movapd	%xmm1, %xmm14
               	movapd	%xmm2, %xmm15
               	movapd	%xmm0, %xmm4
               	vfmadd231sd	%xmm15, %xmm14, %xmm4 # xmm4 = (xmm14 * xmm15) + xmm4
               	movabsq	$0x4018000000000000, %rax # imm = 0x4018000000000000
               	movq	%rax, %xmm15
               	divsd	%xmm15, %xmm1
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movq	%rax, %xmm14
               	movapd	%xmm3, %xmm15
               	movapd	%xmm0, %xmm3
               	vfmadd231sd	%xmm15, %xmm14, %xmm3 # xmm3 = (xmm14 * xmm15) + xmm3
               	movq	%rax, %xmm14
               	movapd	%xmm2, %xmm15
               	movapd	%xmm3, %xmm2
               	vfmadd231sd	%xmm15, %xmm14, %xmm2 # xmm2 = (xmm14 * xmm15) + xmm2
               	addsd	%xmm4, %xmm2
               	movapd	%xmm1, %xmm14
               	movapd	%xmm2, %xmm15
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x110, %rsp            # imm = 0x110
               	leaq	-0x28(%rbp), %rax
               	movabsq	$0x3ff0000000000000, %rcx # imm = 0x3FF0000000000000
               	movq	%rcx, %xmm14
               	movsd	%xmm14, (%rax,%riz)
               	leaq	-0x28(%rbp), %rax
               	addq	$0x8, %rax
               	movabsq	$0x4000000000000000, %rdx # imm = 0x4000000000000000
               	movq	%rdx, %xmm14
               	movsd	%xmm14, (%rax,%riz)
               	leaq	-0x28(%rbp), %rax
               	addq	$0x10, %rax
               	movabsq	$0x4008000000000000, %rcx # imm = 0x4008000000000000
               	movq	%rcx, %xmm14
               	movsd	%xmm14, (%rax,%riz)
               	leaq	-0x28(%rbp), %rax
               	addq	$0x18, %rax
               	movabsq	$0x4010000000000000, %rcx # imm = 0x4010000000000000
               	movq	%rcx, %xmm14
               	movsd	%xmm14, (%rax,%riz)
               	leaq	-0x28(%rbp), %rax
               	addq	$0x20, %rax
               	movabsq	$0x4014000000000000, %rcx # imm = 0x4014000000000000
               	movq	%rcx, %xmm14
               	movsd	%xmm14, (%rax,%riz)
               	leaq	-0x28(%rbp), %rdi
               	movl	$0x5, %esi
               	movq	%rdx, %xmm0
               	callq	<addr>
               	movabsq	$0x4060200000000000, %rdi # imm = 0x4060200000000000
               	movq	%rdi, %xmm1
               	callq	<addr>
               	cmpq	$0x0, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	retq
               	leaq	-0x28(%rbp), %rdi
               	movl	$0x5, %esi
               	xorq	%rdx, %rdx
               	movq	%rdx, %xmm0
               	callq	<addr>
               	movabsq	$0x3ff0000000000000, %rdi # imm = 0x3FF0000000000000
               	movq	%rdi, %xmm1
               	callq	<addr>
               	cmpq	$0x0, %rax
               	jne	<addr>
               	movl	$0x2, %eax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movl	%eax, -0xc0(%rbp)
               	jmp	<addr>
               	movslq	-0xc0(%rbp), %rax
               	cmpq	$0x3, %rax
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0xc0(%rbp), %rax
               	movslq	(%rax), %rcx
               	addq	$0x1, %rcx
               	movl	%ecx, (%rax)
               	jmp	<addr>
               	xorq	%rax, %rax
               	movl	%eax, -0xc8(%rbp)
               	jmp	<addr>
               	xorq	%rax, %rax
               	movl	%eax, -0xc0(%rbp)
               	jmp	<addr>
               	movslq	-0xc8(%rbp), %rax
               	cmpq	$0x3, %rax
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0xc8(%rbp), %rax
               	movslq	(%rax), %rcx
               	addq	$0x1, %rcx
               	movl	%ecx, (%rax)
               	jmp	<addr>
               	leaq	-0x70(%rbp), %rax
               	movslq	-0xc0(%rbp), %rcx
               	imulq	$0x18, %rcx, %rdx
               	addq	%rdx, %rax
               	movslq	-0xc8(%rbp), %rdx
               	movq	%rdx, %rsi
               	shlq	$0x3, %rsi
               	addq	%rsi, %rax
               	imulq	$0x3, %rcx, %rcx
               	movslq	%ecx, %rcx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	addq	$0x1, %rcx
               	movslq	%ecx, %rcx
               	cvtsi2sd	%rcx, %xmm0
               	movsd	%xmm0, (%rax,%riz)
               	leaq	-0xb8(%rbp), %rax
               	movslq	-0xc0(%rbp), %rcx
               	imulq	$0x18, %rcx, %rdx
               	addq	%rdx, %rax
               	movslq	-0xc8(%rbp), %rdx
               	movq	%rdx, %rsi
               	shlq	$0x3, %rsi
               	addq	%rsi, %rax
               	cmpq	%rdx, %rcx
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movabsq	$0x3ff0000000000000, %rcx # imm = 0x3FF0000000000000
               	movq	%rcx, %xmm14
               	movsd	%xmm14, -0xf8(%rbp,%riz)
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	movq	%rcx, %xmm14
               	movsd	%xmm14, -0xf8(%rbp,%riz)
               	jmp	<addr>
               	movsd	-0xf8(%rbp,%riz), %xmm0
               	movsd	%xmm0, (%rax,%riz)
               	jmp	<addr>
               	movslq	-0xc0(%rbp), %rax
               	cmpq	$0x3, %rax
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0xc0(%rbp), %rax
               	movslq	(%rax), %rcx
               	addq	$0x1, %rcx
               	movl	%ecx, (%rax)
               	jmp	<addr>
               	xorq	%rax, %rax
               	movl	%eax, -0xc8(%rbp)
               	jmp	<addr>
               	leaq	-0x70(%rbp), %rdi
               	leaq	-0x70(%rbp), %rsi
               	movl	$0x1, %edx
               	movl	$0x2, %ecx
               	callq	<addr>
               	movabsq	$0x4058000000000000, %rdi # imm = 0x4058000000000000
               	movq	%rdi, %xmm1
               	callq	<addr>
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	movslq	-0xc8(%rbp), %rax
               	cmpq	$0x3, %rax
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0xc8(%rbp), %rax
               	movslq	(%rax), %rcx
               	addq	$0x1, %rcx
               	movl	%ecx, (%rax)
               	jmp	<addr>
               	leaq	-0x70(%rbp), %rdi
               	leaq	-0xb8(%rbp), %rsi
               	movslq	-0xc0(%rbp), %rdx
               	movslq	-0xc8(%rbp), %rcx
               	callq	<addr>
               	leaq	-0x70(%rbp), %rax
               	movslq	-0xc0(%rbp), %rcx
               	imulq	$0x18, %rcx, %rcx
               	addq	%rcx, %rax
               	movslq	-0xc8(%rbp), %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rax
               	movsd	(%rax,%riz), %xmm1
               	callq	<addr>
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x3, %eax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0x4, %eax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	retq
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0xd0(%rbp,%riz)
               	movabsq	$0x4030000000000000, %rcx # imm = 0x4030000000000000
               	movq	%rcx, %xmm15
               	movq	%rax, %xmm14
               	divsd	%xmm15, %xmm14
               	movsd	%xmm14, 0x8(%rsp)
               	xorq	%rax, %rax
               	movl	%eax, -0xe0(%rbp)
               	jmp	<addr>
               	movslq	-0xe0(%rbp), %rax
               	cmpq	$0x10, %rax
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0xe0(%rbp), %rax
               	movslq	(%rax), %rcx
               	addq	$0x1, %rcx
               	movl	%ecx, (%rax)
               	jmp	<addr>
               	movsd	-0xd0(%rbp,%riz), %xmm0
               	movsd	0x8(%rsp), %xmm1
               	callq	<addr>
               	movsd	%xmm0, -0xd0(%rbp,%riz)
               	jmp	<addr>
               	movabsq	$0x4005bf0a8b145769, %rax # imm = 0x4005BF0A8B145769
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0xe8(%rbp,%riz)
               	movsd	-0xd0(%rbp,%riz), %xmm0
               	movsd	-0xe8(%rbp,%riz), %xmm1
               	movapd	%xmm1, %xmm15
               	movapd	%xmm0, %xmm1
               	subsd	%xmm15, %xmm1
               	xorq	%rax, %rax
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm1
               	setb	%al
               	movzbq	%al, %rax
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	jmp	<addr>
               	movabsq	$0x3eb0c6f7a0b5ed8d, %rax # imm = 0x3EB0C6F7A0B5ED8D
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm1
               	seta	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	retq
               	jmp	<addr>
