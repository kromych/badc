
unary_plus_preserves_float.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x4003cd <.text+0x14d>
               	movq	%rax, %rdi
               	callq	*0xfe51(%rip)           # 0x4100e8
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movslq	%edi, %rbx
               	leaq	0xfe3e(%rip), %r9       # 0x4100f8
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	movq	%r9, %rdi
               	addq	%r8, %rdi
               	movq	(%rdi), %r8
               	cmpq	$0x0, %r8
               	je	0x40030b <.text+0x8b>
               	leaq	0xfe1a(%rip), %rdi      # 0x4100f8
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	movq	%rdi, %r9
               	addq	%r8, %r9
               	movq	(%r9), %r8
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r9
               	xorq	%r12, %r12
               	leaq	0xfdf7(%rip), %rdi      # 0x410110
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	movq	%rsi, %rdi
               	addq	$0x8, %rdi
               	leaq	0xfde5(%rip), %rsi      # 0x410116
               	movq	%rsi, (%rdi)
               	leaq	-0x18(%rbp), %r9
               	movq	%r9, %rsi
               	addq	$0x10, %rsi
               	leaq	0xfdd4(%rip), %r9       # 0x41011d
               	movq	%r9, (%rsi)
               	leaq	-0x18(%rbp), %rdi
               	movq	%rbx, %r9
               	shlq	$0x3, %r9
               	movq	%rdi, %rsi
               	addq	%r9, %rsi
               	movq	(%rsi), %r14
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	xorl	%eax, %eax
               	callq	0x400a77 <dlsym>
               	cmpq	$0x0, %rax
               	je	0x400399 <.text+0x119>
               	leaq	0xfd77(%rip), %r14      # 0x4100f8
               	movq	%rbx, %r12
               	shlq	$0x3, %r12
               	movq	%r14, %rdi
               	addq	%r12, %rdi
               	movq	(%rax), %r12
               	movq	%r12, (%rdi)
               	jmp	0x400399 <.text+0x119>
               	leaq	0xfd58(%rip), %r12      # 0x4100f8
               	movq	%rbx, %rax
               	shlq	$0x3, %rax
               	movq	%r12, %rbx
               	addq	%rax, %rbx
               	movq	(%rbx), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	movabsq	$0x3ff8000000000000, %r11 # imm = 0x3FF8000000000000
               	movq	%r11, -0x8(%rbp)
               	movq	-0x8(%rbp), %r9
               	movabsq	$0x3fe0000000000000, %r11 # imm = 0x3FE0000000000000
               	movq	%r9, %xmm7
               	movq	%r11, %xmm15
               	addsd	%xmm15, %xmm7
               	movabsq	$0x4000000000000000, %r11 # imm = 0x4000000000000000
               	movq	%r11, %xmm15
               	ucomisd	%xmm15, %xmm7
               	setne	%r9b
               	movzbq	%r9b, %r9
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %r9
               	cmpq	$0x0, %r9
               	je	0x400445 <.text+0x1c5>
               	movl	$0x1, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movq	-0x8(%rbp), %r9
               	xorq	%rax, %rax
               	cvtsi2sd	%rax, %xmm7
               	movq	%r9, %xmm14
               	ucomisd	%xmm7, %xmm14
               	setb	%al
               	movzbq	%al, %rax
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	0x4004ac <.text+0x22c>
               	movabsq	$0x3fe0000000000000, %r9 # imm = 0x3FE0000000000000
               	movq	%r9, %xmm7
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%r11, %xmm15
               	xorpd	%xmm15, %xmm7
               	movq	%xmm7, %r11
               	movq	%r11, -0x38(%rbp)
               	jmp	0x4004bf <.text+0x23f>
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	movq	%rax, -0x38(%rbp)
               	jmp	0x4004bf <.text+0x23f>
               	movq	-0x38(%rbp), %rax
               	movabsq	$0x3fe0000000000000, %r9 # imm = 0x3FE0000000000000
               	movq	%rax, %xmm14
               	movq	%r9, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%r8b
               	movzbq	%r8b, %r8
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %r8
               	cmpq	$0x0, %r8
               	je	0x40050e <.text+0x28e>
               	movl	$0x2, %r9d
               	movq	%r9, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movq	-0x8(%rbp), %r8
               	movq	%r8, %xmm7
               	movq	%rax, %xmm15
               	addsd	%xmm15, %xmm7
               	movabsq	$0x4000000000000000, %r8 # imm = 0x4000000000000000
               	movq	%r8, %xmm15
               	ucomisd	%xmm15, %xmm7
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	0x400567 <.text+0x2e7>
               	movl	$0x3, %r8d
               	movq	%r8, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movq	-0x8(%rbp), %rax
               	xorq	%r8, %r8
               	cvtsi2sd	%r8, %xmm7
               	movq	%rax, %xmm14
               	ucomisd	%xmm7, %xmm14
               	setb	%r8b
               	movzbq	%r8b, %r8
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %r8
               	cmpq	$0x0, %r8
               	je	0x4005ce <.text+0x34e>
               	movabsq	$0x3fe0000000000000, %r9 # imm = 0x3FE0000000000000
               	movq	%r9, %xmm7
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%r11, %xmm15
               	xorpd	%xmm15, %xmm7
               	movq	%xmm7, %r11
               	movq	%r11, -0x40(%rbp)
               	jmp	0x4005e1 <.text+0x361>
               	movabsq	$0x3fe0000000000000, %r8 # imm = 0x3FE0000000000000
               	movq	%r8, -0x40(%rbp)
               	jmp	0x4005e1 <.text+0x361>
               	movq	-0x40(%rbp), %r8
               	movq	%rax, %xmm7
               	movq	%r8, %xmm15
               	addsd	%xmm15, %xmm7
               	movabsq	$0x4000000000000000, %r8 # imm = 0x4000000000000000
               	movq	%r8, %xmm15
               	ucomisd	%xmm15, %xmm7
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	0x40063a <.text+0x3ba>
               	movl	$0x4, %r8d
               	movq	%r8, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movq	-0x8(%rbp), %rax
               	xorq	%r8, %r8
               	cvtsi2sd	%r8, %xmm7
               	movq	%rax, %xmm14
               	ucomisd	%xmm7, %xmm14
               	setb	%r8b
               	movzbq	%r8b, %r8
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %r8
               	cmpq	$0x0, %r8
               	je	0x4006a1 <.text+0x421>
               	movabsq	$0x3fe0000000000000, %r9 # imm = 0x3FE0000000000000
               	movq	%r9, %xmm7
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%r11, %xmm15
               	xorpd	%xmm15, %xmm7
               	movq	%xmm7, %r11
               	movq	%r11, -0x48(%rbp)
               	jmp	0x4006b4 <.text+0x434>
               	movabsq	$0x3fe0000000000000, %r8 # imm = 0x3FE0000000000000
               	movq	%r8, -0x48(%rbp)
               	jmp	0x4006b4 <.text+0x434>
               	movq	-0x48(%rbp), %r8
               	movq	%rax, %xmm7
               	movq	%r8, %xmm15
               	addsd	%xmm15, %xmm7
               	cvttsd2si	%xmm7, %r8
               	cmpq	$0x2, %r8
               	je	0x4006eb <.text+0x46b>
               	movl	$0x5, %r8d
               	movq	%r8, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movq	-0x8(%rbp), %rax
               	xorq	%r8, %r8
               	cvtsi2sd	%r8, %xmm7
               	movq	%rax, %xmm14
               	ucomisd	%xmm7, %xmm14
               	setb	%r8b
               	movzbq	%r8b, %r8
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %r8
               	cmpq	$0x0, %r8
               	je	0x400752 <.text+0x4d2>
               	movabsq	$0x3fe0000000000000, %r9 # imm = 0x3FE0000000000000
               	movq	%r9, %xmm7
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%r11, %xmm15
               	xorpd	%xmm15, %xmm7
               	movq	%xmm7, %r11
               	movq	%r11, -0x50(%rbp)
               	jmp	0x400765 <.text+0x4e5>
               	movabsq	$0x3fe0000000000000, %r8 # imm = 0x3FE0000000000000
               	movq	%r8, -0x50(%rbp)
               	jmp	0x400765 <.text+0x4e5>
               	movq	-0x50(%rbp), %r8
               	movq	%rax, %xmm7
               	movq	%r8, %xmm15
               	addsd	%xmm15, %xmm7
               	cvttsd2si	%xmm7, %r8
               	cvtsi2sd	%r8, %xmm7
               	movq	%xmm7, %r11
               	movq	%r11, -0x20(%rbp)
               	movq	-0x20(%rbp), %r8
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movq	%r8, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%r9b
               	movzbq	%r9b, %r9
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %r9
               	cmpq	$0x0, %r9
               	je	0x4007d6 <.text+0x556>
               	movl	$0x6, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x3ff8000000000000, %r9 # imm = 0x3FF8000000000000
               	movq	%r9, %xmm7
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%r11, %xmm15
               	xorpd	%xmm15, %xmm7
               	movq	%xmm7, %r11
               	movq	%r11, -0x8(%rbp)
               	movq	-0x8(%rbp), %r9
               	xorq	%rax, %rax
               	cvtsi2sd	%rax, %xmm7
               	movq	%r9, %xmm14
               	ucomisd	%xmm7, %xmm14
               	setb	%al
               	movzbq	%al, %rax
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	0x400869 <.text+0x5e9>
               	movabsq	$0x3fe0000000000000, %r8 # imm = 0x3FE0000000000000
               	movq	%r8, %xmm7
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%r11, %xmm15
               	xorpd	%xmm15, %xmm7
               	movq	%xmm7, %r11
               	movq	%r11, -0x58(%rbp)
               	jmp	0x40087c <.text+0x5fc>
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	movq	%rax, -0x58(%rbp)
               	jmp	0x40087c <.text+0x5fc>
               	movq	-0x58(%rbp), %rax
               	movq	%r9, %xmm7
               	movq	%rax, %xmm15
               	addsd	%xmm15, %xmm7
               	cvttsd2si	%xmm7, %rax
               	cvtsi2sd	%rax, %xmm7
               	movq	%xmm7, %r11
               	movq	%r11, -0x28(%rbp)
               	movq	-0x28(%rbp), %rax
               	movabsq	$0x4000000000000000, %r9 # imm = 0x4000000000000000
               	movq	%r9, %xmm7
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%r11, %xmm15
               	xorpd	%xmm15, %xmm7
               	movq	%rax, %xmm14
               	ucomisd	%xmm7, %xmm14
               	setne	%r9b
               	movzbq	%r9b, %r9
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %r9
               	cmpq	$0x0, %r9
               	je	0x400901 <.text+0x681>
               	movl	$0x7, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movl	$0x7, %r9d
               	movslq	%r9d, %rax
               	cmpq	$0x7, %rax
               	je	0x400925 <.text+0x6a5>
               	movl	$0x8, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	xorq	%r9, %r9
               	movq	%r9, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
