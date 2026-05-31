
ssa_c5_internal_fp_arg.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400462 <.text+0x1a2>
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
               	movq	%r9, %rdi
               	addq	%r8, %rdi
               	movq	(%rdi), %r8
               	cmpq	$0x0, %r8
               	je	0x40034b <.text+0x8b>
               	leaq	0xfde2(%rip), %rdi      # 0x410100
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
               	leaq	0xfdbf(%rip), %rdi      # 0x410118
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	movq	%rsi, %rdi
               	addq	$0x8, %rdi
               	leaq	0xfdad(%rip), %rsi      # 0x41011e
               	movq	%rsi, (%rdi)
               	leaq	-0x18(%rbp), %r9
               	movq	%r9, %rsi
               	addq	$0x10, %rsi
               	leaq	0xfd9c(%rip), %r9       # 0x410125
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
               	callq	0x400777 <dlsym>
               	movq	%rax, %rsi
               	cmpq	$0x0, %rsi
               	je	0x4003dc <.text+0x11c>
               	leaq	0xfd3c(%rip), %r14      # 0x410100
               	movq	%rbx, %r12
               	shlq	$0x3, %r12
               	movq	%r14, %rdi
               	addq	%r12, %rdi
               	movq	(%rsi), %r12
               	movq	%r12, (%rdi)
               	jmp	0x4003dc <.text+0x11c>
               	leaq	0xfd1d(%rip), %r12      # 0x410100
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
               	movq	%r11, %r8
               	addq	$0x64, %r8
               	movslq	%r8d, %r8
               	movq	%r8, %r9
               	subq	%r11, %r9
               	movslq	%r9d, %rbx
               	movabsq	$0x4049400000000000, %r8 # imm = 0x4049400000000000
               	movq	%r11, %rdi
               	subq	%r11, %rdi
               	movslq	%edi, %rdi
               	cvtsi2sd	%rdi, %xmm7
               	movq	%r8, %xmm6
               	addsd	%xmm7, %xmm6
               	movq	%xmm6, %r11
               	movq	%r11, -0x10(%rbp)
               	movq	-0x10(%rbp), %r12
               	movq	%r12, %rdi
               	movq	%rbx, %rsi
               	callq	0x400410 <.text+0x150>
               	movq	%rax, %rdi
               	cmpq	$0x1, %rdi
               	je	0x400502 <.text+0x242>
               	movl	$0x1, %edi
               	movq	%rdi, %rcx
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
               	callq	0x400410 <.text+0x150>
               	movq	%rax, %rdi
               	cmpq	$0x0, %rdi
               	je	0x400549 <.text+0x289>
               	movl	$0x2, %edi
               	movq	%rdi, %rcx
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
               	callq	0x400439 <.text+0x179>
               	movq	%rax, %rdi
               	cmpq	$0x1, %rdi
               	je	0x400598 <.text+0x2d8>
               	movl	$0x3, %edi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	cvtsi2sd	%rbx, %xmm6
               	movabsq	$0x3fe0000000000000, %r12 # imm = 0x3FE0000000000000
               	movapd	%xmm6, %xmm7
               	movq	%r12, %xmm15
               	addsd	%xmm15, %xmm7
               	movq	%xmm7, %r11
               	movq	%r11, -0x40(%rbp)
               	movq	-0x40(%rbp), %r14
               	movq	%r14, %rdi
               	movq	%rbx, %rsi
               	callq	0x400439 <.text+0x179>
               	movq	%rax, %rdi
               	cmpq	$0x0, %rdi
               	je	0x4005ff <.text+0x33f>
               	movl	$0x4, %edi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfb4a(%rip), %r12      # 0x410150
               	movq	%r12, %rdi
               	movb	$0x0, %al
               	callq	0x40077d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %rdi
               	xorq	%rdi, %rdi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
