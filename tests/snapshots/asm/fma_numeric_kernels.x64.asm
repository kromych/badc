
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
               	movslq	%esi, %rsi
               	movq	%rsi, %rax
               	subq	$0x1, %rax
               	movslq	%eax, %rax
               	shlq	$0x3, %rax
               	addq	%rdi, %rax
               	movsd	(%rax,%riz), %xmm1
               	subq	$0x2, %rsi
               	movslq	%esi, %rcx
               	jmp	<addr>
               	movslq	%ecx, %rax
               	cmpq	$0x0, %rax
               	jl	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rcx
               	addq	$-0x1, %rcx
               	jmp	<addr>
               	movslq	%ecx, %rax
               	shlq	$0x3, %rax
               	addq	%rdi, %rax
               	movsd	(%rax,%riz), %xmm2
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
               	movslq	%edx, %rdx
               	movslq	%ecx, %rcx
               	xorq	%r8, %r8
               	movq	%r8, %xmm14
               	movsd	%xmm14, -0x8(%rbp,%riz)
               	jmp	<addr>
               	movslq	%r8d, %rax
               	cmpq	$0x3, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%r8d, %r8
               	addq	$0x1, %r8
               	jmp	<addr>
               	movsd	-0x8(%rbp,%riz), %xmm0
               	imulq	$0x18, %rdx, %rax
               	movq	%rdi, %r9
               	addq	%rax, %r9
               	movslq	%r8d, %r11
               	movq	%r11, %rax
               	shlq	$0x3, %rax
               	addq	%rax, %r9
               	movsd	(%r9,%riz), %xmm1
               	imulq	$0x18, %r11, %r11
               	movq	%rsi, %r9
               	addq	%r11, %r9
               	movq	%rcx, %rax
               	shlq	$0x3, %rax
               	addq	%rax, %r9
               	movsd	(%r9,%riz), %xmm2
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
               	subq	$0x120, %rsp            # imm = 0x120
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	leaq	-0x28(%rbp), %rax
               	movabsq	$0x3ff0000000000000, %rcx # imm = 0x3FF0000000000000
               	movq	%rcx, %xmm14
               	movsd	%xmm14, (%rax,%riz)
               	leaq	-0x28(%rbp), %rcx
               	addq	$0x8, %rcx
               	movabsq	$0x4000000000000000, %rdx # imm = 0x4000000000000000
               	movq	%rdx, %xmm14
               	movsd	%xmm14, (%rcx,%riz)
               	leaq	-0x28(%rbp), %rcx
               	addq	$0x10, %rcx
               	movabsq	$0x4008000000000000, %rax # imm = 0x4008000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, (%rcx,%riz)
               	leaq	-0x28(%rbp), %rcx
               	addq	$0x18, %rcx
               	movabsq	$0x4010000000000000, %rax # imm = 0x4010000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, (%rcx,%riz)
               	leaq	-0x28(%rbp), %rcx
               	addq	$0x20, %rcx
               	movabsq	$0x4014000000000000, %rax # imm = 0x4014000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, (%rcx,%riz)
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
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x120, %rsp            # imm = 0x120
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
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movslq	%ecx, %rax
               	cmpq	$0x3, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rcx
               	addq	$0x1, %rcx
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	jmp	<addr>
               	xorq	%rbx, %rbx
               	jmp	<addr>
               	movslq	%edx, %rax
               	cmpq	$0x3, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%edx, %rdx
               	addq	$0x1, %rdx
               	jmp	<addr>
               	leaq	-0x70(%rbp), %rsi
               	movslq	%ecx, %r8
               	imulq	$0x18, %r8, %rax
               	addq	%rax, %rsi
               	movslq	%edx, %rax
               	movq	%rax, %rdi
               	shlq	$0x3, %rdi
               	addq	%rdi, %rsi
               	leaq	(%r8,%r8,2), %r8
               	movslq	%r8d, %rdi
               	addq	%rax, %rdi
               	movslq	%edi, %rax
               	addq	$0x1, %rax
               	movslq	%eax, %rax
               	cvtsi2sd	%rax, %xmm0
               	movsd	%xmm0, (%rsi,%riz)
               	leaq	-0xb8(%rbp), %rdi
               	movslq	%ecx, %rax
               	imulq	$0x18, %rax, %rsi
               	addq	%rsi, %rdi
               	movslq	%edx, %rsi
               	movq	%rsi, %r8
               	shlq	$0x3, %r8
               	addq	%r8, %rdi
               	cmpq	%rsi, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0xf8(%rbp,%riz)
               	jmp	<addr>
               	xorq	%rax, %rax
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0xf8(%rbp,%riz)
               	jmp	<addr>
               	movsd	-0xf8(%rbp,%riz), %xmm0
               	movsd	%xmm0, (%rdi,%riz)
               	jmp	<addr>
               	movslq	%ebx, %rax
               	cmpq	$0x3, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ebx, %rbx
               	addq	$0x1, %rbx
               	jmp	<addr>
               	xorq	%r12, %r12
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
               	movslq	%r12d, %rax
               	cmpq	$0x3, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%r12d, %r12
               	addq	$0x1, %r12
               	jmp	<addr>
               	leaq	-0x70(%rbp), %rdi
               	leaq	-0xb8(%rbp), %rsi
               	movslq	%ebx, %rdx
               	movslq	%r12d, %rcx
               	callq	<addr>
               	leaq	-0x70(%rbp), %rcx
               	movslq	%ebx, %rax
               	imulq	$0x18, %rax, %rax
               	addq	%rax, %rcx
               	movslq	%r12d, %rax
               	shlq	$0x3, %rax
               	addq	%rax, %rcx
               	movsd	(%rcx,%riz), %xmm1
               	callq	<addr>
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x3, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0x4, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0xd0(%rbp,%riz)
               	movabsq	$0x4030000000000000, %rcx # imm = 0x4030000000000000
               	movq	%rcx, %xmm15
               	movq	%rax, %xmm14
               	divsd	%xmm15, %xmm14
               	movsd	%xmm14, 0x18(%rsp)
               	xorq	%rbx, %rbx
               	jmp	<addr>
               	movslq	%ebx, %rax
               	cmpq	$0x10, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ebx, %rbx
               	addq	$0x1, %rbx
               	jmp	<addr>
               	movsd	-0xd0(%rbp,%riz), %xmm0
               	movsd	0x18(%rsp), %xmm1
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
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	jmp	<addr>
