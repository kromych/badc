
float_is_four_bytes.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<passthrough>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<add3>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	addss	%xmm1, %xmm0
               	addss	%xmm2, %xmm0
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	movq	%rbx, (%rsp)
               	xorq	%rbx, %rbx
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movl	$0x4, %esi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %ebx
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movl	$0x8, %esi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x2, %ebx
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movl	$0x4, %esi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x3, %ebx
               	leaq	-0x18(%rbp), %rax
               	movl	$0x3fc00000, %ecx       # imm = 0x3FC00000
               	movq	%rcx, %xmm14
               	movss	%xmm14, (%rax,%riz)
               	leaq	-0x18(%rbp), %rax
               	movl	$0x12345678, %ecx       # imm = 0x12345678
               	movl	%ecx, 0x4(%rax)
               	leaq	-0x18(%rbp), %rax
               	movslq	0x4(%rax), %rcx
               	cmpq	$0x12345678, %rcx       # imm = 0x12345678
               	je	<addr>
               	leaq	<rip>, %rdi
               	movl	$0x4, %ebx
               	movslq	0x4(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	leaq	-0x18(%rbp), %rax
               	movss	(%rax,%riz), %xmm0
               	movl	$0x3fc00000, %eax       # imm = 0x3FC00000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x5, %ebx
               	leaq	<rip>, %rax
               	leaq	0x4(%rax), %rcx
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
               	leaq	<rip>, %rax
               	movss	(%rax,%riz), %xmm0
               	movl	$0x3fc00000, %eax       # imm = 0x3FC00000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movss	(%rax,%riz), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movb	$0x1, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x7, %ebx
               	leaq	<rip>, %rax
               	movss	0x4(%rax,%riz), %xmm0
               	movl	$0x40200000, %eax       # imm = 0x40200000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movss	0x4(%rax,%riz), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movb	$0x1, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x8, %ebx
               	leaq	<rip>, %rax
               	movss	0x8(%rax,%riz), %xmm0
               	movl	$0x40600000, %eax       # imm = 0x40600000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movss	0x8(%rax,%riz), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movb	$0x1, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x9, %ebx
               	leaq	<rip>, %rax
               	movss	0xc(%rax,%riz), %xmm0
               	movl	$0x40900000, %eax       # imm = 0x40900000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movss	0xc(%rax,%riz), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movb	$0x1, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0xa, %ebx
               	movl	$0x3fc00000, %eax       # imm = 0x3FC00000
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
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0xb, %ebx
               	movl	$0x40200000, %eax       # imm = 0x40200000
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
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0xc, %ebx
               	movl	$0x3fc00000, %eax       # imm = 0x3FC00000
               	movl	$0x40200000, %ecx       # imm = 0x40200000
               	movq	%rax, %xmm14
               	movq	%rcx, %xmm15
               	ucomiss	%xmm15, %xmm14
               	sete	%al
               	movzbq	%al, %rax
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0xd, %ebx
               	movl	$0x3f800000, %eax       # imm = 0x3F800000
               	movl	$0x40000000, %ecx       # imm = 0x40000000
               	movl	$0x40600000, %edx       # imm = 0x40600000
               	movq	%rcx, %xmm15
               	movq	%rax, %xmm0
               	addss	%xmm15, %xmm0
               	movq	%rdx, %xmm15
               	addss	%xmm15, %xmm0
               	movl	$0x40d00000, %eax       # imm = 0x40D00000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rdi
               	movl	$0x3f800000, %eax       # imm = 0x3F800000
               	movl	$0x40000000, %ecx       # imm = 0x40000000
               	movl	$0x40600000, %edx       # imm = 0x40600000
               	movq	%rcx, %xmm15
               	movq	%rax, %xmm0
               	addss	%xmm15, %xmm0
               	movq	%rdx, %xmm15
               	addss	%xmm15, %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movb	$0x1, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0xe, %ebx
               	movl	$0x3fc00000, %eax       # imm = 0x3FC00000
               	movq	%rax, %xmm14
               	movss	%xmm14, -0x30(%rbp,%riz)
               	movl	$0x40000000, %eax       # imm = 0x40000000
               	movq	%rax, %xmm14
               	movss	%xmm14, -0x38(%rbp,%riz)
               	movss	-0x30(%rbp,%riz), %xmm0
               	movss	-0x38(%rbp,%riz), %xmm1
               	movl	$0x3e800000, %eax       # imm = 0x3E800000
               	movapd	%xmm0, %xmm14
               	movapd	%xmm1, %xmm15
               	movq	%rax, %xmm0
               	vfmadd231ss	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	movl	$0x40500000, %eax       # imm = 0x40500000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rdi
               	cvtss2sd	%xmm0, %xmm0
               	movb	$0x1, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0xf, %ebx
               	movl	$0x3f800000, %eax       # imm = 0x3F800000
               	movq	%rax, %xmm14
               	movss	%xmm14, -0x48(%rbp,%riz)
               	leaq	-0x50(%rbp), %rdi
               	leaq	-0x48(%rbp), %rsi
               	movl	$0x4, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	-0x50(%rbp), %eax
               	xorq	$0x3f800000, %rax       # imm = 0x3F800000
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rdi
               	movl	-0x50(%rbp), %esi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x10, %ebx
               	movslq	%ebx, %rax
               	movq	(%rsp), %rbx
               	addq	$0x80, %rsp
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
               	addb	%al, 0x41(%rdx)
