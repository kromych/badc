
compound_assign_fp_int_rhs.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x4003d0 <.text+0x150>
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
               	callq	0x4007c7 <dlsym>
               	movq	%rax, %rsi
               	cmpq	$0x0, %rsi
               	je	0x40039c <.text+0x11c>
               	leaq	0xfd74(%rip), %r14      # 0x4100f8
               	movq	%rbx, %r12
               	shlq	$0x3, %r12
               	movq	%r14, %rdi
               	addq	%r12, %rdi
               	movq	(%rsi), %r12
               	movq	%r12, (%rdi)
               	jmp	0x40039c <.text+0x11c>
               	leaq	0xfd55(%rip), %r12      # 0x4100f8
               	movq	%rbx, %rsi
               	shlq	$0x3, %rsi
               	movq	%r12, %rbx
               	addq	%rsi, %rbx
               	movq	(%rbx), %rsi
               	movq	%rsi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movabsq	$0x3ff8000000000000, %r11 # imm = 0x3FF8000000000000
               	movq	%r11, -0x8(%rbp)
               	leaq	-0x8(%rbp), %r9
               	movq	(%r9), %r8
               	movabsq	$-0x1, %rdi
               	cvtsi2sd	%rdi, %xmm7
               	movq	%r8, %xmm6
               	mulsd	%xmm7, %xmm6
               	movq	%xmm6, %r10
               	movq	%r10, (%r9)
               	movq	-0x8(%rbp), %r8
               	movq	%r11, %xmm6
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%r11, %xmm15
               	xorpd	%xmm15, %xmm6
               	movq	%r8, %xmm14
               	ucomisd	%xmm6, %xmm14
               	setne	%r11b
               	movzbq	%r11b, %r11
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %r11
               	cmpq	$0x0, %r11
               	je	0x400465 <.text+0x1e5>
               	movl	$0x1, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %r11
               	movq	(%r11), %rax
               	movl	$0x2, %r9d
               	cvtsi2sd	%r9, %xmm6
               	movq	%rax, %xmm7
               	mulsd	%xmm6, %xmm7
               	movq	%xmm7, %r10
               	movq	%r10, (%r11)
               	movq	-0x8(%rbp), %rax
               	movabsq	$0x4008000000000000, %r11 # imm = 0x4008000000000000
               	movq	%r11, %xmm7
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%r11, %xmm15
               	xorpd	%xmm15, %xmm7
               	movq	%rax, %xmm14
               	ucomisd	%xmm7, %xmm14
               	setne	%r11b
               	movzbq	%r11b, %r11
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %r11
               	cmpq	$0x0, %r11
               	je	0x4004e7 <.text+0x267>
               	movl	$0x1, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %r11
               	movq	(%r11), %rax
               	movl	$0x1, %r9d
               	cvtsi2sd	%r9, %xmm7
               	movq	%rax, %xmm6
               	addsd	%xmm7, %xmm6
               	movq	%xmm6, %r10
               	movq	%r10, (%r11)
               	movq	-0x8(%rbp), %rax
               	movabsq	$0x4000000000000000, %r11 # imm = 0x4000000000000000
               	movq	%r11, %xmm6
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%r11, %xmm15
               	xorpd	%xmm15, %xmm6
               	movq	%rax, %xmm14
               	ucomisd	%xmm6, %xmm14
               	setne	%r11b
               	movzbq	%r11b, %r11
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %r11
               	cmpq	$0x0, %r11
               	je	0x400569 <.text+0x2e9>
               	movl	$0x1, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %r11
               	movq	(%r11), %rax
               	movl	$0x1, %r9d
               	cvtsi2sd	%r9, %xmm6
               	movq	%rax, %xmm7
               	subsd	%xmm6, %xmm7
               	movq	%xmm7, %r10
               	movq	%r10, (%r11)
               	movq	-0x8(%rbp), %rax
               	movabsq	$0x4008000000000000, %r11 # imm = 0x4008000000000000
               	movq	%r11, %xmm7
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%r11, %xmm15
               	xorpd	%xmm15, %xmm7
               	movq	%rax, %xmm14
               	ucomisd	%xmm7, %xmm14
               	setne	%r11b
               	movzbq	%r11b, %r11
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %r11
               	cmpq	$0x0, %r11
               	je	0x4005eb <.text+0x36b>
               	movl	$0x1, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %r11
               	movq	(%r11), %rax
               	movl	$0x3, %r9d
               	cvtsi2sd	%r9, %xmm7
               	movq	%rax, %xmm6
               	divsd	%xmm7, %xmm6
               	movq	%xmm6, %r10
               	movq	%r10, (%r11)
               	movq	-0x8(%rbp), %rax
               	movabsq	$0x3ff0000000000000, %r11 # imm = 0x3FF0000000000000
               	movq	%r11, %xmm6
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%r11, %xmm15
               	xorpd	%xmm15, %xmm6
               	movq	%rax, %xmm14
               	ucomisd	%xmm6, %xmm14
               	setne	%r11b
               	movzbq	%r11b, %r11
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %r11
               	cmpq	$0x0, %r11
               	je	0x40066d <.text+0x3ed>
               	movl	$0x1, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x11, %r11d
               	movq	%r11, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
