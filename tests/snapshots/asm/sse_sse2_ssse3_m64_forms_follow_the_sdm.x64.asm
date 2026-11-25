
sse_sse2_ssse3_m64_forms_follow_the_sdm.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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

<rnd>:
               	movq	<rip>, %rcx # <addr>
               	movq	%rcx, %rax
               	shrq	$0xc, %rax
               	xorq	%rax, %rcx
               	movq	%rcx, %rax
               	shlq	$0x19, %rax
               	xorq	%rax, %rcx
               	movq	%rcx, %rax
               	shrq	$0x1b, %rax
               	xorq	%rax, %rcx
               	movabsq	$0x2545f4914f6cdd1d, %rax # imm = 0x2545F4914F6CDD1D
               	imulq	%rcx, %rax
               	movq	%rcx, %rdx
               	shrq	$0xc, %rdx
               	xorq	%rdx, %rcx
               	movq	%rcx, %rdx
               	shlq	$0x19, %rdx
               	xorq	%rdx, %rcx
               	movq	%rcx, %rdx
               	shrq	$0x1b, %rdx
               	xorq	%rdx, %rcx
               	movq	%rcx, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %rdi # imm = 0x2545F4914F6CDD1D
               	imulq	%rcx, %rdi
               	xorl	%ecx, %ecx
               	leaq	<rip>, %r8 # <addr>
               	jmp	<addr>
               	incq	%rcx
               	cmpl	$0x8, %ecx
               	jge	<addr>
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	shrxq	%rdx, %rdi, %rsi
               	testb	$0x3, %sil
               	jne	<addr>
               	movl	$0xff, %esi
               	shlxq	%rdx, %rsi, %rsi
               	xorq	$-0x1, %rsi
               	andq	%rax, %rsi
               	leaq	0x2(%rdx), %rax
               	shrxq	%rax, %rdi, %rax
               	andq	$0x3, %rax
               	movzbq	(%r8,%rax), %rax
               	shlxq	%rdx, %rax, %rax
               	orq	%rsi, %rax
               	jmp	<addr>
               	retq

<ref_shuffle_pi16>:
               	movslq	%esi, %rsi
               	movq	%rsi, %rax
               	andq	$0x3, %rax
               	shlq	$0x4, %rax
               	shrxq	%rax, %rdi, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movq	%rsi, %rcx
               	sarq	$0x2, %rcx
               	andq	$0x3, %rcx
               	shlq	$0x4, %rcx
               	shrxq	%rcx, %rdi, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	shlq	$0x10, %rcx
               	orq	%rcx, %rax
               	movq	%rsi, %rcx
               	sarq	$0x4, %rcx
               	andq	$0x3, %rcx
               	shlq	$0x4, %rcx
               	shrxq	%rcx, %rdi, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	shlq	$0x20, %rcx
               	orq	%rcx, %rax
               	sarq	$0x6, %rsi
               	andq	$0x3, %rsi
               	shlq	$0x4, %rsi
               	shrxq	%rsi, %rdi, %rcx
               	shlq	$0x30, %rcx
               	orq	%rcx, %rax
               	retq

<sse_lanes>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	xorl	%r13d, %r13d
               	movsd	%xmm0, 0x28(%rsp)
               	movsd	%xmm1, 0x20(%rsp)
               	callq	<addr>
               	movq	%rax, %rbx
               	movsd	0x28(%rsp), %xmm0
               	movsd	0x20(%rsp), %xmm1
               	movsd	%xmm0, 0x28(%rsp)
               	movsd	%xmm1, 0x20(%rsp)
               	callq	<addr>
               	movq	%rax, %r12
               	movsd	0x28(%rsp), %xmm0
               	movsd	0x20(%rsp), %xmm1
               	movq	%rbx, %rax
               	andq	$0xff, %rax
               	movq	%r12, %rcx
               	andq	$0xff, %rcx
               	addq	%rcx, %rax
               	incq	%rax
               	shrq	%rax
               	movq	%rbx, %rcx
               	shrq	$0x8, %rcx
               	andq	$0xff, %rcx
               	movq	%r12, %rdx
               	shrq	$0x8, %rdx
               	andq	$0xff, %rdx
               	addq	%rdx, %rcx
               	incq	%rcx
               	shrq	%rcx
               	shlq	$0x8, %rcx
               	orq	%rcx, %rax
               	movq	%rbx, %rcx
               	shrq	$0x10, %rcx
               	andq	$0xff, %rcx
               	movq	%r12, %rdx
               	shrq	$0x10, %rdx
               	andq	$0xff, %rdx
               	addq	%rdx, %rcx
               	incq	%rcx
               	shrq	%rcx
               	shlq	$0x10, %rcx
               	orq	%rcx, %rax
               	movq	%rbx, %rcx
               	shrq	$0x18, %rcx
               	andq	$0xff, %rcx
               	movq	%r12, %rdx
               	shrq	$0x18, %rdx
               	andq	$0xff, %rdx
               	addq	%rdx, %rcx
               	incq	%rcx
               	shrq	%rcx
               	shlq	$0x18, %rcx
               	orq	%rcx, %rax
               	movq	%rbx, %rdx
               	shrq	$0x20, %rdx
               	movq	%rdx, %rcx
               	andq	$0xff, %rcx
               	movq	%r12, %rsi
               	shrq	$0x20, %rsi
               	movq	%rsi, %rdi
               	andq	$0xff, %rdi
               	addq	%rdi, %rcx
               	incq	%rcx
               	shrq	%rcx
               	shlq	$0x20, %rcx
               	orq	%rcx, %rax
               	movq	%rbx, %rcx
               	shrq	$0x28, %rcx
               	andq	$0xff, %rcx
               	movq	%r12, %rdi
               	shrq	$0x28, %rdi
               	andq	$0xff, %rdi
               	addq	%rdi, %rcx
               	incq	%rcx
               	shrq	%rcx
               	shlq	$0x28, %rcx
               	orq	%rcx, %rax
               	movq	%rbx, %rdi
               	shrq	$0x30, %rdi
               	movq	%rdi, %rcx
               	andq	$0xff, %rcx
               	movq	%r12, %r8
               	shrq	$0x30, %r8
               	movq	%r8, %r9
               	andq	$0xff, %r9
               	addq	%r9, %rcx
               	incq	%rcx
               	shrq	%rcx
               	shlq	$0x30, %rcx
               	orq	%rcx, %rax
               	movq	%rbx, %rcx
               	shrq	$0x38, %rcx
               	movq	%r12, %r9
               	shrq	$0x38, %r9
               	addq	%r9, %rcx
               	incq	%rcx
               	shrq	%rcx
               	shlq	$0x38, %rcx
               	orq	%rcx, %rax
               	movq	%rbx, %xmm2
               	movq	%r12, %xmm3
               	vpavgb	%xmm3, %xmm2, %xmm4
               	vmovq	%xmm4, %rcx
               	cmpq	%rax, %rcx
               	jne	<addr>
               	vpavgb	%xmm3, %xmm2, %xmm4
               	vmovq	%xmm4, %rcx
               	cmpq	%rax, %rcx
               	jne	<addr>
               	movq	%rbx, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movq	%r12, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	addq	%rcx, %rax
               	incq	%rax
               	shrq	%rax
               	movq	%rbx, %rcx
               	shrq	$0x10, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	movq	%r12, %r9
               	shrq	$0x10, %r9
               	andq	$0xffff, %r9            # imm = 0xFFFF
               	addq	%r9, %rcx
               	incq	%rcx
               	shrq	%rcx
               	shlq	$0x10, %rcx
               	orq	%rcx, %rax
               	movq	%rdx, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	movq	%rsi, %rdx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	addq	%rdx, %rcx
               	incq	%rcx
               	shrq	%rcx
               	shlq	$0x20, %rcx
               	orq	%rcx, %rax
               	leaq	(%rdi,%r8), %rcx
               	incq	%rcx
               	shrq	%rcx
               	shlq	$0x30, %rcx
               	orq	%rcx, %rax
               	vpavgw	%xmm3, %xmm2, %xmm4
               	vmovq	%xmm4, %rcx
               	cmpq	%rax, %rcx
               	jne	<addr>
               	vpavgw	%xmm3, %xmm2, %xmm2
               	vmovq	%xmm2, %rcx
               	cmpq	%rax, %rcx
               	jne	<addr>
               	xorl	%eax, %eax
               	movq	%rax, %rdi
               	movq	%rax, %r8
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	shrxq	%rcx, %rbx, %rdx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	movq	%rdx, %rsi
               	shrq	$0xf, %rsi
               	leaq	-0x10000(%rdx), %r9
               	testq	%rsi, %rsi
               	cmovneq	%r9, %rdx
               	shrxq	%rcx, %r12, %rsi
               	andq	$0xffff, %rsi           # imm = 0xFFFF
               	movq	%rsi, %r9
               	shrq	$0xf, %r9
               	leaq	-0x10000(%rsi), %r10
               	testq	%r9, %r9
               	cmovneq	%r10, %rsi
               	cmpl	%esi, %edx
               	movq	%rsi, %r9
               	cmovgq	%rdx, %r9
               	andq	$0xffff, %r9            # imm = 0xFFFF
               	shlxq	%rcx, %r9, %r9
               	orq	%r9, %r8
               	cmpl	%esi, %edx
               	cmovgeq	%rsi, %rdx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	shlxq	%rcx, %rdx, %rcx
               	orq	%rcx, %rdi
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rbx, %xmm2
               	movq	%r12, %xmm3
               	vpmaxsw	%xmm3, %xmm2, %xmm4
               	vmovq	%xmm4, %rax
               	cmpq	%r8, %rax
               	jne	<addr>
               	vpmaxsw	%xmm3, %xmm2, %xmm4
               	vmovq	%xmm4, %rax
               	nop
               	cmpq	%r8, %rax
               	jne	<addr>
               	vpminsw	%xmm3, %xmm2, %xmm4
               	vmovq	%xmm4, %rax
               	cmpq	%rdi, %rax
               	jne	<addr>
               	vpminsw	%xmm3, %xmm2, %xmm2
               	vmovq	%xmm2, %rax
               	cmpq	%rdi, %rax
               	jne	<addr>
               	xorl	%eax, %eax
               	movq	%rax, %rdi
               	movq	%rax, %r8
               	movq	%rax, %rsi
               	shlq	$0x3, %rsi
               	shrxq	%rsi, %rbx, %rcx
               	andq	$0xff, %rcx
               	shrxq	%rsi, %r12, %rdx
               	andq	$0xff, %rdx
               	cmpl	%edx, %ecx
               	movq	%rdx, %r9
               	cmovaq	%rcx, %r9
               	shlxq	%rsi, %r9, %r9
               	orq	%r9, %r8
               	cmpl	%edx, %ecx
               	cmovaeq	%rdx, %rcx
               	shlxq	%rsi, %rcx, %rcx
               	orq	%rcx, %rdi
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movq	%rbx, %xmm2
               	movq	%r12, %xmm3
               	vpmaxub	%xmm3, %xmm2, %xmm4
               	vmovq	%xmm4, %rax
               	cmpq	%r8, %rax
               	jne	<addr>
               	vpmaxub	%xmm3, %xmm2, %xmm4
               	vmovq	%xmm4, %rax
               	cmpq	%r8, %rax
               	jne	<addr>
               	vpminub	%xmm3, %xmm2, %xmm4
               	vmovq	%xmm4, %rax
               	cmpq	%rdi, %rax
               	jne	<addr>
               	vpminub	%xmm3, %xmm2, %xmm2
               	vmovq	%xmm2, %rax
               	cmpq	%rdi, %rax
               	jne	<addr>
               	xorl	%eax, %eax
               	vpinsrd	$0x0, %eax, %xmm1, %xmm1
               	jmp	<addr>
               	vmovd	%xmm1, %ecx
               	movslq	%ecx, %rcx
               	shlq	$0x3, %rcx
               	movslq	%ecx, %rcx
               	shrxq	%rcx, %rbx, %rcx
               	andq	$0xff, %rcx
               	shrq	$0x7, %rcx
               	vmovd	%xmm1, %edx
               	movslq	%edx, %rdx
               	shlxq	%rdx, %rcx, %rcx
               	orq	%rcx, %rax
               	vmovd	%xmm1, %ecx
               	movslq	%ecx, %rcx
               	incq	%rcx
               	vpinsrd	$0x0, %ecx, %xmm1, %xmm1
               	vmovd	%xmm1, %ecx
               	movslq	%ecx, %rcx
               	nopl	(%rax,%rax)
               	cmpq	$0x8, %rcx
               	jl	<addr>
               	vmovq	%rbx, %xmm2
               	xorl	%ecx, %ecx
               	pmovmskb	%xmm2, %edx
               	cmpl	%eax, %edx
               	jne	<addr>
               	vmovq	%rbx, %xmm2
               	pmovmskb	%xmm2, %edx
               	cmpl	%eax, %edx
               	jne	<addr>
               	movq	%rbx, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movq	%r12, %rdx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	imulq	%rdx, %rax
               	shrq	$0x10, %rax
               	movq	%rbx, %rdx
               	shrq	$0x10, %rdx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	movq	%r12, %rsi
               	shrq	$0x10, %rsi
               	andq	$0xffff, %rsi           # imm = 0xFFFF
               	imulq	%rsi, %rdx
               	shrq	$0x10, %rdx
               	shlq	$0x10, %rdx
               	orq	%rdx, %rax
               	movq	%rbx, %rdx
               	shrq	$0x20, %rdx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	movq	%r12, %rsi
               	shrq	$0x20, %rsi
               	andq	$0xffff, %rsi           # imm = 0xFFFF
               	imulq	%rsi, %rdx
               	shrq	$0x10, %rdx
               	shlq	$0x20, %rdx
               	orq	%rdx, %rax
               	movq	%rbx, %rdx
               	shrq	$0x30, %rdx
               	movq	%r12, %rsi
               	shrq	$0x30, %rsi
               	imulq	%rsi, %rdx
               	shrq	$0x10, %rdx
               	shlq	$0x30, %rdx
               	orq	%rdx, %rax
               	movq	%rbx, %xmm2
               	movq	%r12, %xmm3
               	vpmulhuw	%xmm3, %xmm2, %xmm4
               	vmovq	%xmm4, %rdx
               	cmpq	%rax, %rdx
               	jne	<addr>
               	vpmulhuw	%xmm3, %xmm2, %xmm2
               	vmovq	%xmm2, %rdx
               	nopl	(%rax)
               	cmpq	%rax, %rdx
               	jne	<addr>
               	vpinsrd	$0x0, %ecx, %xmm0, %xmm0
               	jmp	<addr>
               	vmovd	%xmm0, %eax
               	movslq	%eax, %rax
               	shlq	$0x3, %rax
               	movslq	%eax, %rax
               	shrxq	%rax, %rbx, %rax
               	andq	$0xff, %rax
               	vmovd	%xmm0, %edx
               	movslq	%edx, %rdx
               	shlq	$0x3, %rdx
               	movslq	%edx, %rdx
               	shrxq	%rdx, %r12, %rdx
               	andq	$0xff, %rdx
               	subq	%rdx, %rax
               	movq	%rax, %rdx
               	negq	%rdx
               	testl	%eax, %eax
               	cmovlq	%rdx, %rax
               	addq	%rax, %rcx
               	vmovd	%xmm0, %eax
               	movslq	%eax, %rax
               	incq	%rax
               	vpinsrd	$0x0, %eax, %xmm0, %xmm0
               	vmovd	%xmm0, %eax
               	movslq	%eax, %rax
               	cmpq	$0x8, %rax
               	jl	<addr>
               	movq	%rbx, %xmm2
               	movq	%r12, %xmm3
               	vpsadbw	%xmm3, %xmm2, %xmm4
               	vmovq	%xmm4, %rax
               	cmpq	%rcx, %rax
               	jne	<addr>
               	vpsadbw	%xmm3, %xmm2, %xmm2
               	vmovq	%xmm2, %rax
               	nopl	(%rax,%rax)
               	cmpq	%rcx, %rax
               	jne	<addr>
               	vmovq	%rbx, %xmm2
               	xorl	%esi, %esi
               	pshuflw	$0x0, %xmm2, %xmm2      # xmm2 = xmm2[0,0,0,0,4,5,6,7]
               	vmovq	%xmm2, %r14
               	movsd	%xmm1, 0x20(%rsp)
               	movsd	%xmm0, 0x28(%rsp)
               	movq	%rbx, %rdi
               	callq	<addr>
               	movsd	0x20(%rsp), %xmm1
               	movsd	0x28(%rsp), %xmm0
               	nopw	(%rax,%rax)
               	cmpq	%rax, %r14
               	jne	<addr>
               	vmovq	%rbx, %xmm2
               	xorl	%esi, %esi
               	pshuflw	$0x0, %xmm2, %xmm2      # xmm2 = xmm2[0,0,0,0,4,5,6,7]
               	vmovq	%xmm2, %r14
               	movsd	%xmm1, 0x20(%rsp)
               	movsd	%xmm0, 0x28(%rsp)
               	movq	%rbx, %rdi
               	callq	<addr>
               	movsd	0x20(%rsp), %xmm1
               	movsd	0x28(%rsp), %xmm0
               	nopw	(%rax,%rax)
               	cmpq	%rax, %r14
               	jne	<addr>
               	vmovq	%rbx, %xmm2
               	pshuflw	$0x1b, %xmm2, %xmm2     # xmm2 = xmm2[3,2,1,0,4,5,6,7]
               	vmovq	%xmm2, %r14
               	movl	$0x1b, %esi
               	movsd	%xmm1, 0x20(%rsp)
               	movsd	%xmm0, 0x28(%rsp)
               	movq	%rbx, %rdi
               	callq	<addr>
               	movsd	0x20(%rsp), %xmm1
               	movsd	0x28(%rsp), %xmm0
               	nopl	(%rax)
               	cmpq	%rax, %r14
               	jne	<addr>
               	vmovq	%rbx, %xmm2
               	pshuflw	$0x1b, %xmm2, %xmm2     # xmm2 = xmm2[3,2,1,0,4,5,6,7]
               	vmovq	%xmm2, %r14
               	movl	$0x1b, %esi
               	movsd	%xmm1, 0x20(%rsp)
               	movsd	%xmm0, 0x28(%rsp)
               	movq	%rbx, %rdi
               	callq	<addr>
               	movsd	0x20(%rsp), %xmm1
               	movsd	0x28(%rsp), %xmm0
               	nopl	(%rax)
               	cmpq	%rax, %r14
               	jne	<addr>
               	vmovq	%rbx, %xmm2
               	pshuflw	$0x4e, %xmm2, %xmm2     # xmm2 = xmm2[2,3,0,1,4,5,6,7]
               	vmovq	%xmm2, %r14
               	movl	$0x4e, %esi
               	movsd	%xmm1, 0x20(%rsp)
               	movsd	%xmm0, 0x28(%rsp)
               	movq	%rbx, %rdi
               	callq	<addr>
               	movsd	0x20(%rsp), %xmm1
               	movsd	0x28(%rsp), %xmm0
               	nopl	(%rax)
               	cmpq	%rax, %r14
               	jne	<addr>
               	vmovq	%rbx, %xmm2
               	pshuflw	$0x4e, %xmm2, %xmm2     # xmm2 = xmm2[2,3,0,1,4,5,6,7]
               	vmovq	%xmm2, %r14
               	movl	$0x4e, %esi
               	movsd	%xmm1, 0x20(%rsp)
               	movsd	%xmm0, 0x28(%rsp)
               	movq	%rbx, %rdi
               	callq	<addr>
               	movsd	0x20(%rsp), %xmm1
               	movsd	0x28(%rsp), %xmm0
               	nopl	(%rax)
               	cmpq	%rax, %r14
               	jne	<addr>
               	vmovq	%rbx, %xmm2
               	pshuflw	$0x93, %xmm2, %xmm2     # xmm2 = xmm2[3,0,1,2,4,5,6,7]
               	vmovq	%xmm2, %r14
               	movl	$0x93, %esi
               	movsd	%xmm1, 0x20(%rsp)
               	movsd	%xmm0, 0x28(%rsp)
               	movq	%rbx, %rdi
               	callq	<addr>
               	movsd	0x20(%rsp), %xmm1
               	movsd	0x28(%rsp), %xmm0
               	nopl	(%rax)
               	cmpq	%rax, %r14
               	jne	<addr>
               	vmovq	%rbx, %xmm2
               	pshuflw	$0x93, %xmm2, %xmm2     # xmm2 = xmm2[3,0,1,2,4,5,6,7]
               	vmovq	%xmm2, %r14
               	movl	$0x93, %esi
               	movsd	%xmm1, 0x20(%rsp)
               	movsd	%xmm0, 0x28(%rsp)
               	movq	%rbx, %rdi
               	callq	<addr>
               	movsd	0x20(%rsp), %xmm1
               	movsd	0x28(%rsp), %xmm0
               	nopl	(%rax)
               	cmpq	%rax, %r14
               	jne	<addr>
               	vmovq	%rbx, %xmm2
               	pshuflw	$0xe4, %xmm2, %xmm2     # xmm2 = xmm2[0,1,2,3,4,5,6,7]
               	vmovq	%xmm2, %r14
               	movl	$0xe4, %esi
               	movsd	%xmm1, 0x20(%rsp)
               	movsd	%xmm0, 0x28(%rsp)
               	movq	%rbx, %rdi
               	callq	<addr>
               	movsd	0x20(%rsp), %xmm1
               	movsd	0x28(%rsp), %xmm0
               	nopl	(%rax)
               	cmpq	%rax, %r14
               	jne	<addr>
               	vmovq	%rbx, %xmm2
               	pshuflw	$0xe4, %xmm2, %xmm2     # xmm2 = xmm2[0,1,2,3,4,5,6,7]
               	vmovq	%xmm2, %r14
               	movl	$0xe4, %esi
               	movsd	%xmm1, 0x20(%rsp)
               	movsd	%xmm0, 0x28(%rsp)
               	movq	%rbx, %rdi
               	callq	<addr>
               	movsd	0x20(%rsp), %xmm1
               	movsd	0x28(%rsp), %xmm0
               	nopl	(%rax)
               	cmpq	%rax, %r14
               	jne	<addr>
               	vmovq	%rbx, %xmm2
               	pshuflw	$0xff, %xmm2, %xmm2     # xmm2 = xmm2[3,3,3,3,4,5,6,7]
               	vmovq	%xmm2, %r14
               	movl	$0xff, %esi
               	movsd	%xmm1, 0x20(%rsp)
               	movsd	%xmm0, 0x28(%rsp)
               	movq	%rbx, %rdi
               	callq	<addr>
               	movsd	0x20(%rsp), %xmm1
               	movsd	0x28(%rsp), %xmm0
               	nopl	(%rax)
               	cmpq	%rax, %r14
               	jne	<addr>
               	vmovq	%rbx, %xmm2
               	pshuflw	$0xff, %xmm2, %xmm2     # xmm2 = xmm2[3,3,3,3,4,5,6,7]
               	vmovq	%xmm2, %r14
               	movl	$0xff, %esi
               	movsd	%xmm1, 0x20(%rsp)
               	movsd	%xmm0, 0x28(%rsp)
               	movq	%rbx, %rdi
               	callq	<addr>
               	movsd	0x20(%rsp), %xmm1
               	movsd	0x28(%rsp), %xmm0
               	nopl	(%rax)
               	cmpq	%rax, %r14
               	jne	<addr>
               	movswq	%bx, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movq	%rbx, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	nopl	(%rax)
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movq	%rbx, %xmm2
               	movswq	%r12w, %rax
               	movapd	%xmm2, %xmm3
               	vpinsrw	$0x0, %eax, %xmm3, %xmm3
               	vmovq	%xmm3, %rsi
               	movq	%rbx, %rdx
               	andq	$-0x10000, %rdx         # imm = 0xFFFF0000
               	movq	%r12, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	orq	%rcx, %rdx
               	cmpq	%rdx, %rsi
               	jne	<addr>
               	movapd	%xmm2, %xmm3
               	vpinsrw	$0x0, %eax, %xmm3, %xmm3
               	vmovq	%xmm3, %rdx
               	movapd	%xmm2, %xmm3
               	vpinsrw	$0x0, %eax, %xmm3, %xmm3
               	vmovq	%xmm3, %rsi
               	nopl	(%rax,%rax)
               	cmpq	%rsi, %rdx
               	jne	<addr>
               	movq	%rbx, %rdx
               	shrq	$0x10, %rdx
               	movswq	%dx, %rsi
               	andq	$0xffff, %rsi           # imm = 0xFFFF
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	cmpl	%edx, %esi
               	jne	<addr>
               	movapd	%xmm2, %xmm3
               	vpinsrw	$0x1, %eax, %xmm3, %xmm3
               	vmovq	%xmm3, %rsi
               	movabsq	$-0xffff0001, %rdx      # imm = 0xFFFFFFFF0000FFFF
               	andq	%rbx, %rdx
               	movq	%rcx, %rdi
               	shlq	$0x10, %rdi
               	orq	%rdi, %rdx
               	cmpq	%rdx, %rsi
               	jne	<addr>
               	movapd	%xmm2, %xmm3
               	vpinsrw	$0x1, %eax, %xmm3, %xmm3
               	vmovq	%xmm3, %rdx
               	movapd	%xmm2, %xmm3
               	vpinsrw	$0x1, %eax, %xmm3, %xmm3
               	vmovq	%xmm3, %rsi
               	cmpq	%rsi, %rdx
               	jne	<addr>
               	movq	%rbx, %rdx
               	shrq	$0x20, %rdx
               	movswq	%dx, %rsi
               	andq	$0xffff, %rsi           # imm = 0xFFFF
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	cmpl	%edx, %esi
               	jne	<addr>
               	movapd	%xmm2, %xmm3
               	vpinsrw	$0x2, %eax, %xmm3, %xmm3
               	vmovq	%xmm3, %rsi
               	movabsq	$-0xffff00000001, %rdx  # imm = 0xFFFF0000FFFFFFFF
               	andq	%rbx, %rdx
               	shlq	$0x20, %rcx
               	orq	%rcx, %rdx
               	cmpq	%rdx, %rsi
               	jne	<addr>
               	movapd	%xmm2, %xmm3
               	vpinsrw	$0x2, %eax, %xmm3, %xmm3
               	vmovq	%xmm3, %rcx
               	movapd	%xmm2, %xmm3
               	vpinsrw	$0x2, %eax, %xmm3, %xmm3
               	vmovq	%xmm3, %rdx
               	cmpq	%rdx, %rcx
               	jne	<addr>
               	movq	%rbx, %rcx
               	shrq	$0x30, %rcx
               	movswq	%cx, %rdx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	cmpl	%ecx, %edx
               	jne	<addr>
               	movapd	%xmm2, %xmm3
               	vpinsrw	$0x3, %eax, %xmm3, %xmm3
               	vmovq	%xmm3, %rdx
               	movabsq	$0xffffffffffff, %rcx   # imm = 0xFFFFFFFFFFFF
               	andq	%rbx, %rcx
               	movq	%r12, %rsi
               	shlq	$0x30, %rsi
               	orq	%rsi, %rcx
               	cmpq	%rcx, %rdx
               	jne	<addr>
               	vpinsrw	$0x3, %eax, %xmm2, %xmm2
               	vmovq	%xmm2, %rcx
               	movq	%rbx, %xmm2
               	vpinsrw	$0x3, %eax, %xmm2, %xmm2
               	vmovq	%xmm2, %rax
               	cmpq	%rax, %rcx
               	jne	<addr>
               	movw	$0xa1a0, -0x10(%rbp)    # imm = 0xA1A0
               	movw	$0xa1a0, -0x20(%rbp)    # imm = 0xA1A0
               	movw	$0xa3a2, -0xe(%rbp)     # imm = 0xA3A2
               	movw	$0xa3a2, -0x1e(%rbp)    # imm = 0xA3A2
               	movw	$0xa5a4, -0xc(%rbp)     # imm = 0xA5A4
               	movw	$0xa5a4, -0x1c(%rbp)    # imm = 0xA5A4
               	movw	$0xa7a6, -0xa(%rbp)     # imm = 0xA7A6
               	movw	$0xa7a6, -0x1a(%rbp)    # imm = 0xA7A6
               	movw	$0xa9a8, -0x8(%rbp)     # imm = 0xA9A8
               	movw	$0xa9a8, -0x18(%rbp)    # imm = 0xA9A8
               	xorl	%eax, %eax
               	jmp	<addr>
               	incq	%rax
               	nopl	(%rax,%rax)
               	cmpl	$0x8, %eax
               	jge	<addr>
               	movq	%rax, %rsi
               	shlq	$0x3, %rsi
               	shrxq	%rsi, %r12, %rcx
               	andq	$0xff, %rcx
               	nopl	(%rax,%rax)
               	testb	$-0x80, %cl
               	je	<addr>
               	leaq	0x1(%rax), %rdi
               	shrxq	%rsi, %rbx, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, -0x10(%rbp,%rdi)
               	jmp	<addr>
               	leaq	-0x20(%rbp), %rsi
               	leaq	0x1(%rsi), %r8
               	movq	%rbx, -0x40(%rbp)
               	movq	%r12, -0x38(%rbp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	incq	%rax
               	cmpl	$0x8, %eax
               	jge	<addr>
               	movzbq	-0x38(%rbp,%rax), %rcx
               	nopl	(%rax)
               	testb	$-0x80, %cl
               	je	<addr>
               	movsbq	-0x40(%rbp,%rax), %rcx
               	movb	%cl, (%r8,%rax)
               	jmp	<addr>
               	xorl	%eax, %eax
               	movzbq	-0x20(%rbp,%rax), %rcx
               	movzbq	-0x10(%rbp,%rax), %rdi
               	nop
               	cmpl	%edi, %ecx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0xa, %eax
               	jl	<addr>
               	leaq	-0x20(%rbp), %rax
               	leaq	0x1(%rax), %rsi
               	movq	%r12, -0x30(%rbp)
               	movq	%rbx, -0x28(%rbp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	incq	%rax
               	cmpl	$0x8, %eax
               	jge	<addr>
               	movzbq	-0x28(%rbp,%rax), %rcx
               	testb	$-0x80, %cl
               	je	<addr>
               	movsbq	-0x30(%rbp,%rax), %rcx
               	movb	%cl, (%rsi,%rax)
               	jmp	<addr>
               	incq	%r13
               	cmpl	$0x7d0, %r13d           # imm = 0x7D0
               	jl	<addr>
               	leaq	-0x8(%rbp), %rax
               	movabsq	$0x123456789abcdef, %rcx # imm = 0x123456789ABCDEF
               	movntiq	%rcx, (%rax)
               	sfence
               	movq	-0x8(%rbp), %rax
               	movabsq	$0x123456789abcdef, %r11 # imm = 0x123456789ABCDEF
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x98, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movl	$0x92, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movl	$0x89, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movl	$0x89, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movl	$0x88, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movl	$0x88, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movl	$0x87, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movl	$0x87, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movl	$0x86, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movl	$0x86, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movl	$0x7f, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movl	$0x7e, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movl	$0x7d, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movl	$0x7c, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movl	$0x7b, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movl	$0x7a, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movl	$0x77, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movl	$0x71, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movl	$0x6d, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movl	$0x69, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movl	$0x68, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movl	$0x61, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movl	$0x60, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movl	$0x59, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movl	$0x55, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq

<sse_conversions>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xe0, %rsp
               	movl	$0x40200000, -0xb0(%rbp) # imm = 0x40200000
               	movl	$0xc0600000, -0xac(%rbp) # imm = 0xC0600000
               	movl	$0x501502f9, -0xa8(%rbp) # imm = 0x501502F9
               	movl	$0x7fc00000, -0xa4(%rbp) # imm = 0x7FC00000
               	movss	-0xb0(%rbp), %xmm0
               	vmovd	%xmm0, %r11d
               	vmovd	%r11d, %xmm0
               	movss	-0xac(%rbp), %xmm2
               	vmovd	%xmm2, %r11d
               	vpinsrd	$0x1, %r11d, %xmm0, %xmm0
               	movss	-0xa8(%rbp), %xmm2
               	vmovd	%xmm2, %r11d
               	vpinsrd	$0x2, %r11d, %xmm0, %xmm0
               	movss	-0xa4(%rbp), %xmm2
               	vmovd	%xmm2, %r11d
               	vpinsrd	$0x3, %r11d, %xmm0, %xmm0
               	vmovd	%xmm0, %eax
               	movslq	%eax, %rax
               	vmovd	%eax, %xmm2
               	vpextrd	$0x1, %xmm0, %eax
               	movslq	%eax, %rax
               	vpinsrd	$0x1, %eax, %xmm2, %xmm2
               	vmovd	%xmm0, %eax
               	movslq	%eax, %rax
               	vpinsrd	$0x2, %eax, %xmm2, %xmm2
               	vpextrd	$0x1, %xmm0, %eax
               	movslq	%eax, %rax
               	vpinsrd	$0x3, %eax, %xmm2, %xmm2
               	cvtps2dq	%xmm2, %xmm2
               	vmovq	%xmm2, %rax
               	movabsq	$-0x3fffffffe, %r11     # imm = 0xFFFFFFFC00000002
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xb0, %eax
               	leave
               	retq
               	vmovd	%xmm0, %eax
               	movslq	%eax, %rax
               	vmovd	%eax, %xmm2
               	vpextrd	$0x1, %xmm0, %eax
               	movslq	%eax, %rax
               	vpinsrd	$0x1, %eax, %xmm2, %xmm2
               	vmovd	%xmm0, %eax
               	movslq	%eax, %rax
               	vpinsrd	$0x2, %eax, %xmm2, %xmm2
               	vpextrd	$0x1, %xmm0, %eax
               	movslq	%eax, %rax
               	movapd	%xmm2, %xmm0
               	vpinsrd	$0x3, %eax, %xmm0, %xmm0
               	cvtps2dq	%xmm0, %xmm0
               	vmovq	%xmm0, %rax
               	movabsq	$-0x3fffffffe, %r11     # imm = 0xFFFFFFFC00000002
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xb1, %eax
               	leave
               	retq
               	movl	$0x501502f9, -0xa0(%rbp) # imm = 0x501502F9
               	movl	$0x7fc00000, -0x9c(%rbp) # imm = 0x7FC00000
               	movl	$0x0, -0x98(%rbp)
               	movl	$0x0, -0x94(%rbp)
               	movss	-0xa0(%rbp), %xmm0
               	vmovd	%xmm0, %r11d
               	vmovd	%r11d, %xmm0
               	movss	-0x9c(%rbp), %xmm2
               	vmovd	%xmm2, %r11d
               	vpinsrd	$0x1, %r11d, %xmm0, %xmm0
               	movss	-0x98(%rbp), %xmm2
               	vmovd	%xmm2, %r11d
               	vpinsrd	$0x2, %r11d, %xmm0, %xmm0
               	movss	-0x94(%rbp), %xmm2
               	vmovd	%xmm2, %r11d
               	vpinsrd	$0x3, %r11d, %xmm0, %xmm0
               	vmovd	%xmm0, %eax
               	movslq	%eax, %rax
               	vmovd	%eax, %xmm2
               	vpextrd	$0x1, %xmm0, %eax
               	movslq	%eax, %rax
               	vpinsrd	$0x1, %eax, %xmm2, %xmm2
               	vmovd	%xmm0, %eax
               	movslq	%eax, %rax
               	vpinsrd	$0x2, %eax, %xmm2, %xmm2
               	vpextrd	$0x1, %xmm0, %eax
               	movslq	%eax, %rax
               	movapd	%xmm2, %xmm0
               	vpinsrd	$0x3, %eax, %xmm0, %xmm0
               	cvtps2dq	%xmm0, %xmm0
               	vmovq	%xmm0, %rax
               	movabsq	$-0x7fffffff80000000, %r11 # imm = 0x8000000080000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xb2, %eax
               	leave
               	retq
               	movl	$0xc02ccccd, -0x90(%rbp) # imm = 0xC02CCCCD
               	movl	$0x402ccccd, -0x8c(%rbp) # imm = 0x402CCCCD
               	movl	$0x0, -0x88(%rbp)
               	movl	$0x0, -0x84(%rbp)
               	movss	-0x90(%rbp), %xmm0
               	vmovd	%xmm0, %r11d
               	vmovd	%r11d, %xmm0
               	movss	-0x8c(%rbp), %xmm2
               	vmovd	%xmm2, %r11d
               	vpinsrd	$0x1, %r11d, %xmm0, %xmm0
               	movss	-0x88(%rbp), %xmm2
               	vmovd	%xmm2, %r11d
               	vpinsrd	$0x2, %r11d, %xmm0, %xmm0
               	movss	-0x84(%rbp), %xmm2
               	vmovd	%xmm2, %r11d
               	vpinsrd	$0x3, %r11d, %xmm0, %xmm0
               	vmovd	%xmm0, %eax
               	movslq	%eax, %rax
               	vmovd	%eax, %xmm2
               	vpextrd	$0x1, %xmm0, %eax
               	movslq	%eax, %rax
               	vpinsrd	$0x1, %eax, %xmm2, %xmm2
               	vmovd	%xmm0, %eax
               	movslq	%eax, %rax
               	vpinsrd	$0x2, %eax, %xmm2, %xmm2
               	vpextrd	$0x1, %xmm0, %eax
               	movslq	%eax, %rax
               	movapd	%xmm2, %xmm0
               	vpinsrd	$0x3, %eax, %xmm0, %xmm0
               	cvttps2dq	%xmm0, %xmm0
               	vmovq	%xmm0, %rax
               	movabsq	$0x2fffffffe, %r11      # imm = 0x2FFFFFFFE
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xb3, %eax
               	leave
               	retq
               	movl	$0xcf000000, -0x80(%rbp) # imm = 0xCF000000
               	movl	$0x4f000000, -0x7c(%rbp) # imm = 0x4F000000
               	movl	$0x0, -0x78(%rbp)
               	movl	$0x0, -0x74(%rbp)
               	movss	-0x80(%rbp), %xmm0
               	vmovd	%xmm0, %r11d
               	vmovd	%r11d, %xmm0
               	movss	-0x7c(%rbp), %xmm2
               	vmovd	%xmm2, %r11d
               	vpinsrd	$0x1, %r11d, %xmm0, %xmm0
               	movss	-0x78(%rbp), %xmm2
               	vmovd	%xmm2, %r11d
               	vpinsrd	$0x2, %r11d, %xmm0, %xmm0
               	movss	-0x74(%rbp), %xmm2
               	vmovd	%xmm2, %r11d
               	vpinsrd	$0x3, %r11d, %xmm0, %xmm0
               	vmovd	%xmm0, %eax
               	movslq	%eax, %rax
               	vmovd	%eax, %xmm2
               	vpextrd	$0x1, %xmm0, %eax
               	movslq	%eax, %rax
               	vpinsrd	$0x1, %eax, %xmm2, %xmm2
               	vmovd	%xmm0, %eax
               	movslq	%eax, %rax
               	vpinsrd	$0x2, %eax, %xmm2, %xmm2
               	vpextrd	$0x1, %xmm0, %eax
               	movslq	%eax, %rax
               	movapd	%xmm2, %xmm0
               	vpinsrd	$0x3, %eax, %xmm0, %xmm0
               	cvttps2dq	%xmm0, %xmm0
               	vmovq	%xmm0, %rax
               	movabsq	$-0x7fffffff80000000, %r11 # imm = 0x8000000080000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xb4, %eax
               	leave
               	retq
               	leaq	-0xb8(%rbp), %rax
               	stmxcsr	(%rax)
               	movl	-0xb8(%rbp), %eax
               	movl	$0xffff9fff, %r11d      # imm = 0xFFFF9FFF
               	andq	%r11, %rax
               	orq	$0x2000, %rax           # imm = 0x2000
               	movl	%eax, -0xb8(%rbp)
               	leaq	-0xb8(%rbp), %rax
               	ldmxcsr	(%rax)
               	movl	$0x40200000, -0x70(%rbp) # imm = 0x40200000
               	movl	$0xc0200000, -0x6c(%rbp) # imm = 0xC0200000
               	movl	$0x0, -0x68(%rbp)
               	movl	$0x0, -0x64(%rbp)
               	movss	-0x70(%rbp), %xmm0
               	vmovd	%xmm0, %r11d
               	vmovd	%r11d, %xmm0
               	movss	-0x6c(%rbp), %xmm2
               	vmovd	%xmm2, %r11d
               	vpinsrd	$0x1, %r11d, %xmm0, %xmm0
               	movss	-0x68(%rbp), %xmm2
               	vmovd	%xmm2, %r11d
               	vpinsrd	$0x2, %r11d, %xmm0, %xmm0
               	movss	-0x64(%rbp), %xmm2
               	vmovd	%xmm2, %r11d
               	vpinsrd	$0x3, %r11d, %xmm0, %xmm0
               	vmovd	%xmm0, %eax
               	movslq	%eax, %rax
               	vmovd	%eax, %xmm2
               	vpextrd	$0x1, %xmm0, %eax
               	movslq	%eax, %rax
               	vpinsrd	$0x1, %eax, %xmm2, %xmm2
               	vmovd	%xmm0, %eax
               	movslq	%eax, %rax
               	vpinsrd	$0x2, %eax, %xmm2, %xmm2
               	vpextrd	$0x1, %xmm0, %eax
               	movslq	%eax, %rax
               	movapd	%xmm2, %xmm0
               	vpinsrd	$0x3, %eax, %xmm0, %xmm0
               	cvtps2dq	%xmm0, %xmm0
               	vmovq	%xmm0, %rax
               	movabsq	$-0x2fffffffe, %r11     # imm = 0xFFFFFFFD00000002
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xb6, %eax
               	leave
               	retq
               	leaq	-0xb8(%rbp), %rax
               	stmxcsr	(%rax)
               	movl	-0xb8(%rbp), %eax
               	movl	$0xffff9fff, %r11d      # imm = 0xFFFF9FFF
               	andq	%r11, %rax
               	orq	$0x4000, %rax           # imm = 0x4000
               	movl	%eax, -0xb8(%rbp)
               	leaq	-0xb8(%rbp), %rax
               	ldmxcsr	(%rax)
               	movl	$0x40200000, -0x60(%rbp) # imm = 0x40200000
               	movl	$0xc0200000, -0x5c(%rbp) # imm = 0xC0200000
               	movl	$0x0, -0x58(%rbp)
               	movl	$0x0, -0x54(%rbp)
               	movss	-0x60(%rbp), %xmm0
               	vmovd	%xmm0, %r11d
               	vmovd	%r11d, %xmm0
               	movss	-0x5c(%rbp), %xmm2
               	vmovd	%xmm2, %r11d
               	vpinsrd	$0x1, %r11d, %xmm0, %xmm0
               	movss	-0x58(%rbp), %xmm2
               	vmovd	%xmm2, %r11d
               	vpinsrd	$0x2, %r11d, %xmm0, %xmm0
               	movss	-0x54(%rbp), %xmm2
               	vmovd	%xmm2, %r11d
               	vpinsrd	$0x3, %r11d, %xmm0, %xmm0
               	vmovd	%xmm0, %eax
               	movslq	%eax, %rax
               	vmovd	%eax, %xmm2
               	vpextrd	$0x1, %xmm0, %eax
               	movslq	%eax, %rax
               	vpinsrd	$0x1, %eax, %xmm2, %xmm2
               	vmovd	%xmm0, %eax
               	movslq	%eax, %rax
               	vpinsrd	$0x2, %eax, %xmm2, %xmm2
               	vpextrd	$0x1, %xmm0, %eax
               	movslq	%eax, %rax
               	movapd	%xmm2, %xmm0
               	vpinsrd	$0x3, %eax, %xmm0, %xmm0
               	cvtps2dq	%xmm0, %xmm0
               	vmovq	%xmm0, %rax
               	movabsq	$-0x1fffffffd, %r11     # imm = 0xFFFFFFFE00000003
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xb8, %eax
               	leave
               	retq
               	movl	$0x3f99999a, -0x50(%rbp) # imm = 0x3F99999A
               	movl	$0xbf99999a, -0x4c(%rbp) # imm = 0xBF99999A
               	movl	$0x471c4000, -0x48(%rbp) # imm = 0x471C4000
               	movl	$0xc71c4000, -0x44(%rbp) # imm = 0xC71C4000
               	movss	-0x50(%rbp), %xmm0
               	vmovd	%xmm0, %r11d
               	vmovd	%r11d, %xmm0
               	movss	-0x4c(%rbp), %xmm2
               	vmovd	%xmm2, %r11d
               	vpinsrd	$0x1, %r11d, %xmm0, %xmm0
               	movss	-0x48(%rbp), %xmm2
               	vmovd	%xmm2, %r11d
               	vpinsrd	$0x2, %r11d, %xmm0, %xmm0
               	movss	-0x44(%rbp), %xmm2
               	vmovd	%xmm2, %r11d
               	vpinsrd	$0x3, %r11d, %xmm0, %xmm0
               	cvtps2dq	%xmm0, %xmm0
               	vmovd	%xmm0, %ecx
               	movslq	%ecx, %rcx
               	movl	$0x7fff, %eax           # imm = 0x7FFF
               	cmpl	%eax, %ecx
               	jle	<addr>
               	movq	%rax, %rcx
               	movswq	%cx, %rcx
               	vpinsrw	$0x0, %ecx, %xmm2, %xmm2
               	vpextrd	$0x1, %xmm0, %ecx
               	movslq	%ecx, %rcx
               	cmpl	%eax, %ecx
               	jle	<addr>
               	movq	%rax, %rcx
               	movswq	%cx, %rcx
               	vpinsrw	$0x1, %ecx, %xmm2, %xmm2
               	vpextrd	$0x2, %xmm0, %ecx
               	movslq	%ecx, %rcx
               	cmpl	%eax, %ecx
               	jle	<addr>
               	movq	%rax, %rcx
               	movswq	%cx, %rcx
               	vpinsrw	$0x2, %ecx, %xmm2, %xmm2
               	vpextrd	$0x3, %xmm0, %ecx
               	movslq	%ecx, %rcx
               	cmpl	%eax, %ecx
               	jle	<addr>
               	movswq	%ax, %rax
               	movapd	%xmm2, %xmm0
               	vpinsrw	$0x3, %eax, %xmm0, %xmm0
               	vmovq	%xmm0, %rax
               	movabsq	$-0x7fff80000000fffe, %r11 # imm = 0x80007FFFFFFF0002
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xb9, %eax
               	leave
               	retq
               	leaq	-0xb8(%rbp), %rax
               	stmxcsr	(%rax)
               	movl	-0xb8(%rbp), %eax
               	movl	$0xffff9fff, %r11d      # imm = 0xFFFF9FFF
               	andq	%r11, %rax
               	orq	$0x6000, %rax           # imm = 0x6000
               	movl	%eax, -0xb8(%rbp)
               	leaq	-0xb8(%rbp), %rax
               	ldmxcsr	(%rax)
               	movl	$0x40200000, -0x40(%rbp) # imm = 0x40200000
               	movl	$0xc0200000, -0x3c(%rbp) # imm = 0xC0200000
               	movl	$0x0, -0x38(%rbp)
               	movl	$0x0, -0x34(%rbp)
               	movss	-0x40(%rbp), %xmm0
               	vmovd	%xmm0, %r11d
               	vmovd	%r11d, %xmm0
               	movss	-0x3c(%rbp), %xmm2
               	vmovd	%xmm2, %r11d
               	vpinsrd	$0x1, %r11d, %xmm0, %xmm0
               	movss	-0x38(%rbp), %xmm2
               	vmovd	%xmm2, %r11d
               	vpinsrd	$0x2, %r11d, %xmm0, %xmm0
               	movss	-0x34(%rbp), %xmm2
               	vmovd	%xmm2, %r11d
               	vpinsrd	$0x3, %r11d, %xmm0, %xmm0
               	vmovd	%xmm0, %eax
               	movslq	%eax, %rax
               	vmovd	%eax, %xmm2
               	vpextrd	$0x1, %xmm0, %eax
               	movslq	%eax, %rax
               	vpinsrd	$0x1, %eax, %xmm2, %xmm2
               	vmovd	%xmm0, %eax
               	movslq	%eax, %rax
               	vpinsrd	$0x2, %eax, %xmm2, %xmm2
               	vpextrd	$0x1, %xmm0, %eax
               	movslq	%eax, %rax
               	movapd	%xmm2, %xmm0
               	vpinsrd	$0x3, %eax, %xmm0, %xmm0
               	cvtps2dq	%xmm0, %xmm0
               	vmovq	%xmm0, %rax
               	movabsq	$-0x1fffffffe, %r11     # imm = 0xFFFFFFFE00000002
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xbb, %eax
               	leave
               	retq
               	movl	$0x40200000, -0x30(%rbp) # imm = 0x40200000
               	movl	$0xc0200000, -0x2c(%rbp) # imm = 0xC0200000
               	movl	$0x0, -0x28(%rbp)
               	movl	$0x0, -0x24(%rbp)
               	movss	-0x30(%rbp), %xmm0
               	vmovd	%xmm0, %r11d
               	vmovd	%r11d, %xmm0
               	movss	-0x2c(%rbp), %xmm2
               	vmovd	%xmm2, %r11d
               	vpinsrd	$0x1, %r11d, %xmm0, %xmm0
               	movss	-0x28(%rbp), %xmm2
               	vmovd	%xmm2, %r11d
               	vpinsrd	$0x2, %r11d, %xmm0, %xmm0
               	movss	-0x24(%rbp), %xmm2
               	vmovd	%xmm2, %r11d
               	vpinsrd	$0x3, %r11d, %xmm0, %xmm0
               	vmovd	%xmm0, %eax
               	movslq	%eax, %rax
               	vmovd	%eax, %xmm2
               	vpextrd	$0x1, %xmm0, %eax
               	movslq	%eax, %rax
               	vpinsrd	$0x1, %eax, %xmm2, %xmm2
               	vmovd	%xmm0, %eax
               	movslq	%eax, %rax
               	vpinsrd	$0x2, %eax, %xmm2, %xmm2
               	vpextrd	$0x1, %xmm0, %eax
               	movslq	%eax, %rax
               	movapd	%xmm2, %xmm0
               	vpinsrd	$0x3, %eax, %xmm0, %xmm0
               	cvttps2dq	%xmm0, %xmm0
               	vmovq	%xmm0, %rax
               	movabsq	$-0x1fffffffe, %r11     # imm = 0xFFFFFFFE00000002
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xbc, %eax
               	leave
               	retq
               	leaq	-0xb8(%rbp), %rax
               	stmxcsr	(%rax)
               	movl	-0xb8(%rbp), %eax
               	movl	$0xffff9fff, %r11d      # imm = 0xFFFF9FFF
               	andq	%r11, %rax
               	movl	%eax, -0xb8(%rbp)
               	leaq	-0xb8(%rbp), %rax
               	ldmxcsr	(%rax)
               	movl	$0x3fc00000, -0x20(%rbp) # imm = 0x3FC00000
               	movl	$0xbfc00000, -0x1c(%rbp) # imm = 0xBFC00000
               	movl	$0x471c4000, -0x18(%rbp) # imm = 0x471C4000
               	movl	$0x7fc00000, -0x14(%rbp) # imm = 0x7FC00000
               	movss	-0x20(%rbp), %xmm0
               	vmovd	%xmm0, %r11d
               	vmovd	%r11d, %xmm0
               	movss	-0x1c(%rbp), %xmm1
               	vmovd	%xmm1, %r11d
               	vpinsrd	$0x1, %r11d, %xmm0, %xmm0
               	movss	-0x18(%rbp), %xmm1
               	vmovd	%xmm1, %r11d
               	vpinsrd	$0x2, %r11d, %xmm0, %xmm0
               	movss	-0x14(%rbp), %xmm1
               	vmovd	%xmm1, %r11d
               	vpinsrd	$0x3, %r11d, %xmm0, %xmm0
               	cvtps2dq	%xmm0, %xmm0
               	vmovd	%xmm0, %ecx
               	movslq	%ecx, %rcx
               	movl	$0x7fff, %eax           # imm = 0x7FFF
               	cmpl	%eax, %ecx
               	jle	<addr>
               	movq	%rax, %rcx
               	movswq	%cx, %rcx
               	vpinsrw	$0x0, %ecx, %xmm1, %xmm1
               	vpextrd	$0x1, %xmm0, %ecx
               	movslq	%ecx, %rcx
               	cmpl	%eax, %ecx
               	jle	<addr>
               	movq	%rax, %rcx
               	movswq	%cx, %rcx
               	vpinsrw	$0x1, %ecx, %xmm1, %xmm1
               	vpextrd	$0x2, %xmm0, %ecx
               	movslq	%ecx, %rcx
               	cmpl	%eax, %ecx
               	jle	<addr>
               	movq	%rax, %rcx
               	movswq	%cx, %rcx
               	vpinsrw	$0x2, %ecx, %xmm1, %xmm1
               	vpextrd	$0x3, %xmm0, %ecx
               	movslq	%ecx, %rcx
               	cmpl	%eax, %ecx
               	jle	<addr>
               	movswq	%ax, %rax
               	movapd	%xmm1, %xmm0
               	vpinsrw	$0x3, %eax, %xmm0, %xmm0
               	vmovq	%xmm0, %rax
               	movabsq	$-0x7fff80000001fffe, %r11 # imm = 0x80007FFFFFFE0002
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xbe, %eax
               	leave
               	retq
               	movl	$0x43960000, -0x10(%rbp) # imm = 0x43960000
               	movl	$0xc3960000, -0xc(%rbp) # imm = 0xC3960000
               	movl	$0x3f000000, -0x8(%rbp) # imm = 0x3F000000
               	movl	$0xc0e00000, -0x4(%rbp) # imm = 0xC0E00000
               	movss	-0x10(%rbp), %xmm0
               	vmovd	%xmm0, %r11d
               	vmovd	%r11d, %xmm0
               	movss	-0xc(%rbp), %xmm1
               	vmovd	%xmm1, %r11d
               	vpinsrd	$0x1, %r11d, %xmm0, %xmm0
               	movss	-0x8(%rbp), %xmm1
               	vmovd	%xmm1, %r11d
               	vpinsrd	$0x2, %r11d, %xmm0, %xmm0
               	movss	-0x4(%rbp), %xmm1
               	vmovd	%xmm1, %r11d
               	vpinsrd	$0x3, %r11d, %xmm0, %xmm0
               	cvtps2dq	%xmm0, %xmm0
               	vpxor	%xmm1, %xmm1, %xmm1
               	vmovq	%xmm1, %xmm1            # xmm1 = xmm1[0],zero
               	vmovd	%xmm0, %ecx
               	movslq	%ecx, %rcx
               	movl	$0x7f, %eax
               	cmpl	$0x7f, %ecx
               	jle	<addr>
               	movq	%rax, %rcx
               	movsbq	%cl, %rcx
               	vpinsrb	$0x0, %ecx, %xmm1, %xmm1
               	vpextrd	$0x1, %xmm0, %ecx
               	movslq	%ecx, %rcx
               	cmpl	$0x7f, %ecx
               	jle	<addr>
               	movq	%rax, %rcx
               	movsbq	%cl, %rcx
               	vpinsrb	$0x1, %ecx, %xmm1, %xmm1
               	vpextrd	$0x2, %xmm0, %ecx
               	movslq	%ecx, %rcx
               	cmpl	$0x7f, %ecx
               	jle	<addr>
               	movq	%rax, %rcx
               	movsbq	%cl, %rcx
               	vpinsrb	$0x2, %ecx, %xmm1, %xmm1
               	vpextrd	$0x3, %xmm0, %ecx
               	movslq	%ecx, %rcx
               	cmpl	$0x7f, %ecx
               	jle	<addr>
               	movsbq	%al, %rax
               	movapd	%xmm1, %xmm0
               	vpinsrb	$0x3, %eax, %xmm0, %xmm0
               	vmovq	%xmm0, %rax
               	movl	$0xf900807f, %r11d      # imm = 0xF900807F
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xbf, %eax
               	leave
               	retq
               	leaq	<rip>, %rax # <addr>
               	movups	(%rax), %xmm0
               	movss	<rip>, %xmm1 # <addr>
               	movss	<rip>, %xmm2 # <addr>
               	vpermilps	$0x2, %xmm0, %xmm3 # xmm3 = xmm0[2,0,0,0]
               	vpermilps	$0x3, %xmm0, %xmm4 # xmm4 = xmm0[3,0,0,0]
               	movapd	%xmm1, %xmm0
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movapd	%xmm2, %xmm0
               	ucomiss	%xmm2, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movapd	%xmm3, %xmm1
               	ucomiss	<rip>, %xmm1 # <addr>
               	jp	<addr>
               	jne	<addr>
               	movapd	%xmm4, %xmm0
               	ucomiss	<rip>, %xmm0 # <addr>
               	jp	<addr>
               	je	<addr>
               	movl	$0xc1, %eax
               	leave
               	retq
               	leaq	<rip>, %rax # <addr>
               	movups	(%rax), %xmm0
               	movss	<rip>, %xmm1 # <addr>
               	movss	<rip>, %xmm2 # <addr>
               	vpermilps	$0x2, %xmm0, %xmm3 # xmm3 = xmm0[2,0,0,0]
               	vpermilps	$0x3, %xmm0, %xmm0 # xmm0 = xmm0[3,0,0,0]
               	movapd	%xmm1, %xmm4
               	ucomiss	%xmm1, %xmm4
               	jp	<addr>
               	jne	<addr>
               	movapd	%xmm2, %xmm1
               	ucomiss	%xmm2, %xmm1
               	jp	<addr>
               	jne	<addr>
               	movapd	%xmm3, %xmm1
               	ucomiss	<rip>, %xmm1 # <addr>
               	jp	<addr>
               	jne	<addr>
               	ucomiss	<rip>, %xmm0 # <addr>
               	jp	<addr>
               	je	<addr>
               	movl	$0xc3, %eax
               	leave
               	retq
               	movss	<rip>, %xmm2 # <addr>
               	movss	<rip>, %xmm0 # <addr>
               	movss	<rip>, %xmm3 # <addr>
               	xorps	%xmm1, %xmm1
               	movapd	%xmm2, %xmm4
               	ucomiss	%xmm2, %xmm4
               	jp	<addr>
               	jne	<addr>
               	movapd	%xmm0, %xmm2
               	ucomiss	%xmm0, %xmm2
               	jp	<addr>
               	jne	<addr>
               	movapd	%xmm3, %xmm2
               	ucomiss	%xmm3, %xmm2
               	jp	<addr>
               	jne	<addr>
               	movapd	%xmm1, %xmm2
               	ucomiss	%xmm1, %xmm2
               	jp	<addr>
               	je	<addr>
               	movl	$0xc5, %eax
               	leave
               	retq
               	movss	<rip>, %xmm2 # <addr>
               	movss	<rip>, %xmm3 # <addr>
               	movapd	%xmm2, %xmm4
               	ucomiss	%xmm2, %xmm4
               	jp	<addr>
               	jne	<addr>
               	ucomiss	<rip>, %xmm0 # <addr>
               	jp	<addr>
               	jne	<addr>
               	movapd	%xmm3, %xmm0
               	ucomiss	%xmm3, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movapd	%xmm1, %xmm0
               	xorps	%xmm1, %xmm1
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xc7, %eax
               	leave
               	retq
               	movss	<rip>, %xmm2 # <addr>
               	movss	<rip>, %xmm0 # <addr>
               	movss	<rip>, %xmm3 # <addr>
               	movss	<rip>, %xmm1 # <addr>
               	movapd	%xmm2, %xmm4
               	ucomiss	%xmm2, %xmm4
               	jp	<addr>
               	jne	<addr>
               	movapd	%xmm0, %xmm2
               	ucomiss	%xmm0, %xmm2
               	jp	<addr>
               	jne	<addr>
               	movapd	%xmm3, %xmm2
               	ucomiss	%xmm3, %xmm2
               	jp	<addr>
               	jne	<addr>
               	movapd	%xmm1, %xmm2
               	ucomiss	%xmm1, %xmm2
               	jp	<addr>
               	je	<addr>
               	movl	$0xc9, %eax
               	leave
               	retq
               	movss	<rip>, %xmm2 # <addr>
               	movss	<rip>, %xmm3 # <addr>
               	movapd	%xmm2, %xmm4
               	ucomiss	%xmm2, %xmm4
               	jp	<addr>
               	jne	<addr>
               	ucomiss	<rip>, %xmm0 # <addr>
               	jp	<addr>
               	jne	<addr>
               	movapd	%xmm3, %xmm0
               	ucomiss	%xmm3, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movapd	%xmm1, %xmm0
               	ucomiss	<rip>, %xmm0 # <addr>
               	jp	<addr>
               	je	<addr>
               	movl	$0xcb, %eax
               	leave
               	retq
               	movss	<rip>, %xmm0 # <addr>
               	movss	<rip>, %xmm1 # <addr>
               	movss	<rip>, %xmm2 # <addr>
               	movss	<rip>, %xmm3 # <addr>
               	movapd	%xmm0, %xmm4
               	ucomiss	%xmm0, %xmm4
               	jp	<addr>
               	jne	<addr>
               	movapd	%xmm1, %xmm4
               	ucomiss	%xmm1, %xmm4
               	jp	<addr>
               	jne	<addr>
               	movapd	%xmm2, %xmm4
               	ucomiss	%xmm2, %xmm4
               	jp	<addr>
               	jne	<addr>
               	movapd	%xmm3, %xmm2
               	ucomiss	%xmm3, %xmm2
               	jp	<addr>
               	je	<addr>
               	movl	$0xcd, %eax
               	leave
               	retq
               	leaq	-0xd0(%rbp), %rax
               	leaq	<rip>, %rcx # <addr>
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	-0xc8(%rbp), %rcx
               	incq	%rcx
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	leaq	<rip>, %rax # <addr>
               	movups	(%rax), %xmm2
               	movsd	-0xc7(%rbp), %xmm3
               	vpermilps	$0x0, %xmm2, %xmm4 # xmm4 = xmm2[0,0,0,0]
               	vpermilps	$0x1, %xmm2, %xmm2 # xmm2 = xmm2[1,0,0,0]
               	vpermilps	$0x0, %xmm3, %xmm5 # xmm5 = xmm3[0,0,0,0]
               	vpermilps	$0x1, %xmm3, %xmm3 # xmm3 = xmm3[1,0,0,0]
               	ucomiss	%xmm0, %xmm4
               	jp	<addr>
               	jne	<addr>
               	movapd	%xmm2, %xmm0
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movapd	%xmm5, %xmm0
               	ucomiss	<rip>, %xmm0 # <addr>
               	jp	<addr>
               	jne	<addr>
               	movapd	%xmm3, %xmm1
               	ucomiss	<rip>, %xmm1 # <addr>
               	jp	<addr>
               	je	<addr>
               	movl	$0xd2, %eax
               	leave
               	retq
               	leaq	<rip>, %rax # <addr>
               	movups	(%rax), %xmm0
               	movsd	-0xc7(%rbp), %xmm1
               	vpermilps	$0x0, %xmm1, %xmm2 # xmm2 = xmm1[0,0,0,0]
               	vpermilps	$0x1, %xmm1, %xmm1 # xmm1 = xmm1[1,0,0,0]
               	vpermilps	$0x2, %xmm0, %xmm3 # xmm3 = xmm0[2,0,0,0]
               	vpermilps	$0x3, %xmm0, %xmm0 # xmm0 = xmm0[3,0,0,0]
               	ucomiss	<rip>, %xmm2 # <addr>
               	jp	<addr>
               	jne	<addr>
               	ucomiss	<rip>, %xmm1 # <addr>
               	jp	<addr>
               	jne	<addr>
               	movapd	%xmm3, %xmm1
               	ucomiss	<rip>, %xmm1 # <addr>
               	jp	<addr>
               	jne	<addr>
               	movapd	%xmm0, %xmm1
               	ucomiss	<rip>, %xmm1 # <addr>
               	jp	<addr>
               	je	<addr>
               	movl	$0xd4, %eax
               	leave
               	retq
               	leaq	<rip>, %rax # <addr>
               	movups	(%rax), %xmm0
               	vpermilpd	$0x1, %xmm0, %xmm0 # xmm0 = xmm0[1,0]
               	movsd	%xmm0, -0xc7(%rbp)
               	leaq	<rip>, %rax # <addr>
               	movups	(%rax), %xmm0
               	movsd	%xmm0, -0xbf(%rbp)
               	leaq	-0xd8(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movss	-0xd8(%rbp), %xmm0
               	ucomiss	<rip>, %xmm0 # <addr>
               	jp	<addr>
               	jne	<addr>
               	movss	-0xd4(%rbp), %xmm0
               	ucomiss	<rip>, %xmm0 # <addr>
               	jp	<addr>
               	jne	<addr>
               	movss	-0xd0(%rbp), %xmm0
               	ucomiss	<rip>, %xmm0 # <addr>
               	jp	<addr>
               	jne	<addr>
               	movss	-0xcc(%rbp), %xmm0
               	ucomiss	<rip>, %xmm0 # <addr>
               	jp	<addr>
               	je	<addr>
               	movl	$0xd9, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
               	movq	$-0x80, %rax
               	cmpl	$-0x80, %ecx
               	cmovgeq	%rcx, %rax
               	jmp	<addr>
               	movq	$-0x80, %rdx
               	cmpl	$-0x80, %ecx
               	cmovlq	%rdx, %rcx
               	jmp	<addr>
               	movq	$-0x80, %rdx
               	cmpl	$-0x80, %ecx
               	cmovlq	%rdx, %rcx
               	jmp	<addr>
               	movq	$-0x80, %rdx
               	cmpl	$-0x80, %ecx
               	cmovlq	%rdx, %rcx
               	jmp	<addr>
               	movq	$-0x8000, %rax          # imm = 0x8000
               	cmpl	$0xffff8000, %ecx       # imm = 0xFFFF8000
               	cmovgeq	%rcx, %rax
               	jmp	<addr>
               	movq	$-0x8000, %rdx          # imm = 0x8000
               	cmpl	$0xffff8000, %ecx       # imm = 0xFFFF8000
               	cmovlq	%rdx, %rcx
               	jmp	<addr>
               	movq	$-0x8000, %rdx          # imm = 0x8000
               	cmpl	$0xffff8000, %ecx       # imm = 0xFFFF8000
               	cmovlq	%rdx, %rcx
               	jmp	<addr>
               	movq	$-0x8000, %rdx          # imm = 0x8000
               	cmpl	$0xffff8000, %ecx       # imm = 0xFFFF8000
               	cmovlq	%rdx, %rcx
               	jmp	<addr>
               	movq	$-0x8000, %rax          # imm = 0x8000
               	cmpl	$0xffff8000, %ecx       # imm = 0xFFFF8000
               	cmovgeq	%rcx, %rax
               	jmp	<addr>
               	movq	$-0x8000, %rdx          # imm = 0x8000
               	cmpl	$0xffff8000, %ecx       # imm = 0xFFFF8000
               	cmovlq	%rdx, %rcx
               	jmp	<addr>
               	movq	$-0x8000, %rdx          # imm = 0x8000
               	cmpl	$0xffff8000, %ecx       # imm = 0xFFFF8000
               	cmovlq	%rdx, %rcx
               	jmp	<addr>
               	movq	$-0x8000, %rdx          # imm = 0x8000
               	cmpl	$0xffff8000, %ecx       # imm = 0xFFFF8000
               	cmovlq	%rdx, %rcx
               	jmp	<addr>

<sse2>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	pushq	%r12
               	pushq	%rbx
               	xorl	%ebx, %ebx
               	callq	<addr>
               	movq	%rax, %r12
               	callq	<addr>
               	movq	%r12, %xmm0
               	movq	%rax, %xmm1
               	vpmuludq	%xmm1, %xmm0, %xmm0
               	vmovq	%xmm0, %rdx
               	movl	%r12d, %ecx
               	movl	%eax, %eax
               	imulq	%rax, %rcx
               	cmpq	%rcx, %rdx
               	jne	<addr>
               	incq	%rbx
               	cmpl	$0x7d0, %ebx            # imm = 0x7D0
               	jl	<addr>
               	movsd	<rip>, %xmm0 # <addr>
               	movsd	<rip>, %xmm1 # <addr>
               	movsd	%xmm0, -0x60(%rbp)
               	movsd	%xmm1, -0x58(%rbp)
               	movsd	-0x60(%rbp), %xmm0
               	movsd	-0x58(%rbp), %xmm1
               	vunpcklpd	%xmm1, %xmm0, %xmm0 # xmm0 = xmm0[0],xmm1[0]
               	cvtpd2dq	%xmm0, %xmm0
               	vmovq	%xmm0, %rax
               	movabsq	$-0x3fffffffe, %r11     # imm = 0xFFFFFFFC00000002
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xef, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movsd	<rip>, %xmm0 # <addr>
               	movsd	<rip>, %xmm1 # <addr>
               	movsd	%xmm0, -0x50(%rbp)
               	movsd	%xmm1, -0x48(%rbp)
               	movsd	-0x50(%rbp), %xmm0
               	movsd	-0x48(%rbp), %xmm1
               	vunpcklpd	%xmm1, %xmm0, %xmm0 # xmm0 = xmm0[0],xmm1[0]
               	cvtpd2dq	%xmm0, %xmm0
               	vmovq	%xmm0, %rax
               	movabsq	$-0x7fffffff80000001, %r11 # imm = 0x800000007FFFFFFF
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xf0, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movsd	<rip>, %xmm0 # <addr>
               	movsd	%xmm0, -0x40(%rbp)
               	movsd	<rip>, %xmm0 # <addr>
               	movsd	%xmm0, -0x38(%rbp)
               	movsd	-0x40(%rbp), %xmm0
               	movsd	-0x38(%rbp), %xmm1
               	vunpcklpd	%xmm1, %xmm0, %xmm0 # xmm0 = xmm0[0],xmm1[0]
               	cvtpd2dq	%xmm0, %xmm0
               	vmovq	%xmm0, %rax
               	movabsq	$-0x7fffffff80000000, %r11 # imm = 0x8000000080000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xf1, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x68(%rbp), %rax
               	stmxcsr	(%rax)
               	movl	-0x68(%rbp), %eax
               	movl	$0xffff9fff, %r11d      # imm = 0xFFFF9FFF
               	andq	%r11, %rax
               	orq	$0x2000, %rax           # imm = 0x2000
               	movl	%eax, -0x68(%rbp)
               	leaq	-0x68(%rbp), %rax
               	ldmxcsr	(%rax)
               	movsd	<rip>, %xmm0 # <addr>
               	movsd	<rip>, %xmm1 # <addr>
               	movsd	%xmm0, -0x30(%rbp)
               	movsd	%xmm1, -0x28(%rbp)
               	movsd	-0x30(%rbp), %xmm0
               	movsd	-0x28(%rbp), %xmm1
               	vunpcklpd	%xmm1, %xmm0, %xmm0 # xmm0 = xmm0[0],xmm1[0]
               	cvtpd2dq	%xmm0, %xmm0
               	vmovq	%xmm0, %rax
               	movabsq	$-0x2fffffffe, %r11     # imm = 0xFFFFFFFD00000002
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xf3, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x68(%rbp), %rax
               	stmxcsr	(%rax)
               	movl	-0x68(%rbp), %eax
               	movl	$0xffff9fff, %r11d      # imm = 0xFFFF9FFF
               	andq	%r11, %rax
               	movl	%eax, -0x68(%rbp)
               	leaq	-0x68(%rbp), %rax
               	ldmxcsr	(%rax)
               	movsd	<rip>, %xmm0 # <addr>
               	movsd	<rip>, %xmm1 # <addr>
               	movsd	%xmm0, -0x20(%rbp)
               	movsd	%xmm1, -0x18(%rbp)
               	movsd	-0x20(%rbp), %xmm0
               	movsd	-0x18(%rbp), %xmm1
               	vunpcklpd	%xmm1, %xmm0, %xmm0 # xmm0 = xmm0[0],xmm1[0]
               	cvttpd2dq	%xmm0, %xmm0
               	vmovq	%xmm0, %rax
               	movabsq	$0x7ffffffffffffffe, %r11 # imm = 0x7FFFFFFFFFFFFFFE
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xf5, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movsd	<rip>, %xmm0 # <addr>
               	movsd	%xmm0, -0x10(%rbp)
               	movsd	<rip>, %xmm0 # <addr>
               	movsd	%xmm0, -0x8(%rbp)
               	movsd	-0x10(%rbp), %xmm0
               	movsd	-0x8(%rbp), %xmm1
               	vunpcklpd	%xmm1, %xmm0, %xmm0 # xmm0 = xmm0[0],xmm1[0]
               	cvttpd2dq	%xmm0, %xmm0
               	vmovq	%xmm0, %rax
               	movabsq	$-0x7fffffff80000000, %r11 # imm = 0x8000000080000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xf6, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movsd	<rip>, %xmm0 # <addr>
               	movsd	<rip>, %xmm1 # <addr>
               	movapd	%xmm0, %xmm2
               	ucomisd	%xmm0, %xmm2
               	jp	<addr>
               	jne	<addr>
               	movapd	%xmm1, %xmm0
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xf8, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0xec, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq

<ssse3>:
               	subq	$0x30, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	xorl	%r15d, %r15d
               	movsd	%xmm1, 0x48(%rsp)
               	movsd	%xmm0, 0x40(%rsp)
               	callq	<addr>
               	movq	%rax, %rbx
               	movsd	0x48(%rsp), %xmm1
               	movsd	0x40(%rsp), %xmm0
               	movsd	%xmm1, 0x48(%rsp)
               	movsd	%xmm0, 0x40(%rsp)
               	callq	<addr>
               	movq	%rax, %r11
               	movsd	0x48(%rsp), %xmm1
               	movsd	0x40(%rsp), %xmm0
               	xorl	%r14d, %r14d
               	leaq	<rip>, %rax # <addr>
               	movslq	(%rax,%r14,4), %rcx
               	movl	$0x40, %eax
               	cltd
               	idivl	%ecx
               	movq	%rax, %r12
               	xorl	%edx, %edx
               	leaq	-0x1(%rcx), %rax
               	movslq	%eax, %rax
               	movq	%rdx, %r8
               	movq	%rdx, %r9
               	jmp	<addr>
               	movl	$0x1, %edi
               	shlxq	%rcx, %rdi, %rdi
               	decq	%rdi
               	andq	%rdi, %rsi
               	movq	%rcx, %rdi
               	imulq	%rdx, %rdi
               	movslq	%edi, %rdi
               	shlxq	%rdi, %rsi, %rsi
               	orq	%rsi, %r8
               	incq	%rdx
               	nop
               	cmpl	%r12d, %edx
               	jge	<addr>
               	cmpl	$0x40, %ecx
               	jne	<addr>
               	movq	%rbx, %rsi
               	cmpl	$0x40, %ecx
               	jge	<addr>
               	shrxq	%rax, %rsi, %rdi
               	nop
               	testq	%rdi, %rdi
               	je	<addr>
               	movl	$0x1, %edi
               	shlxq	%rcx, %rdi, %rdi
               	subq	%rdi, %rsi
               	cmpl	$0x40, %ecx
               	jne	<addr>
               	movq	%r11, %rdi
               	nop
               	cmpl	$0x40, %ecx
               	jge	<addr>
               	shrxq	%rax, %rdi, %r10
               	testq	%r10, %r10
               	je	<addr>
               	movl	$0x1, %r10d
               	shlxq	%rcx, %r10, %r10
               	subq	%r10, %rdi
               	movq	%rsi, %r10
               	negq	%r10
               	testq	%rsi, %rsi
               	movq	%rsi, %r13
               	cmovlq	%r10, %r13
               	movl	$0x1, %r10d
               	shlxq	%rcx, %r10, %r10
               	decq	%r10
               	andq	%r13, %r10
               	movq	%rcx, %r13
               	imulq	%rdx, %r13
               	movslq	%r13d, %r13
               	shlxq	%r13, %r10, %r10
               	orq	%r10, %r9
               	testq	%rdi, %rdi
               	jge	<addr>
               	negq	%rsi
               	jmp	<addr>
               	xorl	%r10d, %r10d
               	testq	%rdi, %rdi
               	cmoveq	%r10, %rsi
               	jmp	<addr>
               	movq	%rcx, %rdi
               	imulq	%rdx, %rdi
               	movslq	%edi, %rdi
               	shrxq	%rdi, %r11, %rdi
               	movl	$0x1, %r10d
               	shlxq	%rcx, %r10, %r10
               	decq	%r10
               	andq	%r10, %rdi
               	jmp	<addr>
               	movq	%rcx, %rsi
               	imulq	%rdx, %rsi
               	movslq	%esi, %rsi
               	shrxq	%rsi, %rbx, %rsi
               	movl	$0x1, %edi
               	shlxq	%rcx, %rdi, %rdi
               	decq	%rdi
               	andq	%rdi, %rsi
               	jmp	<addr>
               	cmpl	$0x8, %ecx
               	jne	<addr>
               	movq	%r11, 0x30(%rsp)
               	vmovq	%rbx, %xmm2
               	pabsb	%xmm2, %xmm2
               	vmovq	%xmm2, %rax
               	movq	0x30(%rsp), %r11
               	nopw	(%rax,%rax)
               	cmpl	$0x8, %ecx
               	jne	<addr>
               	movq	%r11, 0x30(%rsp)
               	vmovq	%rbx, %xmm2
               	movq	0x30(%rsp), %r11
               	movq	%r9, 0x30(%rsp)
               	vmovq	%r11, %xmm3
               	vpsignb	%xmm3, %xmm2, %xmm2
               	vmovq	%xmm2, %rcx
               	movq	0x30(%rsp), %r9
               	cmpq	%r9, %rax
               	jne	<addr>
               	cmpq	%r8, %rcx
               	je	<addr>
               	nop
               	jmp	<addr>
               	cmpl	$0x10, %ecx
               	jne	<addr>
               	movq	%r11, 0x30(%rsp)
               	vmovq	%rbx, %xmm2
               	movq	0x30(%rsp), %r11
               	movq	%r9, 0x30(%rsp)
               	vmovq	%r11, %xmm3
               	vpsignw	%xmm3, %xmm2, %xmm2
               	vmovq	%xmm2, %rcx
               	movq	0x30(%rsp), %r9
               	jmp	<addr>
               	movq	%r11, 0x30(%rsp)
               	vmovq	%rbx, %xmm2
               	movq	0x30(%rsp), %r11
               	movq	%r9, 0x30(%rsp)
               	vmovq	%r11, %xmm3
               	vpsignd	%xmm3, %xmm2, %xmm2
               	vmovq	%xmm2, %rcx
               	movq	0x30(%rsp), %r9
               	nopl	(%rax)
               	jmp	<addr>
               	cmpl	$0x10, %ecx
               	jne	<addr>
               	movq	%r11, 0x30(%rsp)
               	vmovq	%rbx, %xmm2
               	pabsw	%xmm2, %xmm2
               	vmovq	%xmm2, %rax
               	movq	0x30(%rsp), %r11
               	jmp	<addr>
               	movq	%r11, 0x30(%rsp)
               	vmovq	%rbx, %xmm2
               	pabsd	%xmm2, %xmm2
               	vmovq	%xmm2, %rax
               	movq	0x30(%rsp), %r11
               	jmp	<addr>
               	incq	%r14
               	cmpl	$0x3, %r14d
               	jl	<addr>
               	xorl	%esi, %esi
               	movq	%rbx, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movq	%rax, %rcx
               	shrq	$0xf, %rcx
               	leaq	-0x10000(%rax), %rdx
               	testq	%rcx, %rcx
               	cmoveq	%rax, %rdx
               	movq	%rbx, %rax
               	shrq	$0x10, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movq	%rax, %rcx
               	shrq	$0xf, %rcx
               	leaq	-0x10000(%rax), %r12
               	testq	%rcx, %rcx
               	cmoveq	%rax, %r12
               	movq	%r11, %r8
               	andq	$0xffff, %r8            # imm = 0xFFFF
               	movq	%r8, %rax
               	shrq	$0xf, %rax
               	leaq	-0x10000(%r8), %rcx
               	testq	%rax, %rax
               	cmovneq	%rcx, %r8
               	movq	%r11, %rax
               	shrq	$0x10, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movq	%rax, %rcx
               	shrq	$0xf, %rcx
               	leaq	-0x10000(%rax), %r9
               	testq	%rcx, %rcx
               	cmoveq	%rax, %r9
               	leaq	(%rdx,%r12), %rax
               	movq	%rax, %rdi
               	andq	$0xffff, %rdi           # imm = 0xFFFF
               	orq	%rsi, %rdi
               	leaq	(%r8,%r9), %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	shlq	$0x20, %rcx
               	orq	%rcx, %rdi
               	movl	$0x7fff, %ecx           # imm = 0x7FFF
               	nop
               	cmpl	%ecx, %eax
               	jle	<addr>
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	orq	%rsi, %rcx
               	leaq	(%r8,%r9), %r10
               	movl	$0x7fff, %eax           # imm = 0x7FFF
               	nopl	(%rax,%rax)
               	cmpl	%eax, %r10d
               	jle	<addr>
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	shlq	$0x20, %rax
               	orq	%rcx, %rax
               	movq	%rdx, %r10
               	subq	%r12, %r10
               	andq	$0xffff, %r10           # imm = 0xFFFF
               	orq	%rsi, %r10
               	movq	%r8, %rcx
               	subq	%r9, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	shlq	$0x20, %rcx
               	orq	%rcx, %r10
               	movq	%rdx, %rcx
               	subq	%r12, %rcx
               	movl	$0x7fff, %edx           # imm = 0x7FFF
               	cmpl	%edx, %ecx
               	jle	<addr>
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	orq	%rsi, %rdx
               	movq	%r8, %rsi
               	subq	%r9, %rsi
               	movl	$0x7fff, %ecx           # imm = 0x7FFF
               	cmpl	%ecx, %esi
               	jle	<addr>
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	shlq	$0x20, %rcx
               	orq	%rdx, %rcx
               	movq	%rbx, %rdx
               	shrq	$0x20, %rdx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	movq	%rdx, %rsi
               	shrq	$0xf, %rsi
               	leaq	-0x10000(%rdx), %r8
               	testq	%rsi, %rsi
               	cmoveq	%rdx, %r8
               	movq	%rbx, %r9
               	shrq	$0x30, %r9
               	movq	%r9, %rdx
               	shrq	$0xf, %rdx
               	leaq	-0x10000(%r9), %rsi
               	testq	%rdx, %rdx
               	cmovneq	%rsi, %r9
               	movq	%r11, %rdx
               	shrq	$0x20, %rdx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	movq	%rdx, %rsi
               	shrq	$0xf, %rsi
               	leaq	-0x10000(%rdx), %r12
               	testq	%rsi, %rsi
               	cmoveq	%rdx, %r12
               	movq	%r11, %r13
               	shrq	$0x30, %r13
               	movq	%r13, %rdx
               	shrq	$0xf, %rdx
               	leaq	-0x10000(%r13), %rsi
               	testq	%rdx, %rdx
               	cmovneq	%rsi, %r13
               	leaq	(%r8,%r9), %rdx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	shlq	$0x10, %rdx
               	orq	%rdx, %rdi
               	leaq	(%r12,%r13), %rdx
               	shlq	$0x30, %rdx
               	orq	%rdx, %rdi
               	leaq	(%r8,%r9), %rsi
               	movl	$0x7fff, %edx           # imm = 0x7FFF
               	nopl	(%rax)
               	cmpl	%edx, %esi
               	jle	<addr>
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	shlq	$0x10, %rdx
               	orq	%rax, %rdx
               	leaq	(%r12,%r13), %rax
               	movl	$0x7fff, %esi           # imm = 0x7FFF
               	nop
               	cmpl	%esi, %eax
               	jle	<addr>
               	shlq	$0x30, %rsi
               	orq	%rdx, %rsi
               	movq	%r8, %rdx
               	subq	%r9, %rdx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	shlq	$0x10, %rdx
               	orq	%r10, %rdx
               	movq	%r12, %rax
               	subq	%r13, %rax
               	shlq	$0x30, %rax
               	orq	%rax, %rdx
               	subq	%r9, %r8
               	movl	$0x7fff, %eax           # imm = 0x7FFF
               	nopl	(%rax,%rax)
               	cmpl	%eax, %r8d
               	jle	<addr>
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	shlq	$0x10, %rax
               	orq	%rcx, %rax
               	movq	%r12, %r8
               	subq	%r13, %r8
               	movl	$0x7fff, %ecx           # imm = 0x7FFF
               	cmpl	%ecx, %r8d
               	jle	<addr>
               	shlq	$0x30, %rcx
               	orq	%rax, %rcx
               	vmovq	%rbx, %xmm2
               	vpinsrq	$0x1, %r11, %xmm2, %xmm2
               	vphaddw	%xmm2, %xmm2, %xmm2
               	vmovq	%xmm2, %rax
               	cmpq	%rdi, %rax
               	jne	<addr>
               	vmovq	%rbx, %xmm2
               	vpinsrq	$0x1, %r11, %xmm2, %xmm2
               	vphaddsw	%xmm2, %xmm2, %xmm2
               	vmovq	%xmm2, %rax
               	cmpq	%rsi, %rax
               	jne	<addr>
               	vmovq	%rbx, %xmm2
               	vpinsrq	$0x1, %r11, %xmm2, %xmm2
               	vphsubw	%xmm2, %xmm2, %xmm2
               	vmovq	%xmm2, %rax
               	cmpq	%rdx, %rax
               	jne	<addr>
               	vmovq	%rbx, %xmm2
               	vpinsrq	$0x1, %r11, %xmm2, %xmm2
               	vphsubsw	%xmm2, %xmm2, %xmm2
               	vmovq	%xmm2, %rax
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movl	%ebx, %ecx
               	movq	%rcx, %rdi
               	shrq	$0x1f, %rdi
               	movabsq	$0x100000000, %r9       # imm = 0x100000000
               	movq	%rcx, %rax
               	subq	%r9, %rax
               	testq	%rdi, %rdi
               	cmoveq	%rcx, %rax
               	movq	%rbx, %rdx
               	shrq	$0x20, %rdx
               	movq	%rdx, %r8
               	shrq	$0x1f, %r8
               	movabsq	$0x100000000, %r9       # imm = 0x100000000
               	movq	%rdx, %rsi
               	subq	%r9, %rsi
               	testq	%r8, %r8
               	cmoveq	%rdx, %rsi
               	addq	%rsi, %rax
               	movl	%eax, %r9d
               	movl	%r11d, %eax
               	movq	%rax, %rsi
               	shrq	$0x1f, %rsi
               	movq	%r11, 0x30(%rsp)
               	movabsq	$0x100000000, %r11      # imm = 0x100000000
               	movq	%rax, %r10
               	subq	%r11, %r10
               	testq	%rsi, %rsi
               	cmoveq	%rax, %r10
               	movq	0x30(%rsp), %r11
               	movq	%r11, %rsi
               	shrq	$0x20, %rsi
               	movq	%rsi, %r12
               	shrq	$0x1f, %r12
               	movq	%r10, 0x30(%rsp)
               	movabsq	$0x100000000, %r10      # imm = 0x100000000
               	movq	%rsi, %r13
               	subq	%r10, %r13
               	testq	%r12, %r12
               	cmovneq	%r13, %rsi
               	movq	0x30(%rsp), %r10
               	addq	%r10, %rsi
               	shlq	$0x20, %rsi
               	orq	%rsi, %r9
               	vmovq	%rbx, %xmm2
               	vpinsrq	$0x1, %r11, %xmm2, %xmm2
               	vphaddd	%xmm2, %xmm2, %xmm2
               	vmovq	%xmm2, %rsi
               	cmpq	%r9, %rsi
               	jne	<addr>
               	movabsq	$0x100000000, %r9       # imm = 0x100000000
               	movq	%rcx, %rsi
               	subq	%r9, %rsi
               	testq	%rdi, %rdi
               	cmovneq	%rsi, %rcx
               	movabsq	$0x100000000, %r9       # imm = 0x100000000
               	movq	%rdx, %rsi
               	subq	%r9, %rsi
               	testq	%r8, %r8
               	cmovneq	%rsi, %rdx
               	subq	%rdx, %rcx
               	movl	%ecx, %edx
               	movq	%rax, %rcx
               	shrq	$0x1f, %rcx
               	movabsq	$0x100000000, %r9       # imm = 0x100000000
               	movq	%rax, %rsi
               	subq	%r9, %rsi
               	testq	%rcx, %rcx
               	movq	%rax, %rcx
               	cmovneq	%rsi, %rcx
               	movq	%r11, %rax
               	shrq	$0x20, %rax
               	movq	%rax, %rsi
               	shrq	$0x1f, %rsi
               	movabsq	$0x100000000, %r9       # imm = 0x100000000
               	movq	%rax, %rdi
               	subq	%r9, %rdi
               	testq	%rsi, %rsi
               	cmovneq	%rdi, %rax
               	subq	%rax, %rcx
               	shlq	$0x20, %rcx
               	orq	%rcx, %rdx
               	vmovq	%rbx, %xmm2
               	vpinsrq	$0x1, %r11, %xmm2, %xmm2
               	vphsubd	%xmm2, %xmm2, %xmm2
               	vmovq	%xmm2, %rax
               	cmpq	%rdx, %rax
               	jne	<addr>
               	movq	%rbx, %rdx
               	andq	$0xff, %rdx
               	movq	%r11, %rax
               	andq	$0xff, %rax
               	movq	%rax, %rcx
               	shrq	$0x7, %rcx
               	leaq	-0x100(%rax), %rsi
               	testq	%rcx, %rcx
               	cmovneq	%rsi, %rax
               	imulq	%rax, %rdx
               	movq	%rbx, %rcx
               	shrq	$0x8, %rcx
               	andq	$0xff, %rcx
               	movq	%r11, %rax
               	shrq	$0x8, %rax
               	andq	$0xff, %rax
               	movq	%rax, %rsi
               	shrq	$0x7, %rsi
               	leaq	-0x100(%rax), %rdi
               	testq	%rsi, %rsi
               	cmovneq	%rdi, %rax
               	imulq	%rax, %rcx
               	addq	%rcx, %rdx
               	movl	$0x7fff, %eax           # imm = 0x7FFF
               	nop
               	cmpl	%eax, %edx
               	jle	<addr>
               	movq	%rax, %rdx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	movq	%rbx, %rsi
               	shrq	$0x10, %rsi
               	andq	$0xff, %rsi
               	movq	%r11, %rcx
               	shrq	$0x10, %rcx
               	andq	$0xff, %rcx
               	movq	%rcx, %rdi
               	shrq	$0x7, %rdi
               	leaq	-0x100(%rcx), %r8
               	testq	%rdi, %rdi
               	cmovneq	%r8, %rcx
               	imulq	%rcx, %rsi
               	movq	%rbx, %rdi
               	shrq	$0x18, %rdi
               	andq	$0xff, %rdi
               	movq	%r11, %rcx
               	shrq	$0x18, %rcx
               	andq	$0xff, %rcx
               	movq	%rcx, %r8
               	shrq	$0x7, %r8
               	leaq	-0x100(%rcx), %r9
               	testq	%r8, %r8
               	cmovneq	%r9, %rcx
               	imulq	%rcx, %rdi
               	leaq	(%rsi,%rdi), %rcx
               	cmpl	%eax, %ecx
               	jle	<addr>
               	movq	%rax, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	shlq	$0x10, %rcx
               	orq	%rdx, %rcx
               	movq	%rbx, %rsi
               	shrq	$0x20, %rsi
               	andq	$0xff, %rsi
               	movq	%r11, %rdx
               	shrq	$0x20, %rdx
               	andq	$0xff, %rdx
               	movq	%rdx, %rdi
               	shrq	$0x7, %rdi
               	leaq	-0x100(%rdx), %r8
               	testq	%rdi, %rdi
               	cmovneq	%r8, %rdx
               	imulq	%rdx, %rsi
               	movq	%rbx, %rdi
               	shrq	$0x28, %rdi
               	andq	$0xff, %rdi
               	movq	%r11, %rdx
               	shrq	$0x28, %rdx
               	andq	$0xff, %rdx
               	movq	%rdx, %r8
               	shrq	$0x7, %r8
               	leaq	-0x100(%rdx), %r9
               	testq	%r8, %r8
               	cmovneq	%r9, %rdx
               	imulq	%rdx, %rdi
               	leaq	(%rsi,%rdi), %rdx
               	cmpl	%eax, %edx
               	jle	<addr>
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	shlq	$0x20, %rax
               	orq	%rcx, %rax
               	movq	%rbx, %rdx
               	shrq	$0x30, %rdx
               	andq	$0xff, %rdx
               	movq	%r11, %rcx
               	shrq	$0x30, %rcx
               	andq	$0xff, %rcx
               	movq	%rcx, %rsi
               	shrq	$0x7, %rsi
               	leaq	-0x100(%rcx), %rdi
               	testq	%rsi, %rsi
               	cmovneq	%rdi, %rcx
               	imulq	%rcx, %rdx
               	movq	%rbx, %rsi
               	shrq	$0x38, %rsi
               	movq	%r11, %rcx
               	shrq	$0x38, %rcx
               	movq	%rcx, %rdi
               	shrq	$0x7, %rdi
               	leaq	-0x100(%rcx), %r8
               	testq	%rdi, %rdi
               	cmovneq	%r8, %rcx
               	imulq	%rcx, %rsi
               	addq	%rsi, %rdx
               	movl	$0x7fff, %ecx           # imm = 0x7FFF
               	cmpl	%ecx, %edx
               	jle	<addr>
               	shlq	$0x30, %rcx
               	orq	%rax, %rcx
               	vmovq	%rbx, %xmm2
               	vmovq	%r11, %xmm3
               	vpmaddubsw	%xmm3, %xmm2, %xmm2
               	vmovq	%xmm2, %rax
               	cmpq	%rcx, %rax
               	jne	<addr>
               	xorl	%ecx, %ecx
               	vpinsrd	$0x0, %ecx, %xmm0, %xmm0
               	jmp	<addr>
               	vmovd	%xmm0, %eax
               	movslq	%eax, %rax
               	shlq	$0x4, %rax
               	movslq	%eax, %rsi
               	shrxq	%rsi, %rbx, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movq	%rax, %rdx
               	shrq	$0xf, %rdx
               	leaq	-0x10000(%rax), %rdi
               	testq	%rdx, %rdx
               	movq	%rax, %rdx
               	cmovneq	%rdi, %rdx
               	vmovd	%xmm0, %eax
               	movslq	%eax, %rax
               	shlq	$0x4, %rax
               	movslq	%eax, %rax
               	shrxq	%rax, %r11, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movq	%rax, %rdi
               	shrq	$0xf, %rdi
               	leaq	-0x10000(%rax), %r8
               	testq	%rdi, %rdi
               	cmovneq	%r8, %rax
               	imulq	%rax, %rdx
               	sarq	$0xe, %rdx
               	leaq	0x1(%rdx), %rax
               	sarq	%rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	shlxq	%rsi, %rax, %rax
               	orq	%rax, %rcx
               	vmovd	%xmm0, %eax
               	movslq	%eax, %rax
               	incq	%rax
               	vpinsrd	$0x0, %eax, %xmm0, %xmm0
               	vmovd	%xmm0, %eax
               	movslq	%eax, %rax
               	cmpq	$0x4, %rax
               	jl	<addr>
               	vmovq	%rbx, %xmm2
               	xorl	%edx, %edx
               	vmovq	%r11, %xmm3
               	vpmulhrsw	%xmm3, %xmm2, %xmm2
               	vmovq	%xmm2, %rax
               	cmpq	%rcx, %rax
               	jne	<addr>
               	vpinsrd	$0x0, %edx, %xmm1, %xmm1
               	movq	%rdx, %rcx
               	nop
               	jmp	<addr>
               	shlxq	%rsi, %rax, %rax
               	orq	%rax, %rcx
               	vmovd	%xmm1, %eax
               	movslq	%eax, %rax
               	incq	%rax
               	vpinsrd	$0x0, %eax, %xmm1, %xmm1
               	vmovd	%xmm1, %eax
               	movslq	%eax, %rax
               	cmpq	$0x8, %rax
               	jge	<addr>
               	vmovd	%xmm1, %eax
               	movslq	%eax, %rax
               	shlq	$0x3, %rax
               	movslq	%eax, %rsi
               	shrxq	%rsi, %r11, %rax
               	andq	$0xff, %rax
               	testb	$-0x80, %al
               	je	<addr>
               	movq	%rdx, %rax
               	jmp	<addr>
               	vmovd	%xmm1, %eax
               	movslq	%eax, %rax
               	shlq	$0x3, %rax
               	movslq	%eax, %rax
               	shrxq	%rax, %r11, %rax
               	andq	$0xff, %rax
               	andq	$0x7, %rax
               	shlq	$0x3, %rax
               	shrxq	%rax, %rbx, %rax
               	andq	$0xff, %rax
               	jmp	<addr>
               	vmovq	%r11, %xmm2
               	xorl	%eax, %eax
               	movl	$0x87, %r9d
               	vmovd	%r9d, %xmm3
               	vpbroadcastb	%xmm3, %xmm3
               	vpand	%xmm3, %xmm2, %xmm2
               	vmovq	%rbx, %xmm3
               	vpshufb	%xmm2, %xmm3, %xmm2
               	vmovq	%xmm2, %rdx
               	cmpq	%rcx, %rdx
               	jne	<addr>
               	vmovq	%r11, %xmm2
               	vpinsrq	$0x1, %rbx, %xmm2, %xmm2
               	psrldq	$0x0, %xmm2             # xmm2 = xmm2[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
               	vmovq	%xmm2, %rdi
               	movq	%rax, %rcx
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	shrxq	%rdx, %r11, %rsi
               	andq	$0xff, %rsi
               	shlxq	%rdx, %rsi, %rdx
               	orq	%rdx, %rcx
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	cmpq	%rcx, %rdi
               	jne	<addr>
               	vmovq	%r11, %xmm2
               	vpinsrq	$0x1, %rbx, %xmm2, %xmm2
               	psrldq	$0x1, %xmm2             # xmm2 = xmm2[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15],zero
               	vmovq	%xmm2, %r8
               	movq	%rbx, %rdi
               	andq	$0xff, %rdi
               	xorl	%eax, %eax
               	movq	%rax, %rsi
               	jmp	<addr>
               	shlq	$0x3, %rax
               	shlxq	%rax, %rdx, %rax
               	orq	%rax, %rsi
               	movq	%rcx, %rax
               	cmpl	$0x8, %eax
               	jge	<addr>
               	leaq	0x1(%rax), %rcx
               	cmpl	$0x8, %ecx
               	jge	<addr>
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	shrxq	%rdx, %r11, %rdx
               	andq	$0xff, %rdx
               	jmp	<addr>
               	movq	%rdi, %rdx
               	jmp	<addr>
               	cmpq	%rsi, %r8
               	jne	<addr>
               	vmovq	%r11, %xmm2
               	vpinsrq	$0x1, %rbx, %xmm2, %xmm2
               	psrldq	$0x5, %xmm2             # xmm2 = xmm2[5,6,7,8,9,10,11,12,13,14,15],zero,zero,zero,zero,zero
               	vmovq	%xmm2, %rdi
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	%rax, %rsi
               	shlq	$0x3, %rsi
               	shlxq	%rsi, %rcx, %rcx
               	orq	%rcx, %rdx
               	incq	%rax
               	cmpl	$0x8, %eax
               	jge	<addr>
               	leaq	0x5(%rax), %rcx
               	cmpl	$0x8, %ecx
               	jge	<addr>
               	shlq	$0x3, %rcx
               	shrxq	%rcx, %r11, %rcx
               	andq	$0xff, %rcx
               	jmp	<addr>
               	subq	$0x8, %rcx
               	shlq	$0x3, %rcx
               	shrxq	%rcx, %rbx, %rcx
               	andq	$0xff, %rcx
               	jmp	<addr>
               	nopl	(%rax,%rax)
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	vmovq	%r11, %xmm2
               	vpinsrq	$0x1, %rbx, %xmm2, %xmm2
               	psrldq	$0x8, %xmm2             # xmm2 = xmm2[8,9,10,11,12,13,14,15],zero,zero,zero,zero,zero,zero,zero,zero
               	vmovq	%xmm2, %rdi
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	leaq	0x8(%rax), %rdx
               	subq	$0x8, %rdx
               	shlq	$0x3, %rdx
               	shrxq	%rdx, %rbx, %rdx
               	andq	$0xff, %rdx
               	movq	%rax, %rsi
               	shlq	$0x3, %rsi
               	shlxq	%rsi, %rdx, %rdx
               	orq	%rdx, %rcx
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	cmpq	%rcx, %rdi
               	jne	<addr>
               	vmovq	%r11, %xmm2
               	vpinsrq	$0x1, %rbx, %xmm2, %xmm2
               	psrldq	$0x9, %xmm2             # xmm2 = xmm2[9,10,11,12,13,14,15],zero,zero,zero,zero,zero,zero,zero,zero,zero
               	vmovq	%xmm2, %r8
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	movq	%rcx, %rsi
               	jmp	<addr>
               	movq	%rax, %rdi
               	shlq	$0x3, %rdi
               	shlxq	%rdi, %rdx, %rdx
               	orq	%rdx, %rsi
               	incq	%rax
               	cmpl	$0x8, %eax
               	jge	<addr>
               	leaq	0x9(%rax), %rdx
               	cmpl	$0x10, %edx
               	jge	<addr>
               	subq	$0x8, %rdx
               	shlq	$0x3, %rdx
               	shrxq	%rdx, %rbx, %rdx
               	andq	$0xff, %rdx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	cmpq	%rsi, %r8
               	jne	<addr>
               	vmovq	%r11, %xmm2
               	vpinsrq	$0x1, %rbx, %xmm2, %xmm2
               	psrldq	$0xf, %xmm2             # xmm2 = xmm2[15],zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero
               	vmovq	%xmm2, %r9
               	movq	%rbx, %rsi
               	shrq	$0x38, %rsi
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	movq	%rcx, %rdx
               	leaq	0xf(%rax), %rdi
               	cmpl	$0x10, %edi
               	movq	%rcx, %rdi
               	cmovlq	%rsi, %rdi
               	movq	%rax, %r8
               	shlq	$0x3, %r8
               	shlxq	%r8, %rdi, %rdi
               	orq	%rdi, %rdx
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	cmpq	%rdx, %r9
               	jne	<addr>
               	vmovq	%r11, %xmm2
               	vpinsrq	$0x1, %rbx, %xmm2, %xmm2
               	psrldq	$0x10, %xmm2            # xmm2 = zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero
               	vmovq	%xmm2, %rdi
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	movq	%rcx, %rdx
               	movq	%rax, %rsi
               	shlq	$0x3, %rsi
               	shlxq	%rsi, %rcx, %rsi
               	orq	%rsi, %rdx
               	incq	%rax
               	nop
               	cmpl	$0x8, %eax
               	jl	<addr>
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	vmovq	%r11, %xmm2
               	vpinsrq	$0x1, %rbx, %xmm2, %xmm2
               	psrldq	$0x14, %xmm2            # xmm2 = zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero
               	vmovq	%xmm2, %rdi
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	movq	%rcx, %rdx
               	movq	%rax, %rsi
               	shlq	$0x3, %rsi
               	shlxq	%rsi, %rcx, %rsi
               	orq	%rsi, %rdx
               	incq	%rax
               	nopl	(%rax)
               	cmpl	$0x8, %eax
               	jl	<addr>
               	cmpq	%rdx, %rdi
               	je	<addr>
               	jmp	<addr>
               	movq	$-0x8000, %rcx          # imm = 0x8000
               	cmpl	$0xffff8000, %edx       # imm = 0xFFFF8000
               	cmovgeq	%rdx, %rcx
               	jmp	<addr>
               	movq	$-0x8000, %rax          # imm = 0x8000
               	cmpl	$0xffff8000, %edx       # imm = 0xFFFF8000
               	cmovgeq	%rdx, %rax
               	jmp	<addr>
               	movq	$-0x8000, %rsi          # imm = 0x8000
               	cmpl	$0xffff8000, %ecx       # imm = 0xFFFF8000
               	cmovlq	%rsi, %rcx
               	jmp	<addr>
               	movq	$-0x8000, %rcx          # imm = 0x8000
               	cmpl	$0xffff8000, %edx       # imm = 0xFFFF8000
               	cmovlq	%rcx, %rdx
               	jmp	<addr>
               	movq	$-0x8000, %rcx          # imm = 0x8000
               	cmpl	$0xffff8000, %r8d       # imm = 0xFFFF8000
               	cmovgeq	%r8, %rcx
               	nopl	(%rax)
               	jmp	<addr>
               	movq	$-0x8000, %rax          # imm = 0x8000
               	cmpl	$0xffff8000, %r8d       # imm = 0xFFFF8000
               	cmovgeq	%r8, %rax
               	jmp	<addr>
               	movq	$-0x8000, %rsi          # imm = 0x8000
               	cmpl	$0xffff8000, %eax       # imm = 0xFFFF8000
               	cmovgeq	%rax, %rsi
               	jmp	<addr>
               	movq	$-0x8000, %rdx          # imm = 0x8000
               	cmpl	$0xffff8000, %esi       # imm = 0xFFFF8000
               	cmovgeq	%rsi, %rdx
               	jmp	<addr>
               	movq	$-0x8000, %rcx          # imm = 0x8000
               	cmpl	$0xffff8000, %esi       # imm = 0xFFFF8000
               	cmovgeq	%rsi, %rcx
               	jmp	<addr>
               	movq	$-0x8000, %rdx          # imm = 0x8000
               	cmpl	$0xffff8000, %ecx       # imm = 0xFFFF8000
               	cmovgeq	%rcx, %rdx
               	jmp	<addr>
               	movq	$-0x8000, %rax          # imm = 0x8000
               	cmpl	$0xffff8000, %r10d      # imm = 0xFFFF8000
               	cmovgeq	%r10, %rax
               	jmp	<addr>
               	movq	$-0x8000, %rcx          # imm = 0x8000
               	cmpl	$0xffff8000, %eax       # imm = 0xFFFF8000
               	cmovgeq	%rax, %rcx
               	jmp	<addr>
               	incq	%r15
               	cmpl	$0x7d0, %r15d           # imm = 0x7D0
               	jl	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0x30, %rsp
               	retq
               	movl	$0x139, %eax            # imm = 0x139
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0x30, %rsp
               	retq
               	movl	$0x138, %eax            # imm = 0x138
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0x30, %rsp
               	retq
               	movl	$0x137, %eax            # imm = 0x137
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0x30, %rsp
               	retq
               	movl	$0x136, %eax            # imm = 0x136
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0x30, %rsp
               	retq
               	movl	$0x135, %eax            # imm = 0x135
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0x30, %rsp
               	retq
               	movl	$0x134, %eax            # imm = 0x134
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0x30, %rsp
               	retq
               	movl	$0x133, %eax            # imm = 0x133
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0x30, %rsp
               	retq
               	movl	$0x132, %eax            # imm = 0x132
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0x30, %rsp
               	retq
               	movl	$0x130, %eax            # imm = 0x130
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0x30, %rsp
               	retq
               	movl	$0x12b, %eax            # imm = 0x12B
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0x30, %rsp
               	retq
               	movl	$0x127, %eax            # imm = 0x127
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0x30, %rsp
               	retq
               	movl	$0x120, %eax            # imm = 0x120
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0x30, %rsp
               	retq
               	movl	$0x11d, %eax            # imm = 0x11D
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0x30, %rsp
               	retq
               	movl	$0x11a, %eax            # imm = 0x11A
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0x30, %rsp
               	retq
               	movl	$0x119, %eax            # imm = 0x119
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0x30, %rsp
               	retq
               	movl	$0x10e, %eax            # imm = 0x10E
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0x30, %rsp
               	retq

<main>:
               	pushq	%rax
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	callq	<addr>
               	popq	%r11
               	retq
