
fp_param_ternary.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movslq	%edi, %rbx
               	leaq	<rip>, %r9
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	addq	%r8, %r9
               	movq	(%r9), %r9
               	cmpq	$0x0, %r9
               	je	<addr>
               	leaq	<rip>, %r8
               	movq	%rbx, %r9
               	shlq	$0x3, %r9
               	addq	%r9, %r8
               	movq	(%r8), %r8
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r9
               	xorq	%rdi, %rdi
               	leaq	<rip>, %r8
               	movq	%r8, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	addq	$0x8, %rsi
               	leaq	<rip>, %r8
               	movq	%r8, (%rsi)
               	leaq	-0x18(%rbp), %r9
               	addq	$0x10, %r9
               	leaq	<rip>, %r8
               	movq	%r8, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	addq	%r8, %rsi
               	movq	(%rsi), %r8
               	movq	%r8, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	leaq	<rip>, %rdi
               	movq	%rbx, %rsi
               	shlq	$0x3, %rsi
               	addq	%rsi, %rdi
               	movq	(%rax), %rax
               	movq	%rax, (%rdi)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	shlq	$0x3, %rbx
               	addq	%rbx, %rax
               	movq	(%rax), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
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
               	je	<addr>
               	movss	-0x8(%rbp,%riz), %xmm7
               	cvtss2sd	%xmm7, %xmm7
               	leaq	-0x10(%rbp), %r11
               	cvtsd2ss	%xmm7, %xmm15
               	movss	%xmm15, (%r11,%riz)
               	jmp	<addr>
               	movss	-0x8(%rbp,%riz), %xmm7
               	cvtss2sd	%xmm7, %xmm7
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%r11, %xmm15
               	xorpd	%xmm15, %xmm7
               	leaq	-0x10(%rbp), %r11
               	cvtsd2ss	%xmm7, %xmm15
               	movss	%xmm15, (%r11,%riz)
               	jmp	<addr>
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
               	je	<addr>
               	movss	-0x8(%rbp,%riz), %xmm7
               	cvtss2sd	%xmm7, %xmm7
               	leaq	-0x28(%rbp), %r9
               	cvtsd2ss	%xmm7, %xmm15
               	movss	%xmm15, (%r9,%riz)
               	jmp	<addr>
               	movss	-0x8(%rbp,%riz), %xmm7
               	cvtss2sd	%xmm7, %xmm7
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm7
               	leaq	-0x28(%rbp), %r9
               	cvtsd2ss	%xmm7, %xmm15
               	movss	%xmm15, (%r9,%riz)
               	jmp	<addr>
               	movss	-0x28(%rbp,%riz), %xmm7
               	cvtss2sd	%xmm7, %xmm7
               	leaq	-0x18(%rbp), %r9
               	cvtsd2ss	%xmm7, %xmm15
               	movss	%xmm15, (%r9,%riz)
               	andq	$0x2, %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movss	-0x10(%rbp,%riz), %xmm6
               	cvtss2sd	%xmm6, %xmm6
               	leaq	-0x30(%rbp), %r11
               	cvtsd2ss	%xmm6, %xmm15
               	movss	%xmm15, (%r11,%riz)
               	jmp	<addr>
               	movss	-0x10(%rbp,%riz), %xmm6
               	cvtss2sd	%xmm6, %xmm6
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%r11, %xmm15
               	xorpd	%xmm15, %xmm6
               	leaq	-0x30(%rbp), %r11
               	cvtsd2ss	%xmm6, %xmm15
               	movss	%xmm15, (%r11,%riz)
               	jmp	<addr>
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
               	xorq	%rdi, %rdi
               	movabsq	$0x4014000000000000, %rbx # imm = 0x4014000000000000
               	movq	%rbx, %rsi
               	callq	<addr>
               	movq	%rbx, %xmm7
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
               	je	<addr>
               	movl	$0x1, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %edi
               	movabsq	$0x4014000000000000, %r12 # imm = 0x4014000000000000
               	movq	%r12, %rsi
               	callq	<addr>
               	movq	%rax, %xmm14
               	movq	%r12, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x2, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2, %edi
               	movabsq	$0x4014000000000000, %rbx # imm = 0x4014000000000000
               	movq	%rbx, %rsi
               	callq	<addr>
               	movq	%rbx, %xmm7
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
               	je	<addr>
               	movl	$0x3, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3, %edi
               	movabsq	$0x4014000000000000, %r12 # imm = 0x4014000000000000
               	movq	%r12, %rsi
               	callq	<addr>
               	movq	%rax, %xmm14
               	movq	%r12, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x4, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %edi
               	movabsq	$0x3ff8000000000000, %rbx # imm = 0x3FF8000000000000
               	movabsq	$0x4004000000000000, %r12 # imm = 0x4004000000000000
               	movq	%rbx, %rsi
               	movq	%r12, %rdx
               	callq	<addr>
               	movq	%r12, %xmm7
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%r11, %xmm15
               	xorpd	%xmm15, %xmm7
               	movq	%rbx, %xmm6
               	addsd	%xmm7, %xmm6
               	movq	%rax, %xmm14
               	ucomisd	%xmm6, %xmm14
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x5, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2, %edi
               	movabsq	$0x401d000000000000, %r14 # imm = 0x401D000000000000
               	movabsq	$0x3fc0000000000000, %rbx # imm = 0x3FC0000000000000
               	movq	%r14, %rsi
               	movq	%rbx, %rdx
               	callq	<addr>
               	movq	%r14, %xmm6
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%r11, %xmm15
               	xorpd	%xmm15, %xmm6
               	movq	%rbx, %xmm15
               	addsd	%xmm15, %xmm6
               	movq	%rax, %xmm14
               	ucomisd	%xmm6, %xmm14
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x6, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3, %edi
               	movabsq	$0x4008000000000000, %r12 # imm = 0x4008000000000000
               	movabsq	$0x4010000000000000, %rbx # imm = 0x4010000000000000
               	movq	%r12, %rsi
               	movq	%rbx, %rdx
               	callq	<addr>
               	movq	%r12, %xmm6
               	movq	%rbx, %xmm15
               	addsd	%xmm15, %xmm6
               	movq	%rax, %xmm14
               	ucomisd	%xmm6, %xmm14
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x7, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
