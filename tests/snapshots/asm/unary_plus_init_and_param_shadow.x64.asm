
unary_plus_init_and_param_shadow.x64:	file format elf64-x86-64

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

<f>:
               	movslq	%edi, %rax
               	retq

<main>:
               	leaq	<rip>, %rax
               	movsd	(%rax,%riz), %xmm0
               	movabsq	$0x3fe6666666666666, %rdi # imm = 0x3FE6666666666666
               	movq	%rdi, %xmm1
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	subsd	%xmm1, %xmm0
               	movabsq	$0x3f50624dd2f1a9fc, %rdx # imm = 0x3F50624DD2F1A9FC
               	movq	%rdx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setb	%sil
               	movzbq	%sil, %rsi
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rsi
               	xorq	%rcx, %rcx
               	testq	%rsi, %rsi
               	je	<addr>
               	movq	%rdx, %xmm1
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	ucomisd	%xmm1, %xmm0
               	seta	%sil
               	movzbq	%sil, %rsi
               	movslq	%esi, %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	movl	$0x1, %eax
               	retq
               	movsd	0x8(%rax,%riz), %xmm0
               	movq	%rdi, %xmm15
               	subsd	%xmm15, %xmm0
               	movq	%rdx, %xmm15
               	ucomisd	%xmm0, %xmm15
               	jbe	<addr>
               	movq	%rdx, %xmm1
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	ucomisd	%xmm1, %xmm0
               	seta	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x2, %eax
               	retq
               	movsd	0x10(%rax,%riz), %xmm0
               	movabsq	$0x3ff0000000000000, %rcx # imm = 0x3FF0000000000000
               	movq	%rcx, %xmm15
               	subsd	%xmm15, %xmm0
               	movabsq	$0x3f50624dd2f1a9fc, %rdx # imm = 0x3F50624DD2F1A9FC
               	movq	%rdx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setb	%sil
               	movzbq	%sil, %rsi
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rsi
               	xorq	%rcx, %rcx
               	testq	%rsi, %rsi
               	je	<addr>
               	movq	%rdx, %xmm1
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	ucomisd	%xmm1, %xmm0
               	seta	%sil
               	movzbq	%sil, %rsi
               	movslq	%esi, %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	movl	$0x3, %eax
               	retq
               	movsd	0x18(%rax,%riz), %xmm0
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movq	%rax, %xmm1
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	subsd	%xmm1, %xmm0
               	movq	%rdx, %xmm15
               	ucomisd	%xmm0, %xmm15
               	jbe	<addr>
               	movq	%rdx, %xmm1
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	ucomisd	%xmm1, %xmm0
               	seta	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x4, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x5, %rax
               	movl	$0x1, %eax
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movslq	0x4(%rcx), %rcx
               	cmpq	$-0x3, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x8(%rax), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0xc(%rax), %rax
               	cmpq	$0x7, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	xorq	%rax, %rax
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rcx, %rsi
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rcx, %rsi
               	jmp	<addr>
