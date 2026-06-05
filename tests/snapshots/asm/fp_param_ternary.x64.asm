
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
               	movq	%r12, 0x8(%rsp)
               	movq	%rdi, %rbx
               	movslq	%ebx, %rbx
               	leaq	<rip>, %r12
               	movq	%rbx, %rax
               	shlq	$0x3, %rax
               	addq	%r12, %rax
               	movq	(%rax), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movq	%rbx, %rax
               	shlq	$0x3, %rax
               	addq	%r12, %rax
               	movq	(%rax), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	xorq	%rdi, %rdi
               	leaq	<rip>, %rcx
               	movq	%rcx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	addq	$0x8, %rax
               	leaq	<rip>, %rcx
               	movq	%rcx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	addq	$0x10, %rax
               	leaq	<rip>, %rcx
               	movq	%rcx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	movq	%rbx, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rax
               	movq	(%rax), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	movq	%rbx, %rcx
               	shlq	$0x3, %rcx
               	addq	%r12, %rcx
               	movq	(%rax), %rax
               	movq	%rax, (%rcx)
               	jmp	<addr>
               	movq	%rbx, %rax
               	shlq	$0x3, %rax
               	addq	%r12, %rax
               	movq	(%rax), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
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
               	movq	%rdi, %rax
               	movslq	%eax, %rax
               	movq	0x20(%rbp), %rcx
               	leaq	-0x8(%rbp), %rdx
               	movq	%rcx, %xmm14
               	cvtsd2ss	%xmm14, %xmm15
               	movss	%xmm15, (%rdx,%riz)
               	andq	$0x1, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movss	-0x8(%rbp,%riz), %xmm0
               	leaq	-0x10(%rbp), %rax
               	movss	%xmm0, (%rax,%riz)
               	jmp	<addr>
               	movss	-0x8(%rbp,%riz), %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	leaq	-0x10(%rbp), %rax
               	movss	%xmm0, (%rax,%riz)
               	jmp	<addr>
               	movss	-0x10(%rbp,%riz), %xmm0
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
               	movq	%rdi, %rax
               	movslq	%eax, %rax
               	movq	0x20(%rbp), %rcx
               	leaq	-0x8(%rbp), %rdx
               	movq	%rcx, %xmm14
               	cvtsd2ss	%xmm14, %xmm15
               	movss	%xmm15, (%rdx,%riz)
               	movq	0x30(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	movq	%rcx, %xmm14
               	cvtsd2ss	%xmm14, %xmm15
               	movss	%xmm15, (%rdx,%riz)
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	cmpq	$0x0, %rcx
               	je	<addr>
               	movss	-0x8(%rbp,%riz), %xmm0
               	leaq	-0x28(%rbp), %rcx
               	movss	%xmm0, (%rcx,%riz)
               	jmp	<addr>
               	movss	-0x8(%rbp,%riz), %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	leaq	-0x28(%rbp), %rcx
               	movss	%xmm0, (%rcx,%riz)
               	jmp	<addr>
               	movss	-0x28(%rbp,%riz), %xmm0
               	leaq	-0x18(%rbp), %rcx
               	movss	%xmm0, (%rcx,%riz)
               	andq	$0x2, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movss	-0x10(%rbp,%riz), %xmm0
               	leaq	-0x30(%rbp), %rax
               	movss	%xmm0, (%rax,%riz)
               	jmp	<addr>
               	movss	-0x10(%rbp,%riz), %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	leaq	-0x30(%rbp), %rax
               	movss	%xmm0, (%rax,%riz)
               	jmp	<addr>
               	movss	-0x30(%rbp,%riz), %xmm0
               	leaq	-0x20(%rbp), %rax
               	movss	%xmm0, (%rax,%riz)
               	movss	-0x18(%rbp,%riz), %xmm0
               	movss	-0x20(%rbp,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	addq	$0x30, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x30, %rsp
               	pushq	%r11
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	xorq	%rdi, %rdi
               	movabsq	$0x4014000000000000, %rbx # imm = 0x4014000000000000
               	movq	%rbx, %xmm14
               	cvtsd2ss	%xmm14, %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movq	%xmm0, %r10
               	movq	%r10, -0x20(%rbp)
               	movq	-0x20(%rbp), %rsi
               	callq	<addr>
               	movq	%rbx, %xmm1
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	cvtss2sd	%xmm0, %xmm0
               	ucomisd	%xmm1, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %edi
               	movabsq	$0x4014000000000000, %rbx # imm = 0x4014000000000000
               	movq	%rbx, %xmm14
               	cvtsd2ss	%xmm14, %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movq	%xmm0, %r10
               	movq	%r10, -0x28(%rbp)
               	movq	-0x28(%rbp), %rsi
               	callq	<addr>
               	cvtss2sd	%xmm0, %xmm0
               	movq	%rbx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2, %edi
               	movabsq	$0x4014000000000000, %rbx # imm = 0x4014000000000000
               	movq	%rbx, %xmm14
               	cvtsd2ss	%xmm14, %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movq	%xmm0, %r10
               	movq	%r10, -0x30(%rbp)
               	movq	-0x30(%rbp), %rsi
               	callq	<addr>
               	movq	%rbx, %xmm1
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	cvtss2sd	%xmm0, %xmm0
               	ucomisd	%xmm1, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3, %edi
               	movabsq	$0x4014000000000000, %rbx # imm = 0x4014000000000000
               	movq	%rbx, %xmm14
               	cvtsd2ss	%xmm14, %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movq	%xmm0, %r10
               	movq	%r10, -0x38(%rbp)
               	movq	-0x38(%rbp), %rsi
               	callq	<addr>
               	cvtss2sd	%xmm0, %xmm0
               	movq	%rbx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %edi
               	movabsq	$0x3ff8000000000000, %rbx # imm = 0x3FF8000000000000
               	movq	%rbx, %xmm14
               	cvtsd2ss	%xmm14, %xmm0
               	movabsq	$0x4004000000000000, %r12 # imm = 0x4004000000000000
               	movq	%r12, %xmm14
               	cvtsd2ss	%xmm14, %xmm1
               	cvtss2sd	%xmm0, %xmm0
               	movq	%xmm0, %r10
               	movq	%r10, -0x40(%rbp)
               	movq	-0x40(%rbp), %rsi
               	cvtss2sd	%xmm1, %xmm0
               	movq	%xmm0, %r10
               	movq	%r10, -0x48(%rbp)
               	movq	-0x48(%rbp), %rdx
               	callq	<addr>
               	movq	%r12, %xmm1
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	movapd	%xmm1, %xmm15
               	movq	%rbx, %xmm1
               	addsd	%xmm15, %xmm1
               	cvtss2sd	%xmm0, %xmm0
               	ucomisd	%xmm1, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2, %edi
               	movabsq	$0x401d000000000000, %rbx # imm = 0x401D000000000000
               	movq	%rbx, %xmm14
               	cvtsd2ss	%xmm14, %xmm0
               	movabsq	$0x3fc0000000000000, %r12 # imm = 0x3FC0000000000000
               	movq	%r12, %xmm14
               	cvtsd2ss	%xmm14, %xmm1
               	cvtss2sd	%xmm0, %xmm0
               	movq	%xmm0, %r10
               	movq	%r10, -0x50(%rbp)
               	movq	-0x50(%rbp), %rsi
               	cvtss2sd	%xmm1, %xmm0
               	movq	%xmm0, %r10
               	movq	%r10, -0x58(%rbp)
               	movq	-0x58(%rbp), %rdx
               	callq	<addr>
               	movq	%rbx, %xmm1
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	movq	%r12, %xmm15
               	addsd	%xmm15, %xmm1
               	cvtss2sd	%xmm0, %xmm0
               	ucomisd	%xmm1, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3, %edi
               	movabsq	$0x4008000000000000, %rbx # imm = 0x4008000000000000
               	movq	%rbx, %xmm14
               	cvtsd2ss	%xmm14, %xmm0
               	movabsq	$0x4010000000000000, %r12 # imm = 0x4010000000000000
               	movq	%r12, %xmm14
               	cvtsd2ss	%xmm14, %xmm1
               	cvtss2sd	%xmm0, %xmm0
               	movq	%xmm0, %r10
               	movq	%r10, -0x60(%rbp)
               	movq	-0x60(%rbp), %rsi
               	cvtss2sd	%xmm1, %xmm0
               	movq	%xmm0, %r10
               	movq	%r10, -0x68(%rbp)
               	movq	-0x68(%rbp), %rdx
               	callq	<addr>
               	movq	%r12, %xmm15
               	movq	%rbx, %xmm1
               	addsd	%xmm15, %xmm1
               	cvtss2sd	%xmm0, %xmm0
               	ucomisd	%xmm1, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
