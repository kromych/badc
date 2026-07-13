
math_classify.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<fpclassify>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	leaq	-0x8(%rbp), %rax
               	movsd	%xmm0, (%rax,%riz)
               	leaq	-0x8(%rbp), %rax
               	movq	(%rax), %rax
               	shrq	$0x34, %rax
               	andq	$0x7ff, %rax            # imm = 0x7FF
               	leaq	-0x8(%rbp), %rcx
               	movq	(%rcx), %rcx
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rcx
               	testq	%rax, %rax
               	jne	<addr>
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x2, %eax
               	movslq	%eax, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3, %eax
               	jmp	<addr>
               	cmpq	$0x7ff, %rax            # imm = 0x7FF
               	jne	<addr>
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x1, %eax
               	movslq	%eax, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	jmp	<addr>
               	movl	$0x4, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq

<isnan>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	callq	<addr>
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	popq	%rbp
               	retq

<isinf>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	callq	<addr>
               	cmpq	$0x1, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	popq	%rbp
               	retq

<isfinite>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	callq	<addr>
               	cmpq	$0x2, %rax
               	setge	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	popq	%rbp
               	retq

<signbit>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x8(%rbp), %rax
               	movsd	%xmm0, (%rax,%riz)
               	leaq	-0x8(%rbp), %rax
               	movq	(%rax), %rax
               	shrq	$0x3f, %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	xorq	%rax, %rax
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rbp,%riz)
               	movsd	-0x8(%rbp,%riz), %xmm0
               	movapd	%xmm0, %xmm14
               	divsd	%xmm0, %xmm14
               	movsd	%xmm14, 0x18(%rsp)
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movq	%rax, %xmm14
               	divsd	%xmm0, %xmm14
               	movsd	%xmm14, 0x10(%rsp)
               	movq	%rax, %xmm1
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	movapd	%xmm1, %xmm14
               	divsd	%xmm0, %xmm14
               	movsd	%xmm14, 0x8(%rsp)
               	movsd	0x18(%rsp), %xmm0
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x3ff8000000000000, %rdi # imm = 0x3FF8000000000000
               	movq	%rdi, %xmm0
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movsd	0x10(%rsp), %xmm0
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movsd	0x10(%rsp), %xmm0
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x4, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movsd	0x8(%rsp), %xmm0
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x5, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x3ff8000000000000, %rdi # imm = 0x3FF8000000000000
               	movq	%rdi, %xmm0
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movsd	0x18(%rsp), %xmm0
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x3ff8000000000000, %rdi # imm = 0x3FF8000000000000
               	movq	%rdi, %xmm0
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x8, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	xorq	%rdi, %rdi
               	movq	%rdi, %xmm0
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x9, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movsd	0x10(%rsp), %xmm0
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movsd	0x18(%rsp), %xmm0
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movsd	0x18(%rsp), %xmm0
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movsd	0x10(%rsp), %xmm0
               	callq	<addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x3ff8000000000000, %rdi # imm = 0x3FF8000000000000
               	movq	%rdi, %xmm0
               	callq	<addr>
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movsd	0x8(%rsp), %xmm0
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xf, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x3ff8000000000000, %rdi # imm = 0x3FF8000000000000
               	movq	%rdi, %xmm0
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
