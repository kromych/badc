
int_to_float_assign_conversion.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
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
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r9
               	xorq	%r12, %r12
               	leaq	<rip>, %rdi
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	addq	$0x8, %rsi
               	leaq	<rip>, %rdi
               	movq	%rdi, (%rsi)
               	leaq	-0x18(%rbp), %r9
               	addq	$0x10, %r9
               	leaq	<rip>, %rdi
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	movq	%rbx, %rdi
               	shlq	$0x3, %rdi
               	addq	%rdi, %rsi
               	movq	(%rsi), %r14
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	leaq	<rip>, %r14
               	movq	%rbx, %r12
               	shlq	$0x3, %r12
               	addq	%r12, %r14
               	movq	(%rax), %rax
               	movq	%rax, (%r14)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	shlq	$0x3, %rbx
               	addq	%rbx, %rax
               	movq	(%rax), %rax
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
               	movq	%rbx, (%rsp)
               	leaq	-0x8(%rbp), %r11
               	movl	$0xa, %r9d
               	movb	%r9b, (%r11)
               	leaq	-0x8(%rbp), %r8
               	addq	$0x1, %r8
               	movl	$0x64, %r11d
               	movb	%r11b, (%r8)
               	leaq	-0x8(%rbp), %rdi
               	addq	$0x2, %rdi
               	movl	$0xc8, %r11d
               	movb	%r11b, (%rdi)
               	leaq	-0x8(%rbp), %r8
               	movzbq	(%r8), %r8
               	cvtsi2sd	%r8, %xmm7
               	leaq	-0x10(%rbp), %r8
               	cvtsd2ss	%xmm7, %xmm15
               	movss	%xmm15, (%r8,%riz)
               	leaq	-0x8(%rbp), %r8
               	addq	$0x1, %r8
               	movzbq	(%r8), %r8
               	cvtsi2sd	%r8, %xmm6
               	leaq	-0x18(%rbp), %r8
               	cvtsd2ss	%xmm6, %xmm15
               	movss	%xmm15, (%r8,%riz)
               	leaq	-0x8(%rbp), %r8
               	addq	$0x2, %r8
               	movzbq	(%r8), %r8
               	cvtsi2sd	%r8, %xmm7
               	leaq	-0x20(%rbp), %r8
               	cvtsd2ss	%xmm7, %xmm15
               	movss	%xmm15, (%r8,%riz)
               	movss	-0x10(%rbp,%riz), %xmm6
               	cvtss2sd	%xmm6, %xmm6
               	cvtsi2sd	%r9, %xmm7
               	mulsd	%xmm7, %xmm6
               	cvttsd2si	%xmm6, %r9
               	cmpq	$0x64, %r9
               	je	<addr>
               	movl	$0x1, %r8d
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movss	-0x18(%rbp,%riz), %xmm6
               	cvtss2sd	%xmm6, %xmm6
               	movl	$0xa, %r8d
               	cvtsi2sd	%r8, %xmm7
               	mulsd	%xmm7, %xmm6
               	cvttsd2si	%xmm6, %r8
               	cmpq	$0x3e8, %r8             # imm = 0x3E8
               	je	<addr>
               	movl	$0x2, %r9d
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movss	-0x20(%rbp,%riz), %xmm6
               	cvtss2sd	%xmm6, %xmm6
               	movl	$0xa, %r9d
               	cvtsi2sd	%r9, %xmm7
               	mulsd	%xmm7, %xmm6
               	cvttsd2si	%xmm6, %r9
               	cmpq	$0x7d0, %r9             # imm = 0x7D0
               	je	<addr>
               	movl	$0x3, %r8d
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x28(%rbp), %r9
               	leaq	-0x8(%rbp), %r8
               	addq	$0x1, %r8
               	movzbq	(%r8), %r8
               	cvtsi2sd	%r8, %xmm6
               	cvtsd2ss	%xmm6, %xmm15
               	movss	%xmm15, (%r9,%riz)
               	movss	-0x28(%rbp,%riz), %xmm7
               	cvtss2sd	%xmm7, %xmm7
               	movl	$0x64, %r9d
               	cvtsi2sd	%r9, %xmm6
               	mulsd	%xmm6, %xmm7
               	cvttsd2si	%xmm7, %r9
               	cmpq	$0x2710, %r9            # imm = 0x2710
               	je	<addr>
               	movl	$0x4, %r8d
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x3fd322d0e5604189, %r9 # imm = 0x3FD322D0E5604189
               	movss	-0x10(%rbp,%riz), %xmm7
               	cvtss2sd	%xmm7, %xmm7
               	movq	%r9, %xmm6
               	mulsd	%xmm7, %xmm6
               	movabsq	$0x3fe2c8b439581062, %r9 # imm = 0x3FE2C8B439581062
               	movss	-0x18(%rbp,%riz), %xmm7
               	cvtss2sd	%xmm7, %xmm7
               	movq	%r9, %xmm5
               	mulsd	%xmm7, %xmm5
               	addsd	%xmm5, %xmm6
               	movabsq	$0x3fbd2f1a9fbe76c9, %r9 # imm = 0x3FBD2F1A9FBE76C9
               	movss	-0x20(%rbp,%riz), %xmm5
               	cvtss2sd	%xmm5, %xmm5
               	movq	%r9, %xmm7
               	mulsd	%xmm5, %xmm7
               	addsd	%xmm7, %xmm6
               	movabsq	$0x4060000000000000, %r9 # imm = 0x4060000000000000
               	movq	%r9, %xmm15
               	subsd	%xmm15, %xmm6
               	leaq	-0x30(%rbp), %r9
               	cvtsd2ss	%xmm6, %xmm15
               	movss	%xmm15, (%r9,%riz)
               	movss	-0x30(%rbp,%riz), %xmm7
               	cvtss2sd	%xmm7, %xmm7
               	movabsq	$0x4045800000000000, %r9 # imm = 0x4045800000000000
               	movq	%r9, %xmm6
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%r11, %xmm15
               	xorpd	%xmm15, %xmm6
               	ucomisd	%xmm6, %xmm7
               	seta	%r9b
               	movzbq	%r9b, %r9
               	movq	%r9, -0x50(%rbp)
               	cmpq	$0x0, %r9
               	jne	<addr>
               	movss	-0x30(%rbp,%riz), %xmm6
               	cvtss2sd	%xmm6, %xmm6
               	movabsq	$0x4046000000000000, %r9 # imm = 0x4046000000000000
               	movq	%r9, %xmm7
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%r11, %xmm15
               	xorpd	%xmm15, %xmm7
               	ucomisd	%xmm7, %xmm6
               	setb	%r9b
               	movzbq	%r9b, %r9
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %r9
               	movq	%r9, -0x50(%rbp)
               	jmp	<addr>
               	movq	-0x50(%rbp), %r9
               	cmpq	$0x0, %r9
               	je	<addr>
               	movl	$0x5, %r8d
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movl	$0x7, %r9d
               	cvtsi2sd	%r9, %xmm7
               	leaq	-0x40(%rbp), %r9
               	cvtsd2ss	%xmm7, %xmm15
               	movss	%xmm15, (%r9,%riz)
               	movss	-0x40(%rbp,%riz), %xmm6
               	cvtss2sd	%xmm6, %xmm6
               	movabsq	$0x401c000000000000, %r9 # imm = 0x401C000000000000
               	movq	%r9, %xmm15
               	ucomisd	%xmm15, %xmm6
               	setne	%r8b
               	movzbq	%r8b, %r8
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %r8
               	cmpq	$0x0, %r8
               	je	<addr>
               	movl	$0x6, %r9d
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rbx
               	movq	%rbx, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
