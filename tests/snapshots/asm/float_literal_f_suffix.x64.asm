
float_literal_f_suffix.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<vsum>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xe0, %rsp
               	movq	%rdi, -0xe0(%rbp)
               	movq	%rsi, -0xd8(%rbp)
               	movq	%rdx, -0xd0(%rbp)
               	movq	%rcx, -0xc8(%rbp)
               	movq	%r8, -0xc0(%rbp)
               	movq	%r9, -0xb8(%rbp)
               	testb	%al, %al
               	je	<addr>
               	movsd	%xmm0, -0xb0(%rbp,%riz)
               	movsd	%xmm1, -0xa0(%rbp,%riz)
               	movsd	%xmm2, -0x90(%rbp,%riz)
               	movsd	%xmm3, -0x80(%rbp,%riz)
               	movsd	%xmm4, -0x70(%rbp,%riz)
               	movsd	%xmm5, -0x60(%rbp,%riz)
               	movsd	%xmm6, -0x50(%rbp,%riz)
               	movsd	%xmm7, -0x40(%rbp,%riz)
               	leaq	-0x18(%rbp), %rax
               	leaq	-0xe0(%rbp), %rcx
               	movl	$0x8, (%rax)
               	movl	$0x30, 0x4(%rax)
               	leaq	0x10(%rbp), %r10
               	movq	%r10, 0x8(%rax)
               	leaq	-0xe0(%rbp), %r10
               	movq	%r10, 0x10(%rax)
               	xorq	%rax, %rax
               	cvtsi2sd	%rax, %xmm0
               	jmp	<addr>
               	leaq	-0x18(%rbp), %rdx
               	movq	%rdx, %r11
               	movl	0x4(%r11), %r10d
               	cmpq	$0xb0, %r10
               	jae	<addr>
               	addq	0x10(%r11), %r10
               	addl	$0x10, 0x4(%r11)
               	jmp	<addr>
               	movq	0x8(%r11), %r10
               	addq	$0x8, 0x8(%r11)
               	movq	%r10, %rdx
               	movsd	(%rdx,%riz), %xmm1
               	addsd	%xmm1, %xmm0
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	movslq	-0xe0(%rbp), %rdx
               	cmpq	%rdx, %rcx
               	jl	<addr>
               	leaq	-0x18(%rbp), %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x4b800000, %eax       # imm = 0x4B800000
               	movq	%rax, %xmm14
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm14
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbp
               	retq
               	movabsq	$0x4170000010000000, %rax # imm = 0x4170000010000000
               	movabsq	$0x4170000000000000, %rcx # imm = 0x4170000000000000
               	movq	%rax, %xmm14
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	sete	%al
               	movzbq	%al, %rax
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbp
               	retq
               	movl	$0x3dcccccd, %eax       # imm = 0x3DCCCCCD
               	movabsq	$0x3fb999999999999a, %rcx # imm = 0x3FB999999999999A
               	movq	%rax, %xmm14
               	cvtss2sd	%xmm14, %xmm0
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	sete	%al
               	movzbq	%al, %rax
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbp
               	retq
               	movl	$0x3dcccccd, %eax       # imm = 0x3DCCCCCD
               	movabsq	$0x3fb99999a0000000, %rcx # imm = 0x3FB99999A0000000
               	movq	%rax, %xmm14
               	cvtss2sd	%xmm14, %xmm0
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	popq	%rbp
               	retq
               	movl	$0x3dcccccd, %eax       # imm = 0x3DCCCCCD
               	movq	%rax, %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movabsq	$0x3fb99999a0000000, %rax # imm = 0x3FB99999A0000000
               	movq	%rax, %xmm1
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
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	popq	%rbp
               	retq
               	movl	$0x2, %edi
               	movl	$0x3fc00000, %eax       # imm = 0x3FC00000
               	movq	%rax, %xmm14
               	cvtss2sd	%xmm14, %xmm0
               	movl	$0x3e800000, %eax       # imm = 0x3E800000
               	movq	%rax, %xmm14
               	cvtss2sd	%xmm14, %xmm1
               	movb	$0x2, %al
               	callq	<addr>
               	movabsq	$0x3ffc000000000000, %rax # imm = 0x3FFC000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	popq	%rbp
               	retq
               	movl	$0x1, %edi
               	movl	$0x3dcccccd, %eax       # imm = 0x3DCCCCCD
               	movq	%rax, %xmm14
               	cvtss2sd	%xmm14, %xmm0
               	movb	$0x1, %al
               	callq	<addr>
               	movabsq	$0x3fb99999a0000000, %rax # imm = 0x3FB99999A0000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	popq	%rbp
               	retq
               	movl	$0x4b800001, %eax       # imm = 0x4B800001
               	movq	%rax, %xmm14
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm14
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
               	movl	$0x6, %eax
               	popq	%rbp
               	retq
               	movl	$0x7, %eax
               	popq	%rbp
               	retq
               	movl	$0x8, %eax
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
