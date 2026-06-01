
two_d_float_array_partial_init.x64:	file format elf64-x86-64

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
               	subq	$0x80, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	xorq	%r11, %r11
               	movl	%r11d, -0x8(%rbp)
               	jmp	<addr>
               	movslq	-0x8(%rbp), %r11
               	cmpq	$0xc, %r11
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x8(%rbp), %r9
               	movslq	(%r9), %r11
               	addq	$0x1, %r11
               	movl	%r11d, (%r9)
               	jmp	<addr>
               	xorq	%r11, %r11
               	movl	%r11d, -0x10(%rbp)
               	jmp	<addr>
               	xorq	%r15, %r15
               	leaq	-0x18(%rbp), %rax
               	movq	%r15, %xmm14
               	cvtsd2ss	%xmm14, %xmm15
               	movss	%xmm15, (%rax,%riz)
               	movl	%r15d, -0x8(%rbp)
               	jmp	<addr>
               	movslq	-0x10(%rbp), %r11
               	cmpq	$0x4, %r11
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x10(%rbp), %r8
               	movslq	(%r8), %r11
               	addq	$0x1, %r11
               	movl	%r11d, (%r8)
               	jmp	<addr>
               	leaq	<rip>, %r11
               	movslq	-0x8(%rbp), %r9
               	shlq	$0x4, %r9
               	addq	%r9, %r11
               	movslq	-0x10(%rbp), %r8
               	shlq	$0x2, %r8
               	addq	%r8, %r11
               	movss	(%r11,%riz), %xmm7
               	cvtss2sd	%xmm7, %xmm7
               	leaq	<rip>, %r11
               	addq	%r9, %r11
               	addq	%r8, %r11
               	movss	(%r11,%riz), %xmm6
               	cvtss2sd	%xmm6, %xmm6
               	ucomisd	%xmm6, %xmm7
               	setne	%r11b
               	movzbq	%r11b, %r11
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x2, %ebx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r12
               	leaq	<rip>, %r14
               	movslq	-0x8(%rbp), %rbx
               	movslq	-0x10(%rbp), %r15
               	leaq	<rip>, %rsi
               	movq	%rbx, %rdx
               	shlq	$0x4, %rdx
               	addq	%rdx, %rsi
               	movq	%r15, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rsi
               	movss	(%rsi,%riz), %xmm14
               	cvtss2sd	%xmm14, %xmm14
               	movsd	%xmm14, 0x38(%rsp)
               	leaq	<rip>, %rsi
               	addq	%rdx, %rsi
               	addq	%rcx, %rsi
               	movss	(%rsi,%riz), %xmm14
               	cvtss2sd	%xmm14, %xmm14
               	movsd	%xmm14, 0x30(%rsp)
               	movsd	0x38(%rsp), %xmm0
               	movsd	0x30(%rsp), %xmm1
               	movq	%r12, %rdi
               	movq	%r15, %rcx
               	movq	%rbx, %rdx
               	movq	%r14, %rsi
               	movb	$0x2, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movslq	-0x8(%rbp), %r15
               	cmpq	$0xc, %r15
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x8(%rbp), %rax
               	movslq	(%rax), %r15
               	addq	$0x1, %r15
               	movl	%r15d, (%rax)
               	jmp	<addr>
               	leaq	-0x18(%rbp), %r15
               	movss	(%r15,%riz), %xmm6
               	cvtss2sd	%xmm6, %xmm6
               	leaq	<rip>, %rbx
               	movslq	-0x8(%rbp), %rax
               	shlq	$0x4, %rax
               	addq	%rax, %rbx
               	movss	(%rbx,%riz), %xmm7
               	cvtss2sd	%xmm7, %xmm7
               	movq	%rbx, %rax
               	addq	$0x4, %rax
               	movss	(%rax,%riz), %xmm5
               	cvtss2sd	%xmm5, %xmm5
               	addsd	%xmm5, %xmm7
               	addq	$0x8, %rbx
               	movss	(%rbx,%riz), %xmm5
               	cvtss2sd	%xmm5, %xmm5
               	addsd	%xmm5, %xmm7
               	addsd	%xmm7, %xmm6
               	cvtsd2ss	%xmm6, %xmm15
               	movss	%xmm15, (%r15,%riz)
               	jmp	<addr>
               	movss	-0x18(%rbp,%riz), %xmm6
               	cvtss2sd	%xmm6, %xmm6
               	xorq	%r15, %r15
               	movq	%r15, %xmm15
               	ucomisd	%xmm15, %xmm6
               	setne	%bl
               	movzbq	%bl, %rbx
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rbx
               	cmpq	$0x0, %rbx
               	je	<addr>
               	movl	$0x2, %r12d
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%rax, %r15
               	leaq	<rip>, %rbx
               	movss	-0x18(%rbp,%riz), %xmm14
               	cvtss2sd	%xmm14, %xmm14
               	movsd	%xmm14, 0x28(%rsp)
               	movsd	0x28(%rsp), %xmm0
               	movq	%r15, %rdi
               	movq	%rbx, %rsi
               	movb	$0x1, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
