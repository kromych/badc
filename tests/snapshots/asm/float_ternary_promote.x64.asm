
float_ternary_promote.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<sel>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movslq	%edi, %rdi
               	movapd	%xmm0, %xmm2
               	testq	%rdi, %rdi
               	je	<addr>
               	jmp	<addr>
               	movapd	%xmm1, %xmm2
               	movapd	%xmm2, %xmm0
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	movq	%rbx, (%rsp)
               	movl	$0x1, %edi
               	movl	$0x3fc00000, %ebx       # imm = 0x3FC00000
               	movl	$0x40200000, %eax       # imm = 0x40200000
               	movq	%rax, %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movapd	%xmm0, %xmm1
               	movq	%rbx, %xmm0
               	callq	<addr>
               	movq	%rbx, %xmm15
               	ucomiss	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	xorq	%rdi, %rdi
               	movl	$0x3fc00000, %esi       # imm = 0x3FC00000
               	movl	$0x40200000, %eax       # imm = 0x40200000
               	movq	%rax, %xmm14
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm14
               	movsd	%xmm14, 0x18(%rsp)
               	movq	%rsi, %xmm0
               	movsd	0x18(%rsp), %xmm1
               	callq	<addr>
               	movsd	0x18(%rsp), %xmm15
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
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movl	$0x40500000, %eax       # imm = 0x40500000
               	movq	%rax, %xmm14
               	movss	%xmm14, -0x8(%rbp,%riz)
               	movss	-0x8(%rbp,%riz), %xmm0
               	xorq	%rax, %rax
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	seta	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movss	-0x8(%rbp,%riz), %xmm0
               	jmp	<addr>
               	movss	-0x8(%rbp,%riz), %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movss	-0x8(%rbp,%riz), %xmm1
               	xorq	%rax, %rax
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm1
               	setb	%al
               	movzbq	%al, %rax
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movss	-0x8(%rbp,%riz), %xmm1
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	jmp	<addr>
               	movss	-0x8(%rbp,%riz), %xmm1
               	addss	%xmm1, %xmm0
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
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	xorq	%rax, %rax
               	movq	%rax, %xmm14
               	movss	%xmm14, -0x38(%rbp,%riz)
               	jmp	<addr>
               	cmpq	$0x1, %rax
               	jne	<addr>
               	jmp	<addr>
               	movss	-0x38(%rbp,%riz), %xmm0
               	movl	$0x41a00000, %eax       # imm = 0x41A00000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	jmp	<addr>
               	movl	$0x41200000, %eax       # imm = 0x41200000
               	movq	%rax, %xmm14
               	movss	%xmm14, -0x40(%rbp,%riz)
               	jmp	<addr>
               	movl	$0x41a00000, %eax       # imm = 0x41A00000
               	movq	%rax, %xmm14
               	movss	%xmm14, -0x40(%rbp,%riz)
               	movss	-0x40(%rbp,%riz), %xmm0
               	movss	%xmm0, -0x38(%rbp,%riz)
               	jmp	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
