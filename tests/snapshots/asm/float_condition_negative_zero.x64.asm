
float_condition_negative_zero.x64:	file format elf64-x86-64

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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	xorq	%rdx, %rdx
               	movq	%rdx, %xmm0
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movq	%rdx, %xmm14
               	movsd	%xmm14, -0x10(%rbp,%riz)
               	movq	%rdx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x1, %ecx
               	movsd	-0x10(%rbp,%riz), %xmm1
               	ucomisd	%xmm0, %xmm1
               	jp	<addr>
               	je	<addr>
               	orq	$0x2, %rcx
               	movq	%rdx, %rax
               	jmp	<addr>
               	incq	%rax
               	cmpl	$0x2, %eax
               	jg	<addr>
               	movq	%rdx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	orq	$0x4, %rcx
               	xorq	%rax, %rax
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	orq	$0x8, %rcx
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x1, %edx
               	movslq	%edx, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	orq	$0x10, %rcx
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%dl
               	movzbq	%dl, %rdx
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x1, %esi
               	testq	%rsi, %rsi
               	je	<addr>
               	orq	$0x20, %rcx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movq	%rax, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	orq	$0x40, %rcx
               	movslq	%ecx, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	xorq	%rax, %rax
               	leave
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rdx, %rsi
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rax, %rdx
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rdx, %rcx
               	jmp	<addr>
