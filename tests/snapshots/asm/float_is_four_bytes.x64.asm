
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
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	0x10(%rbp), %rax
               	leaq	-0x8(%rbp), %rcx
               	movq	%rax, %xmm14
               	cvtsd2ss	%xmm14, %xmm15
               	movss	%xmm15, (%rcx,%riz)
               	movss	-0x8(%rbp,%riz), %xmm0
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
               	movq	0x10(%rbp), %rax
               	leaq	-0x8(%rbp), %rcx
               	movq	%rax, %xmm14
               	cvtsd2ss	%xmm14, %xmm15
               	movss	%xmm15, (%rcx,%riz)
               	movq	0x20(%rbp), %rax
               	leaq	-0x10(%rbp), %rcx
               	movq	%rax, %xmm14
               	cvtsd2ss	%xmm14, %xmm15
               	movss	%xmm15, (%rcx,%riz)
               	movq	0x30(%rbp), %rax
               	leaq	-0x18(%rbp), %rcx
               	movq	%rax, %xmm14
               	cvtsd2ss	%xmm14, %xmm15
               	movss	%xmm15, (%rcx,%riz)
               	movss	-0x8(%rbp,%riz), %xmm0
               	movss	-0x10(%rbp,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	-0x18(%rbp,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	addq	$0x20, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x30, %rsp
               	pushq	%r11
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xe0, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	xorq	%rbx, %rbx
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movl	$0x4, %esi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %ebx
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movl	$0x8, %esi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x2, %ebx
               	jmp	<addr>
               	xorq	%rax, %rax
               	movq	%rax, %xmm14
               	cvtsd2ss	%xmm14, %xmm0
               	leaq	-0x10(%rbp), %rcx
               	movss	%xmm0, (%rcx,%riz)
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movl	$0x4, %esi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x3, %ebx
               	jmp	<addr>
               	leaq	-0x18(%rbp), %rax
               	movabsq	$0x3ff8000000000000, %rcx # imm = 0x3FF8000000000000
               	movq	%rcx, %xmm14
               	cvtsd2ss	%xmm14, %xmm0
               	movss	%xmm0, (%rax,%riz)
               	leaq	-0x18(%rbp), %rax
               	addq	$0x4, %rax
               	movl	$0x12345678, %ecx       # imm = 0x12345678
               	movl	%ecx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	movq	%rax, %rcx
               	addq	$0x4, %rcx
               	movslq	(%rcx), %rcx
               	cmpq	$0x12345678, %rcx       # imm = 0x12345678
               	je	<addr>
               	leaq	<rip>, %rdi
               	movl	$0x4, %ebx
               	addq	$0x4, %rax
               	movslq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	leaq	-0x18(%rbp), %rax
               	movss	(%rax,%riz), %xmm0
               	movabsq	$0x3ff8000000000000, %rax # imm = 0x3FF8000000000000
               	cvtss2sd	%xmm0, %xmm0
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x5, %ebx
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	%rax, %rcx
               	addq	$0x4, %rcx
               	subq	%rax, %rcx
               	cmpq	$0x4, %rcx
               	je	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rcx
               	addq	$0x4, %rcx
               	movq	%rcx, %rsi
               	subq	%rax, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x6, %ebx
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movss	(%rax,%riz), %xmm0
               	movabsq	$0x3ff8000000000000, %rax # imm = 0x3FF8000000000000
               	cvtss2sd	%xmm0, %xmm0
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movss	(%rax,%riz), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movb	$0x1, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x7, %ebx
               	jmp	<addr>
               	leaq	<rip>, %rax
               	addq	$0x4, %rax
               	movss	(%rax,%riz), %xmm0
               	movabsq	$0x4004000000000000, %rax # imm = 0x4004000000000000
               	cvtss2sd	%xmm0, %xmm0
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	addq	$0x4, %rax
               	movss	(%rax,%riz), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movb	$0x1, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x8, %ebx
               	jmp	<addr>
               	leaq	<rip>, %rax
               	addq	$0x8, %rax
               	movss	(%rax,%riz), %xmm0
               	movabsq	$0x400c000000000000, %rax # imm = 0x400C000000000000
               	cvtss2sd	%xmm0, %xmm0
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	addq	$0x8, %rax
               	movss	(%rax,%riz), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movb	$0x1, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x9, %ebx
               	jmp	<addr>
               	leaq	<rip>, %rax
               	addq	$0xc, %rax
               	movss	(%rax,%riz), %xmm0
               	movabsq	$0x4012000000000000, %rax # imm = 0x4012000000000000
               	cvtss2sd	%xmm0, %xmm0
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	addq	$0xc, %rax
               	movss	(%rax,%riz), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movb	$0x1, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0xa, %ebx
               	jmp	<addr>
               	movabsq	$0x3ff8000000000000, %r12 # imm = 0x3FF8000000000000
               	movq	%r12, %xmm14
               	cvtsd2ss	%xmm14, %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movq	%xmm0, %r10
               	movq	%r10, -0x70(%rbp)
               	movq	-0x70(%rbp), %rdi
               	callq	<addr>
               	cvtss2sd	%xmm0, %xmm0
               	movq	%r12, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0xb, %ebx
               	jmp	<addr>
               	movabsq	$0x4004000000000000, %r12 # imm = 0x4004000000000000
               	movq	%r12, %xmm14
               	cvtsd2ss	%xmm14, %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movq	%xmm0, %r10
               	movq	%r10, -0x78(%rbp)
               	movq	-0x78(%rbp), %rdi
               	callq	<addr>
               	cvtss2sd	%xmm0, %xmm0
               	movq	%r12, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0xc, %ebx
               	jmp	<addr>
               	movabsq	$0x3ff8000000000000, %rax # imm = 0x3FF8000000000000
               	movq	%rax, %xmm14
               	cvtsd2ss	%xmm14, %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movq	%xmm0, %r10
               	movq	%r10, -0x80(%rbp)
               	movq	-0x80(%rbp), %rdi
               	callq	<addr>
               	movsd	%xmm0, 0x18(%rsp)
               	movabsq	$0x4004000000000000, %rax # imm = 0x4004000000000000
               	movq	%rax, %xmm14
               	cvtsd2ss	%xmm14, %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movq	%xmm0, %r10
               	movq	%r10, -0x88(%rbp)
               	movq	-0x88(%rbp), %rdi
               	callq	<addr>
               	movsd	0x18(%rsp), %xmm14
               	ucomiss	%xmm0, %xmm14
               	sete	%al
               	movzbq	%al, %rax
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0xd, %ebx
               	jmp	<addr>
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movq	%rax, %xmm14
               	cvtsd2ss	%xmm14, %xmm0
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movq	%rax, %xmm14
               	cvtsd2ss	%xmm14, %xmm1
               	movabsq	$0x400c000000000000, %rax # imm = 0x400C000000000000
               	movq	%rax, %xmm14
               	cvtsd2ss	%xmm14, %xmm2
               	cvtss2sd	%xmm0, %xmm0
               	movq	%xmm0, %r10
               	movq	%r10, -0x90(%rbp)
               	movq	-0x90(%rbp), %rdi
               	cvtss2sd	%xmm1, %xmm0
               	movq	%xmm0, %r10
               	movq	%r10, -0x98(%rbp)
               	movq	-0x98(%rbp), %rsi
               	cvtss2sd	%xmm2, %xmm0
               	movq	%xmm0, %r10
               	movq	%r10, -0xa0(%rbp)
               	movq	-0xa0(%rbp), %rdx
               	callq	<addr>
               	movabsq	$0x401a000000000000, %rax # imm = 0x401A000000000000
               	cvtss2sd	%xmm0, %xmm0
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	leaq	<rip>, %rbx
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movq	%rax, %xmm14
               	cvtsd2ss	%xmm14, %xmm0
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movq	%rax, %xmm14
               	cvtsd2ss	%xmm14, %xmm1
               	movabsq	$0x400c000000000000, %rax # imm = 0x400C000000000000
               	movq	%rax, %xmm14
               	cvtsd2ss	%xmm14, %xmm2
               	cvtss2sd	%xmm0, %xmm0
               	movq	%xmm0, %r10
               	movq	%r10, -0xa8(%rbp)
               	movq	-0xa8(%rbp), %rdi
               	cvtss2sd	%xmm1, %xmm0
               	movq	%xmm0, %r10
               	movq	%r10, -0xb0(%rbp)
               	movq	-0xb0(%rbp), %rsi
               	cvtss2sd	%xmm2, %xmm0
               	movq	%xmm0, %r10
               	movq	%r10, -0xb8(%rbp)
               	movq	-0xb8(%rbp), %rdx
               	callq	<addr>
               	cvtss2sd	%xmm0, %xmm0
               	movq	%rbx, %rdi
               	movb	$0x1, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0xe, %ebx
               	jmp	<addr>
               	movabsq	$0x3ff8000000000000, %rax # imm = 0x3FF8000000000000
               	movq	%rax, %xmm14
               	cvtsd2ss	%xmm14, %xmm0
               	leaq	-0x30(%rbp), %rax
               	movss	%xmm0, (%rax,%riz)
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movq	%rax, %xmm14
               	cvtsd2ss	%xmm14, %xmm0
               	leaq	-0x38(%rbp), %rax
               	movss	%xmm0, (%rax,%riz)
               	movss	-0x30(%rbp,%riz), %xmm0
               	movss	-0x38(%rbp,%riz), %xmm1
               	mulss	%xmm1, %xmm0
               	movabsq	$0x3fd0000000000000, %rax # imm = 0x3FD0000000000000
               	cvtss2sd	%xmm0, %xmm0
               	movq	%rax, %xmm15
               	addsd	%xmm15, %xmm0
               	cvtsd2ss	%xmm0, %xmm0
               	leaq	-0x40(%rbp), %rax
               	movss	%xmm0, (%rax,%riz)
               	movss	-0x40(%rbp,%riz), %xmm0
               	movabsq	$0x400a000000000000, %rax # imm = 0x400A000000000000
               	cvtss2sd	%xmm0, %xmm0
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	leaq	<rip>, %rdi
               	movss	-0x40(%rbp,%riz), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movb	$0x1, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0xf, %ebx
               	jmp	<addr>
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movq	%rax, %xmm14
               	cvtsd2ss	%xmm14, %xmm0
               	leaq	-0x48(%rbp), %rax
               	movss	%xmm0, (%rax,%riz)
               	leaq	-0x50(%rbp), %rdi
               	leaq	-0x48(%rbp), %rsi
               	movl	$0x4, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	-0x50(%rbp), %eax
               	xorq	$0x3f800000, %rax       # imm = 0x3F800000
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	je	<addr>
               	leaq	<rip>, %rdi
               	movl	-0x50(%rbp), %esi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x10, %ebx
               	jmp	<addr>
               	movslq	%ebx, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	addb	%al, (%rax)
