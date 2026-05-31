
fp_param_ternary.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400680 <.text+0x400>
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
               	callq	0x400bb7 <dlsym>
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
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rsi, (%rsp)
               	subq	$0x10, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movslq	%edi, %r11
               	movq	0x20(%rbp), %r9
               	leaq	-0x8(%rbp), %r8
               	movq	%r9, %xmm14
               	cvtsd2ss	%xmm14, %xmm15
               	movss	%xmm15, (%r8,%riz)
               	movq	%r11, %r8
               	andq	$0x1, %r8
               	cmpq	$0x0, %r8
               	je	0x400449 <.text+0x1c9>
               	movss	-0x8(%rbp,%riz), %xmm7
               	cvtss2sd	%xmm7, %xmm7
               	leaq	-0x10(%rbp), %r8
               	cvtsd2ss	%xmm7, %xmm15
               	movss	%xmm15, (%r8,%riz)
               	jmp	0x400486 <.text+0x206>
               	movss	-0x8(%rbp,%riz), %xmm7
               	cvtss2sd	%xmm7, %xmm7
               	movapd	%xmm7, %xmm6
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%r11, %xmm15
               	xorpd	%xmm15, %xmm6
               	leaq	-0x10(%rbp), %r8
               	cvtsd2ss	%xmm6, %xmm15
               	movss	%xmm15, (%r8,%riz)
               	jmp	0x400486 <.text+0x206>
               	movss	-0x10(%rbp,%riz), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movq	%xmm0, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rdx, (%rsp)
               	subq	$0x10, %rsp
               	movq	%rsi, (%rsp)
               	subq	$0x10, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movslq	%edi, %r11
               	movq	0x20(%rbp), %r9
               	leaq	-0x8(%rbp), %r8
               	movq	%r9, %xmm14
               	cvtsd2ss	%xmm14, %xmm15
               	movss	%xmm15, (%r8,%riz)
               	movq	0x30(%rbp), %r8
               	leaq	-0x10(%rbp), %r9
               	movq	%r8, %xmm14
               	cvtsd2ss	%xmm14, %xmm15
               	movss	%xmm15, (%r9,%riz)
               	movq	%r11, %r9
               	andq	$0x1, %r9
               	cmpq	$0x0, %r9
               	je	0x40054f <.text+0x2cf>
               	movss	-0x8(%rbp,%riz), %xmm7
               	cvtss2sd	%xmm7, %xmm7
               	leaq	-0x28(%rbp), %r9
               	cvtsd2ss	%xmm7, %xmm15
               	movss	%xmm15, (%r9,%riz)
               	jmp	0x40058c <.text+0x30c>
               	movss	-0x8(%rbp,%riz), %xmm7
               	cvtss2sd	%xmm7, %xmm7
               	movapd	%xmm7, %xmm6
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm6
               	leaq	-0x28(%rbp), %r9
               	cvtsd2ss	%xmm6, %xmm15
               	movss	%xmm15, (%r9,%riz)
               	jmp	0x40058c <.text+0x30c>
               	movss	-0x28(%rbp,%riz), %xmm6
               	cvtss2sd	%xmm6, %xmm6
               	leaq	-0x18(%rbp), %r9
               	cvtsd2ss	%xmm6, %xmm15
               	movss	%xmm15, (%r9,%riz)
               	movq	%r11, %r9
               	andq	$0x2, %r9
               	cmpq	$0x0, %r9
               	je	0x4005e8 <.text+0x368>
               	movss	-0x10(%rbp,%riz), %xmm7
               	cvtss2sd	%xmm7, %xmm7
               	leaq	-0x30(%rbp), %r9
               	cvtsd2ss	%xmm7, %xmm15
               	movss	%xmm15, (%r9,%riz)
               	jmp	0x400625 <.text+0x3a5>
               	movss	-0x10(%rbp,%riz), %xmm7
               	cvtss2sd	%xmm7, %xmm7
               	movapd	%xmm7, %xmm6
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%r11, %xmm15
               	xorpd	%xmm15, %xmm6
               	leaq	-0x30(%rbp), %r9
               	cvtsd2ss	%xmm6, %xmm15
               	movss	%xmm15, (%r9,%riz)
               	jmp	0x400625 <.text+0x3a5>
               	movss	-0x30(%rbp,%riz), %xmm6
               	cvtss2sd	%xmm6, %xmm6
               	leaq	-0x20(%rbp), %r9
               	cvtsd2ss	%xmm6, %xmm15
               	movss	%xmm15, (%r9,%riz)
               	movss	-0x18(%rbp,%riz), %xmm7
               	cvtss2sd	%xmm7, %xmm7
               	movss	-0x20(%rbp,%riz), %xmm6
               	cvtss2sd	%xmm6, %xmm6
               	movapd	%xmm7, %xmm0
               	addsd	%xmm6, %xmm0
               	movq	%xmm0, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x30, %rsp
               	pushq	%r11
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x90, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	xorq	%rbx, %rbx
               	movabsq	$0x4014000000000000, %r12 # imm = 0x4014000000000000
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	0x4003cd <.text+0x14d>
               	movq	%r12, %xmm7
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%r11, %xmm15
               	xorpd	%xmm15, %xmm7
               	movq	%rax, %xmm14
               	ucomisd	%xmm7, %xmm14
               	setne	%r12b
               	movzbq	%r12b, %r12
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %r12
               	cmpq	$0x0, %r12
               	je	0x400720 <.text+0x4a0>
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %r14d
               	movabsq	$0x4014000000000000, %r12 # imm = 0x4014000000000000
               	movq	%r14, %rdi
               	movq	%r12, %rsi
               	callq	0x4003cd <.text+0x14d>
               	movq	%rax, %xmm14
               	movq	%r12, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%r14b
               	movzbq	%r14b, %r14
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %r14
               	cmpq	$0x0, %r14
               	je	0x400791 <.text+0x511>
               	movl	$0x2, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2, %ebx
               	movabsq	$0x4014000000000000, %r14 # imm = 0x4014000000000000
               	movq	%rbx, %rdi
               	movq	%r14, %rsi
               	callq	0x4003cd <.text+0x14d>
               	movq	%r14, %xmm7
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%r11, %xmm15
               	xorpd	%xmm15, %xmm7
               	movq	%rax, %xmm14
               	ucomisd	%xmm7, %xmm14
               	setne	%r14b
               	movzbq	%r14b, %r14
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %r14
               	cmpq	$0x0, %r14
               	je	0x400815 <.text+0x595>
               	movl	$0x3, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3, %r12d
               	movabsq	$0x4014000000000000, %r14 # imm = 0x4014000000000000
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	callq	0x4003cd <.text+0x14d>
               	movq	%rax, %xmm14
               	movq	%r14, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%r12b
               	movzbq	%r12b, %r12
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %r12
               	cmpq	$0x0, %r12
               	je	0x400886 <.text+0x606>
               	movl	$0x4, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %ebx
               	movabsq	$0x3ff8000000000000, %r12 # imm = 0x3FF8000000000000
               	movabsq	$0x4004000000000000, %r15 # imm = 0x4004000000000000
               	movq	%rbx, %rdi
               	movq	%r15, %rdx
               	movq	%r12, %rsi
               	callq	0x4004ac <.text+0x22c>
               	movq	%r15, %xmm7
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%r11, %xmm15
               	xorpd	%xmm15, %xmm7
               	movq	%r12, %xmm6
               	addsd	%xmm7, %xmm6
               	movq	%rax, %xmm14
               	ucomisd	%xmm6, %xmm14
               	setne	%r12b
               	movzbq	%r12b, %r12
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %r12
               	cmpq	$0x0, %r12
               	je	0x400920 <.text+0x6a0>
               	movl	$0x5, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2, %r14d
               	movabsq	$0x401d000000000000, %r12 # imm = 0x401D000000000000
               	movabsq	$0x3fc0000000000000, %rbx # imm = 0x3FC0000000000000
               	movq	%r14, %rdi
               	movq	%rbx, %rdx
               	movq	%r12, %rsi
               	callq	0x4004ac <.text+0x22c>
               	movq	%r12, %xmm6
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%r11, %xmm15
               	xorpd	%xmm15, %xmm6
               	movapd	%xmm6, %xmm7
               	movq	%rbx, %xmm15
               	addsd	%xmm15, %xmm7
               	movq	%rax, %xmm14
               	ucomisd	%xmm7, %xmm14
               	setne	%bl
               	movzbq	%bl, %rbx
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rbx
               	cmpq	$0x0, %rbx
               	je	0x4009c0 <.text+0x740>
               	movl	$0x6, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3, %r15d
               	movabsq	$0x4008000000000000, %rbx # imm = 0x4008000000000000
               	movabsq	$0x4010000000000000, %r14 # imm = 0x4010000000000000
               	movq	%r15, %rdi
               	movq	%r14, %rdx
               	movq	%rbx, %rsi
               	callq	0x4004ac <.text+0x22c>
               	movq	%rbx, %xmm7
               	movq	%r14, %xmm15
               	addsd	%xmm15, %xmm7
               	movq	%rax, %xmm14
               	ucomisd	%xmm7, %xmm14
               	setne	%r14b
               	movzbq	%r14b, %r14
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %r14
               	cmpq	$0x0, %r14
               	je	0x400a48 <.text+0x7c8>
               	movl	$0x7, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	xorq	%r14, %r14
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
