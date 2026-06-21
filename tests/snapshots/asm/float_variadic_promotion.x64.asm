
float_variadic_promotion.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<approx>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%r13, (%rsp)
               	movapd	%xmm1, %xmm15
               	movapd	%xmm0, %xmm1
               	subsd	%xmm15, %xmm1
               	xorq	%rax, %rax
               	cvtsi2sd	%rax, %xmm0
               	ucomisd	%xmm0, %xmm1
               	setb	%al
               	movzbq	%al, %rax
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	movabsq	$0x3f50624dd2f1a9fc, %rax # imm = 0x3F50624DD2F1A9FC
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm1
               	setb	%al
               	movzbq	%al, %rax
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>

<vsum>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xf0, %rsp
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
               	movq	%r13, (%rsp)
               	leaq	-0x18(%rbp), %rax
               	leaq	-0xe0(%rbp), %rcx
               	movl	$0x8, (%rax)
               	movl	$0x30, 0x4(%rax)
               	leaq	0x10(%rbp), %r10
               	movq	%r10, 0x8(%rax)
               	leaq	-0xe0(%rbp), %r10
               	movq	%r10, 0x10(%rax)
               	xorq	%rcx, %rcx
               	cvtsi2sd	%rcx, %xmm0
               	movslq	%ecx, %rax
               	movslq	-0xe0(%rbp), %rdx
               	cmpq	%rdx, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rax
               	movq	%rax, %rcx
               	incq	%rcx
               	jmp	<addr>
               	leaq	-0x18(%rbp), %rax
               	movq	%rax, %r13
               	movl	0x4(%r13), %r10d
               	cmpq	$0xb0, %r10
               	jae	<addr>
               	addq	0x10(%r13), %r10
               	addl	$0x10, 0x4(%r13)
               	jmp	<addr>
               	movq	0x8(%r13), %r10
               	addq	$0x8, 0x8(%r13)
               	movq	%r10, %rax
               	movsd	(%rax,%riz), %xmm1
               	addsd	%xmm1, %xmm0
               	jmp	<addr>
               	leaq	-0x18(%rbp), %rax
               	movq	(%rsp), %r13
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r13, 0x8(%rsp)
               	movabsq	$0x405147ae147ae148, %rbx # imm = 0x405147AE147AE148
               	movq	%rbx, %xmm14
               	cvtsd2ss	%xmm14, %xmm14
               	movsd	%xmm14, 0x18(%rsp)
               	movabsq	$0x3ff8000000000000, %rax # imm = 0x3FF8000000000000
               	movq	%rax, %xmm14
               	cvtsd2ss	%xmm14, %xmm14
               	movsd	%xmm14, 0x10(%rsp)
               	movl	$0x1, %edi
               	movsd	0x18(%rsp), %xmm14
               	cvtss2sd	%xmm14, %xmm0
               	movb	$0x1, %al
               	callq	<addr>
               	movq	%rbx, %xmm1
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %edi
               	movabsq	$0x4004000000000000, %rbx # imm = 0x4004000000000000
               	movq	%rbx, %xmm14
               	cvtsd2ss	%xmm14, %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movb	$0x1, %al
               	callq	<addr>
               	movq	%rbx, %xmm1
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2, %edi
               	movsd	0x18(%rsp), %xmm14
               	cvtss2sd	%xmm14, %xmm0
               	movsd	0x10(%rsp), %xmm14
               	cvtss2sd	%xmm14, %xmm1
               	movb	$0x2, %al
               	callq	<addr>
               	movabsq	$0x4051a7ae147ae148, %rdi # imm = 0x4051A7AE147AE148
               	movq	%rdi, %xmm1
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x3, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3, %edi
               	movl	$0xa, %eax
               	cvtsi2sd	%rax, %xmm0
               	movsd	0x18(%rsp), %xmm14
               	cvtss2sd	%xmm14, %xmm1
               	movsd	0x10(%rsp), %xmm14
               	cvtss2sd	%xmm14, %xmm2
               	movb	$0x3, %al
               	callq	<addr>
               	movabsq	$0x405427ae147ae148, %rdi # imm = 0x405427AE147AE148
               	movq	%rdi, %xmm1
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x4, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
