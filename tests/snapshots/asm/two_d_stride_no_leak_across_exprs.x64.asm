
two_d_stride_no_leak_across_exprs.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x4003be <.text+0x13e>
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
               	callq	0x400717 <dlsym>
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
               	movq	%rdi, %r11
               	movzwq	(%r11), %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x530, %rsp            # imm = 0x530
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	leaq	-0x400(%rbp), %r11
               	movl	$0x7, %r9d
               	movw	%r9w, (%r11)
               	leaq	-0x400(%rbp), %r8
               	addq	$0x2, %r8
               	movl	$0xb, %r9d
               	movw	%r9w, (%r8)
               	leaq	-0x400(%rbp), %rbx
               	movq	%rbx, %rdi
               	callq	0x4003b6 <.text+0x136>
               	movslq	%eax, %rax
               	cmpq	$0x7, %rax
               	je	0x400437 <.text+0x1b7>
               	movl	$0x1, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x530, %rsp            # imm = 0x530
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movl	%eax, -0x510(%rbp)
               	jmp	0x400445 <.text+0x1c5>
               	movslq	-0x510(%rbp), %rax
               	cmpq	$0x40, %rax
               	jge	0x4004bb <.text+0x23b>
               	jmp	0x400476 <.text+0x1f6>
               	leaq	-0x510(%rbp), %rbx
               	movslq	(%rbx), %rax
               	addq	$0x1, %rax
               	movl	%eax, (%rbx)
               	jmp	0x400445 <.text+0x1c5>
               	leaq	-0x508(%rbp), %rax
               	movslq	-0x510(%rbp), %r8
               	movq	%r8, %rbx
               	shlq	$0x2, %rbx
               	addq	%rbx, %rax
               	cvtsi2sd	%r8, %xmm7
               	movabsq	$0x3fd0000000000000, %r8 # imm = 0x3FD0000000000000
               	movq	%r8, %xmm15
               	mulsd	%xmm15, %xmm7
               	cvtsd2ss	%xmm7, %xmm15
               	movss	%xmm15, (%rax,%riz)
               	jmp	0x40045e <.text+0x1de>
               	leaq	-0x508(%rbp), %rax
               	addq	$0x20, %rax
               	movss	(%rax,%riz), %xmm6
               	cvtss2sd	%xmm6, %xmm6
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm6
               	setne	%r8b
               	movzbq	%r8b, %r8
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %r8
               	cmpq	$0x0, %r8
               	je	0x400527 <.text+0x2a7>
               	movl	$0x2, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x530, %rsp            # imm = 0x530
               	popq	%rbp
               	retq
               	leaq	-0x400(%rbp), %r12
               	movq	%r12, %rdi
               	callq	0x4003b6 <.text+0x136>
               	leaq	-0x508(%rbp), %rax
               	movabsq	$0x4058c00000000000, %r12 # imm = 0x4058C00000000000
               	movq	%r12, %xmm14
               	cvtsd2ss	%xmm14, %xmm15
               	movss	%xmm15, (%rax,%riz)
               	leaq	-0x508(%rbp), %rax
               	movss	(%rax,%riz), %xmm6
               	cvtss2sd	%xmm6, %xmm6
               	movq	%r12, %xmm15
               	ucomisd	%xmm15, %xmm6
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	0x4005b7 <.text+0x337>
               	movl	$0x3, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x530, %rsp            # imm = 0x530
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x530, %rsp            # imm = 0x530
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
