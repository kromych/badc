
float_increment_decrement.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xb0, %rsp
               	movl	$0x3fc00000, %eax       # imm = 0x3FC00000
               	movq	%rax, %xmm14
               	movss	%xmm14, -0x8(%rbp,%riz)
               	movss	-0x8(%rbp,%riz), %xmm0
               	movabsq	$0x3ff0000000000000, %rcx # imm = 0x3FF0000000000000
               	cvtss2sd	%xmm0, %xmm1
               	movq	%rcx, %xmm15
               	addsd	%xmm15, %xmm1
               	cvtsd2ss	%xmm1, %xmm1
               	movss	%xmm1, -0x8(%rbp,%riz)
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movss	-0x8(%rbp,%riz), %xmm0
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
               	movl	$0x1, %eax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3fc00000, %eax       # imm = 0x3FC00000
               	movq	%rax, %xmm14
               	movss	%xmm14, -0x18(%rbp,%riz)
               	movss	-0x18(%rbp,%riz), %xmm0
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	cvtss2sd	%xmm0, %xmm0
               	movq	%rax, %xmm15
               	addsd	%xmm15, %xmm0
               	cvtsd2ss	%xmm0, %xmm0
               	movss	%xmm0, -0x18(%rbp,%riz)
               	movl	$0x40200000, %eax       # imm = 0x40200000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movss	-0x18(%rbp,%riz), %xmm0
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
               	movl	$0x2, %eax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x400a000000000000, %rax # imm = 0x400A000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x28(%rbp,%riz)
               	movsd	-0x28(%rbp,%riz), %xmm0
               	movabsq	$-0x4010000000000000, %rcx # imm = 0xBFF0000000000000
               	movq	%rcx, %xmm15
               	movapd	%xmm0, %xmm1
               	addsd	%xmm15, %xmm1
               	movsd	%xmm1, -0x28(%rbp,%riz)
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movsd	-0x28(%rbp,%riz), %xmm0
               	movabsq	$0x4002000000000000, %rax # imm = 0x4002000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x400a000000000000, %rax # imm = 0x400A000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x38(%rbp,%riz)
               	movsd	-0x38(%rbp,%riz), %xmm0
               	movabsq	$-0x4010000000000000, %rax # imm = 0xBFF0000000000000
               	movq	%rax, %xmm15
               	addsd	%xmm15, %xmm0
               	movsd	%xmm0, -0x38(%rbp,%riz)
               	movabsq	$0x4002000000000000, %rax # imm = 0x4002000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movsd	-0x38(%rbp,%riz), %xmm0
               	movabsq	$0x4002000000000000, %rax # imm = 0x4002000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3f800000, %eax       # imm = 0x3F800000
               	movq	%rax, %xmm14
               	movss	%xmm14, -0x48(%rbp,%riz)
               	leaq	-0x48(%rbp), %rax
               	movss	(%rax,%riz), %xmm0
               	movabsq	$0x3ff0000000000000, %rcx # imm = 0x3FF0000000000000
               	cvtss2sd	%xmm0, %xmm0
               	movq	%rcx, %xmm15
               	addsd	%xmm15, %xmm0
               	cvtsd2ss	%xmm0, %xmm0
               	movss	%xmm0, (%rax,%riz)
               	movss	(%rax,%riz), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movq	%rcx, %xmm15
               	addsd	%xmm15, %xmm0
               	cvtsd2ss	%xmm0, %xmm0
               	movss	%xmm0, (%rax,%riz)
               	movss	-0x48(%rbp,%riz), %xmm0
               	movl	$0x40400000, %eax       # imm = 0x40400000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x60(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x60(%rbp), %rax
               	movss	(%rax,%riz), %xmm0
               	movabsq	$0x3ff0000000000000, %rcx # imm = 0x3FF0000000000000
               	cvtss2sd	%xmm0, %xmm0
               	movq	%rcx, %xmm15
               	addsd	%xmm15, %xmm0
               	cvtsd2ss	%xmm0, %xmm0
               	movss	%xmm0, (%rax,%riz)
               	leaq	-0x60(%rbp), %rax
               	movsd	0x8(%rax,%riz), %xmm0
               	movabsq	$-0x4010000000000000, %rcx # imm = 0xBFF0000000000000
               	movq	%rcx, %xmm15
               	addsd	%xmm15, %xmm0
               	movsd	%xmm0, 0x8(%rax,%riz)
               	leaq	-0x60(%rbp), %rax
               	movss	(%rax,%riz), %xmm0
               	movl	$0x40200000, %eax       # imm = 0x40200000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x60(%rbp), %rax
               	movsd	0x8(%rax,%riz), %xmm0
               	movabsq	$0x3ff8000000000000, %rax # imm = 0x3FF8000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movsd	(%rax,%riz), %xmm0
               	movabsq	$0x3ff0000000000000, %rcx # imm = 0x3FF0000000000000
               	movq	%rcx, %xmm15
               	addsd	%xmm15, %xmm0
               	movsd	%xmm0, (%rax,%riz)
               	movsd	(%rax,%riz), %xmm0
               	movq	%rcx, %xmm15
               	addsd	%xmm15, %xmm0
               	movsd	%xmm0, (%rax,%riz)
               	movsd	(%rax,%riz), %xmm0
               	movabsq	$0x401c000000000000, %rax # imm = 0x401C000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x78(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	movq	0x10(%rcx), %rdx
               	movq	%rdx, 0x10(%rax)
               	popq	%rdx
               	leaq	-0x78(%rbp), %rax
               	movsd	0x8(%rax,%riz), %xmm0
               	movabsq	$0x3ff0000000000000, %rcx # imm = 0x3FF0000000000000
               	movq	%rcx, %xmm15
               	addsd	%xmm15, %xmm0
               	movsd	%xmm0, 0x8(%rax,%riz)
               	leaq	-0x78(%rbp), %rax
               	movsd	0x10(%rax,%riz), %xmm0
               	movabsq	$-0x4010000000000000, %rcx # imm = 0xBFF0000000000000
               	movq	%rcx, %xmm15
               	addsd	%xmm15, %xmm0
               	movsd	%xmm0, 0x10(%rax,%riz)
               	leaq	-0x78(%rbp), %rax
               	movsd	0x8(%rax,%riz), %xmm0
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x78(%rbp), %rax
               	movsd	0x10(%rax,%riz), %xmm0
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x4b800000, %eax       # imm = 0x4B800000
               	movq	%rax, %xmm14
               	movss	%xmm14, -0x80(%rbp,%riz)
               	movss	-0x80(%rbp,%riz), %xmm0
               	movabsq	$0x3ff0000000000000, %rcx # imm = 0x3FF0000000000000
               	cvtss2sd	%xmm0, %xmm0
               	movq	%rcx, %xmm15
               	addsd	%xmm15, %xmm0
               	cvtsd2ss	%xmm0, %xmm0
               	movss	%xmm0, -0x80(%rbp,%riz)
               	movss	-0x80(%rbp,%riz), %xmm0
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
