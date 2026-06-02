
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
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movslq	%edi, %rbx
               	leaq	<rip>, %r12
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	addq	%r12, %r8
               	movq	(%r8), %r8
               	cmpq	$0x0, %r8
               	je	<addr>
               	movq	%rbx, %rdi
               	shlq	$0x3, %rdi
               	addq	%r12, %rdi
               	movq	(%rdi), %rdi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r8
               	xorq	%rdi, %rdi
               	leaq	<rip>, %rsi
               	movq	%rsi, (%r8)
               	leaq	-0x18(%rbp), %rdx
               	addq	$0x8, %rdx
               	leaq	<rip>, %rsi
               	movq	%rsi, (%rdx)
               	leaq	-0x18(%rbp), %r8
               	addq	$0x10, %r8
               	leaq	<rip>, %rsi
               	movq	%rsi, (%r8)
               	leaq	-0x18(%rbp), %rdx
               	movq	%rbx, %rsi
               	shlq	$0x3, %rsi
               	addq	%rsi, %rdx
               	movq	(%rdx), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	movq	%rbx, %rsi
               	shlq	$0x3, %rsi
               	addq	%r12, %rsi
               	movq	(%rax), %rax
               	movq	%rax, (%rsi)
               	jmp	<addr>
               	shlq	$0x3, %rbx
               	addq	%rbx, %r12
               	movq	(%r12), %r12
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
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
               	xorq	%rcx, %rcx
               	leaq	-0x18(%rbp), %rax
               	movq	%rcx, %xmm14
               	cvtsd2ss	%xmm14, %xmm15
               	movss	%xmm15, (%rax,%riz)
               	movl	%ecx, -0x8(%rbp)
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
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %r11
               	leaq	<rip>, %rsi
               	movslq	-0x8(%rbp), %rdx
               	movslq	-0x10(%rbp), %rcx
               	leaq	<rip>, %rdi
               	movq	%rdx, %r9
               	shlq	$0x4, %r9
               	addq	%r9, %rdi
               	movq	%rcx, %r8
               	shlq	$0x2, %r8
               	addq	%r8, %rdi
               	movss	(%rdi,%riz), %xmm6
               	cvtss2sd	%xmm6, %xmm6
               	leaq	<rip>, %rdi
               	addq	%r9, %rdi
               	addq	%r8, %rdi
               	movss	(%rdi,%riz), %xmm7
               	cvtss2sd	%xmm7, %xmm7
               	movapd	%xmm6, %xmm0
               	movapd	%xmm7, %xmm1
               	movq	%r11, %rdi
               	movb	$0x2, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movslq	-0x8(%rbp), %rcx
               	cmpq	$0xc, %rcx
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x8(%rbp), %rax
               	movslq	(%rax), %rcx
               	addq	$0x1, %rcx
               	movl	%ecx, (%rax)
               	jmp	<addr>
               	leaq	-0x18(%rbp), %rcx
               	movss	(%rcx,%riz), %xmm7
               	cvtss2sd	%xmm7, %xmm7
               	leaq	<rip>, %rdx
               	movslq	-0x8(%rbp), %rax
               	shlq	$0x4, %rax
               	addq	%rax, %rdx
               	movss	(%rdx,%riz), %xmm6
               	cvtss2sd	%xmm6, %xmm6
               	movq	%rdx, %rax
               	addq	$0x4, %rax
               	movss	(%rax,%riz), %xmm5
               	cvtss2sd	%xmm5, %xmm5
               	addsd	%xmm5, %xmm6
               	addq	$0x8, %rdx
               	movss	(%rdx,%riz), %xmm5
               	cvtss2sd	%xmm5, %xmm5
               	addsd	%xmm5, %xmm6
               	addsd	%xmm6, %xmm7
               	cvtsd2ss	%xmm7, %xmm15
               	movss	%xmm15, (%rcx,%riz)
               	jmp	<addr>
               	movss	-0x18(%rbp,%riz), %xmm7
               	cvtss2sd	%xmm7, %xmm7
               	xorq	%rcx, %rcx
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm7
               	setne	%dl
               	movzbq	%dl, %rdx
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rdx
               	cmpq	$0x0, %rdx
               	je	<addr>
               	movl	$0x2, %ebx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	movss	-0x18(%rbp,%riz), %xmm7
               	cvtss2sd	%xmm7, %xmm7
               	movapd	%xmm7, %xmm0
               	movb	$0x1, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
