
float_is_four_bytes.x64:	file format elf64-x86-64

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
               	movq	(%r9), %r8
               	cmpq	$0x0, %r8
               	je	<addr>
               	leaq	<rip>, %r9
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
               	movq	(%rax), %r12
               	movq	%r12, (%r14)
               	jmp	<addr>
               	leaq	<rip>, %r12
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
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	0x10(%rbp), %r11
               	leaq	-0x8(%rbp), %r9
               	movq	%r11, %xmm14
               	cvtsd2ss	%xmm14, %xmm15
               	movss	%xmm15, (%r9,%riz)
               	movss	-0x8(%rbp,%riz), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movq	%xmm0, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rdx, (%rsp)
               	subq	$0x10, %rsp
               	movq	%rsi, (%rsp)
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	0x10(%rbp), %r11
               	leaq	-0x8(%rbp), %r9
               	movq	%r11, %xmm14
               	cvtsd2ss	%xmm14, %xmm15
               	movss	%xmm15, (%r9,%riz)
               	movq	0x20(%rbp), %r9
               	leaq	-0x10(%rbp), %r11
               	movq	%r9, %xmm14
               	cvtsd2ss	%xmm14, %xmm15
               	movss	%xmm15, (%r11,%riz)
               	movq	0x30(%rbp), %r11
               	leaq	-0x18(%rbp), %r9
               	movq	%r11, %xmm14
               	cvtsd2ss	%xmm14, %xmm15
               	movss	%xmm15, (%r9,%riz)
               	movss	-0x8(%rbp,%riz), %xmm7
               	cvtss2sd	%xmm7, %xmm7
               	movss	-0x10(%rbp,%riz), %xmm6
               	cvtss2sd	%xmm6, %xmm6
               	addsd	%xmm6, %xmm7
               	movss	-0x18(%rbp,%riz), %xmm6
               	cvtss2sd	%xmm6, %xmm6
               	movapd	%xmm7, %xmm0
               	addsd	%xmm6, %xmm0
               	movq	%xmm0, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x30, %rsp
               	pushq	%r11
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x110, %rsp            # imm = 0x110
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	xorq	%r11, %r11
               	movl	%r11d, -0x8(%rbp)
               	cmpq	$0x0, %r11
               	je	<addr>
               	leaq	<rip>, %rbx
               	movl	$0x4, %r12d
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movl	%eax, -0x8(%rbp)
               	jmp	<addr>
               	xorq	%rax, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	leaq	<rip>, %r14
               	movl	$0x8, %r12d
               	movq	%r14, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x2, %eax
               	movl	%eax, -0x8(%rbp)
               	jmp	<addr>
               	xorq	%rax, %rax
               	leaq	-0x10(%rbp), %r12
               	movq	%rax, %xmm14
               	cvtsd2ss	%xmm14, %xmm15
               	movss	%xmm15, (%r12)
               	cmpq	$0x0, %rax
               	je	<addr>
               	leaq	<rip>, %rbx
               	movl	$0x4, %r12d
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x3, %eax
               	movl	%eax, -0x8(%rbp)
               	jmp	<addr>
               	leaq	-0x18(%rbp), %rax
               	movabsq	$0x3ff8000000000000, %r12 # imm = 0x3FF8000000000000
               	movq	%r12, %xmm14
               	cvtsd2ss	%xmm14, %xmm15
               	movss	%xmm15, (%rax,%riz)
               	leaq	-0x18(%rbp), %r12
               	addq	$0x4, %r12
               	movl	$0x12345678, %eax       # imm = 0x12345678
               	movl	%eax, (%r12)
               	leaq	-0x18(%rbp), %rbx
               	movq	%rbx, %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %r12
               	cmpq	$0x12345678, %r12       # imm = 0x12345678
               	je	<addr>
               	leaq	<rip>, %r14
               	movl	$0x4, %r15d
               	addq	$0x4, %rbx
               	movslq	(%rbx), %r12
               	movq	%r14, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	%r15d, -0x8(%rbp)
               	jmp	<addr>
               	leaq	-0x18(%rbp), %r15
               	movss	(%r15,%riz), %xmm7
               	cvtss2sd	%xmm7, %xmm7
               	movabsq	$0x3ff8000000000000, %r15 # imm = 0x3FF8000000000000
               	movq	%r15, %xmm15
               	ucomisd	%xmm15, %xmm7
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	leaq	<rip>, %rbx
               	movq	%rbx, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x5, %eax
               	movl	%eax, -0x8(%rbp)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	%rax, %rbx
               	addq	$0x4, %rbx
               	subq	%rax, %rbx
               	cmpq	$0x4, %rbx
               	je	<addr>
               	leaq	<rip>, %r15
               	leaq	<rip>, %rbx
               	addq	$0x4, %rbx
               	subq	%rax, %rbx
               	movq	%r15, %rdi
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x6, %eax
               	movl	%eax, -0x8(%rbp)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movss	(%rax,%riz), %xmm7
               	cvtss2sd	%xmm7, %xmm7
               	movabsq	$0x3ff8000000000000, %rax # imm = 0x3FF8000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm7
               	setne	%bl
               	movzbq	%bl, %rbx
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rbx
               	cmpq	$0x0, %rbx
               	je	<addr>
               	leaq	<rip>, %r12
               	leaq	<rip>, %rbx
               	movss	(%rbx,%riz), %xmm14
               	cvtss2sd	%xmm14, %xmm14
               	movsd	%xmm14, 0x48(%rsp)
               	movsd	0x48(%rsp), %xmm0
               	movq	%r12, %rdi
               	movb	$0x1, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x7, %eax
               	movl	%eax, -0x8(%rbp)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	addq	$0x4, %rax
               	movss	(%rax,%riz), %xmm7
               	cvtss2sd	%xmm7, %xmm7
               	movabsq	$0x4004000000000000, %rax # imm = 0x4004000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm7
               	setne	%r12b
               	movzbq	%r12b, %r12
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %r12
               	cmpq	$0x0, %r12
               	je	<addr>
               	leaq	<rip>, %rbx
               	leaq	<rip>, %r12
               	addq	$0x4, %r12
               	movss	(%r12), %xmm14
               	cvtss2sd	%xmm14, %xmm14
               	movsd	%xmm14, 0x40(%rsp)
               	movsd	0x40(%rsp), %xmm0
               	movq	%rbx, %rdi
               	movb	$0x1, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x8, %eax
               	movl	%eax, -0x8(%rbp)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	addq	$0x8, %rax
               	movss	(%rax,%riz), %xmm7
               	cvtss2sd	%xmm7, %xmm7
               	movabsq	$0x400c000000000000, %rax # imm = 0x400C000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm7
               	setne	%bl
               	movzbq	%bl, %rbx
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rbx
               	cmpq	$0x0, %rbx
               	je	<addr>
               	leaq	<rip>, %r12
               	leaq	<rip>, %rbx
               	addq	$0x8, %rbx
               	movss	(%rbx,%riz), %xmm14
               	cvtss2sd	%xmm14, %xmm14
               	movsd	%xmm14, 0x38(%rsp)
               	movsd	0x38(%rsp), %xmm0
               	movq	%r12, %rdi
               	movb	$0x1, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x9, %eax
               	movl	%eax, -0x8(%rbp)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	addq	$0xc, %rax
               	movss	(%rax,%riz), %xmm7
               	cvtss2sd	%xmm7, %xmm7
               	movabsq	$0x4012000000000000, %rax # imm = 0x4012000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm7
               	setne	%r12b
               	movzbq	%r12b, %r12
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %r12
               	cmpq	$0x0, %r12
               	je	<addr>
               	leaq	<rip>, %rbx
               	leaq	<rip>, %r12
               	addq	$0xc, %r12
               	movss	(%r12), %xmm14
               	cvtss2sd	%xmm14, %xmm14
               	movsd	%xmm14, 0x30(%rsp)
               	movsd	0x30(%rsp), %xmm0
               	movq	%rbx, %rdi
               	movb	$0x1, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0xa, %eax
               	movl	%eax, -0x8(%rbp)
               	jmp	<addr>
               	movabsq	$0x3ff8000000000000, %r12 # imm = 0x3FF8000000000000
               	movq	%r12, %rdi
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
               	leaq	<rip>, %rbx
               	movq	%rbx, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0xb, %eax
               	movl	%eax, -0x8(%rbp)
               	jmp	<addr>
               	movabsq	$0x4004000000000000, %r12 # imm = 0x4004000000000000
               	movq	%r12, %rdi
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
               	leaq	<rip>, %rbx
               	movq	%rbx, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0xc, %eax
               	movl	%eax, -0x8(%rbp)
               	jmp	<addr>
               	movabsq	$0x3ff8000000000000, %r12 # imm = 0x3FF8000000000000
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%rax, %r14
               	movabsq	$0x4004000000000000, %rbx # imm = 0x4004000000000000
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%r14, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	sete	%r14b
               	movzbq	%r14b, %r14
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %r14
               	cmpq	$0x0, %r14
               	je	<addr>
               	leaq	<rip>, %r15
               	movq	%r15, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0xd, %eax
               	movl	%eax, -0x8(%rbp)
               	jmp	<addr>
               	movabsq	$0x3ff0000000000000, %r14 # imm = 0x3FF0000000000000
               	movabsq	$0x4000000000000000, %r12 # imm = 0x4000000000000000
               	movabsq	$0x400c000000000000, %r15 # imm = 0x400C000000000000
               	movq	%r14, %rdi
               	movq	%r15, %rdx
               	movq	%r12, %rsi
               	callq	<addr>
               	movabsq	$0x401a000000000000, %r15 # imm = 0x401A000000000000
               	movq	%rax, %xmm14
               	movq	%r15, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	leaq	<rip>, %r10
               	movq	%r10, 0x28(%rsp)
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movabsq	$0x4000000000000000, %r12 # imm = 0x4000000000000000
               	movabsq	$0x400c000000000000, %r14 # imm = 0x400C000000000000
               	movq	%rax, -0xa8(%rbp)
               	movq	-0xa8(%rbp), %r15
               	movq	%r12, -0xb0(%rbp)
               	movq	-0xb0(%rbp), %r12
               	movq	%r14, -0xb8(%rbp)
               	movq	-0xb8(%rbp), %r14
               	movq	%r15, %rdi
               	movq	%r14, %rdx
               	movq	%r12, %rsi
               	callq	<addr>
               	movq	%rax, %rbx
               	movq	%rbx, %xmm0
               	movq	0x28(%rsp), %rdi
               	movb	$0x1, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0xe, %eax
               	movl	%eax, -0x8(%rbp)
               	jmp	<addr>
               	movabsq	$0x3ff8000000000000, %rax # imm = 0x3FF8000000000000
               	leaq	-0x30(%rbp), %rbx
               	movq	%rax, %xmm14
               	cvtsd2ss	%xmm14, %xmm15
               	movss	%xmm15, (%rbx,%riz)
               	movabsq	$0x4000000000000000, %rbx # imm = 0x4000000000000000
               	leaq	-0x38(%rbp), %rax
               	movq	%rbx, %xmm14
               	cvtsd2ss	%xmm14, %xmm15
               	movss	%xmm15, (%rax,%riz)
               	movss	-0x30(%rbp,%riz), %xmm7
               	cvtss2sd	%xmm7, %xmm7
               	movss	-0x38(%rbp,%riz), %xmm6
               	cvtss2sd	%xmm6, %xmm6
               	mulsd	%xmm6, %xmm7
               	movabsq	$0x3fd0000000000000, %rax # imm = 0x3FD0000000000000
               	movq	%rax, %xmm15
               	addsd	%xmm15, %xmm7
               	leaq	-0x40(%rbp), %rax
               	cvtsd2ss	%xmm7, %xmm15
               	movss	%xmm15, (%rax,%riz)
               	movss	-0x40(%rbp,%riz), %xmm6
               	cvtss2sd	%xmm6, %xmm6
               	movabsq	$0x400a000000000000, %rax # imm = 0x400A000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm6
               	setne	%bl
               	movzbq	%bl, %rbx
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rbx
               	cmpq	$0x0, %rbx
               	je	<addr>
               	leaq	<rip>, %r14
               	movss	-0x40(%rbp,%riz), %xmm14
               	cvtss2sd	%xmm14, %xmm14
               	movsd	%xmm14, 0x20(%rsp)
               	movsd	0x20(%rsp), %xmm0
               	movq	%r14, %rdi
               	movb	$0x1, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0xf, %eax
               	movl	%eax, -0x8(%rbp)
               	jmp	<addr>
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	leaq	-0x48(%rbp), %r14
               	movq	%rax, %xmm14
               	cvtsd2ss	%xmm14, %xmm15
               	movss	%xmm15, (%r14,%riz)
               	leaq	-0x50(%rbp), %rbx
               	leaq	-0x48(%rbp), %r14
               	movl	$0x4, %r15d
               	movq	%rbx, %rdi
               	movq	%r15, %rdx
               	movq	%r14, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	-0x50(%rbp), %eax
               	xorq	$0x3f800000, %rax       # imm = 0x3F800000
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	leaq	<rip>, %r12
               	movl	-0x50(%rbp), %r15d
               	movq	%r12, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x10, %eax
               	movl	%eax, -0x8(%rbp)
               	jmp	<addr>
               	movslq	-0x8(%rbp), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
