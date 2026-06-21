
float_single_precision.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<reciprocal_is_single_precision>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%r13, (%rsp)
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movabsq	$0x4008000000000000, %rcx # imm = 0x4008000000000000
               	movq	%rcx, %xmm15
               	movq	%rax, %xmm0
               	divsd	%xmm15, %xmm0
               	cvtsd2ss	%xmm0, %xmm0
               	movabsq	$0x3fd555555fb67c87, %rax # imm = 0x3FD555555FB67C87
               	movq	%rax, %xmm14
               	cvtsd2ss	%xmm14, %xmm1
               	movapd	%xmm1, %xmm15
               	movapd	%xmm0, %xmm1
               	subss	%xmm15, %xmm1
               	xorq	%rax, %rax
               	cvtsi2sd	%rax, %xmm0
               	cvtsd2ss	%xmm0, %xmm0
               	ucomiss	%xmm0, %xmm1
               	setb	%al
               	movzbq	%al, %rax
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	movabsq	$0x3e7ad7f29abcaf48, %rax # imm = 0x3E7AD7F29ABCAF48
               	cvtss2sd	%xmm1, %xmm0
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	seta	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>

<accumulation_rounds_in_f32>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%r13, (%rsp)
               	xorq	%rcx, %rcx
               	movq	%rcx, %xmm14
               	cvtsd2ss	%xmm14, %xmm0
               	movss	%xmm0, -0x8(%rbp,%riz)
               	movslq	%ecx, %rax
               	cmpq	$0xa, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rax
               	movq	%rax, %rcx
               	incq	%rcx
               	jmp	<addr>
               	leaq	-0x8(%rbp), %rax
               	movss	(%rax,%riz), %xmm0
               	movabsq	$0x3fb999999999999a, %rdx # imm = 0x3FB999999999999A
               	cvtss2sd	%xmm0, %xmm0
               	movq	%rdx, %xmm15
               	addsd	%xmm15, %xmm0
               	cvtsd2ss	%xmm0, %xmm0
               	movss	%xmm0, (%rax,%riz)
               	jmp	<addr>
               	movabsq	$0x3ff000001ad7f29b, %rax # imm = 0x3FF000001AD7F29B
               	movq	%rax, %xmm14
               	cvtsd2ss	%xmm14, %xmm0
               	movss	-0x8(%rbp,%riz), %xmm1
               	subss	%xmm0, %xmm1
               	xorq	%rax, %rax
               	cvtsi2sd	%rax, %xmm0
               	cvtsd2ss	%xmm0, %xmm0
               	ucomiss	%xmm0, %xmm1
               	setb	%al
               	movzbq	%al, %rax
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	movabsq	$0x3eb0c6f7a0b5ed8d, %rax # imm = 0x3EB0C6F7A0B5ED8D
               	cvtss2sd	%xmm1, %xmm0
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	seta	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movss	-0x8(%rbp,%riz), %xmm0
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	cvtss2sd	%xmm0, %xmm0
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	sete	%al
               	movzbq	%al, %rax
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>

<chained_mul_is_single_precision>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%r13, (%rsp)
               	movabsq	$0x3ff199999999999a, %rax # imm = 0x3FF199999999999A
               	movq	%rax, %xmm14
               	cvtsd2ss	%xmm14, %xmm0
               	movapd	%xmm0, %xmm1
               	mulss	%xmm0, %xmm1
               	mulss	%xmm0, %xmm1
               	movapd	%xmm0, %xmm15
               	movapd	%xmm1, %xmm0
               	mulss	%xmm15, %xmm0
               	movabsq	$0x3ff76cf439f92012, %rax # imm = 0x3FF76CF439F92012
               	cvtss2sd	%xmm0, %xmm0
               	movq	%rax, %xmm15
               	subsd	%xmm15, %xmm0
               	cvtsd2ss	%xmm0, %xmm1
               	xorq	%rax, %rax
               	cvtsi2sd	%rax, %xmm0
               	cvtsd2ss	%xmm0, %xmm0
               	ucomiss	%xmm0, %xmm1
               	setb	%al
               	movzbq	%al, %rax
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	movabsq	$0x3ee4f8b588e368f1, %rax # imm = 0x3EE4F8B588E368F1
               	cvtss2sd	%xmm1, %xmm0
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	seta	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%r13, (%rsp)
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
