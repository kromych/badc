
fp_param_ternary.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400657 <.text+0x3d7>
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
               	addq	%r8, %r9
               	movq	(%r9), %r8
               	cmpq	$0x0, %r8
               	je	0x400305 <.text+0x85>
               	leaq	0xfe1d(%rip), %r9       # 0x4100f8
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
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
               	leaq	0xfdfd(%rip), %rdi      # 0x410110
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	addq	$0x8, %rsi
               	leaq	0xfdee(%rip), %rdi      # 0x410116
               	movq	%rdi, (%rsi)
               	leaq	-0x18(%rbp), %r9
               	addq	$0x10, %r9
               	leaq	0xfde0(%rip), %rdi      # 0x41011d
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	movq	%rbx, %rdi
               	shlq	$0x3, %rdi
               	addq	%rdi, %rsi
               	movq	(%rsi), %r14
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	xorl	%eax, %eax
               	callq	0x400b87 <dlsym>
               	cmpq	$0x0, %rax
               	je	0x400387 <.text+0x107>
               	leaq	0xfd86(%rip), %r14      # 0x4100f8
               	movq	%rbx, %r12
               	shlq	$0x3, %r12
               	addq	%r12, %r14
               	movq	(%rax), %r12
               	movq	%r12, (%r14)
               	jmp	0x400387 <.text+0x107>
               	leaq	0xfd6a(%rip), %r12      # 0x4100f8
               	shlq	$0x3, %rbx
               	addq	%rbx, %r12
               	movq	(%r12), %rbx
               	movq	%rbx, %rcx
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
               	andq	$0x1, %r11
               	cmpq	$0x0, %r11
               	je	0x40042f <.text+0x1af>
               	movss	-0x8(%rbp,%riz), %xmm7
               	cvtss2sd	%xmm7, %xmm7
               	leaq	-0x10(%rbp), %r11
               	cvtsd2ss	%xmm7, %xmm15
               	movss	%xmm15, (%r11,%riz)
               	jmp	0x400468 <.text+0x1e8>
               	movss	-0x8(%rbp,%riz), %xmm7
               	cvtss2sd	%xmm7, %xmm7
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%r11, %xmm15
               	xorpd	%xmm15, %xmm7
               	leaq	-0x10(%rbp), %r11
               	cvtsd2ss	%xmm7, %xmm15
               	movss	%xmm15, (%r11,%riz)
               	jmp	0x400468 <.text+0x1e8>
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
               	je	0x400531 <.text+0x2b1>
               	movss	-0x8(%rbp,%riz), %xmm7
               	cvtss2sd	%xmm7, %xmm7
               	leaq	-0x28(%rbp), %r9
               	cvtsd2ss	%xmm7, %xmm15
               	movss	%xmm15, (%r9,%riz)
               	jmp	0x40056a <.text+0x2ea>
               	movss	-0x8(%rbp,%riz), %xmm7
               	cvtss2sd	%xmm7, %xmm7
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm7
               	leaq	-0x28(%rbp), %r9
               	cvtsd2ss	%xmm7, %xmm15
               	movss	%xmm15, (%r9,%riz)
               	jmp	0x40056a <.text+0x2ea>
               	movss	-0x28(%rbp,%riz), %xmm7
               	cvtss2sd	%xmm7, %xmm7
               	leaq	-0x18(%rbp), %r9
               	cvtsd2ss	%xmm7, %xmm15
               	movss	%xmm15, (%r9,%riz)
               	andq	$0x2, %r11
               	cmpq	$0x0, %r11
               	je	0x4005c3 <.text+0x343>
               	movss	-0x10(%rbp,%riz), %xmm6
               	cvtss2sd	%xmm6, %xmm6
               	leaq	-0x30(%rbp), %r11
               	cvtsd2ss	%xmm6, %xmm15
               	movss	%xmm15, (%r11,%riz)
               	jmp	0x4005fc <.text+0x37c>
               	movss	-0x10(%rbp,%riz), %xmm6
               	cvtss2sd	%xmm6, %xmm6
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%r11, %xmm15
               	xorpd	%xmm15, %xmm6
               	leaq	-0x30(%rbp), %r11
               	cvtsd2ss	%xmm6, %xmm15
               	movss	%xmm15, (%r11,%riz)
               	jmp	0x4005fc <.text+0x37c>
               	movss	-0x30(%rbp,%riz), %xmm6
               	cvtss2sd	%xmm6, %xmm6
               	leaq	-0x20(%rbp), %r11
               	cvtsd2ss	%xmm6, %xmm15
               	movss	%xmm15, (%r11,%riz)
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
               	callq	0x4003b6 <.text+0x136>
               	movq	%r12, %xmm7
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%r11, %xmm15
               	xorpd	%xmm15, %xmm7
               	movq	%rax, %xmm14
               	ucomisd	%xmm7, %xmm14
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	0x4006f8 <.text+0x478>
               	movl	$0x1, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %r14d
               	movabsq	$0x4014000000000000, %r15 # imm = 0x4014000000000000
               	movq	%r14, %rdi
               	movq	%r15, %rsi
               	callq	0x4003b6 <.text+0x136>
               	movq	%rax, %xmm14
               	movq	%r15, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	0x40076a <.text+0x4ea>
               	movl	$0x2, %r15d
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2, %ebx
               	movabsq	$0x4014000000000000, %r12 # imm = 0x4014000000000000
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	0x4003b6 <.text+0x136>
               	movq	%r12, %xmm7
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%r11, %xmm15
               	xorpd	%xmm15, %xmm7
               	movq	%rax, %xmm14
               	ucomisd	%xmm7, %xmm14
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	0x4007ef <.text+0x56f>
               	movl	$0x3, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3, %r14d
               	movabsq	$0x4014000000000000, %r15 # imm = 0x4014000000000000
               	movq	%r14, %rdi
               	movq	%r15, %rsi
               	callq	0x4003b6 <.text+0x136>
               	movq	%rax, %xmm14
               	movq	%r15, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	0x400861 <.text+0x5e1>
               	movl	$0x4, %r15d
               	movq	%r15, %rcx
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
               	callq	0x40048e <.text+0x20e>
               	movq	%r15, %xmm7
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%r11, %xmm15
               	xorpd	%xmm15, %xmm7
               	movq	%r12, %xmm6
               	addsd	%xmm7, %xmm6
               	movq	%rax, %xmm14
               	ucomisd	%xmm6, %xmm14
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	0x4008fc <.text+0x67c>
               	movl	$0x5, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2, %r14d
               	movabsq	$0x401d000000000000, %rbx # imm = 0x401D000000000000
               	movabsq	$0x3fc0000000000000, %r12 # imm = 0x3FC0000000000000
               	movq	%r14, %rdi
               	movq	%r12, %rdx
               	movq	%rbx, %rsi
               	callq	0x40048e <.text+0x20e>
               	movq	%rbx, %xmm6
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%r11, %xmm15
               	xorpd	%xmm15, %xmm6
               	movq	%r12, %xmm15
               	addsd	%xmm15, %xmm6
               	movq	%rax, %xmm14
               	ucomisd	%xmm6, %xmm14
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	0x400999 <.text+0x719>
               	movl	$0x6, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3, %r15d
               	movabsq	$0x4008000000000000, %r14 # imm = 0x4008000000000000
               	movabsq	$0x4010000000000000, %r12 # imm = 0x4010000000000000
               	movq	%r15, %rdi
               	movq	%r12, %rdx
               	movq	%r14, %rsi
               	callq	0x40048e <.text+0x20e>
               	movq	%r14, %xmm6
               	movq	%r12, %xmm15
               	addsd	%xmm15, %xmm6
               	movq	%rax, %xmm14
               	ucomisd	%xmm6, %xmm14
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	0x400a22 <.text+0x7a2>
               	movl	$0x7, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
