
ssa_fp_compare_nan.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400421 <.text+0x161>
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
               	callq	0x400827 <dlsym>
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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	xorq	%r11, %r11
               	movq	%r11, %xmm0
               	movq	%r11, %xmm15
               	divsd	%xmm15, %xmm0
               	movq	%xmm0, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	callq	0x4003f6 <.text+0x136>
               	xorq	%r9, %r9
               	movl	%r9d, -0x10(%rbp)
               	movq	%rax, %xmm14
               	movq	%r9, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setb	%r8b
               	movzbq	%r8b, %r8
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %r8
               	cmpq	$0x0, %r8
               	je	0x40048b <.text+0x1cb>
               	leaq	-0x10(%rbp), %r9
               	movslq	(%r9), %r8
               	orq	$0x1, %r8
               	movl	%r8d, (%r9)
               	jmp	0x40048b <.text+0x1cb>
               	xorq	%r8, %r8
               	movq	%rax, %xmm14
               	movq	%r8, %xmm15
               	ucomisd	%xmm15, %xmm14
               	seta	%dil
               	movzbq	%dil, %rdi
               	cmpq	$0x0, %rdi
               	je	0x4004c8 <.text+0x208>
               	leaq	-0x10(%rbp), %r8
               	movslq	(%r8), %rdi
               	orq	$0x2, %rdi
               	movl	%edi, (%r8)
               	jmp	0x4004c8 <.text+0x208>
               	xorq	%rdi, %rdi
               	movq	%rax, %xmm14
               	movq	%rdi, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setbe	%r9b
               	movzbq	%r9b, %r9
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %r9
               	cmpq	$0x0, %r9
               	je	0x400510 <.text+0x250>
               	leaq	-0x10(%rbp), %rdi
               	movslq	(%rdi), %r9
               	orq	$0x4, %r9
               	movl	%r9d, (%rdi)
               	jmp	0x400510 <.text+0x250>
               	xorq	%r9, %r9
               	movq	%rax, %xmm14
               	movq	%r9, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setae	%r8b
               	movzbq	%r8b, %r8
               	cmpq	$0x0, %r8
               	je	0x40054d <.text+0x28d>
               	leaq	-0x10(%rbp), %r9
               	movslq	(%r9), %r8
               	orq	$0x8, %r8
               	movl	%r8d, (%r9)
               	jmp	0x40054d <.text+0x28d>
               	xorq	%r8, %r8
               	movq	%rax, %xmm14
               	movq	%r8, %xmm15
               	ucomisd	%xmm15, %xmm14
               	sete	%dil
               	movzbq	%dil, %rdi
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %rdi
               	cmpq	$0x0, %rdi
               	je	0x400595 <.text+0x2d5>
               	leaq	-0x10(%rbp), %r8
               	movslq	(%r8), %rdi
               	orq	$0x10, %rdi
               	movl	%edi, (%r8)
               	jmp	0x400595 <.text+0x2d5>
               	xorq	%rdi, %rdi
               	movq	%rax, %xmm14
               	movq	%rdi, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%r9b
               	movzbq	%r9b, %r9
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %r9
               	cmpq	$0x0, %r9
               	jne	0x4005dd <.text+0x31d>
               	leaq	-0x10(%rbp), %rdi
               	movslq	(%rdi), %r9
               	orq	$0x20, %r9
               	movl	%r9d, (%rdi)
               	jmp	0x4005dd <.text+0x31d>
               	movq	%rax, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setb	%r9b
               	movzbq	%r9b, %r9
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %r9
               	cmpq	$0x0, %r9
               	je	0x400622 <.text+0x362>
               	leaq	-0x10(%rbp), %r8
               	movslq	(%r8), %r9
               	orq	$0x40, %r9
               	movl	%r9d, (%r8)
               	jmp	0x400622 <.text+0x362>
               	movq	%rax, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	sete	%al
               	movzbq	%al, %rax
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	0x400667 <.text+0x3a7>
               	leaq	-0x10(%rbp), %r9
               	movslq	(%r9), %rax
               	orq	$0x80, %rax
               	movl	%eax, (%r9)
               	jmp	0x400667 <.text+0x3a7>
               	movslq	-0x10(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	0x4006b5 <.text+0x3f5>
               	leaq	0xfad1(%rip), %rbx      # 0x410150
               	movslq	-0x10(%rbp), %r12
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x40082d <printf>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfaa4(%rip), %r14      # 0x410160
               	movq	%r14, %rdi
               	movb	$0x0, %al
               	callq	0x40082d <printf>
               	movslq	%eax, %rax
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
