
out_pointer_return_float_args.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3

<mkf5>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x90, %rsp
               	movq	%rdi, -0x90(%rbp)
               	movq	%rsi, -0x80(%rbp)
               	movq	%rdx, -0x70(%rbp)
               	movq	%rcx, -0x60(%rbp)
               	movq	%r8, -0x50(%rbp)
               	movq	%r9, -0x40(%rbp)
               	movq	-0x80(%rbp), %rax
               	movq	%rax, %xmm14
               	cvtsd2ss	%xmm14, %xmm15
               	movss	%xmm15, -0x28(%rbp,%riz)
               	movq	-0x70(%rbp), %rax
               	movq	%rax, %xmm14
               	cvtsd2ss	%xmm14, %xmm15
               	movss	%xmm15, -0x20(%rbp,%riz)
               	movq	-0x60(%rbp), %rax
               	movq	%rax, %xmm14
               	cvtsd2ss	%xmm14, %xmm15
               	movss	%xmm15, -0x18(%rbp,%riz)
               	movq	-0x50(%rbp), %rax
               	movq	%rax, %xmm14
               	cvtsd2ss	%xmm14, %xmm15
               	movss	%xmm15, -0x10(%rbp,%riz)
               	movq	-0x40(%rbp), %rax
               	movq	%rax, %xmm14
               	cvtsd2ss	%xmm14, %xmm15
               	movss	%xmm15, -0x8(%rbp,%riz)
               	movss	-0x28(%rbp,%riz), %xmm0
               	movss	-0x20(%rbp,%riz), %xmm1
               	movss	-0x18(%rbp,%riz), %xmm2
               	movss	-0x10(%rbp,%riz), %xmm3
               	movss	-0x8(%rbp,%riz), %xmm4
               	movq	-0x90(%rbp), %rax
               	movss	%xmm0, (%rax,%riz)
               	movss	%xmm1, 0x4(%rax,%riz)
               	movss	%xmm2, 0x8(%rax,%riz)
               	movss	%xmm3, 0xc(%rax,%riz)
               	movss	%xmm4, 0x10(%rax,%riz)
               	leave
               	retq

<mkd3>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rdi, -0x40(%rbp)
               	movq	%rsi, -0x30(%rbp)
               	movq	%rdx, -0x20(%rbp)
               	movq	%rcx, -0x10(%rbp)
               	movsd	-0x30(%rbp,%riz), %xmm0
               	movsd	-0x20(%rbp,%riz), %xmm1
               	movsd	-0x10(%rbp,%riz), %xmm2
               	movq	-0x40(%rbp), %rax
               	movsd	%xmm0, (%rax,%riz)
               	movsd	%xmm1, 0x8(%rax,%riz)
               	movsd	%xmm2, 0x10(%rax,%riz)
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	movq	%rbx, (%rsp)
               	movl	$0x3f800000, %eax       # imm = 0x3F800000
               	movl	$0x40000000, %ecx       # imm = 0x40000000
               	movl	$0x40400000, %edx       # imm = 0x40400000
               	movl	$0x40800000, %esi       # imm = 0x40800000
               	movq	%rax, %xmm14
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm14
               	jp	<addr>
               	jne	<addr>
               	movq	%rcx, %xmm14
               	movq	%rcx, %xmm15
               	ucomiss	%xmm15, %xmm14
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	%rdx, %xmm14
               	movq	%rdx, %xmm15
               	ucomiss	%xmm15, %xmm14
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	%rsi, %xmm14
               	movq	%rsi, %xmm15
               	ucomiss	%xmm15, %xmm14
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0x30(%rbp), %rdi
               	movl	$0x3fc00000, %ebx       # imm = 0x3FC00000
               	movq	%rbx, %xmm14
               	cvtss2sd	%xmm14, %xmm0
               	movq	%xmm0, %r10
               	movq	%r10, -0x50(%rbp)
               	movl	$0x40200000, %eax       # imm = 0x40200000
               	movq	%rax, %xmm14
               	cvtss2sd	%xmm14, %xmm1
               	movq	%xmm1, %r10
               	movq	%r10, -0x50(%rbp)
               	movl	$0x40600000, %eax       # imm = 0x40600000
               	movq	%rax, %xmm14
               	cvtss2sd	%xmm14, %xmm2
               	movq	%xmm2, %r10
               	movq	%r10, -0x50(%rbp)
               	movl	$0x40900000, %eax       # imm = 0x40900000
               	movq	%rax, %xmm14
               	cvtss2sd	%xmm14, %xmm3
               	movq	%xmm3, %r10
               	movq	%r10, -0x50(%rbp)
               	movl	$0x40b00000, %eax       # imm = 0x40B00000
               	movq	%rax, %xmm14
               	cvtss2sd	%xmm14, %xmm4
               	movq	%xmm4, %r10
               	movq	%r10, -0x50(%rbp)
               	movq	%xmm0, %rsi
               	movq	%xmm1, %rdx
               	movq	%xmm2, %rcx
               	movq	%xmm3, %r8
               	movq	%xmm4, %r9
               	callq	<addr>
               	leaq	-0x30(%rbp), %rcx
               	leaq	-0x48(%rbp), %rax
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	movzbq	0x10(%rcx), %rdx
               	movb	%dl, 0x10(%rax)
               	movzbq	0x11(%rcx), %rdx
               	movb	%dl, 0x11(%rax)
               	movzbq	0x12(%rcx), %rdx
               	movb	%dl, 0x12(%rax)
               	movzbq	0x13(%rcx), %rdx
               	movb	%dl, 0x13(%rax)
               	popq	%rdx
               	movss	(%rax,%riz), %xmm0
               	movq	%rbx, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	0x4(%rax,%riz), %xmm0
               	movl	$0x40200000, %ecx       # imm = 0x40200000
               	movq	%rcx, %xmm15
               	ucomiss	%xmm15, %xmm0
               	setne	%cl
               	movzbq	%cl, %rcx
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movss	0x8(%rax,%riz), %xmm0
               	movl	$0x40600000, %ecx       # imm = 0x40600000
               	movq	%rcx, %xmm15
               	ucomiss	%xmm15, %xmm0
               	setne	%cl
               	movzbq	%cl, %rcx
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movss	0xc(%rax,%riz), %xmm0
               	movl	$0x40900000, %ecx       # imm = 0x40900000
               	movq	%rcx, %xmm15
               	ucomiss	%xmm15, %xmm0
               	setne	%cl
               	movzbq	%cl, %rcx
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movss	0x10(%rax,%riz), %xmm0
               	movl	$0x40b00000, %eax       # imm = 0x40B00000
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
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0x18(%rbp), %rdi
               	movabsq	$0x4024000000000000, %rbx # imm = 0x4024000000000000
               	movabsq	$0x4034000000000000, %rdx # imm = 0x4034000000000000
               	movabsq	$0x403e000000000000, %rcx # imm = 0x403E000000000000
               	movq	%rbx, %rsi
               	callq	<addr>
               	leaq	-0x18(%rbp), %rcx
               	leaq	-0x48(%rbp), %rax
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	movq	0x10(%rcx), %rdx
               	movq	%rdx, 0x10(%rax)
               	popq	%rdx
               	movsd	(%rax,%riz), %xmm0
               	movq	%rbx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movsd	0x8(%rax,%riz), %xmm0
               	movabsq	$0x4034000000000000, %rcx # imm = 0x4034000000000000
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%cl
               	movzbq	%cl, %rcx
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movsd	0x10(%rax,%riz), %xmm0
               	movabsq	$0x403e000000000000, %rax # imm = 0x403E000000000000
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
               	movq	(%rsp), %rbx
               	leave
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	leave
               	retq
