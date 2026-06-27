
float_condition_negative_zero.x64:	file format elf64-x86-64

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
               	subq	$0x70, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	xorq	%rbx, %rbx
               	movq	%rbx, %xmm14
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm14
               	movsd	%xmm14, 0x18(%rsp)
               	movq	%rbx, %xmm14
               	movsd	%xmm14, -0x10(%rbp,%riz)
               	movsd	0x18(%rsp), %xmm14
               	movq	%rbx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	orq	$0x1, %rbx
               	movsd	-0x10(%rbp,%riz), %xmm0
               	movsd	0x18(%rsp), %xmm15
               	ucomisd	%xmm15, %xmm0
               	sete	%al
               	movzbq	%al, %rax
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	orq	$0x2, %rbx
               	xorq	%r12, %r12
               	xorq	%rax, %rax
               	movsd	0x18(%rsp), %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	incq	%r12
               	movslq	%r12d, %rax
               	cmpq	$0x2, %rax
               	jle	<addr>
               	jmp	<addr>
               	movslq	%r12d, %rax
               	testq	%rax, %rax
               	je	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	orq	$0x4, %rbx
               	xorq	%rax, %rax
               	movsd	0x18(%rsp), %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	orq	$0x8, %rbx
               	xorq	%rax, %rax
               	movsd	0x18(%rsp), %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %ecx
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	movslq	%ecx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	orq	$0x10, %rbx
               	xorq	%rax, %rax
               	movsd	0x18(%rsp), %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%r12b
               	movzbq	%r12b, %r12
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %r12
               	testq	%r12, %r12
               	je	<addr>
               	movl	$0x1, %r12d
               	testq	%r12, %r12
               	je	<addr>
               	orq	$0x20, %rbx
               	xorq	%rax, %rax
               	movsd	0x18(%rsp), %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%r12b
               	movzbq	%r12b, %r12
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %r12
               	testq	%r12, %r12
               	jne	<addr>
               	xorq	%r12, %r12
               	testq	%r12, %r12
               	je	<addr>
               	orq	$0x40, %rbx
               	movslq	%ebx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rdi
               	movslq	%ebx, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x70, %rsp
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
               	addb	%al, 0x41(%rdx)
