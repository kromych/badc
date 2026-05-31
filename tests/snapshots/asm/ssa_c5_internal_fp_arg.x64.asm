
ssa_c5_internal_fp_arg.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400448 <.text+0x188>
               	movq	%rax, %rdi
               	callq	*0xfe19(%rip)           # 0x4100f0
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movslq	%edi, %rbx
               	leaq	0xfe06(%rip), %r9       # 0x410100
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	addq	%r8, %r9
               	movq	(%r9), %r8
               	cmpq	$0x0, %r8
               	je	0x400345 <.text+0x85>
               	leaq	0xfde5(%rip), %r9       # 0x410100
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
               	leaq	0xfdc5(%rip), %rdi      # 0x410118
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	addq	$0x8, %rsi
               	leaq	0xfdb6(%rip), %rdi      # 0x41011e
               	movq	%rdi, (%rsi)
               	leaq	-0x18(%rbp), %r9
               	addq	$0x10, %r9
               	leaq	0xfda8(%rip), %rdi      # 0x410125
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	movq	%rbx, %rdi
               	shlq	$0x3, %rdi
               	addq	%rdi, %rsi
               	movq	(%rsi), %r14
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	xorl	%eax, %eax
               	callq	0x400747 <dlsym>
               	cmpq	$0x0, %rax
               	je	0x4003c7 <.text+0x107>
               	leaq	0xfd4e(%rip), %r14      # 0x410100
               	movq	%rbx, %r12
               	shlq	$0x3, %r12
               	addq	%r12, %r14
               	movq	(%rax), %r12
               	movq	%r12, (%r14)
               	jmp	0x4003c7 <.text+0x107>
               	leaq	0xfd32(%rip), %r12      # 0x410100
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
               	movq	%rsi, %r9
               	cvtsi2sd	%r9, %xmm7
               	movq	%r11, %xmm14
               	ucomisd	%xmm7, %xmm14
               	setb	%al
               	movzbq	%al, %rax
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %rax
               	retq
               	movq	%rdi, %r11
               	movq	%rsi, %r9
               	cvtsi2sd	%r9, %xmm7
               	movq	%r11, %xmm14
               	ucomisd	%xmm7, %xmm14
               	setbe	%al
               	movzbq	%al, %rax
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movslq	%edi, %r11
               	movq	%rsi, %r9
               	movq	%r11, %r9
               	addq	$0x64, %r9
               	movslq	%r9d, %r9
               	subq	%r11, %r9
               	movslq	%r9d, %rbx
               	movabsq	$0x4049400000000000, %r9 # imm = 0x4049400000000000
               	movq	%r11, %r10
               	subq	%r10, %r11
               	movslq	%r11d, %r11
               	cvtsi2sd	%r11, %xmm7
               	movq	%r9, %xmm6
               	addsd	%xmm7, %xmm6
               	movq	%xmm6, %r11
               	movq	%r11, -0x10(%rbp)
               	movq	-0x10(%rbp), %r12
               	movq	%r12, %rdi
               	movq	%rbx, %rsi
               	callq	0x4003f6 <.text+0x136>
               	cmpq	$0x1, %rax
               	je	0x4004e3 <.text+0x223>
               	movl	$0x1, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x4062d00000000000, %r14 # imm = 0x4062D00000000000
               	movq	%r14, %rdi
               	movq	%rbx, %rsi
               	callq	0x4003f6 <.text+0x136>
               	cmpq	$0x0, %rax
               	je	0x400528 <.text+0x268>
               	movl	$0x2, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	cvtsi2sd	%rbx, %xmm6
               	movq	%xmm6, %r11
               	movq	%r11, -0x38(%rbp)
               	movq	-0x38(%rbp), %r12
               	movq	%r12, %rdi
               	movq	%rbx, %rsi
               	callq	0x40041f <.text+0x15f>
               	cmpq	$0x1, %rax
               	je	0x400575 <.text+0x2b5>
               	movl	$0x3, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	cvtsi2sd	%rbx, %xmm6
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	movq	%rax, %xmm15
               	addsd	%xmm15, %xmm6
               	movq	%xmm6, %r11
               	movq	%r11, -0x40(%rbp)
               	movq	-0x40(%rbp), %r14
               	movq	%r14, %rdi
               	movq	%rbx, %rsi
               	callq	0x40041f <.text+0x15f>
               	cmpq	$0x0, %rax
               	je	0x4005d6 <.text+0x316>
               	movl	$0x4, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfb73(%rip), %r12      # 0x410150
               	movq	%r12, %rdi
               	movb	$0x0, %al
               	callq	0x40074d <printf>
               	movslq	%eax, %rax
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
