
sse_sse2_ssse3_m64_forms_follow_the_sdm.x64:	file format elf64-x86-64

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

<rnd>:
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rcx
               	shrq	$0xc, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shrq	$0x1b, %rcx
               	xorq	%rax, %rcx
               	movq	%rcx, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %rax # imm = 0x2545F4914F6CDD1D
               	imulq	%rcx, %rax
               	movq	%rcx, %rdx
               	shrq	$0xc, %rdx
               	xorq	%rdx, %rcx
               	movq	%rcx, <rip> # <addr>
               	movq	%rcx, %rdx
               	shlq	$0x19, %rdx
               	xorq	%rdx, %rcx
               	movq	%rcx, <rip> # <addr>
               	movq	%rcx, %rdx
               	shrq	$0x1b, %rdx
               	xorq	%rdx, %rcx
               	movq	%rcx, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %rsi # imm = 0x2545F4914F6CDD1D
               	imulq	%rcx, %rsi
               	xorl	%ecx, %ecx
               	leaq	<rip>, %rdi # <addr>
               	jmp	<addr>
               	incq	%rcx
               	cmpl	$0x8, %ecx
               	jge	<addr>
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	shrxq	%rdx, %rsi, %r8
               	testb	$0x3, %r8b
               	jne	<addr>
               	movl	$0xff, %r8d
               	shlxq	%rdx, %r8, %r8
               	xorq	$-0x1, %r8
               	andq	%r8, %rax
               	leaq	0x2(%rdx), %r8
               	shrxq	%r8, %rsi, %r8
               	andq	$0x3, %r8
               	movzbq	(%rdi,%r8), %r8
               	shlxq	%rdx, %r8, %rdx
               	orq	%rdx, %rax
               	jmp	<addr>
               	retq

<ref_shuffle_pi16>:
               	movslq	%esi, %rsi
               	movq	%rsi, %rax
               	andq	$0x3, %rax
               	shlq	$0x4, %rax
               	movslq	%eax, %rax
               	shrxq	%rax, %rdi, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movq	%rsi, %rcx
               	sarq	$0x2, %rcx
               	andq	$0x3, %rcx
               	shlq	$0x4, %rcx
               	movslq	%ecx, %rcx
               	shrxq	%rcx, %rdi, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	shlq	$0x10, %rcx
               	orq	%rcx, %rax
               	movq	%rsi, %rcx
               	sarq	$0x4, %rcx
               	andq	$0x3, %rcx
               	shlq	$0x4, %rcx
               	movslq	%ecx, %rcx
               	shrxq	%rcx, %rdi, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	shlq	$0x20, %rcx
               	orq	%rcx, %rax
               	sarq	$0x6, %rsi
               	andq	$0x3, %rsi
               	shlq	$0x4, %rsi
               	movslq	%esi, %rcx
               	shrxq	%rcx, %rdi, %rcx
               	shlq	$0x30, %rcx
               	orq	%rcx, %rax
               	retq

<sse_lanes>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	xorl	%r14d, %r14d
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
               	movq	%rax, %rdx
               	orq	%rcx, %rdx
               	movq	%rbx, %rax
               	shrq	$0x20, %rax
               	movq	%rax, %rsi
               	andq	$0xff, %rsi
               	movq	%r12, %rcx
               	shrq	$0x20, %rcx
               	movq	%rcx, %rdi
               	andq	$0xff, %rdi
               	addq	%rdi, %rsi
               	incq	%rsi
               	shrq	%rsi
               	shlq	$0x20, %rsi
               	orq	%rsi, %rdx
               	movq	%rbx, %rsi
               	shrq	$0x28, %rsi
               	andq	$0xff, %rsi
               	movq	%r12, %rdi
               	shrq	$0x28, %rdi
               	andq	$0xff, %rdi
               	addq	%rdi, %rsi
               	incq	%rsi
               	shrq	%rsi
               	shlq	$0x28, %rsi
               	movq	%rdx, %rdi
               	orq	%rsi, %rdi
               	movq	%rbx, %rdx
               	shrq	$0x30, %rdx
               	movq	%rdx, %r8
               	andq	$0xff, %r8
               	movq	%r12, %rsi
               	shrq	$0x30, %rsi
               	movq	%rsi, %r9
               	andq	$0xff, %r9
               	addq	%r9, %r8
               	incq	%r8
               	shrq	%r8
               	shlq	$0x30, %r8
               	orq	%r8, %rdi
               	movq	%rbx, %r8
               	shrq	$0x38, %r8
               	movq	%r12, %r9
               	shrq	$0x38, %r9
               	addq	%r9, %r8
               	incq	%r8
               	shrq	%r8
               	shlq	$0x38, %r8
               	orq	%r8, %rdi
               	movq	%rbx, %xmm2
               	movq	%r12, %xmm3
               	vpavgb	%xmm3, %xmm2, %xmm4
               	vmovq	%xmm4, %r8
               	cmpq	%rdi, %r8
               	jne	<addr>
               	vpavgb	%xmm3, %xmm2, %xmm4
               	vmovq	%xmm4, %r8
               	cmpq	%rdi, %r8
               	jne	<addr>
               	movq	%rbx, %rdi
               	andq	$0xffff, %rdi           # imm = 0xFFFF
               	movq	%r12, %r8
               	andq	$0xffff, %r8            # imm = 0xFFFF
               	addq	%r8, %rdi
               	incq	%rdi
               	shrq	%rdi
               	movq	%rbx, %r8
               	shrq	$0x10, %r8
               	andq	$0xffff, %r8            # imm = 0xFFFF
               	movq	%r12, %r9
               	shrq	$0x10, %r9
               	andq	$0xffff, %r9            # imm = 0xFFFF
               	addq	%r9, %r8
               	incq	%r8
               	shrq	%r8
               	shlq	$0x10, %r8
               	orq	%r8, %rdi
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	addq	%rcx, %rax
               	incq	%rax
               	shrq	%rax
               	shlq	$0x20, %rax
               	orq	%rdi, %rax
               	leaq	(%rdx,%rsi), %rcx
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
               	movq	%rax, %rsi
               	movq	%rax, %rdi
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	movslq	%ecx, %rdx
               	shrxq	%rdx, %rbx, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	movq	%rcx, %r8
               	shrq	$0xf, %r8
               	leaq	-0x10000(%rcx), %r9
               	testq	%r8, %r8
               	cmovneq	%r9, %rcx
               	shrxq	%rdx, %r12, %rdx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	movq	%rdx, %r8
               	shrq	$0xf, %r8
               	leaq	-0x10000(%rdx), %r9
               	testq	%r8, %r8
               	cmovneq	%r9, %rdx
               	cmpl	%edx, %ecx
               	movq	%rdx, %r8
               	cmovgq	%rcx, %r8
               	movq	%r8, %r9
               	andq	$0xffff, %r9            # imm = 0xFFFF
               	movq	%rax, %r8
               	shlq	$0x4, %r8
               	movslq	%r8d, %r13
               	shlxq	%r13, %r9, %r9
               	orq	%r9, %rdi
               	cmpl	%edx, %ecx
               	cmovgeq	%rdx, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	movslq	%r8d, %rdx
               	shlxq	%rdx, %rcx, %rcx
               	orq	%rcx, %rsi
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rbx, %xmm2
               	movq	%r12, %xmm3
               	vpmaxsw	%xmm3, %xmm2, %xmm4
               	vmovq	%xmm4, %rax
               	cmpq	%rdi, %rax
               	jne	<addr>
               	vpmaxsw	%xmm3, %xmm2, %xmm4
               	vmovq	%xmm4, %rax
               	cmpq	%rdi, %rax
               	jne	<addr>
               	vpminsw	%xmm3, %xmm2, %xmm4
               	vmovq	%xmm4, %rax
               	cmpq	%rsi, %rax
               	jne	<addr>
               	vpminsw	%xmm3, %xmm2, %xmm2
               	vmovq	%xmm2, %rax
               	cmpq	%rsi, %rax
               	jne	<addr>
               	xorl	%eax, %eax
               	movq	%rax, %rsi
               	movq	%rax, %rdi
               	movq	%rax, %r8
               	shlq	$0x3, %r8
               	movslq	%r8d, %rdx
               	shrxq	%rdx, %rbx, %rcx
               	andq	$0xff, %rcx
               	shrxq	%rdx, %r12, %rdx
               	andq	$0xff, %rdx
               	cmpl	%edx, %ecx
               	movq	%rdx, %r9
               	cmovaq	%rcx, %r9
               	movslq	%r8d, %r8
               	shlxq	%r8, %r9, %r8
               	orq	%r8, %rdi
               	cmpl	%edx, %ecx
               	cmovaeq	%rdx, %rcx
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	movslq	%edx, %rdx
               	shlxq	%rdx, %rcx, %rcx
               	orq	%rcx, %rsi
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movq	%rbx, %xmm2
               	movq	%r12, %xmm3
               	vpmaxub	%xmm3, %xmm2, %xmm4
               	vmovq	%xmm4, %rax
               	cmpq	%rdi, %rax
               	jne	<addr>
               	vpmaxub	%xmm3, %xmm2, %xmm4
               	vmovq	%xmm4, %rax
               	cmpq	%rdi, %rax
               	jne	<addr>
               	vpminub	%xmm3, %xmm2, %xmm4
               	vmovq	%xmm4, %rax
               	cmpq	%rsi, %rax
               	jne	<addr>
               	vpminub	%xmm3, %xmm2, %xmm2
               	vmovq	%xmm2, %rax
               	cmpq	%rsi, %rax
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
               	cmpq	$0x8, %rcx
               	jl	<addr>
               	movq	%rbx, %xmm2
               	vpextrb	$0x0, %xmm2, %ecx
               	shrq	$0x7, %rcx
               	vpextrb	$0x1, %xmm2, %edx
               	shrq	$0x7, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	vpextrb	$0x2, %xmm2, %edx
               	shrq	$0x7, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	vpextrb	$0x3, %xmm2, %edx
               	shrq	$0x7, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	vpextrb	$0x4, %xmm2, %edx
               	shrq	$0x7, %rdx
               	shlq	$0x4, %rdx
               	orq	%rdx, %rcx
               	vpextrb	$0x5, %xmm2, %edx
               	shrq	$0x7, %rdx
               	shlq	$0x5, %rdx
               	orq	%rdx, %rcx
               	vpextrb	$0x6, %xmm2, %edx
               	shrq	$0x7, %rdx
               	shlq	$0x6, %rdx
               	orq	%rdx, %rcx
               	vpextrb	$0x7, %xmm2, %edx
               	shrq	$0x7, %rdx
               	shlq	$0x7, %rdx
               	orq	%rdx, %rcx
               	cmpl	%eax, %ecx
               	jne	<addr>
               	vpextrb	$0x0, %xmm2, %ecx
               	shrq	$0x7, %rcx
               	vpextrb	$0x1, %xmm2, %edx
               	shrq	$0x7, %rdx
               	shlq	%rdx
               	orq	%rdx, %rcx
               	vpextrb	$0x2, %xmm2, %edx
               	shrq	$0x7, %rdx
               	shlq	$0x2, %rdx
               	orq	%rdx, %rcx
               	vpextrb	$0x3, %xmm2, %edx
               	shrq	$0x7, %rdx
               	shlq	$0x3, %rdx
               	orq	%rdx, %rcx
               	vpextrb	$0x4, %xmm2, %edx
               	shrq	$0x7, %rdx
               	shlq	$0x4, %rdx
               	orq	%rdx, %rcx
               	vpextrb	$0x5, %xmm2, %edx
               	shrq	$0x7, %rdx
               	shlq	$0x5, %rdx
               	orq	%rdx, %rcx
               	vpextrb	$0x6, %xmm2, %edx
               	shrq	$0x7, %rdx
               	shlq	$0x6, %rdx
               	orq	%rdx, %rcx
               	vpextrb	$0x7, %xmm2, %edx
               	shrq	$0x7, %rdx
               	shlq	$0x7, %rdx
               	orq	%rdx, %rcx
               	cmpl	%eax, %ecx
               	jne	<addr>
               	movq	%rbx, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movq	%r12, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	imulq	%rcx, %rax
               	shrq	$0x10, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movq	%rbx, %rcx
               	shrq	$0x10, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	movq	%r12, %rdx
               	shrq	$0x10, %rdx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	imulq	%rdx, %rcx
               	shrq	$0x10, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	shlq	$0x10, %rcx
               	orq	%rcx, %rax
               	movq	%rbx, %rcx
               	shrq	$0x20, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	movq	%r12, %rdx
               	shrq	$0x20, %rdx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	imulq	%rdx, %rcx
               	shrq	$0x10, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	shlq	$0x20, %rcx
               	orq	%rcx, %rax
               	movq	%rbx, %rcx
               	shrq	$0x30, %rcx
               	movq	%r12, %rdx
               	shrq	$0x30, %rdx
               	imulq	%rdx, %rcx
               	shrq	$0x10, %rcx
               	shlq	$0x30, %rcx
               	orq	%rcx, %rax
               	movq	%r12, %xmm3
               	vpmulhuw	%xmm3, %xmm2, %xmm4
               	vmovq	%xmm4, %rcx
               	cmpq	%rax, %rcx
               	jne	<addr>
               	vpmulhuw	%xmm3, %xmm2, %xmm2
               	vmovq	%xmm2, %rcx
               	cmpq	%rax, %rcx
               	jne	<addr>
               	xorl	%eax, %eax
               	vpinsrd	$0x0, %eax, %xmm0, %xmm0
               	jmp	<addr>
               	vmovd	%xmm0, %ecx
               	movslq	%ecx, %rcx
               	shlq	$0x3, %rcx
               	movslq	%ecx, %rcx
               	shrxq	%rcx, %rbx, %rcx
               	andq	$0xff, %rcx
               	vmovd	%xmm0, %edx
               	movslq	%edx, %rdx
               	shlq	$0x3, %rdx
               	movslq	%edx, %rdx
               	shrxq	%rdx, %r12, %rdx
               	andq	$0xff, %rdx
               	subq	%rdx, %rcx
               	movq	%rcx, %rdx
               	negq	%rdx
               	testl	%ecx, %ecx
               	cmovlq	%rdx, %rcx
               	addq	%rcx, %rax
               	vmovd	%xmm0, %ecx
               	movslq	%ecx, %rcx
               	incq	%rcx
               	vpinsrd	$0x0, %ecx, %xmm0, %xmm0
               	vmovd	%xmm0, %ecx
               	movslq	%ecx, %rcx
               	cmpq	$0x8, %rcx
               	jl	<addr>
               	movq	%rbx, %xmm2
               	movq	%r12, %xmm3
               	vpsadbw	%xmm3, %xmm2, %xmm4
               	vmovq	%xmm4, %rcx
               	cmpq	%rax, %rcx
               	jne	<addr>
               	vpsadbw	%xmm3, %xmm2, %xmm3
               	vmovq	%xmm3, %rcx
               	cmpq	%rax, %rcx
               	jne	<addr>
               	vpextrw	$0x0, %xmm2, %eax
               	movswq	%ax, %rax
               	movw	%ax, -0x30(%rbp)
               	vpextrw	$0x0, %xmm2, %eax
               	movswq	%ax, %rax
               	movw	%ax, -0x2e(%rbp)
               	vpextrw	$0x0, %xmm2, %eax
               	movswq	%ax, %rax
               	movw	%ax, -0x2c(%rbp)
               	vpextrw	$0x0, %xmm2, %eax
               	movswq	%ax, %rax
               	movw	%ax, -0x2a(%rbp)
               	movq	-0x30(%rbp), %r13
               	xorl	%esi, %esi
               	movsd	%xmm1, 0x20(%rsp)
               	movsd	%xmm0, 0x28(%rsp)
               	movq	%rbx, %rdi
               	callq	<addr>
               	movsd	0x20(%rsp), %xmm1
               	movsd	0x28(%rsp), %xmm0
               	cmpq	%rax, %r13
               	jne	<addr>
               	movq	%rbx, %xmm2
               	vpextrw	$0x0, %xmm2, %eax
               	movswq	%ax, %rax
               	movw	%ax, -0x30(%rbp)
               	vpextrw	$0x0, %xmm2, %eax
               	movswq	%ax, %rax
               	movw	%ax, -0x2e(%rbp)
               	vpextrw	$0x0, %xmm2, %eax
               	movswq	%ax, %rax
               	movw	%ax, -0x2c(%rbp)
               	vpextrw	$0x0, %xmm2, %eax
               	movswq	%ax, %rax
               	movw	%ax, -0x2a(%rbp)
               	movq	-0x30(%rbp), %r13
               	xorl	%esi, %esi
               	movsd	%xmm1, 0x20(%rsp)
               	movsd	%xmm0, 0x28(%rsp)
               	movq	%rbx, %rdi
               	callq	<addr>
               	movsd	0x20(%rsp), %xmm1
               	movsd	0x28(%rsp), %xmm0
               	cmpq	%rax, %r13
               	jne	<addr>
               	movq	%rbx, %xmm2
               	vpextrw	$0x3, %xmm2, %eax
               	movswq	%ax, %rax
               	movw	%ax, -0x30(%rbp)
               	vpextrw	$0x2, %xmm2, %eax
               	movswq	%ax, %rax
               	movw	%ax, -0x2e(%rbp)
               	vpextrw	$0x1, %xmm2, %eax
               	movswq	%ax, %rax
               	movw	%ax, -0x2c(%rbp)
               	vpextrw	$0x0, %xmm2, %eax
               	movswq	%ax, %rax
               	movw	%ax, -0x2a(%rbp)
               	movq	-0x30(%rbp), %r13
               	movl	$0x1b, %esi
               	movsd	%xmm1, 0x20(%rsp)
               	movsd	%xmm0, 0x28(%rsp)
               	movq	%rbx, %rdi
               	callq	<addr>
               	movsd	0x20(%rsp), %xmm1
               	movsd	0x28(%rsp), %xmm0
               	cmpq	%rax, %r13
               	jne	<addr>
               	movq	%rbx, %xmm2
               	vpextrw	$0x3, %xmm2, %eax
               	movswq	%ax, %rax
               	movw	%ax, -0x30(%rbp)
               	vpextrw	$0x2, %xmm2, %eax
               	movswq	%ax, %rax
               	movw	%ax, -0x2e(%rbp)
               	vpextrw	$0x1, %xmm2, %eax
               	movswq	%ax, %rax
               	movw	%ax, -0x2c(%rbp)
               	vpextrw	$0x0, %xmm2, %eax
               	movswq	%ax, %rax
               	movw	%ax, -0x2a(%rbp)
               	movq	-0x30(%rbp), %r13
               	movl	$0x1b, %esi
               	movsd	%xmm1, 0x20(%rsp)
               	movsd	%xmm0, 0x28(%rsp)
               	movq	%rbx, %rdi
               	callq	<addr>
               	movsd	0x20(%rsp), %xmm1
               	movsd	0x28(%rsp), %xmm0
               	cmpq	%rax, %r13
               	jne	<addr>
               	movq	%rbx, %xmm2
               	vpextrw	$0x2, %xmm2, %eax
               	movswq	%ax, %rax
               	movw	%ax, -0x30(%rbp)
               	vpextrw	$0x3, %xmm2, %eax
               	movswq	%ax, %rax
               	movw	%ax, -0x2e(%rbp)
               	vpextrw	$0x0, %xmm2, %eax
               	movswq	%ax, %rax
               	movw	%ax, -0x2c(%rbp)
               	vpextrw	$0x1, %xmm2, %eax
               	movswq	%ax, %rax
               	movw	%ax, -0x2a(%rbp)
               	movq	-0x30(%rbp), %r13
               	movl	$0x4e, %esi
               	movsd	%xmm1, 0x20(%rsp)
               	movsd	%xmm0, 0x28(%rsp)
               	movq	%rbx, %rdi
               	callq	<addr>
               	movsd	0x20(%rsp), %xmm1
               	movsd	0x28(%rsp), %xmm0
               	cmpq	%rax, %r13
               	jne	<addr>
               	movq	%rbx, %xmm2
               	vpextrw	$0x2, %xmm2, %eax
               	movswq	%ax, %rax
               	movw	%ax, -0x30(%rbp)
               	vpextrw	$0x3, %xmm2, %eax
               	movswq	%ax, %rax
               	movw	%ax, -0x2e(%rbp)
               	vpextrw	$0x0, %xmm2, %eax
               	movswq	%ax, %rax
               	movw	%ax, -0x2c(%rbp)
               	vpextrw	$0x1, %xmm2, %eax
               	movswq	%ax, %rax
               	movw	%ax, -0x2a(%rbp)
               	movq	-0x30(%rbp), %r13
               	movl	$0x4e, %esi
               	movsd	%xmm1, 0x20(%rsp)
               	movsd	%xmm0, 0x28(%rsp)
               	movq	%rbx, %rdi
               	callq	<addr>
               	movsd	0x20(%rsp), %xmm1
               	movsd	0x28(%rsp), %xmm0
               	cmpq	%rax, %r13
               	jne	<addr>
               	movq	%rbx, %xmm2
               	vpextrw	$0x3, %xmm2, %eax
               	movswq	%ax, %rax
               	movw	%ax, -0x30(%rbp)
               	vpextrw	$0x0, %xmm2, %eax
               	movswq	%ax, %rax
               	movw	%ax, -0x2e(%rbp)
               	vpextrw	$0x1, %xmm2, %eax
               	movswq	%ax, %rax
               	movw	%ax, -0x2c(%rbp)
               	vpextrw	$0x2, %xmm2, %eax
               	movswq	%ax, %rax
               	movw	%ax, -0x2a(%rbp)
               	movq	-0x30(%rbp), %r13
               	movl	$0x93, %esi
               	movsd	%xmm1, 0x20(%rsp)
               	movsd	%xmm0, 0x28(%rsp)
               	movq	%rbx, %rdi
               	callq	<addr>
               	movsd	0x20(%rsp), %xmm1
               	movsd	0x28(%rsp), %xmm0
               	cmpq	%rax, %r13
               	jne	<addr>
               	movq	%rbx, %xmm2
               	vpextrw	$0x3, %xmm2, %eax
               	movswq	%ax, %rax
               	movw	%ax, -0x30(%rbp)
               	vpextrw	$0x0, %xmm2, %eax
               	movswq	%ax, %rax
               	movw	%ax, -0x2e(%rbp)
               	vpextrw	$0x1, %xmm2, %eax
               	movswq	%ax, %rax
               	movw	%ax, -0x2c(%rbp)
               	vpextrw	$0x2, %xmm2, %eax
               	movswq	%ax, %rax
               	movw	%ax, -0x2a(%rbp)
               	movq	-0x30(%rbp), %r13
               	movl	$0x93, %esi
               	movsd	%xmm1, 0x20(%rsp)
               	movsd	%xmm0, 0x28(%rsp)
               	movq	%rbx, %rdi
               	callq	<addr>
               	movsd	0x20(%rsp), %xmm1
               	movsd	0x28(%rsp), %xmm0
               	cmpq	%rax, %r13
               	jne	<addr>
               	movq	%rbx, %xmm2
               	vpextrw	$0x0, %xmm2, %eax
               	movswq	%ax, %rax
               	movw	%ax, -0x30(%rbp)
               	vpextrw	$0x1, %xmm2, %eax
               	movswq	%ax, %rax
               	movw	%ax, -0x2e(%rbp)
               	vpextrw	$0x2, %xmm2, %eax
               	movswq	%ax, %rax
               	movw	%ax, -0x2c(%rbp)
               	vpextrw	$0x3, %xmm2, %eax
               	movswq	%ax, %rax
               	movw	%ax, -0x2a(%rbp)
               	movq	-0x30(%rbp), %r13
               	movl	$0xe4, %esi
               	movsd	%xmm1, 0x20(%rsp)
               	movsd	%xmm0, 0x28(%rsp)
               	movq	%rbx, %rdi
               	callq	<addr>
               	movsd	0x20(%rsp), %xmm1
               	movsd	0x28(%rsp), %xmm0
               	cmpq	%rax, %r13
               	jne	<addr>
               	movq	%rbx, %xmm2
               	vpextrw	$0x0, %xmm2, %eax
               	movswq	%ax, %rax
               	movw	%ax, -0x30(%rbp)
               	vpextrw	$0x1, %xmm2, %eax
               	movswq	%ax, %rax
               	movw	%ax, -0x2e(%rbp)
               	vpextrw	$0x2, %xmm2, %eax
               	movswq	%ax, %rax
               	movw	%ax, -0x2c(%rbp)
               	vpextrw	$0x3, %xmm2, %eax
               	movswq	%ax, %rax
               	movw	%ax, -0x2a(%rbp)
               	movq	-0x30(%rbp), %r13
               	movl	$0xe4, %esi
               	movsd	%xmm1, 0x20(%rsp)
               	movsd	%xmm0, 0x28(%rsp)
               	movq	%rbx, %rdi
               	callq	<addr>
               	movsd	0x20(%rsp), %xmm1
               	movsd	0x28(%rsp), %xmm0
               	cmpq	%rax, %r13
               	jne	<addr>
               	movq	%rbx, %xmm2
               	vpextrw	$0x3, %xmm2, %eax
               	movswq	%ax, %rax
               	movw	%ax, -0x30(%rbp)
               	vpextrw	$0x3, %xmm2, %eax
               	movswq	%ax, %rax
               	movw	%ax, -0x2e(%rbp)
               	vpextrw	$0x3, %xmm2, %eax
               	movswq	%ax, %rax
               	movw	%ax, -0x2c(%rbp)
               	vpextrw	$0x3, %xmm2, %eax
               	movswq	%ax, %rax
               	movw	%ax, -0x2a(%rbp)
               	movq	-0x30(%rbp), %r13
               	movl	$0xff, %esi
               	movsd	%xmm1, 0x20(%rsp)
               	movsd	%xmm0, 0x28(%rsp)
               	movq	%rbx, %rdi
               	callq	<addr>
               	movsd	0x20(%rsp), %xmm1
               	movsd	0x28(%rsp), %xmm0
               	cmpq	%rax, %r13
               	jne	<addr>
               	movq	%rbx, %xmm2
               	vpextrw	$0x3, %xmm2, %eax
               	movswq	%ax, %rax
               	movw	%ax, -0x30(%rbp)
               	vpextrw	$0x3, %xmm2, %eax
               	movswq	%ax, %rax
               	movw	%ax, -0x2e(%rbp)
               	vpextrw	$0x3, %xmm2, %eax
               	movswq	%ax, %rax
               	movw	%ax, -0x2c(%rbp)
               	vpextrw	$0x3, %xmm2, %eax
               	movswq	%ax, %rax
               	movw	%ax, -0x2a(%rbp)
               	movq	-0x30(%rbp), %r13
               	movl	$0xff, %esi
               	movsd	%xmm1, 0x20(%rsp)
               	movsd	%xmm0, 0x28(%rsp)
               	movq	%rbx, %rdi
               	callq	<addr>
               	movsd	0x20(%rsp), %xmm1
               	movsd	0x28(%rsp), %xmm0
               	cmpq	%rax, %r13
               	jne	<addr>
               	movswq	%bx, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movq	%rbx, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movq	%rbx, %xmm2
               	movswq	%r12w, %rax
               	movapd	%xmm2, %xmm3
               	vpinsrw	$0x0, %eax, %xmm3, %xmm3
               	vmovq	%xmm3, %rdx
               	movq	%rbx, %rsi
               	andq	$-0x10000, %rsi         # imm = 0xFFFF0000
               	movq	%r12, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	orq	%rcx, %rsi
               	cmpq	%rsi, %rdx
               	jne	<addr>
               	movapd	%xmm2, %xmm3
               	vpinsrw	$0x0, %eax, %xmm3, %xmm3
               	vmovq	%xmm3, %rdx
               	movapd	%xmm2, %xmm3
               	vpinsrw	$0x0, %eax, %xmm3, %xmm3
               	vmovq	%xmm3, %rsi
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
               	vmovq	%xmm3, %rdx
               	movabsq	$-0xffff0001, %rsi      # imm = 0xFFFFFFFF0000FFFF
               	andq	%rbx, %rsi
               	movq	%rcx, %rdi
               	shlq	$0x10, %rdi
               	orq	%rdi, %rsi
               	cmpq	%rsi, %rdx
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
               	vmovq	%xmm3, %rdx
               	movabsq	$-0xffff00000001, %rsi  # imm = 0xFFFF0000FFFFFFFF
               	andq	%rbx, %rsi
               	shlq	$0x20, %rcx
               	orq	%rsi, %rcx
               	cmpq	%rcx, %rdx
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
               	vpinsrw	$0x3, %eax, %xmm2, %xmm2
               	vmovq	%xmm2, %rcx
               	movabsq	$0xffffffffffff, %rdx   # imm = 0xFFFFFFFFFFFF
               	andq	%rbx, %rdx
               	movq	%r12, %rsi
               	shlq	$0x30, %rsi
               	orq	%rsi, %rdx
               	cmpq	%rdx, %rcx
               	jne	<addr>
               	movq	%rbx, %xmm2
               	movapd	%xmm2, %xmm3
               	vpinsrw	$0x3, %eax, %xmm3, %xmm3
               	vmovq	%xmm3, %rcx
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
               	cmpl	$0x8, %eax
               	jge	<addr>
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	movslq	%ecx, %rcx
               	shrxq	%rcx, %r12, %rdx
               	andq	$0xff, %rdx
               	testb	$-0x80, %dl
               	je	<addr>
               	leaq	-0x10(%rbp), %rdx
               	leaq	0x1(%rax), %rsi
               	shrxq	%rcx, %rbx, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, (%rdx,%rsi)
               	jmp	<addr>
               	leaq	-0x20(%rbp), %rax
               	leaq	0x1(%rax), %rcx
               	leaq	-0x30(%rbp), %rdx
               	movq	%rbx, -0x30(%rbp)
               	leaq	-0x28(%rbp), %rsi
               	movq	%r12, -0x28(%rbp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	incq	%rax
               	cmpl	$0x8, %eax
               	jge	<addr>
               	movzbq	(%rsi,%rax), %rdi
               	testb	$-0x80, %dil
               	je	<addr>
               	movsbq	(%rdx,%rax), %rdi
               	movb	%dil, (%rcx,%rax)
               	jmp	<addr>
               	xorl	%eax, %eax
               	leaq	-0x20(%rbp), %rcx
               	movzbq	(%rcx,%rax), %rcx
               	leaq	-0x10(%rbp), %rdx
               	movzbq	(%rdx,%rax), %rdx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0xa, %eax
               	jl	<addr>
               	leaq	-0x20(%rbp), %rax
               	leaq	0x1(%rax), %rcx
               	leaq	-0x30(%rbp), %rdx
               	movq	%r12, -0x30(%rbp)
               	leaq	-0x28(%rbp), %rsi
               	movq	%rbx, -0x28(%rbp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	incq	%rax
               	cmpl	$0x8, %eax
               	jge	<addr>
               	movzbq	(%rsi,%rax), %rdi
               	testb	$-0x80, %dil
               	je	<addr>
               	movsbq	(%rdx,%rax), %rdi
               	movb	%dil, (%rcx,%rax)
               	jmp	<addr>
               	incq	%r14
               	cmpl	$0x7d0, %r14d           # imm = 0x7D0
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
               	subq	$0x40, %rsp
               	movl	$0x40200000, -0x18(%rbp) # imm = 0x40200000
               	movl	$0xc0600000, -0x14(%rbp) # imm = 0xC0600000
               	movl	$0x501502f9, -0x10(%rbp) # imm = 0x501502F9
               	movl	$0x7fc00000, -0xc(%rbp) # imm = 0x7FC00000
               	movss	-0x18(%rbp), %xmm0
               	vmovd	%xmm0, %r11d
               	vmovd	%r11d, %xmm0
               	movss	-0x14(%rbp), %xmm1
               	vmovd	%xmm1, %r11d
               	vpinsrd	$0x1, %r11d, %xmm0, %xmm0
               	movss	-0x10(%rbp), %xmm1
               	vmovd	%xmm1, %r11d
               	vpinsrd	$0x2, %r11d, %xmm0, %xmm0
               	movss	-0xc(%rbp), %xmm1
               	vmovd	%xmm1, %r11d
               	vpinsrd	$0x3, %r11d, %xmm0, %xmm0
               	vmovd	%xmm0, %eax
               	movslq	%eax, %rax
               	vmovd	%eax, %xmm1
               	vpextrd	$0x1, %xmm0, %eax
               	movslq	%eax, %rax
               	vpinsrd	$0x1, %eax, %xmm1, %xmm1
               	vmovd	%xmm0, %eax
               	movslq	%eax, %rax
               	vpinsrd	$0x2, %eax, %xmm1, %xmm1
               	vpextrd	$0x1, %xmm0, %eax
               	movslq	%eax, %rax
               	vpinsrd	$0x3, %eax, %xmm1, %xmm1
               	cvtps2dq	%xmm1, %xmm1
               	vmovq	%xmm1, %rax
               	movabsq	$-0x3fffffffe, %r11     # imm = 0xFFFFFFFC00000002
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xb0, %eax
               	leave
               	retq
               	vmovd	%xmm0, %eax
               	movslq	%eax, %rax
               	vmovd	%eax, %xmm1
               	vpextrd	$0x1, %xmm0, %eax
               	movslq	%eax, %rax
               	vpinsrd	$0x1, %eax, %xmm1, %xmm1
               	vmovd	%xmm0, %eax
               	movslq	%eax, %rax
               	vpinsrd	$0x2, %eax, %xmm1, %xmm1
               	vpextrd	$0x1, %xmm0, %eax
               	movslq	%eax, %rax
               	movapd	%xmm1, %xmm0
               	vpinsrd	$0x3, %eax, %xmm0, %xmm0
               	cvtps2dq	%xmm0, %xmm0
               	vmovq	%xmm0, %rax
               	movabsq	$-0x3fffffffe, %r11     # imm = 0xFFFFFFFC00000002
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xb1, %eax
               	leave
               	retq
               	movl	$0x501502f9, -0x18(%rbp) # imm = 0x501502F9
               	movl	$0x7fc00000, -0x14(%rbp) # imm = 0x7FC00000
               	movl	$0x0, -0x10(%rbp)
               	movl	$0x0, -0xc(%rbp)
               	movss	-0x18(%rbp), %xmm0
               	vmovd	%xmm0, %r11d
               	vmovd	%r11d, %xmm0
               	movss	-0x14(%rbp), %xmm1
               	vmovd	%xmm1, %r11d
               	vpinsrd	$0x1, %r11d, %xmm0, %xmm0
               	movss	-0x10(%rbp), %xmm1
               	vmovd	%xmm1, %r11d
               	vpinsrd	$0x2, %r11d, %xmm0, %xmm0
               	movss	-0xc(%rbp), %xmm1
               	vmovd	%xmm1, %r11d
               	vpinsrd	$0x3, %r11d, %xmm0, %xmm0
               	vmovd	%xmm0, %edx
               	movslq	%edx, %rdx
               	vmovd	%edx, %xmm1
               	vpextrd	$0x1, %xmm0, %edx
               	movslq	%edx, %rdx
               	vpinsrd	$0x1, %edx, %xmm1, %xmm1
               	vmovd	%xmm0, %edx
               	movslq	%edx, %rdx
               	vpinsrd	$0x2, %edx, %xmm1, %xmm1
               	vpextrd	$0x1, %xmm0, %edx
               	movslq	%edx, %rdx
               	movapd	%xmm1, %xmm0
               	vpinsrd	$0x3, %edx, %xmm0, %xmm0
               	cvtps2dq	%xmm0, %xmm0
               	vmovq	%xmm0, %rdx
               	movabsq	$-0x7fffffff80000000, %r11 # imm = 0x8000000080000000
               	cmpq	%r11, %rdx
               	je	<addr>
               	movl	$0xb2, %eax
               	leave
               	retq
               	movl	$0xc02ccccd, -0x18(%rbp) # imm = 0xC02CCCCD
               	movl	$0x402ccccd, -0x14(%rbp) # imm = 0x402CCCCD
               	movl	$0x0, -0x10(%rbp)
               	movl	$0x0, -0xc(%rbp)
               	movss	-0x18(%rbp), %xmm0
               	vmovd	%xmm0, %r11d
               	vmovd	%r11d, %xmm0
               	movss	-0x14(%rbp), %xmm1
               	vmovd	%xmm1, %r11d
               	vpinsrd	$0x1, %r11d, %xmm0, %xmm0
               	movss	-0x10(%rbp), %xmm1
               	vmovd	%xmm1, %r11d
               	vpinsrd	$0x2, %r11d, %xmm0, %xmm0
               	movss	-0xc(%rbp), %xmm1
               	vmovd	%xmm1, %r11d
               	vpinsrd	$0x3, %r11d, %xmm0, %xmm0
               	vmovd	%xmm0, %eax
               	movslq	%eax, %rax
               	vmovd	%eax, %xmm1
               	vpextrd	$0x1, %xmm0, %eax
               	movslq	%eax, %rax
               	vpinsrd	$0x1, %eax, %xmm1, %xmm1
               	vmovd	%xmm0, %eax
               	movslq	%eax, %rax
               	vpinsrd	$0x2, %eax, %xmm1, %xmm1
               	vpextrd	$0x1, %xmm0, %eax
               	movslq	%eax, %rax
               	movapd	%xmm1, %xmm0
               	vpinsrd	$0x3, %eax, %xmm0, %xmm0
               	cvttps2dq	%xmm0, %xmm0
               	vmovq	%xmm0, %rax
               	movabsq	$0x2fffffffe, %r11      # imm = 0x2FFFFFFFE
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xb3, %eax
               	leave
               	retq
               	movl	$0xcf000000, -0x18(%rbp) # imm = 0xCF000000
               	movl	$0x4f000000, -0x14(%rbp) # imm = 0x4F000000
               	movl	$0x0, -0x10(%rbp)
               	movl	$0x0, -0xc(%rbp)
               	movss	-0x18(%rbp), %xmm0
               	vmovd	%xmm0, %r11d
               	vmovd	%r11d, %xmm0
               	movss	-0x14(%rbp), %xmm1
               	vmovd	%xmm1, %r11d
               	vpinsrd	$0x1, %r11d, %xmm0, %xmm0
               	movss	-0x10(%rbp), %xmm1
               	vmovd	%xmm1, %r11d
               	vpinsrd	$0x2, %r11d, %xmm0, %xmm0
               	movss	-0xc(%rbp), %xmm1
               	vmovd	%xmm1, %r11d
               	vpinsrd	$0x3, %r11d, %xmm0, %xmm0
               	vmovd	%xmm0, %eax
               	movslq	%eax, %rax
               	vmovd	%eax, %xmm1
               	vpextrd	$0x1, %xmm0, %eax
               	movslq	%eax, %rax
               	vpinsrd	$0x1, %eax, %xmm1, %xmm1
               	vmovd	%xmm0, %eax
               	movslq	%eax, %rax
               	vpinsrd	$0x2, %eax, %xmm1, %xmm1
               	vpextrd	$0x1, %xmm0, %eax
               	movslq	%eax, %rax
               	movapd	%xmm1, %xmm0
               	vpinsrd	$0x3, %eax, %xmm0, %xmm0
               	cvttps2dq	%xmm0, %xmm0
               	vmovq	%xmm0, %rax
               	movabsq	$-0x7fffffff80000000, %r11 # imm = 0x8000000080000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xb4, %eax
               	leave
               	retq
               	leaq	-0x8(%rbp), %rax
               	stmxcsr	(%rax)
               	movl	-0x8(%rbp), %eax
               	movl	$0xffff9fff, %r11d      # imm = 0xFFFF9FFF
               	andq	%r11, %rax
               	orq	$0x2000, %rax           # imm = 0x2000
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	ldmxcsr	(%rax)
               	movl	$0x40200000, -0x18(%rbp) # imm = 0x40200000
               	movl	$0xc0200000, -0x14(%rbp) # imm = 0xC0200000
               	movl	$0x0, -0x10(%rbp)
               	movl	$0x0, -0xc(%rbp)
               	movss	-0x18(%rbp), %xmm0
               	vmovd	%xmm0, %r11d
               	vmovd	%r11d, %xmm0
               	movss	-0x14(%rbp), %xmm1
               	vmovd	%xmm1, %r11d
               	vpinsrd	$0x1, %r11d, %xmm0, %xmm0
               	movss	-0x10(%rbp), %xmm1
               	vmovd	%xmm1, %r11d
               	vpinsrd	$0x2, %r11d, %xmm0, %xmm0
               	movss	-0xc(%rbp), %xmm1
               	vmovd	%xmm1, %r11d
               	vpinsrd	$0x3, %r11d, %xmm0, %xmm0
               	vmovd	%xmm0, %eax
               	movslq	%eax, %rax
               	vmovd	%eax, %xmm1
               	vpextrd	$0x1, %xmm0, %eax
               	movslq	%eax, %rax
               	vpinsrd	$0x1, %eax, %xmm1, %xmm1
               	vmovd	%xmm0, %eax
               	movslq	%eax, %rax
               	vpinsrd	$0x2, %eax, %xmm1, %xmm1
               	vpextrd	$0x1, %xmm0, %eax
               	movslq	%eax, %rax
               	movapd	%xmm1, %xmm0
               	vpinsrd	$0x3, %eax, %xmm0, %xmm0
               	cvtps2dq	%xmm0, %xmm0
               	vmovq	%xmm0, %rax
               	movabsq	$-0x2fffffffe, %r11     # imm = 0xFFFFFFFD00000002
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xb6, %eax
               	leave
               	retq
               	leaq	-0x8(%rbp), %rax
               	stmxcsr	(%rax)
               	movl	-0x8(%rbp), %eax
               	movl	$0xffff9fff, %r11d      # imm = 0xFFFF9FFF
               	andq	%r11, %rax
               	orq	$0x4000, %rax           # imm = 0x4000
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	ldmxcsr	(%rax)
               	movl	$0x40200000, -0x18(%rbp) # imm = 0x40200000
               	movl	$0xc0200000, -0x14(%rbp) # imm = 0xC0200000
               	movl	$0x0, -0x10(%rbp)
               	movl	$0x0, -0xc(%rbp)
               	movss	-0x18(%rbp), %xmm0
               	vmovd	%xmm0, %r11d
               	vmovd	%r11d, %xmm0
               	movss	-0x14(%rbp), %xmm1
               	vmovd	%xmm1, %r11d
               	vpinsrd	$0x1, %r11d, %xmm0, %xmm0
               	movss	-0x10(%rbp), %xmm1
               	vmovd	%xmm1, %r11d
               	vpinsrd	$0x2, %r11d, %xmm0, %xmm0
               	movss	-0xc(%rbp), %xmm1
               	vmovd	%xmm1, %r11d
               	vpinsrd	$0x3, %r11d, %xmm0, %xmm0
               	vmovd	%xmm0, %eax
               	movslq	%eax, %rax
               	vmovd	%eax, %xmm1
               	vpextrd	$0x1, %xmm0, %eax
               	movslq	%eax, %rax
               	vpinsrd	$0x1, %eax, %xmm1, %xmm1
               	vmovd	%xmm0, %eax
               	movslq	%eax, %rax
               	vpinsrd	$0x2, %eax, %xmm1, %xmm1
               	vpextrd	$0x1, %xmm0, %eax
               	movslq	%eax, %rax
               	movapd	%xmm1, %xmm0
               	vpinsrd	$0x3, %eax, %xmm0, %xmm0
               	cvtps2dq	%xmm0, %xmm0
               	vmovq	%xmm0, %rax
               	movabsq	$-0x1fffffffd, %r11     # imm = 0xFFFFFFFE00000003
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xb8, %eax
               	leave
               	retq
               	movl	$0x3f99999a, -0x18(%rbp) # imm = 0x3F99999A
               	movl	$0xbf99999a, -0x14(%rbp) # imm = 0xBF99999A
               	movl	$0x471c4000, -0x10(%rbp) # imm = 0x471C4000
               	movl	$0xc71c4000, -0xc(%rbp) # imm = 0xC71C4000
               	movss	-0x18(%rbp), %xmm0
               	vmovd	%xmm0, %r11d
               	vmovd	%r11d, %xmm0
               	movss	-0x14(%rbp), %xmm1
               	vmovd	%xmm1, %r11d
               	vpinsrd	$0x1, %r11d, %xmm0, %xmm0
               	movss	-0x10(%rbp), %xmm1
               	vmovd	%xmm1, %r11d
               	vpinsrd	$0x2, %r11d, %xmm0, %xmm0
               	movss	-0xc(%rbp), %xmm1
               	vmovd	%xmm1, %r11d
               	vpinsrd	$0x3, %r11d, %xmm0, %xmm0
               	cvtps2dq	%xmm0, %xmm0
               	vmovd	%xmm0, %edx
               	movslq	%edx, %rdx
               	movl	$0x7fff, %eax           # imm = 0x7FFF
               	cmpl	%eax, %edx
               	jle	<addr>
               	movq	%rax, %rdx
               	movswq	%dx, %rdx
               	vpinsrw	$0x0, %edx, %xmm1, %xmm1
               	vpextrd	$0x1, %xmm0, %edx
               	movslq	%edx, %rdx
               	cmpl	%eax, %edx
               	jle	<addr>
               	movq	%rax, %rdx
               	movswq	%dx, %rdx
               	vpinsrw	$0x1, %edx, %xmm1, %xmm1
               	vpextrd	$0x2, %xmm0, %edx
               	movslq	%edx, %rdx
               	cmpl	%eax, %edx
               	jle	<addr>
               	movq	%rax, %rdx
               	movswq	%dx, %rdx
               	vpinsrw	$0x2, %edx, %xmm1, %xmm1
               	vpextrd	$0x3, %xmm0, %edx
               	movslq	%edx, %rdx
               	cmpl	%eax, %edx
               	jle	<addr>
               	movswq	%ax, %rax
               	vpinsrw	$0x3, %eax, %xmm1, %xmm1
               	vmovq	%xmm1, %rax
               	movabsq	$-0x7fff80000000fffe, %r11 # imm = 0x80007FFFFFFF0002
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xb9, %eax
               	leave
               	retq
               	leaq	-0x8(%rbp), %rax
               	stmxcsr	(%rax)
               	movl	-0x8(%rbp), %eax
               	movl	$0xffff9fff, %r11d      # imm = 0xFFFF9FFF
               	andq	%r11, %rax
               	orq	$0x6000, %rax           # imm = 0x6000
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	ldmxcsr	(%rax)
               	movl	$0x40200000, -0x18(%rbp) # imm = 0x40200000
               	movl	$0xc0200000, -0x14(%rbp) # imm = 0xC0200000
               	movl	$0x0, -0x10(%rbp)
               	movl	$0x0, -0xc(%rbp)
               	movss	-0x18(%rbp), %xmm0
               	vmovd	%xmm0, %r11d
               	vmovd	%r11d, %xmm0
               	movss	-0x14(%rbp), %xmm2
               	vmovd	%xmm2, %r11d
               	vpinsrd	$0x1, %r11d, %xmm0, %xmm0
               	movss	-0x10(%rbp), %xmm2
               	vmovd	%xmm2, %r11d
               	vpinsrd	$0x2, %r11d, %xmm0, %xmm0
               	movss	-0xc(%rbp), %xmm2
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
               	movl	$0x40200000, -0x18(%rbp) # imm = 0x40200000
               	movl	$0xc0200000, -0x14(%rbp) # imm = 0xC0200000
               	movl	$0x0, -0x10(%rbp)
               	movl	$0x0, -0xc(%rbp)
               	movss	-0x18(%rbp), %xmm0
               	vmovd	%xmm0, %r11d
               	vmovd	%r11d, %xmm0
               	movss	-0x14(%rbp), %xmm2
               	vmovd	%xmm2, %r11d
               	vpinsrd	$0x1, %r11d, %xmm0, %xmm0
               	movss	-0x10(%rbp), %xmm2
               	vmovd	%xmm2, %r11d
               	vpinsrd	$0x2, %r11d, %xmm0, %xmm0
               	movss	-0xc(%rbp), %xmm2
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
               	leaq	-0x8(%rbp), %rax
               	stmxcsr	(%rax)
               	movl	-0x8(%rbp), %eax
               	movl	$0xffff9fff, %r11d      # imm = 0xFFFF9FFF
               	andq	%r11, %rax
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	ldmxcsr	(%rax)
               	movl	$0x3fc00000, -0x18(%rbp) # imm = 0x3FC00000
               	movl	$0xbfc00000, -0x14(%rbp) # imm = 0xBFC00000
               	movl	$0x471c4000, -0x10(%rbp) # imm = 0x471C4000
               	movl	$0x7fc00000, -0xc(%rbp) # imm = 0x7FC00000
               	movss	-0x18(%rbp), %xmm0
               	vmovd	%xmm0, %r11d
               	vmovd	%r11d, %xmm0
               	movss	-0x14(%rbp), %xmm2
               	vmovd	%xmm2, %r11d
               	vpinsrd	$0x1, %r11d, %xmm0, %xmm0
               	movss	-0x10(%rbp), %xmm2
               	vmovd	%xmm2, %r11d
               	vpinsrd	$0x2, %r11d, %xmm0, %xmm0
               	movss	-0xc(%rbp), %xmm2
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
               	movl	$0x43960000, -0x18(%rbp) # imm = 0x43960000
               	movl	$0xc3960000, -0x14(%rbp) # imm = 0xC3960000
               	movl	$0x3f000000, -0x10(%rbp) # imm = 0x3F000000
               	movl	$0xc0e00000, -0xc(%rbp) # imm = 0xC0E00000
               	movss	-0x18(%rbp), %xmm0
               	vmovd	%xmm0, %r11d
               	vmovd	%r11d, %xmm0
               	movss	-0x14(%rbp), %xmm1
               	vmovd	%xmm1, %r11d
               	vpinsrd	$0x1, %r11d, %xmm0, %xmm0
               	movss	-0x10(%rbp), %xmm1
               	vmovd	%xmm1, %r11d
               	vpinsrd	$0x2, %r11d, %xmm0, %xmm0
               	movss	-0xc(%rbp), %xmm1
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
               	movl	$0x4b800000, %eax       # imm = 0x4B800000
               	movl	$0xc0a00000, %ecx       # imm = 0xC0A00000
               	vpermilps	$0x2, %xmm0, %xmm1 # xmm1 = xmm0[2,0,0,0]
               	vpermilps	$0x3, %xmm0, %xmm0 # xmm0 = xmm0[3,0,0,0]
               	movq	%rax, %xmm2
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm2
               	jp	<addr>
               	jne	<addr>
               	movq	%rcx, %xmm2
               	movq	%rcx, %xmm15
               	ucomiss	%xmm15, %xmm2
               	jp	<addr>
               	jne	<addr>
               	movl	$0x41100000, %eax       # imm = 0x41100000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm1
               	jp	<addr>
               	jne	<addr>
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xc1, %eax
               	leave
               	retq
               	leaq	<rip>, %rax # <addr>
               	movups	(%rax), %xmm0
               	movl	$0x40c00000, %eax       # imm = 0x40C00000
               	movl	$0x40e00000, %ecx       # imm = 0x40E00000
               	vpermilps	$0x2, %xmm0, %xmm1 # xmm1 = xmm0[2,0,0,0]
               	vpermilps	$0x3, %xmm0, %xmm0 # xmm0 = xmm0[3,0,0,0]
               	movq	%rax, %xmm2
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm2
               	jp	<addr>
               	jne	<addr>
               	movq	%rcx, %xmm2
               	movq	%rcx, %xmm15
               	ucomiss	%xmm15, %xmm2
               	jp	<addr>
               	jne	<addr>
               	movl	$0x40400000, %eax       # imm = 0x40400000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm1
               	jp	<addr>
               	jne	<addr>
               	movl	$0x40800000, %eax       # imm = 0x40800000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xc3, %eax
               	leave
               	retq
               	movl	$0xc7000000, %eax       # imm = 0xC7000000
               	movl	$0x46fffe00, %ecx       # imm = 0x46FFFE00
               	movl	$0xbf800000, %edx       # imm = 0xBF800000
               	xorl	%esi, %esi
               	movq	%rax, %xmm0
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movq	%rcx, %xmm0
               	movq	%rcx, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movq	%rdx, %xmm0
               	movq	%rdx, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movq	%rsi, %xmm0
               	movq	%rsi, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xc5, %eax
               	leave
               	retq
               	movl	$0x47000000, %eax       # imm = 0x47000000
               	movl	$0x46fffe00, %ecx       # imm = 0x46FFFE00
               	movl	$0x477fff00, %edx       # imm = 0x477FFF00
               	xorl	%esi, %esi
               	movq	%rax, %xmm0
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movq	%rcx, %xmm0
               	movq	%rcx, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movq	%rdx, %xmm0
               	movq	%rdx, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movq	%rsi, %xmm0
               	movq	%rsi, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xc7, %eax
               	leave
               	retq
               	movl	$0xc3000000, %eax       # imm = 0xC3000000
               	movl	$0x42fe0000, %ecx       # imm = 0x42FE0000
               	movl	$0xbf800000, %edx       # imm = 0xBF800000
               	movl	$0x40a00000, %esi       # imm = 0x40A00000
               	movq	%rax, %xmm0
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movq	%rcx, %xmm0
               	movq	%rcx, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movq	%rdx, %xmm0
               	movq	%rdx, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movq	%rsi, %xmm0
               	movq	%rsi, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xc9, %eax
               	leave
               	retq
               	movl	$0x43000000, %eax       # imm = 0x43000000
               	movl	$0x42fe0000, %ecx       # imm = 0x42FE0000
               	movl	$0x437f0000, %edx       # imm = 0x437F0000
               	movl	$0x40a00000, %esi       # imm = 0x40A00000
               	movq	%rax, %xmm0
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movq	%rcx, %xmm0
               	movq	%rcx, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movq	%rdx, %xmm0
               	movq	%rdx, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movq	%rsi, %xmm0
               	movq	%rsi, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xcb, %eax
               	leave
               	retq
               	movl	$0x3f800000, %eax       # imm = 0x3F800000
               	movl	$0x40000000, %ecx       # imm = 0x40000000
               	movl	$0x40400000, %edx       # imm = 0x40400000
               	movl	$0xc0800000, %esi       # imm = 0xC0800000
               	movq	%rax, %xmm0
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movq	%rcx, %xmm0
               	movq	%rcx, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movq	%rdx, %xmm0
               	movq	%rdx, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movq	%rsi, %xmm0
               	movq	%rsi, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xcd, %eax
               	leave
               	retq
               	leaq	-0x38(%rbp), %rax
               	leaq	<rip>, %rcx # <addr>
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	-0x30(%rbp), %rcx
               	incq	%rcx
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	leaq	<rip>, %rax # <addr>
               	movups	(%rax), %xmm0
               	movsd	-0x2f(%rbp), %xmm1
               	vpermilps	$0x0, %xmm0, %xmm2 # xmm2 = xmm0[0,0,0,0]
               	vpermilps	$0x1, %xmm0, %xmm0 # xmm0 = xmm0[1,0,0,0]
               	vpermilps	$0x0, %xmm1, %xmm3 # xmm3 = xmm1[0,0,0,0]
               	vpermilps	$0x1, %xmm1, %xmm1 # xmm1 = xmm1[1,0,0,0]
               	movl	$0x3f800000, %eax       # imm = 0x3F800000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm2
               	jp	<addr>
               	jne	<addr>
               	movl	$0x40000000, %eax       # imm = 0x40000000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movapd	%xmm3, %xmm0
               	movl	$0x3fa00000, %eax       # imm = 0x3FA00000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movapd	%xmm1, %xmm0
               	movl	$0xc0200000, %eax       # imm = 0xC0200000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xd2, %eax
               	leave
               	retq
               	leaq	<rip>, %rdx # <addr>
               	movups	(%rdx), %xmm0
               	movsd	-0x2f(%rbp), %xmm1
               	vpermilps	$0x0, %xmm1, %xmm2 # xmm2 = xmm1[0,0,0,0]
               	vpermilps	$0x1, %xmm1, %xmm1 # xmm1 = xmm1[1,0,0,0]
               	vpermilps	$0x2, %xmm0, %xmm3 # xmm3 = xmm0[2,0,0,0]
               	vpermilps	$0x3, %xmm0, %xmm0 # xmm0 = xmm0[3,0,0,0]
               	movl	$0x3fa00000, %edx       # imm = 0x3FA00000
               	movq	%rdx, %xmm15
               	ucomiss	%xmm15, %xmm2
               	jp	<addr>
               	jne	<addr>
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm1
               	jp	<addr>
               	jne	<addr>
               	movapd	%xmm3, %xmm1
               	movl	$0x40400000, %eax       # imm = 0x40400000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm1
               	jp	<addr>
               	jne	<addr>
               	movl	$0x40800000, %eax       # imm = 0x40800000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xd4, %eax
               	leave
               	retq
               	leaq	<rip>, %rdx # <addr>
               	movups	(%rdx), %xmm0
               	vpermilpd	$0x1, %xmm0, %xmm0 # xmm0 = xmm0[1,0]
               	movsd	%xmm0, -0x2f(%rbp)
               	leaq	<rip>, %rdx # <addr>
               	movups	(%rdx), %xmm0
               	movsd	%xmm0, -0x27(%rbp)
               	leaq	-0x40(%rbp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movss	-0x40(%rbp), %xmm0
               	movl	$0x40400000, %ecx       # imm = 0x40400000
               	movq	%rcx, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	-0x3c(%rbp), %xmm0
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	-0x38(%rbp), %xmm0
               	movl	$0x40a00000, %eax       # imm = 0x40A00000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	-0x34(%rbp), %xmm0
               	movl	$0x40c00000, %eax       # imm = 0x40C00000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
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
               	cmpl	$0xffff8000, %edx       # imm = 0xFFFF8000
               	cmovgeq	%rdx, %rax
               	jmp	<addr>
               	movq	$-0x8000, %rsi          # imm = 0x8000
               	cmpl	$0xffff8000, %edx       # imm = 0xFFFF8000
               	cmovlq	%rsi, %rdx
               	jmp	<addr>
               	movq	$-0x8000, %rsi          # imm = 0x8000
               	cmpl	$0xffff8000, %edx       # imm = 0xFFFF8000
               	cmovlq	%rsi, %rdx
               	jmp	<addr>
               	movq	$-0x8000, %rsi          # imm = 0x8000
               	cmpl	$0xffff8000, %edx       # imm = 0xFFFF8000
               	cmovlq	%rsi, %rdx
               	jmp	<addr>

<sse2>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	pushq	%r12
               	pushq	%rbx
               	xorl	%ebx, %ebx
               	callq	<addr>
               	movq	%rax, %r12
               	callq	<addr>
               	movq	%r12, %xmm0
               	movq	%rax, %xmm1
               	vpmuludq	%xmm1, %xmm0, %xmm0
               	vmovq	%xmm0, %rcx
               	movl	%r12d, %edx
               	movl	%eax, %eax
               	imulq	%rdx, %rax
               	cmpq	%rax, %rcx
               	jne	<addr>
               	incq	%rbx
               	cmpl	$0x7d0, %ebx            # imm = 0x7D0
               	jl	<addr>
               	movabsq	$0x4004000000000000, %rax # imm = 0x4004000000000000
               	movabsq	$-0x3ff4000000000000, %rcx # imm = 0xC00C000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x18(%rbp)
               	movq	%rcx, %xmm14
               	movsd	%xmm14, -0x10(%rbp)
               	movsd	-0x18(%rbp), %xmm0
               	movsd	-0x10(%rbp), %xmm1
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
               	movabsq	$0x41dfffffffd9999a, %rax # imm = 0x41DFFFFFFFD9999A
               	movabsq	$-0x3e20000000000000, %rcx # imm = 0xC1E0000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x18(%rbp)
               	movq	%rcx, %xmm14
               	movsd	%xmm14, -0x10(%rbp)
               	movsd	-0x18(%rbp), %xmm0
               	movsd	-0x10(%rbp), %xmm1
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
               	movabsq	$0x41e65a0bc0000000, %rax # imm = 0x41E65A0BC0000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x18(%rbp)
               	movabsq	$0x7ff8000000000000, %rax # imm = 0x7FF8000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x10(%rbp)
               	movsd	-0x18(%rbp), %xmm0
               	movsd	-0x10(%rbp), %xmm1
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
               	leaq	-0x8(%rbp), %rax
               	stmxcsr	(%rax)
               	movl	-0x8(%rbp), %eax
               	movl	$0xffff9fff, %r11d      # imm = 0xFFFF9FFF
               	andq	%r11, %rax
               	orq	$0x2000, %rax           # imm = 0x2000
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	ldmxcsr	(%rax)
               	movabsq	$0x4004000000000000, %rax # imm = 0x4004000000000000
               	movabsq	$-0x3ffc000000000000, %rcx # imm = 0xC004000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x18(%rbp)
               	movq	%rcx, %xmm14
               	movsd	%xmm14, -0x10(%rbp)
               	movsd	-0x18(%rbp), %xmm0
               	movsd	-0x10(%rbp), %xmm1
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
               	leaq	-0x8(%rbp), %rax
               	stmxcsr	(%rax)
               	movl	-0x8(%rbp), %eax
               	movl	$0xffff9fff, %r11d      # imm = 0xFFFF9FFF
               	andq	%r11, %rax
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	ldmxcsr	(%rax)
               	movabsq	$-0x3ffa666666666666, %rax # imm = 0xC00599999999999A
               	movabsq	$0x41dffffffff9999a, %rcx # imm = 0x41DFFFFFFFF9999A
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x18(%rbp)
               	movq	%rcx, %xmm14
               	movsd	%xmm14, -0x10(%rbp)
               	movsd	-0x18(%rbp), %xmm0
               	movsd	-0x10(%rbp), %xmm1
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
               	movabsq	$-0x3e1fffffffe00000, %rax # imm = 0xC1E0000000200000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x18(%rbp)
               	movabsq	$0x7ff8000000000000, %rax # imm = 0x7FF8000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x10(%rbp)
               	movsd	-0x18(%rbp), %xmm0
               	movsd	-0x10(%rbp), %xmm1
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
               	movabsq	$0x41dfffffffc00000, %rax # imm = 0x41DFFFFFFFC00000
               	movabsq	$-0x3e20000000000000, %rcx # imm = 0xC1E0000000000000
               	movq	%rax, %xmm0
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movq	%rcx, %xmm0
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm0
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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x58, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	xorl	%r10d, %r10d
               	movq	%r10, 0x40(%rsp)
               	movsd	%xmm0, 0x38(%rsp)
               	movsd	%xmm1, 0x30(%rsp)
               	callq	<addr>
               	movq	%rax, %rbx
               	movsd	0x38(%rsp), %xmm0
               	movsd	0x30(%rsp), %xmm1
               	movsd	%xmm0, 0x38(%rsp)
               	movsd	%xmm1, 0x30(%rsp)
               	callq	<addr>
               	movq	%rax, %r8
               	movsd	0x38(%rsp), %xmm0
               	movsd	0x30(%rsp), %xmm1
               	movq	%r8, -0x28(%rbp)
               	xorl	%r10d, %r10d
               	movq	%r10, 0x48(%rsp)
               	movq	0x48(%rsp), %rax
               	cmpl	$0x3, %eax
               	jge	<addr>
               	leaq	<rip>, %rcx # <addr>
               	movslq	(%rcx,%rax,4), %rcx
               	movl	$0x40, %eax
               	cltd
               	idivl	%ecx
               	movq	%rax, %r13
               	xorl	%edx, %edx
               	leaq	-0x1(%rcx), %rax
               	movslq	%eax, %r12
               	movq	%rdx, %r9
               	movq	%rdx, %rax
               	jmp	<addr>
               	movl	$0x1, %edi
               	shlxq	%rcx, %rdi, %rdi
               	decq	%rdi
               	andq	%rdi, %rsi
               	movq	%rcx, %rdi
               	imulq	%rdx, %rdi
               	movslq	%edi, %rdi
               	shlxq	%rdi, %rsi, %rsi
               	orq	%rsi, %r9
               	incq	%rdx
               	cmpl	%r13d, %edx
               	jge	<addr>
               	cmpl	$0x40, %ecx
               	jne	<addr>
               	movq	%rbx, %rsi
               	cmpl	$0x40, %ecx
               	jge	<addr>
               	shrxq	%r12, %rsi, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	movl	$0x1, %edi
               	shlxq	%rcx, %rdi, %rdi
               	subq	%rdi, %rsi
               	cmpl	$0x40, %ecx
               	jne	<addr>
               	movq	%r8, %rdi
               	cmpl	$0x40, %ecx
               	jge	<addr>
               	shrxq	%r12, %rdi, %r14
               	testq	%r14, %r14
               	je	<addr>
               	movl	$0x1, %r14d
               	shlxq	%rcx, %r14, %r14
               	subq	%r14, %rdi
               	movq	%rsi, %r14
               	negq	%r14
               	testq	%rsi, %rsi
               	movq	%rsi, %r15
               	cmovlq	%r14, %r15
               	movl	$0x1, %r14d
               	shlxq	%rcx, %r14, %r14
               	decq	%r14
               	andq	%r15, %r14
               	movq	%rcx, %r15
               	imulq	%rdx, %r15
               	movslq	%r15d, %r15
               	shlxq	%r15, %r14, %r14
               	orq	%r14, %rax
               	testq	%rdi, %rdi
               	jge	<addr>
               	negq	%rsi
               	jmp	<addr>
               	xorl	%r14d, %r14d
               	testq	%rdi, %rdi
               	cmoveq	%r14, %rsi
               	jmp	<addr>
               	movq	%rcx, %rdi
               	imulq	%rdx, %rdi
               	movslq	%edi, %rdi
               	shrxq	%rdi, %r8, %rdi
               	movl	$0x1, %r14d
               	shlxq	%rcx, %r14, %r14
               	decq	%r14
               	andq	%r14, %rdi
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
               	movq	%rbx, -0x20(%rbp)
               	xorl	%edx, %edx
               	jmp	<addr>
               	andq	$0xff, %rsi
               	movb	%sil, (%rdi,%rdx)
               	incq	%rdx
               	cmpl	$0x8, %edx
               	jge	<addr>
               	leaq	-0x18(%rbp), %rdi
               	leaq	-0x20(%rbp), %rsi
               	movsbq	(%rsi,%rdx), %rsi
               	testl	%esi, %esi
               	jge	<addr>
               	leaq	-0x20(%rbp), %rsi
               	movsbq	(%rsi,%rdx), %rsi
               	negq	%rsi
               	jmp	<addr>
               	leaq	-0x20(%rbp), %rsi
               	movsbq	(%rsi,%rdx), %rsi
               	jmp	<addr>
               	movq	-0x18(%rbp), %rdi
               	cmpl	$0x8, %ecx
               	jne	<addr>
               	leaq	-0x28(%rbp), %rcx
               	leaq	-0x20(%rbp), %rdx
               	movq	(%rcx), %r10
               	movq	%r10, (%rdx)
               	movq	%rbx, -0x18(%rbp)
               	leaq	-0x20(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	movq	(%rcx), %r10
               	movq	%r10, (%rdx)
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	andq	$0xff, %rdx
               	movb	%dl, (%rsi,%rcx)
               	incq	%rcx
               	cmpl	$0x8, %ecx
               	jge	<addr>
               	leaq	-0x8(%rbp), %rsi
               	leaq	-0x10(%rbp), %rdx
               	movsbq	(%rdx,%rcx), %rdx
               	testl	%edx, %edx
               	jge	<addr>
               	leaq	-0x18(%rbp), %rdx
               	movsbq	(%rdx,%rcx), %rdx
               	negq	%rdx
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rdx
               	cmpb	$0x0, (%rdx,%rcx)
               	je	<addr>
               	leaq	-0x18(%rbp), %rdx
               	movsbq	(%rdx,%rcx), %rdx
               	jmp	<addr>
               	xorl	%edx, %edx
               	jmp	<addr>
               	movq	-0x8(%rbp), %rcx
               	cmpq	%rax, %rdi
               	jne	<addr>
               	cmpq	%r9, %rcx
               	je	<addr>
               	jmp	<addr>
               	cmpl	$0x10, %ecx
               	jne	<addr>
               	leaq	-0x28(%rbp), %rcx
               	leaq	-0x20(%rbp), %rdx
               	movq	(%rcx), %r10
               	movq	%r10, (%rdx)
               	movq	%rbx, -0x18(%rbp)
               	leaq	-0x20(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	movq	(%rcx), %r10
               	movq	%r10, (%rdx)
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	movw	%dx, (%rsi,%rcx,2)
               	incq	%rcx
               	cmpl	$0x4, %ecx
               	jge	<addr>
               	leaq	-0x8(%rbp), %rsi
               	leaq	-0x10(%rbp), %rdx
               	movswq	(%rdx,%rcx,2), %rdx
               	testl	%edx, %edx
               	jge	<addr>
               	leaq	-0x18(%rbp), %rdx
               	movswq	(%rdx,%rcx,2), %rdx
               	negq	%rdx
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rdx
               	cmpw	$0x0, (%rdx,%rcx,2)
               	je	<addr>
               	leaq	-0x18(%rbp), %rdx
               	movswq	(%rdx,%rcx,2), %rdx
               	jmp	<addr>
               	xorl	%edx, %edx
               	jmp	<addr>
               	movq	-0x8(%rbp), %rcx
               	jmp	<addr>
               	leaq	-0x28(%rbp), %rcx
               	leaq	-0x20(%rbp), %rdx
               	movq	(%rcx), %r10
               	movq	%r10, (%rdx)
               	movq	%rbx, -0x18(%rbp)
               	leaq	-0x20(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	movq	(%rcx), %r10
               	movq	%r10, (%rdx)
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	movl	%edx, (%rsi,%rcx,4)
               	incq	%rcx
               	cmpl	$0x2, %ecx
               	jge	<addr>
               	leaq	-0x8(%rbp), %rsi
               	leaq	-0x10(%rbp), %rdx
               	movl	(%rdx,%rcx,4), %edx
               	testl	%edx, %edx
               	jge	<addr>
               	leaq	-0x18(%rbp), %rdx
               	movl	(%rdx,%rcx,4), %edx
               	negq	%rdx
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rdx
               	cmpl	$0x0, (%rdx,%rcx,4)
               	je	<addr>
               	leaq	-0x18(%rbp), %rdx
               	movl	(%rdx,%rcx,4), %edx
               	jmp	<addr>
               	xorl	%edx, %edx
               	jmp	<addr>
               	movq	-0x8(%rbp), %rcx
               	jmp	<addr>
               	cmpl	$0x10, %ecx
               	jne	<addr>
               	movq	%rbx, -0x20(%rbp)
               	xorl	%edx, %edx
               	jmp	<addr>
               	andq	$0xffff, %rsi           # imm = 0xFFFF
               	movw	%si, (%rdi,%rdx,2)
               	incq	%rdx
               	cmpl	$0x4, %edx
               	jge	<addr>
               	leaq	-0x18(%rbp), %rdi
               	leaq	-0x20(%rbp), %rsi
               	movswq	(%rsi,%rdx,2), %rsi
               	testl	%esi, %esi
               	jge	<addr>
               	leaq	-0x20(%rbp), %rsi
               	movswq	(%rsi,%rdx,2), %rsi
               	negq	%rsi
               	jmp	<addr>
               	leaq	-0x20(%rbp), %rsi
               	movswq	(%rsi,%rdx,2), %rsi
               	jmp	<addr>
               	movq	-0x18(%rbp), %rdi
               	jmp	<addr>
               	movq	%rbx, -0x20(%rbp)
               	xorl	%edx, %edx
               	jmp	<addr>
               	movl	%esi, (%rdi,%rdx,4)
               	incq	%rdx
               	cmpl	$0x2, %edx
               	jge	<addr>
               	leaq	-0x18(%rbp), %rdi
               	leaq	-0x20(%rbp), %rsi
               	movl	(%rsi,%rdx,4), %esi
               	testl	%esi, %esi
               	jge	<addr>
               	leaq	-0x20(%rbp), %rsi
               	movl	(%rsi,%rdx,4), %esi
               	negq	%rsi
               	jmp	<addr>
               	leaq	-0x20(%rbp), %rsi
               	movl	(%rsi,%rdx,4), %esi
               	jmp	<addr>
               	movq	-0x18(%rbp), %rdi
               	jmp	<addr>
               	movq	0x48(%rsp), %r10
               	incq	%r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x48(%rsp), %rax
               	cmpl	$0x3, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movq	%rbx, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	movq	%rcx, %rdx
               	shrq	$0xf, %rdx
               	leaq	-0x10000(%rcx), %rsi
               	testq	%rdx, %rdx
               	cmovneq	%rsi, %rcx
               	movq	%rbx, %rdx
               	shrq	$0x10, %rdx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	movq	%rdx, %rsi
               	shrq	$0xf, %rsi
               	leaq	-0x10000(%rdx), %rdi
               	testq	%rsi, %rsi
               	cmovneq	%rdi, %rdx
               	movq	%r8, %rsi
               	andq	$0xffff, %rsi           # imm = 0xFFFF
               	movq	%rsi, %rdi
               	shrq	$0xf, %rdi
               	leaq	-0x10000(%rsi), %r9
               	testq	%rdi, %rdi
               	cmovneq	%r9, %rsi
               	movq	%r8, %rdi
               	shrq	$0x10, %rdi
               	andq	$0xffff, %rdi           # imm = 0xFFFF
               	movq	%rdi, %r9
               	shrq	$0xf, %r9
               	leaq	-0x10000(%rdi), %r12
               	testq	%r9, %r9
               	cmovneq	%r12, %rdi
               	leaq	(%rcx,%rdx), %r9
               	andq	$0xffff, %r9            # imm = 0xFFFF
               	orq	%rax, %r9
               	leaq	(%rsi,%rdi), %r12
               	andq	$0xffff, %r12           # imm = 0xFFFF
               	shlq	$0x20, %r12
               	movq	%r9, %r13
               	orq	%r12, %r13
               	leaq	(%rcx,%rdx), %r12
               	movl	$0x7fff, %r9d           # imm = 0x7FFF
               	cmpl	%r9d, %r12d
               	jle	<addr>
               	andq	$0xffff, %r9            # imm = 0xFFFF
               	movq	%rax, %r14
               	orq	%r9, %r14
               	leaq	(%rsi,%rdi), %r12
               	movl	$0x7fff, %r9d           # imm = 0x7FFF
               	cmpl	%r9d, %r12d
               	jle	<addr>
               	andq	$0xffff, %r9            # imm = 0xFFFF
               	shlq	$0x20, %r9
               	movq	%r14, %r12
               	orq	%r9, %r12
               	movq	%rcx, %r9
               	subq	%rdx, %r9
               	andq	$0xffff, %r9            # imm = 0xFFFF
               	orq	%rax, %r9
               	movq	%rsi, %r14
               	subq	%rdi, %r14
               	andq	$0xffff, %r14           # imm = 0xFFFF
               	shlq	$0x20, %r14
               	orq	%r9, %r14
               	movq	%rcx, %r9
               	subq	%rdx, %r9
               	movl	$0x7fff, %ecx           # imm = 0x7FFF
               	cmpl	%ecx, %r9d
               	jle	<addr>
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	movq	%rax, %rdx
               	orq	%rcx, %rdx
               	movq	%rsi, %rcx
               	subq	%rdi, %rcx
               	movl	$0x7fff, %eax           # imm = 0x7FFF
               	cmpl	%eax, %ecx
               	jle	<addr>
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	shlq	$0x20, %rax
               	movq	%rdx, %r15
               	orq	%rax, %r15
               	movq	%rbx, %rax
               	shrq	$0x20, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movq	%rax, %rcx
               	shrq	$0xf, %rcx
               	leaq	-0x10000(%rax), %rdx
               	testq	%rcx, %rcx
               	cmovneq	%rdx, %rax
               	movq	%rbx, %rcx
               	shrq	$0x30, %rcx
               	movq	%rcx, %rdx
               	shrq	$0xf, %rdx
               	leaq	-0x10000(%rcx), %rsi
               	testq	%rdx, %rdx
               	cmovneq	%rsi, %rcx
               	movq	%r8, %rdx
               	shrq	$0x20, %rdx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	movq	%rdx, %rsi
               	shrq	$0xf, %rsi
               	leaq	-0x10000(%rdx), %rdi
               	testq	%rsi, %rsi
               	cmovneq	%rdi, %rdx
               	movq	%r8, %rsi
               	shrq	$0x30, %rsi
               	movq	%rsi, %rdi
               	shrq	$0xf, %rdi
               	leaq	-0x10000(%rsi), %r9
               	testq	%rdi, %rdi
               	cmovneq	%r9, %rsi
               	leaq	(%rax,%rcx), %rdi
               	andq	$0xffff, %rdi           # imm = 0xFFFF
               	shlq	$0x10, %rdi
               	orq	%r13, %rdi
               	leaq	(%rdx,%rsi), %r9
               	shlq	$0x30, %r9
               	movq	%rdi, %r13
               	orq	%r9, %r13
               	leaq	(%rax,%rcx), %r9
               	movl	$0x7fff, %edi           # imm = 0x7FFF
               	cmpl	%edi, %r9d
               	jle	<addr>
               	andq	$0xffff, %rdi           # imm = 0xFFFF
               	shlq	$0x10, %rdi
               	orq	%rdi, %r12
               	leaq	(%rdx,%rsi), %r9
               	movl	$0x7fff, %edi           # imm = 0x7FFF
               	cmpl	%edi, %r9d
               	jle	<addr>
               	shlq	$0x30, %rdi
               	movq	%r12, %r9
               	orq	%rdi, %r9
               	movq	%rax, %rdi
               	subq	%rcx, %rdi
               	andq	$0xffff, %rdi           # imm = 0xFFFF
               	shlq	$0x10, %rdi
               	orq	%r14, %rdi
               	movq	%rdx, %r12
               	subq	%rsi, %r12
               	shlq	$0x30, %r12
               	orq	%rdi, %r12
               	movq	%rax, %rdi
               	subq	%rcx, %rdi
               	movl	$0x7fff, %eax           # imm = 0x7FFF
               	cmpl	%eax, %edi
               	jle	<addr>
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	shlq	$0x10, %rax
               	movq	%r15, %rdi
               	orq	%rax, %rdi
               	movq	%rdx, %rcx
               	subq	%rsi, %rcx
               	movl	$0x7fff, %eax           # imm = 0x7FFF
               	cmpl	%eax, %ecx
               	jle	<addr>
               	shlq	$0x30, %rax
               	movq	%rdi, %rsi
               	orq	%rax, %rsi
               	leaq	-0x28(%rbp), %rax
               	movq	%rbx, %xmm2
               	leaq	-0x20(%rbp), %rcx
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	movsd	-0x28(%rbp), %xmm3
               	vpextrw	$0x0, %xmm2, %eax
               	vpextrw	$0x1, %xmm2, %ecx
               	addq	%rcx, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movw	%ax, -0x8(%rbp)
               	vpextrw	$0x2, %xmm2, %eax
               	vpextrw	$0x3, %xmm2, %ecx
               	addq	%rcx, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movw	%ax, -0x6(%rbp)
               	vpextrw	$0x0, %xmm3, %eax
               	vpextrw	$0x1, %xmm3, %ecx
               	addq	%rcx, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movw	%ax, -0x4(%rbp)
               	vpextrw	$0x2, %xmm3, %eax
               	vpextrw	$0x3, %xmm3, %ecx
               	addq	%rcx, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movw	%ax, -0x2(%rbp)
               	movq	-0x8(%rbp), %rax
               	cmpq	%r13, %rax
               	jne	<addr>
               	leaq	-0x28(%rbp), %rax
               	movq	%rbx, %xmm2
               	leaq	-0x20(%rbp), %rcx
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	movsd	-0x28(%rbp), %xmm3
               	vpextrw	$0x0, %xmm2, %eax
               	movswq	%ax, %rax
               	vpextrw	$0x1, %xmm2, %ecx
               	movswq	%cx, %rcx
               	addq	%rax, %rcx
               	movl	$0x7fff, %eax           # imm = 0x7FFF
               	cmpl	%eax, %ecx
               	jle	<addr>
               	movw	%ax, -0x8(%rbp)
               	vpextrw	$0x2, %xmm2, %eax
               	movswq	%ax, %rax
               	vpextrw	$0x3, %xmm2, %ecx
               	movswq	%cx, %rcx
               	addq	%rax, %rcx
               	movl	$0x7fff, %eax           # imm = 0x7FFF
               	cmpl	%eax, %ecx
               	jle	<addr>
               	movw	%ax, -0x6(%rbp)
               	vpextrw	$0x0, %xmm3, %eax
               	movswq	%ax, %rax
               	vpextrw	$0x1, %xmm3, %ecx
               	movswq	%cx, %rcx
               	addq	%rax, %rcx
               	movl	$0x7fff, %eax           # imm = 0x7FFF
               	cmpl	%eax, %ecx
               	jle	<addr>
               	movw	%ax, -0x4(%rbp)
               	vpextrw	$0x2, %xmm3, %eax
               	movswq	%ax, %rax
               	vpextrw	$0x3, %xmm3, %ecx
               	movswq	%cx, %rcx
               	addq	%rax, %rcx
               	movl	$0x7fff, %eax           # imm = 0x7FFF
               	cmpl	%eax, %ecx
               	jle	<addr>
               	movw	%ax, -0x2(%rbp)
               	movq	-0x8(%rbp), %rax
               	cmpq	%r9, %rax
               	jne	<addr>
               	leaq	-0x28(%rbp), %rax
               	movq	%rbx, %xmm2
               	leaq	-0x20(%rbp), %rcx
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	movsd	-0x28(%rbp), %xmm3
               	vpextrw	$0x0, %xmm2, %eax
               	vpextrw	$0x1, %xmm2, %ecx
               	subq	%rcx, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movw	%ax, -0x8(%rbp)
               	vpextrw	$0x2, %xmm2, %eax
               	vpextrw	$0x3, %xmm2, %ecx
               	subq	%rcx, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movw	%ax, -0x6(%rbp)
               	vpextrw	$0x0, %xmm3, %eax
               	vpextrw	$0x1, %xmm3, %ecx
               	subq	%rcx, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movw	%ax, -0x4(%rbp)
               	vpextrw	$0x2, %xmm3, %eax
               	vpextrw	$0x3, %xmm3, %ecx
               	subq	%rcx, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movw	%ax, -0x2(%rbp)
               	movq	-0x8(%rbp), %rax
               	cmpq	%r12, %rax
               	jne	<addr>
               	leaq	-0x28(%rbp), %rax
               	leaq	-0x20(%rbp), %rcx
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	movsd	-0x28(%rbp), %xmm3
               	vpextrw	$0x0, %xmm2, %ecx
               	movswq	%cx, %rcx
               	vpextrw	$0x1, %xmm2, %eax
               	movswq	%ax, %rax
               	subq	%rax, %rcx
               	movl	$0x7fff, %eax           # imm = 0x7FFF
               	cmpl	%eax, %ecx
               	jle	<addr>
               	movq	%rax, %rcx
               	movw	%cx, -0x8(%rbp)
               	vpextrw	$0x2, %xmm2, %ecx
               	movswq	%cx, %rcx
               	vpextrw	$0x3, %xmm2, %edx
               	movswq	%dx, %rdx
               	subq	%rdx, %rcx
               	cmpl	%eax, %ecx
               	jle	<addr>
               	movw	%ax, -0x6(%rbp)
               	vpextrw	$0x0, %xmm3, %ecx
               	movswq	%cx, %rcx
               	vpextrw	$0x1, %xmm3, %eax
               	movswq	%ax, %rax
               	subq	%rax, %rcx
               	movl	$0x7fff, %eax           # imm = 0x7FFF
               	cmpl	%eax, %ecx
               	jle	<addr>
               	movq	%rax, %rcx
               	movw	%cx, -0x4(%rbp)
               	vpextrw	$0x2, %xmm3, %ecx
               	movswq	%cx, %rcx
               	vpextrw	$0x3, %xmm3, %edx
               	movswq	%dx, %rdx
               	subq	%rdx, %rcx
               	cmpl	%eax, %ecx
               	jle	<addr>
               	movw	%ax, -0x2(%rbp)
               	movq	-0x8(%rbp), %rax
               	cmpq	%rsi, %rax
               	jne	<addr>
               	movl	%ebx, %eax
               	movq	%rax, %rdx
               	shrq	$0x1f, %rdx
               	movabsq	$0x100000000, %r11      # imm = 0x100000000
               	movq	%rax, %rcx
               	subq	%r11, %rcx
               	testq	%rdx, %rdx
               	movq	%rax, %rsi
               	cmovneq	%rcx, %rsi
               	movq	%rbx, %rcx
               	shrq	$0x20, %rcx
               	movq	%rcx, %rdi
               	shrq	$0x1f, %rdi
               	movabsq	$0x100000000, %r11      # imm = 0x100000000
               	movq	%rcx, %r9
               	subq	%r11, %r9
               	testq	%rdi, %rdi
               	cmovneq	%r9, %rcx
               	addq	%rsi, %rcx
               	movl	%ecx, %esi
               	movl	%r8d, %ecx
               	movq	%rcx, %rdi
               	shrq	$0x1f, %rdi
               	movabsq	$0x100000000, %r11      # imm = 0x100000000
               	movq	%rcx, %r9
               	subq	%r11, %r9
               	testq	%rdi, %rdi
               	cmoveq	%rcx, %r9
               	movq	%r8, %rcx
               	shrq	$0x20, %rcx
               	movq	%rcx, %rdi
               	shrq	$0x1f, %rdi
               	movabsq	$0x100000000, %r11      # imm = 0x100000000
               	movq	%rcx, %r12
               	subq	%r11, %r12
               	testq	%rdi, %rdi
               	cmovneq	%r12, %rcx
               	addq	%r9, %rcx
               	shlq	$0x20, %rcx
               	orq	%rsi, %rcx
               	leaq	-0x28(%rbp), %rsi
               	movq	%rbx, %xmm2
               	leaq	-0x20(%rbp), %rdi
               	movq	(%rsi), %r10
               	movq	%r10, (%rdi)
               	movsd	-0x28(%rbp), %xmm3
               	vmovd	%xmm2, %esi
               	vpextrd	$0x1, %xmm2, %edi
               	addq	%rdi, %rsi
               	movl	%esi, -0x8(%rbp)
               	vmovd	%xmm3, %esi
               	vpextrd	$0x1, %xmm3, %edi
               	addq	%rdi, %rsi
               	movl	%esi, -0x4(%rbp)
               	movq	-0x8(%rbp), %rsi
               	cmpq	%rcx, %rsi
               	jne	<addr>
               	movabsq	$0x100000000, %r11      # imm = 0x100000000
               	movq	%rax, %rcx
               	subq	%r11, %rcx
               	testq	%rdx, %rdx
               	cmoveq	%rax, %rcx
               	movq	%rbx, %rax
               	shrq	$0x20, %rax
               	movq	%rax, %rdx
               	shrq	$0x1f, %rdx
               	movabsq	$0x100000000, %r11      # imm = 0x100000000
               	movq	%rax, %rsi
               	subq	%r11, %rsi
               	testq	%rdx, %rdx
               	cmovneq	%rsi, %rax
               	subq	%rax, %rcx
               	movl	%ecx, %ecx
               	movl	%r8d, %eax
               	movq	%rax, %rdx
               	shrq	$0x1f, %rdx
               	movabsq	$0x100000000, %r11      # imm = 0x100000000
               	movq	%rax, %rsi
               	subq	%r11, %rsi
               	testq	%rdx, %rdx
               	cmoveq	%rax, %rsi
               	movq	%r8, %rax
               	shrq	$0x20, %rax
               	movq	%rax, %rdx
               	shrq	$0x1f, %rdx
               	movabsq	$0x100000000, %r11      # imm = 0x100000000
               	movq	%rax, %rdi
               	subq	%r11, %rdi
               	testq	%rdx, %rdx
               	cmovneq	%rdi, %rax
               	subq	%rax, %rsi
               	shlq	$0x20, %rsi
               	orq	%rsi, %rcx
               	leaq	-0x28(%rbp), %rax
               	leaq	-0x20(%rbp), %rdx
               	movq	(%rax), %r10
               	movq	%r10, (%rdx)
               	movsd	-0x28(%rbp), %xmm3
               	vmovd	%xmm2, %eax
               	vpextrd	$0x1, %xmm2, %edx
               	subq	%rdx, %rax
               	movl	%eax, -0x8(%rbp)
               	vmovd	%xmm3, %eax
               	vpextrd	$0x1, %xmm3, %edx
               	subq	%rdx, %rax
               	movl	%eax, -0x4(%rbp)
               	movq	-0x8(%rbp), %rax
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movq	%rbx, %rcx
               	andq	$0xff, %rcx
               	movq	%r8, %rax
               	andq	$0xff, %rax
               	movq	%rax, %rdx
               	shrq	$0x7, %rdx
               	leaq	-0x100(%rax), %rsi
               	testq	%rdx, %rdx
               	cmovneq	%rsi, %rax
               	imulq	%rax, %rcx
               	movq	%rbx, %rax
               	shrq	$0x8, %rax
               	movq	%rax, %rdx
               	andq	$0xff, %rdx
               	movq	%r8, %rax
               	shrq	$0x8, %rax
               	andq	$0xff, %rax
               	movq	%rax, %rsi
               	shrq	$0x7, %rsi
               	leaq	-0x100(%rax), %rdi
               	testq	%rsi, %rsi
               	cmovneq	%rdi, %rax
               	imulq	%rdx, %rax
               	addq	%rax, %rcx
               	movl	$0x7fff, %eax           # imm = 0x7FFF
               	cmpq	%rax, %rcx
               	jle	<addr>
               	movq	%rax, %rdx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	movq	%rbx, %rax
               	shrq	$0x10, %rax
               	movq	%rax, %rcx
               	andq	$0xff, %rcx
               	movq	%r8, %rax
               	shrq	$0x10, %rax
               	andq	$0xff, %rax
               	movq	%rax, %rsi
               	shrq	$0x7, %rsi
               	leaq	-0x100(%rax), %rdi
               	testq	%rsi, %rsi
               	cmovneq	%rdi, %rax
               	imulq	%rax, %rcx
               	movq	%rbx, %rax
               	shrq	$0x18, %rax
               	movq	%rax, %rsi
               	andq	$0xff, %rsi
               	movq	%r8, %rax
               	shrq	$0x18, %rax
               	andq	$0xff, %rax
               	movq	%rax, %rdi
               	shrq	$0x7, %rdi
               	leaq	-0x100(%rax), %r9
               	testq	%rdi, %rdi
               	cmovneq	%r9, %rax
               	imulq	%rsi, %rax
               	addq	%rax, %rcx
               	movl	$0x7fff, %eax           # imm = 0x7FFF
               	cmpq	%rax, %rcx
               	jle	<addr>
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	shlq	$0x10, %rax
               	orq	%rax, %rdx
               	movq	%rbx, %rax
               	shrq	$0x20, %rax
               	movq	%rax, %rcx
               	andq	$0xff, %rcx
               	movq	%r8, %rax
               	shrq	$0x20, %rax
               	andq	$0xff, %rax
               	movq	%rax, %rsi
               	shrq	$0x7, %rsi
               	leaq	-0x100(%rax), %rdi
               	testq	%rsi, %rsi
               	cmovneq	%rdi, %rax
               	imulq	%rax, %rcx
               	movq	%rbx, %rax
               	shrq	$0x28, %rax
               	movq	%rax, %rsi
               	andq	$0xff, %rsi
               	movq	%r8, %rax
               	shrq	$0x28, %rax
               	andq	$0xff, %rax
               	movq	%rax, %rdi
               	shrq	$0x7, %rdi
               	leaq	-0x100(%rax), %r9
               	testq	%rdi, %rdi
               	cmovneq	%r9, %rax
               	imulq	%rsi, %rax
               	addq	%rax, %rcx
               	movl	$0x7fff, %eax           # imm = 0x7FFF
               	cmpq	%rax, %rcx
               	jle	<addr>
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	shlq	$0x20, %rax
               	orq	%rax, %rdx
               	movq	%rbx, %rax
               	shrq	$0x30, %rax
               	movq	%rax, %rcx
               	andq	$0xff, %rcx
               	movq	%r8, %rax
               	shrq	$0x30, %rax
               	andq	$0xff, %rax
               	movq	%rax, %rsi
               	shrq	$0x7, %rsi
               	leaq	-0x100(%rax), %rdi
               	testq	%rsi, %rsi
               	cmovneq	%rdi, %rax
               	imulq	%rax, %rcx
               	movq	%rbx, %rsi
               	shrq	$0x38, %rsi
               	movq	%r8, %rax
               	shrq	$0x38, %rax
               	movq	%rax, %rdi
               	shrq	$0x7, %rdi
               	leaq	-0x100(%rax), %r9
               	testq	%rdi, %rdi
               	cmovneq	%r9, %rax
               	imulq	%rsi, %rax
               	addq	%rax, %rcx
               	movl	$0x7fff, %eax           # imm = 0x7FFF
               	cmpq	%rax, %rcx
               	jle	<addr>
               	shlq	$0x30, %rax
               	orq	%rax, %rdx
               	leaq	-0x28(%rbp), %rcx
               	leaq	-0x20(%rbp), %rax
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movq	%rbx, -0x18(%rbp)
               	leaq	-0x10(%rbp), %rcx
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	movzbq	-0x18(%rbp), %rax
               	movsbq	-0x20(%rbp), %rcx
               	imulq	%rcx, %rax
               	movzbq	-0x17(%rbp), %rcx
               	movsbq	-0x1f(%rbp), %rsi
               	imulq	%rsi, %rcx
               	addq	%rax, %rcx
               	movl	$0x7fff, %eax           # imm = 0x7FFF
               	cmpl	%eax, %ecx
               	jle	<addr>
               	movw	%ax, -0x8(%rbp)
               	movzbq	-0x16(%rbp), %rax
               	movsbq	-0xe(%rbp), %rcx
               	imulq	%rcx, %rax
               	movzbq	-0x15(%rbp), %rcx
               	movsbq	-0xd(%rbp), %rsi
               	imulq	%rsi, %rcx
               	addq	%rax, %rcx
               	movl	$0x7fff, %eax           # imm = 0x7FFF
               	cmpl	%eax, %ecx
               	jle	<addr>
               	movw	%ax, -0x6(%rbp)
               	movzbq	-0x14(%rbp), %rax
               	movsbq	-0xc(%rbp), %rcx
               	imulq	%rcx, %rax
               	movzbq	-0x13(%rbp), %rcx
               	movsbq	-0xb(%rbp), %rsi
               	imulq	%rsi, %rcx
               	addq	%rax, %rcx
               	movl	$0x7fff, %eax           # imm = 0x7FFF
               	cmpl	%eax, %ecx
               	jle	<addr>
               	movw	%ax, -0x4(%rbp)
               	movzbq	-0x12(%rbp), %rax
               	movsbq	-0xa(%rbp), %rcx
               	imulq	%rcx, %rax
               	movzbq	-0x11(%rbp), %rcx
               	movsbq	-0x9(%rbp), %rsi
               	imulq	%rsi, %rcx
               	addq	%rax, %rcx
               	movl	$0x7fff, %eax           # imm = 0x7FFF
               	cmpl	%eax, %ecx
               	jle	<addr>
               	movw	%ax, -0x2(%rbp)
               	movq	-0x8(%rbp), %rax
               	cmpq	%rdx, %rax
               	jne	<addr>
               	xorl	%eax, %eax
               	vpinsrd	$0x0, %eax, %xmm1, %xmm1
               	jmp	<addr>
               	vmovd	%xmm1, %ecx
               	movslq	%ecx, %rcx
               	shlq	$0x4, %rcx
               	movslq	%ecx, %rdx
               	shrxq	%rdx, %rbx, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	movq	%rcx, %rsi
               	shrq	$0xf, %rsi
               	leaq	-0x10000(%rcx), %rdi
               	testq	%rsi, %rsi
               	cmoveq	%rcx, %rdi
               	vmovd	%xmm1, %ecx
               	movslq	%ecx, %rcx
               	shlq	$0x4, %rcx
               	movslq	%ecx, %rcx
               	shrxq	%rcx, %r8, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	movq	%rcx, %rsi
               	shrq	$0xf, %rsi
               	leaq	-0x10000(%rcx), %r9
               	testq	%rsi, %rsi
               	cmovneq	%r9, %rcx
               	imulq	%rdi, %rcx
               	sarq	$0xe, %rcx
               	incq	%rcx
               	sarq	%rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	shlxq	%rdx, %rcx, %rcx
               	orq	%rcx, %rax
               	vmovd	%xmm1, %ecx
               	movslq	%ecx, %rcx
               	incq	%rcx
               	vpinsrd	$0x0, %ecx, %xmm1, %xmm1
               	vmovd	%xmm1, %ecx
               	movslq	%ecx, %rcx
               	cmpq	$0x4, %rcx
               	jl	<addr>
               	leaq	-0x28(%rbp), %rdx
               	leaq	-0x20(%rbp), %rcx
               	movq	(%rdx), %r10
               	movq	%r10, (%rcx)
               	movq	%rbx, -0x18(%rbp)
               	leaq	-0x10(%rbp), %rdx
               	movq	(%rcx), %r10
               	movq	%r10, (%rdx)
               	movswq	-0x18(%rbp), %rcx
               	movswq	-0x20(%rbp), %rdx
               	imulq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	sarq	$0xe, %rcx
               	incq	%rcx
               	sarq	%rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	movw	%cx, -0x8(%rbp)
               	movswq	-0x16(%rbp), %rcx
               	movswq	-0xe(%rbp), %rdx
               	imulq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	sarq	$0xe, %rcx
               	incq	%rcx
               	sarq	%rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	movw	%cx, -0x6(%rbp)
               	movswq	-0x14(%rbp), %rcx
               	movswq	-0xc(%rbp), %rdx
               	imulq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	sarq	$0xe, %rcx
               	incq	%rcx
               	sarq	%rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	movw	%cx, -0x4(%rbp)
               	movswq	-0x12(%rbp), %rcx
               	movswq	-0xa(%rbp), %rdx
               	imulq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	sarq	$0xe, %rcx
               	incq	%rcx
               	sarq	%rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	movw	%cx, -0x2(%rbp)
               	movq	-0x8(%rbp), %rcx
               	cmpq	%rax, %rcx
               	jne	<addr>
               	xorl	%eax, %eax
               	vpinsrd	$0x0, %eax, %xmm0, %xmm0
               	movq	%rax, %rdx
               	jmp	<addr>
               	shlxq	%rcx, %rsi, %rcx
               	orq	%rcx, %rdx
               	vmovd	%xmm0, %ecx
               	movslq	%ecx, %rcx
               	incq	%rcx
               	vpinsrd	$0x0, %ecx, %xmm0, %xmm0
               	vmovd	%xmm0, %ecx
               	movslq	%ecx, %rcx
               	cmpq	$0x8, %rcx
               	jge	<addr>
               	vmovd	%xmm0, %ecx
               	movslq	%ecx, %rcx
               	shlq	$0x3, %rcx
               	movslq	%ecx, %rcx
               	shrxq	%rcx, %r8, %rsi
               	andq	$0xff, %rsi
               	testb	$-0x80, %sil
               	je	<addr>
               	movq	%rax, %rsi
               	jmp	<addr>
               	vmovd	%xmm0, %esi
               	movslq	%esi, %rsi
               	shlq	$0x3, %rsi
               	movslq	%esi, %rsi
               	shrxq	%rsi, %r8, %rsi
               	andq	$0xff, %rsi
               	andq	$0x7, %rsi
               	shlq	$0x3, %rsi
               	movslq	%esi, %rsi
               	shrxq	%rsi, %rbx, %rsi
               	andq	$0xff, %rsi
               	jmp	<addr>
               	leaq	-0x28(%rbp), %rcx
               	leaq	-0x20(%rbp), %rax
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movq	%rbx, -0x18(%rbp)
               	leaq	-0x8(%rbp), %rcx
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movb	%cl, (%rsi,%rax)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jge	<addr>
               	leaq	-0x10(%rbp), %rsi
               	leaq	-0x8(%rbp), %rcx
               	movzbq	(%rcx,%rax), %rcx
               	testb	$-0x80, %cl
               	je	<addr>
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	leaq	-0x18(%rbp), %rcx
               	leaq	-0x8(%rbp), %rdi
               	movzbq	(%rdi,%rax), %rdi
               	andq	$0x7, %rdi
               	movsbq	(%rcx,%rdi), %rcx
               	jmp	<addr>
               	movq	-0x10(%rbp), %rax
               	cmpq	%rdx, %rax
               	jne	<addr>
               	leaq	-0x28(%rbp), %rcx
               	leaq	-0x20(%rbp), %rax
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movq	%rbx, -0x18(%rbp)
               	leaq	-0x10(%rbp), %rcx
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	xorl	%eax, %eax
               	leaq	-0x8(%rbp), %rdx
               	movzbq	(%rcx,%rax), %rsi
               	movb	%sil, (%rdx,%rax)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movq	-0x8(%rbp), %rdi
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	movslq	%edx, %rdx
               	shrxq	%rdx, %r8, %rsi
               	andq	$0xff, %rsi
               	shlxq	%rdx, %rsi, %rdx
               	orq	%rdx, %rcx
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	cmpq	%rcx, %rdi
               	jne	<addr>
               	leaq	-0x28(%rbp), %rcx
               	leaq	-0x20(%rbp), %rax
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movq	%rbx, -0x18(%rbp)
               	leaq	-0x10(%rbp), %rsi
               	movq	(%rax), %r10
               	movq	%r10, (%rsi)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movb	%dl, (%rdi,%rax)
               	movq	%rcx, %rax
               	cmpl	$0x8, %eax
               	jge	<addr>
               	leaq	0x1(%rax), %rcx
               	leaq	-0x8(%rbp), %rdi
               	cmpl	$0x8, %ecx
               	jae	<addr>
               	movzbq	(%rsi,%rcx), %rdx
               	jmp	<addr>
               	movzbq	-0x18(%rbp), %rdx
               	jmp	<addr>
               	movq	-0x8(%rbp), %r9
               	movq	%rbx, %rdi
               	andq	$0xff, %rdi
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	jmp	<addr>
               	shlq	$0x3, %rax
               	movslq	%eax, %rax
               	shlxq	%rax, %rsi, %rax
               	orq	%rax, %rdx
               	movq	%rcx, %rax
               	cmpl	$0x8, %eax
               	jge	<addr>
               	leaq	0x1(%rax), %rcx
               	cmpl	$0x8, %ecx
               	jge	<addr>
               	movq	%rcx, %rsi
               	shlq	$0x3, %rsi
               	movslq	%esi, %rsi
               	shrxq	%rsi, %r8, %rsi
               	andq	$0xff, %rsi
               	jmp	<addr>
               	movq	%rdi, %rsi
               	jmp	<addr>
               	cmpq	%rdx, %r9
               	jne	<addr>
               	leaq	-0x28(%rbp), %rcx
               	leaq	-0x20(%rbp), %rax
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movq	%rbx, -0x18(%rbp)
               	leaq	-0x10(%rbp), %rdx
               	movq	(%rax), %r10
               	movq	%r10, (%rdx)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movb	%cl, (%rsi,%rax)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jge	<addr>
               	leaq	0x5(%rax), %rcx
               	leaq	-0x8(%rbp), %rsi
               	cmpl	$0x8, %ecx
               	jae	<addr>
               	movzbq	(%rdx,%rcx), %rcx
               	jmp	<addr>
               	leaq	-0x18(%rbp), %rdi
               	subq	$0x8, %rcx
               	movzbq	(%rdi,%rcx), %rcx
               	jmp	<addr>
               	movq	-0x8(%rbp), %rdi
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	%rax, %rsi
               	shlq	$0x3, %rsi
               	movslq	%esi, %rsi
               	shlxq	%rsi, %rcx, %rcx
               	orq	%rcx, %rdx
               	incq	%rax
               	cmpl	$0x8, %eax
               	jge	<addr>
               	leaq	0x5(%rax), %rcx
               	cmpl	$0x8, %ecx
               	jge	<addr>
               	shlq	$0x3, %rcx
               	movslq	%ecx, %rcx
               	shrxq	%rcx, %r8, %rcx
               	andq	$0xff, %rcx
               	jmp	<addr>
               	subq	$0x8, %rcx
               	shlq	$0x3, %rcx
               	movslq	%ecx, %rcx
               	shrxq	%rcx, %rbx, %rcx
               	andq	$0xff, %rcx
               	jmp	<addr>
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	leaq	-0x28(%rbp), %rcx
               	leaq	-0x20(%rbp), %rax
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	-0x18(%rbp), %rsi
               	movq	%rbx, -0x18(%rbp)
               	leaq	-0x10(%rbp), %rdx
               	movq	(%rax), %r10
               	movq	%r10, (%rdx)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movb	%cl, (%rdi,%rax)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jge	<addr>
               	leaq	0x8(%rax), %rcx
               	leaq	-0x8(%rbp), %rdi
               	cmpl	$0x8, %ecx
               	jae	<addr>
               	movzbq	(%rdx,%rcx), %rcx
               	jmp	<addr>
               	subq	$0x8, %rcx
               	movzbq	(%rsi,%rcx), %rcx
               	jmp	<addr>
               	leaq	-0x8(%rbp), %rsi
               	movq	-0x8(%rbp), %r8
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	leaq	0x8(%rax), %rdx
               	subq	$0x8, %rdx
               	shlq	$0x3, %rdx
               	movslq	%edx, %rdx
               	shrxq	%rdx, %rbx, %rdx
               	andq	$0xff, %rdx
               	movq	%rax, %rdi
               	shlq	$0x3, %rdi
               	movslq	%edi, %rdi
               	shlxq	%rdi, %rdx, %rdx
               	orq	%rdx, %rcx
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	cmpq	%rcx, %r8
               	jne	<addr>
               	leaq	-0x28(%rbp), %rcx
               	leaq	-0x20(%rbp), %rax
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movq	%rbx, -0x18(%rbp)
               	leaq	-0x10(%rbp), %rdx
               	movq	(%rax), %r10
               	movq	%r10, (%rdx)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movb	%cl, (%rsi,%rax)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jge	<addr>
               	leaq	0x9(%rax), %rcx
               	cmpl	$0x8, %ecx
               	jae	<addr>
               	movzbq	(%rdx,%rcx), %rcx
               	jmp	<addr>
               	cmpl	$0x10, %ecx
               	jae	<addr>
               	leaq	-0x18(%rbp), %rdi
               	subq	$0x8, %rcx
               	movzbq	(%rdi,%rcx), %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	movq	-0x8(%rbp), %r8
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	movq	%rcx, %rdx
               	jmp	<addr>
               	movq	%rax, %rdi
               	shlq	$0x3, %rdi
               	movslq	%edi, %rdi
               	shlxq	%rdi, %rsi, %rsi
               	orq	%rsi, %rdx
               	incq	%rax
               	cmpl	$0x8, %eax
               	jge	<addr>
               	leaq	0x9(%rax), %rsi
               	cmpl	$0x10, %esi
               	jge	<addr>
               	subq	$0x8, %rsi
               	shlq	$0x3, %rsi
               	movslq	%esi, %rsi
               	shrxq	%rsi, %rbx, %rsi
               	andq	$0xff, %rsi
               	jmp	<addr>
               	movq	%rcx, %rsi
               	jmp	<addr>
               	cmpq	%rdx, %r8
               	jne	<addr>
               	leaq	-0x28(%rbp), %rcx
               	leaq	-0x20(%rbp), %rax
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	-0x18(%rbp), %rsi
               	movq	%rbx, -0x18(%rbp)
               	leaq	-0x10(%rbp), %rdx
               	movq	(%rax), %r10
               	movq	%r10, (%rdx)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movb	%cl, (%rdi,%rax)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jge	<addr>
               	leaq	0xf(%rax), %rcx
               	leaq	-0x8(%rbp), %rdi
               	cmpl	$0x8, %ecx
               	jae	<addr>
               	movzbq	(%rdx,%rcx), %rcx
               	jmp	<addr>
               	cmpl	$0x10, %ecx
               	jae	<addr>
               	subq	$0x8, %rcx
               	movzbq	(%rsi,%rcx), %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	movq	-0x8(%rbp), %r9
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
               	movslq	%r8d, %r8
               	shlxq	%r8, %rdi, %rdi
               	orq	%rdi, %rdx
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	cmpq	%rdx, %r9
               	jne	<addr>
               	leaq	-0x28(%rbp), %rcx
               	leaq	-0x20(%rbp), %rax
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	-0x18(%rbp), %rsi
               	movq	%rbx, -0x18(%rbp)
               	leaq	-0x10(%rbp), %rdx
               	movq	(%rax), %r10
               	movq	%r10, (%rdx)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movb	%cl, (%rdi,%rax)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jge	<addr>
               	leaq	0x10(%rax), %rcx
               	leaq	-0x8(%rbp), %rdi
               	cmpl	$0x8, %ecx
               	jae	<addr>
               	movzbq	(%rdx,%rcx), %rcx
               	jmp	<addr>
               	cmpl	$0x10, %ecx
               	jae	<addr>
               	subq	$0x8, %rcx
               	movl	%ecx, %ecx
               	movzbq	(%rsi,%rcx), %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	movq	-0x8(%rbp), %rdi
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	movq	%rcx, %rdx
               	movq	%rax, %rsi
               	shlq	$0x3, %rsi
               	movslq	%esi, %rsi
               	shlxq	%rsi, %rcx, %rsi
               	orq	%rsi, %rdx
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	leaq	-0x28(%rbp), %rcx
               	leaq	-0x20(%rbp), %rax
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	-0x18(%rbp), %rdi
               	movq	%rbx, -0x18(%rbp)
               	leaq	-0x10(%rbp), %rsi
               	movq	(%rax), %r10
               	movq	%r10, (%rsi)
               	xorl	%edx, %edx
               	movq	%rdx, %rax
               	jmp	<addr>
               	movb	%cl, (%r8,%rax)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jge	<addr>
               	leaq	0x14(%rax), %rcx
               	leaq	-0x8(%rbp), %r8
               	cmpl	$0x8, %ecx
               	jae	<addr>
               	movzbq	(%rsi,%rcx), %rcx
               	jmp	<addr>
               	cmpl	$0x10, %ecx
               	jae	<addr>
               	subq	$0x8, %rcx
               	movl	%ecx, %ecx
               	movzbq	(%rdi,%rcx), %rcx
               	jmp	<addr>
               	movq	%rdx, %rcx
               	jmp	<addr>
               	movq	-0x8(%rbp), %rdi
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	movq	%rcx, %rdx
               	movq	%rax, %rsi
               	shlq	$0x3, %rsi
               	movslq	%esi, %rsi
               	shlxq	%rsi, %rcx, %rsi
               	orq	%rsi, %rdx
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	cmpq	%rdx, %rdi
               	je	<addr>
               	jmp	<addr>
               	movq	$-0x8000, %rax          # imm = 0x8000
               	cmpl	$0xffff8000, %ecx       # imm = 0xFFFF8000
               	cmovgeq	%rcx, %rax
               	jmp	<addr>
               	movq	$-0x8000, %rax          # imm = 0x8000
               	cmpl	$0xffff8000, %ecx       # imm = 0xFFFF8000
               	cmovgeq	%rcx, %rax
               	jmp	<addr>
               	movq	$-0x8000, %rax          # imm = 0x8000
               	cmpl	$0xffff8000, %ecx       # imm = 0xFFFF8000
               	cmovgeq	%rcx, %rax
               	jmp	<addr>
               	movq	$-0x8000, %rax          # imm = 0x8000
               	cmpl	$0xffff8000, %ecx       # imm = 0xFFFF8000
               	cmovgeq	%rcx, %rax
               	jmp	<addr>
               	movq	$-0x8000, %rax          # imm = 0x8000
               	cmpq	$-0x8000, %rcx          # imm = 0x8000
               	cmovgeq	%rcx, %rax
               	jmp	<addr>
               	movq	$-0x8000, %rax          # imm = 0x8000
               	cmpq	$-0x8000, %rcx          # imm = 0x8000
               	cmovgeq	%rcx, %rax
               	jmp	<addr>
               	movq	$-0x8000, %rax          # imm = 0x8000
               	cmpq	$-0x8000, %rcx          # imm = 0x8000
               	cmovgeq	%rcx, %rax
               	jmp	<addr>
               	movq	$-0x8000, %rax          # imm = 0x8000
               	cmpq	$-0x8000, %rcx          # imm = 0x8000
               	cmovgeq	%rcx, %rax
               	jmp	<addr>
               	movq	$-0x8000, %rax          # imm = 0x8000
               	cmpl	$0xffff8000, %ecx       # imm = 0xFFFF8000
               	cmovgeq	%rcx, %rax
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
               	movq	$-0x8000, %rax          # imm = 0x8000
               	cmpl	$0xffff8000, %ecx       # imm = 0xFFFF8000
               	cmovgeq	%rcx, %rax
               	jmp	<addr>
               	movq	$-0x8000, %rax          # imm = 0x8000
               	cmpl	$0xffff8000, %ecx       # imm = 0xFFFF8000
               	cmovgeq	%rcx, %rax
               	jmp	<addr>
               	movq	$-0x8000, %rax          # imm = 0x8000
               	cmpl	$0xffff8000, %ecx       # imm = 0xFFFF8000
               	cmovgeq	%rcx, %rax
               	jmp	<addr>
               	movq	$-0x8000, %rax          # imm = 0x8000
               	cmpl	$0xffff8000, %ecx       # imm = 0xFFFF8000
               	cmovgeq	%rcx, %rax
               	jmp	<addr>
               	movq	$-0x8000, %rax          # imm = 0x8000
               	cmpl	$0xffff8000, %ecx       # imm = 0xFFFF8000
               	cmovgeq	%rcx, %rax
               	jmp	<addr>
               	movq	$-0x8000, %rax          # imm = 0x8000
               	cmpl	$0xffff8000, %edi       # imm = 0xFFFF8000
               	cmovgeq	%rdi, %rax
               	jmp	<addr>
               	movq	$-0x8000, %rdi          # imm = 0x8000
               	cmpl	$0xffff8000, %r9d       # imm = 0xFFFF8000
               	cmovgeq	%r9, %rdi
               	jmp	<addr>
               	movq	$-0x8000, %rdi          # imm = 0x8000
               	cmpl	$0xffff8000, %r9d       # imm = 0xFFFF8000
               	cmovgeq	%r9, %rdi
               	jmp	<addr>
               	movq	$-0x8000, %rax          # imm = 0x8000
               	cmpl	$0xffff8000, %ecx       # imm = 0xFFFF8000
               	cmovgeq	%rcx, %rax
               	jmp	<addr>
               	movq	$-0x8000, %rcx          # imm = 0x8000
               	cmpl	$0xffff8000, %r9d       # imm = 0xFFFF8000
               	cmovgeq	%r9, %rcx
               	jmp	<addr>
               	movq	$-0x8000, %r9           # imm = 0x8000
               	cmpl	$0xffff8000, %r12d      # imm = 0xFFFF8000
               	cmovgeq	%r12, %r9
               	jmp	<addr>
               	movq	$-0x8000, %r9           # imm = 0x8000
               	cmpl	$0xffff8000, %r12d      # imm = 0xFFFF8000
               	cmovgeq	%r12, %r9
               	jmp	<addr>
               	movq	0x40(%rsp), %r10
               	incq	%r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x40(%rsp), %rax
               	cmpl	$0x7d0, %eax            # imm = 0x7D0
               	jl	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x139, %eax            # imm = 0x139
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x138, %eax            # imm = 0x138
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x137, %eax            # imm = 0x137
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x136, %eax            # imm = 0x136
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x135, %eax            # imm = 0x135
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x134, %eax            # imm = 0x134
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x133, %eax            # imm = 0x133
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x132, %eax            # imm = 0x132
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x130, %eax            # imm = 0x130
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x12b, %eax            # imm = 0x12B
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x127, %eax            # imm = 0x127
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x120, %eax            # imm = 0x120
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x11d, %eax            # imm = 0x11D
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x11a, %eax            # imm = 0x11A
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x119, %eax            # imm = 0x119
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x10e, %eax            # imm = 0x10E
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
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
               	popq	%rbp
               	retq
