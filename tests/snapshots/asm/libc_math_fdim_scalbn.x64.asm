
libc_math_fdim_scalbn.x64:	file format elf64-x86-64

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

<scalbn>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movslq	%edi, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	popq	%rbp
               	retq

<scalbln>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x4, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	popq	%rbp
               	retq

<scalbnf>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x2, %edi
               	cvtss2sd	%xmm0, %xmm0
               	xorl	%eax, %eax
               	callq	<addr>
               	cvtsd2ss	%xmm0, %xmm0
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movabsq	$0x4014000000000000, %rcx # imm = 0x4014000000000000
               	movabsq	$0x4008000000000000, %rax # imm = 0x4008000000000000
               	movq	%rcx, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	movl	$0x1, %edx
               	ja	<addr>
               	movq	%rcx, %xmm14
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%sil
               	movzbq	%sil, %rsi
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	movq	%rax, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%sil
               	movzbq	%sil, %rsi
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movq	%rax, %xmm15
               	movq	%rcx, %xmm0
               	subsd	%xmm15, %xmm0
               	movsd	%xmm0, -0x8(%rbp,%riz)
               	movsd	-0x8(%rbp,%riz), %xmm0
               	movabsq	$0x4000000000000000, %rsi # imm = 0x4000000000000000
               	movq	%rsi, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movq	%rax, %xmm14
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	ja	<addr>
               	movq	%rax, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%dl
               	movzbq	%dl, %rdx
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movq	%rcx, %xmm14
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%dl
               	movzbq	%dl, %rdx
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	%rcx, %xmm15
               	movq	%rax, %xmm0
               	subsd	%xmm15, %xmm0
               	movsd	%xmm0, -0x8(%rbp,%riz)
               	movsd	-0x8(%rbp,%riz), %xmm0
               	xorq	%r12, %r12
               	movq	%r12, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movq	%rax, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	movl	$0x1, %ebx
               	ja	<addr>
               	movq	%rax, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%cl
               	movzbq	%cl, %rcx
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	%rax, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%cl
               	movzbq	%cl, %rcx
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	%rax, %xmm15
               	movq	%rax, %xmm0
               	subsd	%xmm15, %xmm0
               	movsd	%xmm0, -0x8(%rbp,%riz)
               	movsd	-0x8(%rbp,%riz), %xmm0
               	movq	%r12, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x3ff0000000000000, %r13 # imm = 0x3FF0000000000000
               	movl	$0x3, %esi
               	movq	%r13, %xmm0
               	movq	%rsi, %rdi
               	callq	<addr>
               	movabsq	$0x4020000000000000, %rax # imm = 0x4020000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x4008000000000000, %rdi # imm = 0x4008000000000000
               	movabsq	$-0x1, %rsi
               	movq	%rdi, %xmm0
               	movq	%rsi, %rdi
               	callq	<addr>
               	movabsq	$0x3ff8000000000000, %rax # imm = 0x3FF8000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movl	$0x4, %esi
               	movq	%r13, %xmm0
               	movq	%rsi, %rdi
               	callq	<addr>
               	movabsq	$0x4030000000000000, %rax # imm = 0x4030000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3f800000, %edi       # imm = 0x3F800000
               	movl	$0x2, %esi
               	movq	%rdi, %xmm0
               	movq	%rsi, %rdi
               	callq	<addr>
               	movl	$0x40800000, %eax       # imm = 0x40800000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movl	$0x40a00000, %eax       # imm = 0x40A00000
               	movl	$0x40400000, %ecx       # imm = 0x40400000
               	movq	%rax, %xmm14
               	cvtss2sd	%xmm14, %xmm0
               	movq	%rcx, %xmm14
               	cvtss2sd	%xmm14, %xmm1
               	ucomisd	%xmm1, %xmm0
               	ja	<addr>
               	ucomisd	%xmm0, %xmm0
               	setne	%bl
               	movzbq	%bl, %rbx
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rbx
               	testq	%rbx, %rbx
               	jne	<addr>
               	ucomisd	%xmm1, %xmm1
               	setne	%bl
               	movzbq	%bl, %rbx
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rbx
               	testq	%rbx, %rbx
               	je	<addr>
               	subsd	%xmm1, %xmm0
               	movsd	%xmm0, -0x8(%rbp,%riz)
               	movsd	-0x8(%rbp,%riz), %xmm0
               	cvtsd2ss	%xmm0, %xmm0
               	movl	$0x40000000, %eax       # imm = 0x40000000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x8, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movq	%r12, %xmm14
               	movsd	%xmm14, -0x8(%rbp,%riz)
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	%r12, %xmm14
               	movsd	%xmm14, -0x8(%rbp,%riz)
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rbx, %rcx
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	movq	%rcx, %xmm14
               	movsd	%xmm14, -0x8(%rbp,%riz)
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	xorq	%rsi, %rsi
               	movq	%rsi, %xmm14
               	movsd	%xmm14, -0x8(%rbp,%riz)
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rdx, %rsi
               	jmp	<addr>
