
leading_dot_float_literal.x64:	file format elf64-x86-64

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
               	callq	0x4006c7 <dlsym>
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
               	subq	$0x30, %rsp
               	movabsq	$0x3fe0000000000000, %r11 # imm = 0x3FE0000000000000
               	leaq	-0x8(%rbp), %r9
               	movq	%r11, %xmm14
               	cvtsd2ss	%xmm14, %xmm15
               	movss	%xmm15, (%r9,%riz)
               	movabsq	$0x3fd0000000000000, %r9 # imm = 0x3FD0000000000000
               	movabsq	$0x4039000000000000, %r8 # imm = 0x4039000000000000
               	leaq	-0x20(%rbp), %rdi
               	movq	%r11, %xmm14
               	cvtsd2ss	%xmm14, %xmm15
               	movss	%xmm15, (%rdi,%riz)
               	movl	$0x1, %edi
               	movl	%edi, -0x28(%rbp)
               	movss	-0x8(%rbp,%riz), %xmm7
               	cvtss2sd	%xmm7, %xmm7
               	movq	%r11, %xmm15
               	ucomisd	%xmm15, %xmm7
               	setne	%sil
               	movzbq	%sil, %rsi
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rsi
               	cmpq	$0x0, %rsi
               	je	0x400471 <.text+0x1f1>
               	xorq	%r11, %r11
               	movl	%r11d, -0x28(%rbp)
               	jmp	0x400471 <.text+0x1f1>
               	movabsq	$0x3fd0000000000000, %r11 # imm = 0x3FD0000000000000
               	movq	%r9, %xmm14
               	movq	%r11, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%sil
               	movzbq	%sil, %rsi
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rsi
               	cmpq	$0x0, %rsi
               	je	0x4004b6 <.text+0x236>
               	xorq	%r11, %r11
               	movl	%r11d, -0x28(%rbp)
               	jmp	0x4004b6 <.text+0x236>
               	movabsq	$0x4039000000000000, %r11 # imm = 0x4039000000000000
               	movq	%r8, %xmm14
               	movq	%r11, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%sil
               	movzbq	%sil, %rsi
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rsi
               	cmpq	$0x0, %rsi
               	je	0x4004fb <.text+0x27b>
               	xorq	%r11, %r11
               	movl	%r11d, -0x28(%rbp)
               	jmp	0x4004fb <.text+0x27b>
               	movss	-0x20(%rbp,%riz), %xmm7
               	cvtss2sd	%xmm7, %xmm7
               	movabsq	$0x3fe0000000000000, %rsi # imm = 0x3FE0000000000000
               	movq	%rsi, %xmm15
               	ucomisd	%xmm15, %xmm7
               	setne	%r11b
               	movzbq	%r11b, %r11
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %r11
               	cmpq	$0x0, %r11
               	je	0x400547 <.text+0x2c7>
               	xorq	%rsi, %rsi
               	movl	%esi, -0x28(%rbp)
               	jmp	0x400547 <.text+0x2c7>
               	movslq	-0x28(%rbp), %rsi
               	cmpq	$0x0, %rsi
               	je	0x400567 <.text+0x2e7>
               	movl	$0x7, %r11d
               	movq	%r11, -0x30(%rbp)
               	jmp	0x400573 <.text+0x2f3>
               	xorq	%r11, %r11
               	movq	%r11, -0x30(%rbp)
               	jmp	0x400573 <.text+0x2f3>
               	movq	-0x30(%rbp), %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
