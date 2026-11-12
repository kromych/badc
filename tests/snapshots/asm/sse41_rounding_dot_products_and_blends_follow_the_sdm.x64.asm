
sse41_rounding_dot_products_and_blends_follow_the_sdm.x64:	file format elf64-x86-64

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

<__badc_round>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rdi, %r9
               	movslq	%ecx, %r11
               	movq	%r11, 0x18(%rsp)
               	movslq	%edx, %rdx
               	movslq	%esi, %rsi
               	movl	$0x1, %eax
               	movl	$0x8, %ecx
               	movl	$0xb, %edi
               	cmpl	$0x7f, %edx
               	cmovneq	%rdi, %rcx
               	addq	%rsi, %rcx
               	movslq	%ecx, %rcx
               	shlxq	%rcx, %rax, %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x10(%rsp), %rax
               	movq	%rax, %rcx
               	xorq	$-0x1, %rcx
               	andq	%r9, %rcx
               	shrxq	%rsi, %rcx, %r8
               	subq	%rdx, %r8
               	andq	%r9, %rax
               	testq	%rax, %rax
               	setne	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x18(%rsp), %rdi
               	testb	$0x4, %dil
               	je	<addr>
               	leaq	-0x8(%rbp), %rax
               	stmxcsr	(%rax)
               	movl	-0x8(%rbp), %eax
               	shrq	$0xd, %rax
               	movq	%rax, %rdi
               	andq	$0x3, %rdi
               	cmpl	%esi, %r8d
               	jl	<addr>
               	movq	%r9, %rax
               	leave
               	retq
               	testl	%r8d, %r8d
               	jge	<addr>
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	%r9, %rax
               	leave
               	retq
               	shlxq	%rsi, %rdx, %r8
               	xorl	%eax, %eax
               	testl	%edi, %edi
               	jne	<addr>
               	decq	%rdx
               	movslq	%edx, %rdx
               	shlxq	%rsi, %rdx, %rdx
               	cmpq	%rdx, %rcx
               	seta	%dl
               	movzbq	%dl, %rdx
               	cmpl	$0x1, %edi
               	je	<addr>
               	cmpl	$0x2, %edi
               	jne	<addr>
               	cmpl	$0x1, %edi
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	0x8(%rsp), %rdx
               	cmpl	%ecx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	movq	0x18(%rsp), %rcx
               	testb	$0x8, %cl
               	jne	<addr>
               	movabsq	$0x3ff0000000000000, %rcx # imm = 0x3FF0000000000000
               	movq	%rcx, %xmm14
               	movsd	%xmm14, -0x10(%rbp)
               	movsd	-0x10(%rbp), %xmm0
               	movabsq	$0x3c30000000000000, %rcx # imm = 0x3C30000000000000
               	movq	%rcx, %xmm15
               	addsd	%xmm15, %xmm0
               	movsd	%xmm0, -0x10(%rbp)
               	leaq	(%rax,%r8), %rcx
               	testq	%rdx, %rdx
               	cmovneq	%rcx, %rax
               	movq	%r9, %rcx
               	andq	0x10(%rsp), %rcx
               	orq	%rcx, %rax
               	leave
               	retq
               	xorl	%edx, %edx
               	jmp	<addr>
               	movl	$0x1, %eax
               	movq	%rsi, %rdx
               	subq	%r8, %rdx
               	movslq	%edx, %rdx
               	shlxq	%rdx, %rax, %r8
               	leaq	-0x1(%r8), %rsi
               	andq	%rcx, %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	movq	%r9, %rax
               	leave
               	retq
               	movq	%rcx, %rax
               	subq	%rsi, %rax
               	testl	%edi, %edi
               	jne	<addr>
               	movq	%r8, %rdx
               	shrq	%rdx
               	cmpq	%rdx, %rsi
               	movl	$0x1, %edx
               	ja	<addr>
               	movq	%r8, %rdx
               	shrq	%rdx
               	xorl	%r10d, %r10d
               	movq	%r10, (%rsp)
               	andq	%r8, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	cmpq	%rdx, %rsi
               	movq	(%rsp), %r11
               	movq	%r11, %rdx
               	cmoveq	%rcx, %rdx
               	jmp	<addr>
               	xorl	%edx, %edx
               	jmp	<addr>
               	andq	$0x3, %rdi
               	jmp	<addr>

<__badc_round_f>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, %rcx
               	ucomiss	%xmm0, %xmm0
               	jp	<addr>
               	je	<addr>
               	addss	%xmm0, %xmm0
               	leave
               	retq
               	vmovd	%xmm0, %r11d
               	vmovd	%r11d, %xmm0
               	xorl	%eax, %eax
               	movq	%rax, %xmm15
               	vmovd	%xmm15, %r11d
               	vpinsrd	$0x1, %r11d, %xmm0, %xmm0
               	movq	%rax, %xmm15
               	vmovd	%xmm15, %r11d
               	vpinsrd	$0x2, %r11d, %xmm0, %xmm0
               	movq	%rax, %xmm15
               	vmovd	%xmm15, %r11d
               	movapd	%xmm0, %xmm14
               	vpinsrd	$0x3, %r11d, %xmm14, %xmm14
               	movups	%xmm14, (%rsp)
               	movups	(%rsp), %xmm14
               	vmovd	%xmm14, %eax
               	movslq	%eax, %rax
               	movl	%eax, %edi
               	movl	$0x17, %esi
               	movl	$0x7f, %edx
               	callq	<addr>
               	movups	(%rsp), %xmm0
               	vpinsrd	$0x0, %eax, %xmm0, %xmm0
               	leave
               	retq

<__badc_round_d>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, %rcx
               	ucomisd	%xmm0, %xmm0
               	jp	<addr>
               	je	<addr>
               	addsd	%xmm0, %xmm0
               	leave
               	retq
               	xorl	%eax, %eax
               	movq	%rax, %xmm15
               	vmovq	%xmm15, %r11
               	movapd	%xmm0, %xmm14
               	vpinsrq	$0x1, %r11, %xmm14, %xmm14
               	movups	%xmm14, (%rsp)
               	movups	(%rsp), %xmm14
               	vmovq	%xmm14, %rdi
               	movl	$0x34, %esi
               	movl	$0x3ff, %edx            # imm = 0x3FF
               	callq	<addr>
               	movups	(%rsp), %xmm0
               	vpinsrq	$0x0, %rax, %xmm0, %xmm0
               	leave
               	retq

<value>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
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
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rax
               	movq	%rax, %rcx
               	shrq	$0x3b, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	leaq	-0x8(%rbp), %rcx
               	leaq	<rip>, %rdx # <addr>
               	shrq	$0x20, %rax
               	movl	$0xaaaaaaab, %esi       # imm = 0xAAAAAAAB
               	imulq	%rax, %rsi
               	shrq	$0x21, %rsi
               	leaq	(%rsi,%rsi,2), %rsi
               	subq	%rsi, %rax
               	shlq	$0x3, %rax
               	addq	%rdx, %rax
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	movsd	-0x8(%rbp), %xmm0
               	leave
               	retq
               	movq	%rax, %rcx
               	shrq	$0x3e, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx # <addr>
               	shrq	$0x20, %rax
               	movq	%rax, %rdx
               	shrq	$0x3, %rdx
               	imulq	$0x55555556, %rdx, %rdx # imm = 0x55555556
               	shrq	$0x20, %rdx
               	imulq	$0x18, %rdx, %rdx
               	subq	%rdx, %rax
               	shlq	$0x3, %rax
               	addq	%rcx, %rax
               	movsd	(%rax), %xmm0
               	leave
               	retq
               	movq	%rax, %rcx
               	shrq	$0x28, %rcx
               	xorps	%xmm0, %xmm0
               	movq	%rcx, %r10
               	testq	%r10, %r10
               	js	<addr>
               	cvtsi2sd	%r10, %xmm0
               	jmp	<addr>
               	movq	%r10, %r11
               	shrq	%r11
               	andq	$0x1, %r10
               	orq	%r10, %r11
               	cvtsi2sd	%r11, %xmm0
               	addsd	%xmm0, %xmm0
               	movl	$0x1, %ecx
               	movq	%rax, %rdx
               	shrq	$0x8, %rdx
               	andq	$0xf, %rdx
               	shlxq	%rdx, %rcx, %rcx
               	movslq	%ecx, %rcx
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rcx, %xmm1
               	divsd	%xmm1, %xmm0
               	testb	$0x1, %al
               	je	<addr>
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	leave
               	retq

<fvalue>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
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
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rax
               	movq	%rax, %rcx
               	shrq	$0x3b, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	leaq	-0x8(%rbp), %rcx
               	leaq	<rip>, %rdx # <addr>
               	shrq	$0x20, %rax
               	movl	$0xaaaaaaab, %esi       # imm = 0xAAAAAAAB
               	imulq	%rax, %rsi
               	shrq	$0x21, %rsi
               	leaq	(%rsi,%rsi,2), %rsi
               	subq	%rsi, %rax
               	shlq	$0x2, %rax
               	addq	%rdx, %rax
               	movl	(%rax), %r10d
               	movl	%r10d, (%rcx)
               	movss	-0x8(%rbp), %xmm0
               	leave
               	retq
               	callq	<addr>
               	cvtsd2ss	%xmm0, %xmm0
               	leave
               	retq

<model_round>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movapd	%xmm0, %xmm1
               	movsd	%xmm1, -0x30(%rbp)
               	movsd	%xmm1, -0x8(%rbp)
               	leaq	-0x10(%rbp), %rcx
               	leaq	-0x8(%rbp), %rax
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	movq	-0x8(%rbp), %rcx
               	movq	%rcx, -0x8(%rbp)
               	movq	%rcx, %rdx
               	shrq	$0x34, %rdx
               	andq	$0x7ff, %rdx            # imm = 0x7FF
               	cmpl	$0x7ff, %edx            # imm = 0x7FF
               	jne	<addr>
               	movabsq	$0x8000000000000, %rdx  # imm = 0x8000000000000
               	xorl	%esi, %esi
               	movabsq	$0xfffffffffffff, %rdi  # imm = 0xFFFFFFFFFFFFF
               	andq	%rcx, %rdi
               	testq	%rdi, %rdi
               	cmoveq	%rsi, %rdx
               	orq	%rcx, %rdx
               	movq	%rdx, -0x8(%rbp)
               	leaq	-0x30(%rbp), %rcx
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	movsd	-0x8(%rbp), %xmm0
               	leave
               	retq
               	movabsq	$0x4330000000000000, %rax # imm = 0x4330000000000000
               	movq	%rax, %xmm15
               	comisd	%xmm15, %xmm1
               	jae	<addr>
               	movabsq	$-0x3cd0000000000000, %rax # imm = 0xC330000000000000
               	movq	%rax, %xmm15
               	comisd	%xmm1, %xmm15
               	jb	<addr>
               	movapd	%xmm1, %xmm0
               	leave
               	retq
               	cvttsd2si	%xmm1, %rax
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rax, %xmm0
               	subsd	%xmm0, %xmm1
               	testl	%edi, %edi
               	jne	<addr>
               	movabsq	$0x3fe0000000000000, %rdx # imm = 0x3FE0000000000000
               	movq	%rdx, %xmm15
               	comisd	%xmm15, %xmm1
               	ja	<addr>
               	movq	%rdx, %xmm15
               	ucomisd	%xmm15, %xmm1
               	jp	<addr>
               	jne	<addr>
               	testb	$0x1, %al
               	je	<addr>
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movq	%rax, %xmm15
               	addsd	%xmm15, %xmm0
               	xorl	%eax, %eax
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movq	%rcx, %rax
               	shrq	$0x3f, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%r11, %xmm0
               	leave
               	retq
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm0
               	jmp	<addr>
               	movabsq	$-0x4020000000000000, %rdx # imm = 0xBFE0000000000000
               	movq	%rdx, %xmm15
               	comisd	%xmm1, %xmm15
               	ja	<addr>
               	movq	%rdx, %xmm15
               	ucomisd	%xmm15, %xmm1
               	jp	<addr>
               	jne	<addr>
               	testb	$0x1, %al
               	je	<addr>
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movq	%rax, %xmm15
               	subsd	%xmm15, %xmm0
               	jmp	<addr>
               	cmpl	$0x1, %edi
               	jne	<addr>
               	xorl	%eax, %eax
               	movq	%rax, %xmm15
               	comisd	%xmm1, %xmm15
               	jbe	<addr>
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movq	%rax, %xmm15
               	subsd	%xmm15, %xmm0
               	jmp	<addr>
               	cmpl	$0x2, %edi
               	jne	<addr>
               	xorl	%eax, %eax
               	movq	%rax, %xmm15
               	comisd	%xmm15, %xmm1
               	jbe	<addr>
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movq	%rax, %xmm15
               	addsd	%xmm15, %xmm0
               	jmp	<addr>

<model_round_f>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movss	%xmm0, -0x18(%rbp)
               	movss	%xmm0, -0x10(%rbp)
               	leaq	-0x8(%rbp), %rcx
               	leaq	-0x10(%rbp), %rax
               	movl	(%rax), %r10d
               	movl	%r10d, (%rcx)
               	movl	-0x10(%rbp), %eax
               	movl	%eax, -0x8(%rbp)
               	movq	%rax, %rdx
               	shrq	$0x17, %rdx
               	andq	$0xff, %rdx
               	cmpl	$0xff, %edx
               	jne	<addr>
               	movl	$0x400000, %edx         # imm = 0x400000
               	xorl	%esi, %esi
               	testl	$0x7fffff, %eax         # imm = 0x7FFFFF
               	cmoveq	%rsi, %rdx
               	orq	%rdx, %rax
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x18(%rbp), %rax
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	movss	-0x8(%rbp), %xmm0
               	leave
               	retq
               	cvtss2sd	%xmm0, %xmm0
               	callq	<addr>
               	cvtsd2ss	%xmm0, %xmm0
               	leave
               	retq

<check_round_ps>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x208, %rsp            # imm = 0x208
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	callq	<addr>
               	movss	%xmm0, -0x18(%rbp)
               	callq	<addr>
               	movss	%xmm0, -0x14(%rbp)
               	callq	<addr>
               	movss	%xmm0, -0x10(%rbp)
               	callq	<addr>
               	movss	%xmm0, -0xc(%rbp)
               	movups	-0x18(%rbp), %xmm14
               	movups	%xmm14, 0x1f0(%rsp)
               	xorl	%ebx, %ebx
               	movq	%rbx, %r13
               	leaq	-0x18(%rbp), %rax
               	movq	%rbx, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	movss	(%rax), %xmm0
               	ucomiss	%xmm0, %xmm0
               	sete	%cl
               	movzbq	%cl, %rcx
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rcx
               	xorl	%eax, %eax
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x3, %edi
               	callq	<addr>
               	leaq	-0x18(%rbp), %rax
               	movq	%rbx, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	movss	(%rax), %xmm1
               	ucomiss	%xmm1, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	orq	%rax, %r13
               	incq	%rbx
               	cmpl	$0x4, %ebx
               	jl	<addr>
               	movups	0x1f0(%rsp), %xmm0
               	vmovq	%xmm0, %rax
               	movq	%rax, -0x1f0(%rbp)
               	vpextrq	$0x1, %xmm0, %rax
               	movq	%rax, -0x1e8(%rbp)
               	movq	$0x0, -0x1e0(%rbp)
               	movq	$0x0, -0x1d8(%rbp)
               	movl	<rip>, %eax # <addr>
               	movl	$0xffff9fc0, %r11d      # imm = 0xFFFF9FC0
               	andq	%r11, %rax
               	orq	$0x2000, %rax           # imm = 0x2000
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	ldmxcsr	(%rax)
               	movq	-0x1f0(%rbp), %rax
               	vmovq	%rax, %xmm14
               	movups	%xmm14, 0x1d0(%rsp)
               	movq	-0x1e8(%rbp), %rax
               	movups	0x1d0(%rsp), %xmm0
               	movapd	%xmm0, %xmm14
               	vpinsrq	$0x1, %rax, %xmm14, %xmm14
               	movups	%xmm14, 0x1e0(%rsp)
               	movq	-0x1e0(%rbp), %rax
               	movq	-0x1d8(%rbp), %rax
               	xorl	%edi, %edi
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	0x1e0(%rsp), %xmm14
               	vpinsrd	$0x0, %r11d, %xmm14, %xmm14
               	movups	%xmm14, 0x1c0(%rsp)
               	movups	0x1d0(%rsp), %xmm14
               	vpermilps	$0x1, %xmm14, %xmm0 # xmm0 = xmm14[1,0,0,0]
               	xorl	%edi, %edi
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	0x1c0(%rsp), %xmm14
               	vpinsrd	$0x1, %r11d, %xmm14, %xmm14
               	movups	%xmm14, 0x1d0(%rsp)
               	movups	0x1e0(%rsp), %xmm14
               	vpermilps	$0x2, %xmm14, %xmm0 # xmm0 = xmm14[2,0,0,0]
               	xorl	%edi, %edi
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	0x1d0(%rsp), %xmm14
               	vpinsrd	$0x2, %r11d, %xmm14, %xmm14
               	movups	%xmm14, 0x1c0(%rsp)
               	movups	0x1e0(%rsp), %xmm14
               	vpermilps	$0x3, %xmm14, %xmm0 # xmm0 = xmm14[3,0,0,0]
               	xorl	%edi, %edi
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	0x1c0(%rsp), %xmm0
               	vpinsrd	$0x3, %r11d, %xmm0, %xmm0
               	movups	0x1d0(%rsp), %xmm14
               	vmovq	%xmm14, %rax
               	movq	%rax, -0x1d0(%rbp)
               	vpextrq	$0x1, %xmm0, %rax
               	movq	%rax, -0x1c8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	stmxcsr	(%rax)
               	movl	-0x8(%rbp), %eax
               	shrq	$0x5, %rax
               	movq	%rax, %r15
               	andq	$0x1, %r15
               	movl	<rip>, %eax # <addr>
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	ldmxcsr	(%rax)
               	movq	-0x1d0(%rbp), %rax
               	movq	%rax, -0x200(%rbp)
               	movq	-0x1c8(%rbp), %rax
               	movq	%rax, -0x1f8(%rbp)
               	xorl	%ebx, %ebx
               	xorl	%r12d, %r12d
               	leaq	-0x200(%rbp), %rcx
               	movq	%rbx, %rax
               	shlq	$0x2, %rax
               	addq	%rax, %rcx
               	movss	(%rcx), %xmm0
               	movss	%xmm0, -0x28(%rbp)
               	leaq	-0x20(%rbp), %rcx
               	leaq	-0x28(%rbp), %rdx
               	movl	(%rdx), %r10d
               	movl	%r10d, (%rcx)
               	movl	-0x28(%rbp), %r14d
               	leaq	-0x18(%rbp), %rcx
               	addq	%rcx, %rax
               	movss	(%rax), %xmm0
               	xorl	%edi, %edi
               	callq	<addr>
               	movss	%xmm0, -0x28(%rbp)
               	leaq	-0x20(%rbp), %rax
               	leaq	-0x28(%rbp), %rcx
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	movl	-0x28(%rbp), %eax
               	movl	$0x1, %ecx
               	cmpl	%eax, %r14d
               	cmovneq	%rcx, %r12
               	incq	%rbx
               	cmpl	$0x4, %ebx
               	jl	<addr>
               	testl	%r13d, %r13d
               	setne	%al
               	movzbq	%al, %rax
               	movl	$0x1, %ecx
               	cmpl	%eax, %r15d
               	cmovneq	%rcx, %r12
               	movups	0x1f0(%rsp), %xmm0
               	vmovq	%xmm0, %rax
               	movq	%rax, -0x1c0(%rbp)
               	vpextrq	$0x1, %xmm0, %rax
               	movq	%rax, -0x1b8(%rbp)
               	movq	$0x0, -0x1b0(%rbp)
               	movq	$0x0, -0x1a8(%rbp)
               	movl	<rip>, %eax # <addr>
               	movl	$0xffff9fc0, %r11d      # imm = 0xFFFF9FC0
               	andq	%r11, %rax
               	movl	%eax, -0x28(%rbp)
               	leaq	-0x28(%rbp), %rax
               	ldmxcsr	(%rax)
               	movq	-0x1c0(%rbp), %rax
               	vmovq	%rax, %xmm14
               	movups	%xmm14, 0x1d0(%rsp)
               	movq	-0x1b8(%rbp), %rax
               	movups	0x1d0(%rsp), %xmm0
               	movapd	%xmm0, %xmm14
               	vpinsrq	$0x1, %rax, %xmm14, %xmm14
               	movups	%xmm14, 0x1e0(%rsp)
               	movq	-0x1b0(%rbp), %rax
               	movq	-0x1a8(%rbp), %rax
               	movl	$0x1, %edi
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	0x1e0(%rsp), %xmm14
               	vpinsrd	$0x0, %r11d, %xmm14, %xmm14
               	movups	%xmm14, 0x1c0(%rsp)
               	movups	0x1d0(%rsp), %xmm14
               	vpermilps	$0x1, %xmm14, %xmm0 # xmm0 = xmm14[1,0,0,0]
               	movl	$0x1, %edi
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	0x1c0(%rsp), %xmm14
               	vpinsrd	$0x1, %r11d, %xmm14, %xmm14
               	movups	%xmm14, 0x1d0(%rsp)
               	movups	0x1e0(%rsp), %xmm14
               	vpermilps	$0x2, %xmm14, %xmm0 # xmm0 = xmm14[2,0,0,0]
               	movl	$0x1, %edi
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	0x1d0(%rsp), %xmm14
               	vpinsrd	$0x2, %r11d, %xmm14, %xmm14
               	movups	%xmm14, 0x1c0(%rsp)
               	movups	0x1e0(%rsp), %xmm14
               	vpermilps	$0x3, %xmm14, %xmm0 # xmm0 = xmm14[3,0,0,0]
               	movl	$0x1, %edi
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	0x1c0(%rsp), %xmm0
               	vpinsrd	$0x3, %r11d, %xmm0, %xmm0
               	movups	0x1d0(%rsp), %xmm14
               	vmovq	%xmm14, %rax
               	movq	%rax, -0x1a0(%rbp)
               	vpextrq	$0x1, %xmm0, %rax
               	movq	%rax, -0x198(%rbp)
               	leaq	-0x28(%rbp), %rax
               	stmxcsr	(%rax)
               	movl	-0x28(%rbp), %eax
               	shrq	$0x5, %rax
               	movq	%rax, %r15
               	andq	$0x1, %r15
               	movl	<rip>, %eax # <addr>
               	movl	%eax, -0x28(%rbp)
               	leaq	-0x28(%rbp), %rax
               	ldmxcsr	(%rax)
               	movq	-0x1a0(%rbp), %rax
               	movq	%rax, -0x200(%rbp)
               	movq	-0x198(%rbp), %rax
               	movq	%rax, -0x1f8(%rbp)
               	xorl	%ebx, %ebx
               	leaq	-0x200(%rbp), %rcx
               	movq	%rbx, %rax
               	shlq	$0x2, %rax
               	addq	%rax, %rcx
               	movss	(%rcx), %xmm0
               	movss	%xmm0, -0x28(%rbp)
               	leaq	-0x20(%rbp), %rcx
               	leaq	-0x28(%rbp), %rdx
               	movl	(%rdx), %r10d
               	movl	%r10d, (%rcx)
               	movl	-0x28(%rbp), %r14d
               	leaq	-0x18(%rbp), %rcx
               	addq	%rcx, %rax
               	movss	(%rax), %xmm0
               	movl	$0x1, %edi
               	callq	<addr>
               	movss	%xmm0, -0x28(%rbp)
               	leaq	-0x20(%rbp), %rax
               	leaq	-0x28(%rbp), %rcx
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	movl	-0x28(%rbp), %eax
               	movl	$0x1, %ecx
               	cmpl	%eax, %r14d
               	cmovneq	%rcx, %r12
               	incq	%rbx
               	cmpl	$0x4, %ebx
               	jl	<addr>
               	testl	%r13d, %r13d
               	setne	%al
               	movzbq	%al, %rax
               	movl	$0x1, %ecx
               	cmpl	%eax, %r15d
               	cmovneq	%rcx, %r12
               	movups	0x1f0(%rsp), %xmm0
               	vmovq	%xmm0, %rax
               	movq	%rax, -0x190(%rbp)
               	vpextrq	$0x1, %xmm0, %rax
               	movq	%rax, -0x188(%rbp)
               	movq	$0x0, -0x180(%rbp)
               	movq	$0x0, -0x178(%rbp)
               	movl	<rip>, %eax # <addr>
               	movl	$0xffff9fc0, %r11d      # imm = 0xFFFF9FC0
               	andq	%r11, %rax
               	orq	$0x6000, %rax           # imm = 0x6000
               	movl	%eax, -0x28(%rbp)
               	leaq	-0x28(%rbp), %rax
               	ldmxcsr	(%rax)
               	movq	-0x190(%rbp), %rax
               	vmovq	%rax, %xmm14
               	movups	%xmm14, 0x1d0(%rsp)
               	movq	-0x188(%rbp), %rax
               	movups	0x1d0(%rsp), %xmm0
               	movapd	%xmm0, %xmm14
               	vpinsrq	$0x1, %rax, %xmm14, %xmm14
               	movups	%xmm14, 0x1e0(%rsp)
               	movq	-0x180(%rbp), %rax
               	movq	-0x178(%rbp), %rax
               	movl	$0x2, %edi
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	0x1e0(%rsp), %xmm14
               	vpinsrd	$0x0, %r11d, %xmm14, %xmm14
               	movups	%xmm14, 0x1c0(%rsp)
               	movups	0x1d0(%rsp), %xmm14
               	vpermilps	$0x1, %xmm14, %xmm0 # xmm0 = xmm14[1,0,0,0]
               	movl	$0x2, %edi
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	0x1c0(%rsp), %xmm14
               	vpinsrd	$0x1, %r11d, %xmm14, %xmm14
               	movups	%xmm14, 0x1d0(%rsp)
               	movups	0x1e0(%rsp), %xmm14
               	vpermilps	$0x2, %xmm14, %xmm0 # xmm0 = xmm14[2,0,0,0]
               	movl	$0x2, %edi
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	0x1d0(%rsp), %xmm14
               	vpinsrd	$0x2, %r11d, %xmm14, %xmm14
               	movups	%xmm14, 0x1c0(%rsp)
               	movups	0x1e0(%rsp), %xmm14
               	vpermilps	$0x3, %xmm14, %xmm0 # xmm0 = xmm14[3,0,0,0]
               	movl	$0x2, %edi
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	0x1c0(%rsp), %xmm0
               	vpinsrd	$0x3, %r11d, %xmm0, %xmm0
               	movups	0x1d0(%rsp), %xmm14
               	vmovq	%xmm14, %rax
               	movq	%rax, -0x170(%rbp)
               	vpextrq	$0x1, %xmm0, %rax
               	movq	%rax, -0x168(%rbp)
               	leaq	-0x28(%rbp), %rax
               	stmxcsr	(%rax)
               	movl	-0x28(%rbp), %eax
               	shrq	$0x5, %rax
               	movq	%rax, %r15
               	andq	$0x1, %r15
               	movl	<rip>, %eax # <addr>
               	movl	%eax, -0x28(%rbp)
               	leaq	-0x28(%rbp), %rax
               	ldmxcsr	(%rax)
               	movq	-0x170(%rbp), %rax
               	movq	%rax, -0x200(%rbp)
               	movq	-0x168(%rbp), %rax
               	movq	%rax, -0x1f8(%rbp)
               	xorl	%ebx, %ebx
               	leaq	-0x200(%rbp), %rcx
               	movq	%rbx, %rax
               	shlq	$0x2, %rax
               	addq	%rax, %rcx
               	movss	(%rcx), %xmm0
               	movss	%xmm0, -0x28(%rbp)
               	leaq	-0x20(%rbp), %rcx
               	leaq	-0x28(%rbp), %rdx
               	movl	(%rdx), %r10d
               	movl	%r10d, (%rcx)
               	movl	-0x28(%rbp), %r14d
               	leaq	-0x18(%rbp), %rcx
               	addq	%rcx, %rax
               	movss	(%rax), %xmm0
               	movl	$0x2, %edi
               	callq	<addr>
               	movss	%xmm0, -0x28(%rbp)
               	leaq	-0x20(%rbp), %rax
               	leaq	-0x28(%rbp), %rcx
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	movl	-0x28(%rbp), %eax
               	movl	$0x1, %ecx
               	cmpl	%eax, %r14d
               	cmovneq	%rcx, %r12
               	incq	%rbx
               	cmpl	$0x4, %ebx
               	jl	<addr>
               	testl	%r13d, %r13d
               	setne	%al
               	movzbq	%al, %rax
               	movl	$0x1, %ecx
               	cmpl	%eax, %r15d
               	cmovneq	%rcx, %r12
               	movups	0x1f0(%rsp), %xmm0
               	vmovq	%xmm0, %rax
               	movq	%rax, -0x160(%rbp)
               	vpextrq	$0x1, %xmm0, %rax
               	movq	%rax, -0x158(%rbp)
               	movq	$0x0, -0x150(%rbp)
               	movq	$0x0, -0x148(%rbp)
               	movl	<rip>, %eax # <addr>
               	movl	$0xffff9fc0, %r11d      # imm = 0xFFFF9FC0
               	andq	%r11, %rax
               	orq	$0x4000, %rax           # imm = 0x4000
               	movl	%eax, -0x28(%rbp)
               	leaq	-0x28(%rbp), %rax
               	ldmxcsr	(%rax)
               	movq	-0x160(%rbp), %rax
               	vmovq	%rax, %xmm14
               	movups	%xmm14, 0x1d0(%rsp)
               	movq	-0x158(%rbp), %rax
               	movups	0x1d0(%rsp), %xmm0
               	movapd	%xmm0, %xmm14
               	vpinsrq	$0x1, %rax, %xmm14, %xmm14
               	movups	%xmm14, 0x1e0(%rsp)
               	movq	-0x150(%rbp), %rax
               	movq	-0x148(%rbp), %rax
               	movl	$0x3, %edi
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	0x1e0(%rsp), %xmm14
               	vpinsrd	$0x0, %r11d, %xmm14, %xmm14
               	movups	%xmm14, 0x1c0(%rsp)
               	movups	0x1d0(%rsp), %xmm14
               	vpermilps	$0x1, %xmm14, %xmm0 # xmm0 = xmm14[1,0,0,0]
               	movl	$0x3, %edi
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	0x1c0(%rsp), %xmm14
               	vpinsrd	$0x1, %r11d, %xmm14, %xmm14
               	movups	%xmm14, 0x1d0(%rsp)
               	movups	0x1e0(%rsp), %xmm14
               	vpermilps	$0x2, %xmm14, %xmm0 # xmm0 = xmm14[2,0,0,0]
               	movl	$0x3, %edi
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	0x1d0(%rsp), %xmm14
               	vpinsrd	$0x2, %r11d, %xmm14, %xmm14
               	movups	%xmm14, 0x1c0(%rsp)
               	movups	0x1e0(%rsp), %xmm14
               	vpermilps	$0x3, %xmm14, %xmm0 # xmm0 = xmm14[3,0,0,0]
               	movl	$0x3, %edi
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	0x1c0(%rsp), %xmm0
               	vpinsrd	$0x3, %r11d, %xmm0, %xmm0
               	movups	0x1d0(%rsp), %xmm14
               	vmovq	%xmm14, %rax
               	movq	%rax, -0x140(%rbp)
               	vpextrq	$0x1, %xmm0, %rax
               	movq	%rax, -0x138(%rbp)
               	leaq	-0x28(%rbp), %rax
               	stmxcsr	(%rax)
               	movl	-0x28(%rbp), %eax
               	shrq	$0x5, %rax
               	movq	%rax, %r15
               	andq	$0x1, %r15
               	movl	<rip>, %eax # <addr>
               	movl	%eax, -0x28(%rbp)
               	leaq	-0x28(%rbp), %rax
               	ldmxcsr	(%rax)
               	movq	-0x140(%rbp), %rax
               	movq	%rax, -0x200(%rbp)
               	movq	-0x138(%rbp), %rax
               	movq	%rax, -0x1f8(%rbp)
               	xorl	%ebx, %ebx
               	leaq	-0x200(%rbp), %rcx
               	movq	%rbx, %rax
               	shlq	$0x2, %rax
               	addq	%rax, %rcx
               	movss	(%rcx), %xmm0
               	movss	%xmm0, -0x28(%rbp)
               	leaq	-0x20(%rbp), %rcx
               	leaq	-0x28(%rbp), %rdx
               	movl	(%rdx), %r10d
               	movl	%r10d, (%rcx)
               	movl	-0x28(%rbp), %r14d
               	leaq	-0x18(%rbp), %rcx
               	addq	%rcx, %rax
               	movss	(%rax), %xmm0
               	movl	$0x3, %edi
               	callq	<addr>
               	movss	%xmm0, -0x28(%rbp)
               	leaq	-0x20(%rbp), %rax
               	leaq	-0x28(%rbp), %rcx
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	movl	-0x28(%rbp), %eax
               	movl	$0x1, %ecx
               	cmpl	%eax, %r14d
               	cmovneq	%rcx, %r12
               	incq	%rbx
               	cmpl	$0x4, %ebx
               	jl	<addr>
               	testl	%r13d, %r13d
               	setne	%al
               	movzbq	%al, %rax
               	movl	$0x1, %ecx
               	cmpl	%eax, %r15d
               	cmovneq	%rcx, %r12
               	movups	0x1f0(%rsp), %xmm0
               	vmovq	%xmm0, %rax
               	movq	%rax, -0x130(%rbp)
               	vpextrq	$0x1, %xmm0, %rax
               	movq	%rax, -0x128(%rbp)
               	movq	$0x0, -0x120(%rbp)
               	movq	$0x0, -0x118(%rbp)
               	movl	<rip>, %eax # <addr>
               	movl	$0xffff9fc0, %r11d      # imm = 0xFFFF9FC0
               	andq	%r11, %rax
               	orq	$0x4000, %rax           # imm = 0x4000
               	movl	%eax, -0x28(%rbp)
               	leaq	-0x28(%rbp), %rax
               	ldmxcsr	(%rax)
               	movq	-0x130(%rbp), %rax
               	vmovq	%rax, %xmm14
               	movups	%xmm14, 0x1d0(%rsp)
               	movq	-0x128(%rbp), %rax
               	movups	0x1d0(%rsp), %xmm0
               	movapd	%xmm0, %xmm14
               	vpinsrq	$0x1, %rax, %xmm14, %xmm14
               	movups	%xmm14, 0x1e0(%rsp)
               	movq	-0x120(%rbp), %rax
               	movq	-0x118(%rbp), %rax
               	movl	$0x8, %edi
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	0x1e0(%rsp), %xmm14
               	vpinsrd	$0x0, %r11d, %xmm14, %xmm14
               	movups	%xmm14, 0x1c0(%rsp)
               	movups	0x1d0(%rsp), %xmm14
               	vpermilps	$0x1, %xmm14, %xmm0 # xmm0 = xmm14[1,0,0,0]
               	movl	$0x8, %edi
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	0x1c0(%rsp), %xmm14
               	vpinsrd	$0x1, %r11d, %xmm14, %xmm14
               	movups	%xmm14, 0x1d0(%rsp)
               	movups	0x1e0(%rsp), %xmm14
               	vpermilps	$0x2, %xmm14, %xmm0 # xmm0 = xmm14[2,0,0,0]
               	movl	$0x8, %edi
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	0x1d0(%rsp), %xmm14
               	vpinsrd	$0x2, %r11d, %xmm14, %xmm14
               	movups	%xmm14, 0x1c0(%rsp)
               	movups	0x1e0(%rsp), %xmm14
               	vpermilps	$0x3, %xmm14, %xmm0 # xmm0 = xmm14[3,0,0,0]
               	movl	$0x8, %edi
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	0x1c0(%rsp), %xmm0
               	vpinsrd	$0x3, %r11d, %xmm0, %xmm0
               	movups	0x1d0(%rsp), %xmm14
               	vmovq	%xmm14, %rax
               	movq	%rax, -0x110(%rbp)
               	vpextrq	$0x1, %xmm0, %rax
               	movq	%rax, -0x108(%rbp)
               	leaq	-0x28(%rbp), %rax
               	stmxcsr	(%rax)
               	movl	-0x28(%rbp), %eax
               	shrq	$0x5, %rax
               	movq	%rax, %r14
               	andq	$0x1, %r14
               	movl	<rip>, %eax # <addr>
               	movl	%eax, -0x28(%rbp)
               	leaq	-0x28(%rbp), %rax
               	ldmxcsr	(%rax)
               	movq	-0x110(%rbp), %rax
               	movq	%rax, -0x200(%rbp)
               	movq	-0x108(%rbp), %rax
               	movq	%rax, -0x1f8(%rbp)
               	xorl	%ebx, %ebx
               	leaq	-0x200(%rbp), %rcx
               	movq	%rbx, %rax
               	shlq	$0x2, %rax
               	addq	%rax, %rcx
               	movss	(%rcx), %xmm0
               	movss	%xmm0, -0x28(%rbp)
               	leaq	-0x20(%rbp), %rcx
               	leaq	-0x28(%rbp), %rdx
               	movl	(%rdx), %r10d
               	movl	%r10d, (%rcx)
               	movl	-0x28(%rbp), %r13d
               	leaq	-0x18(%rbp), %rcx
               	addq	%rcx, %rax
               	movss	(%rax), %xmm0
               	xorl	%edi, %edi
               	callq	<addr>
               	movss	%xmm0, -0x28(%rbp)
               	leaq	-0x20(%rbp), %rax
               	leaq	-0x28(%rbp), %rcx
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	movl	-0x28(%rbp), %eax
               	movl	$0x1, %ecx
               	cmpl	%eax, %r13d
               	cmovneq	%rcx, %r12
               	incq	%rbx
               	cmpl	$0x4, %ebx
               	jl	<addr>
               	movl	$0x1, %eax
               	testl	%r14d, %r14d
               	cmovneq	%rax, %r12
               	movups	0x1f0(%rsp), %xmm0
               	vmovq	%xmm0, %rax
               	movq	%rax, -0x100(%rbp)
               	vpextrq	$0x1, %xmm0, %rax
               	movq	%rax, -0xf8(%rbp)
               	movq	$0x0, -0xf0(%rbp)
               	movq	$0x0, -0xe8(%rbp)
               	movl	<rip>, %eax # <addr>
               	movl	$0xffff9fc0, %r11d      # imm = 0xFFFF9FC0
               	andq	%r11, %rax
               	orq	$0x6000, %rax           # imm = 0x6000
               	movl	%eax, -0x28(%rbp)
               	leaq	-0x28(%rbp), %rax
               	ldmxcsr	(%rax)
               	movq	-0x100(%rbp), %rax
               	vmovq	%rax, %xmm14
               	movups	%xmm14, 0x1d0(%rsp)
               	movq	-0xf8(%rbp), %rax
               	movups	0x1d0(%rsp), %xmm0
               	movapd	%xmm0, %xmm14
               	vpinsrq	$0x1, %rax, %xmm14, %xmm14
               	movups	%xmm14, 0x1e0(%rsp)
               	movq	-0xf0(%rbp), %rax
               	movq	-0xe8(%rbp), %rax
               	movl	$0x9, %edi
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	0x1e0(%rsp), %xmm14
               	vpinsrd	$0x0, %r11d, %xmm14, %xmm14
               	movups	%xmm14, 0x1c0(%rsp)
               	movups	0x1d0(%rsp), %xmm14
               	vpermilps	$0x1, %xmm14, %xmm0 # xmm0 = xmm14[1,0,0,0]
               	movl	$0x9, %edi
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	0x1c0(%rsp), %xmm14
               	vpinsrd	$0x1, %r11d, %xmm14, %xmm14
               	movups	%xmm14, 0x1d0(%rsp)
               	movups	0x1e0(%rsp), %xmm14
               	vpermilps	$0x2, %xmm14, %xmm0 # xmm0 = xmm14[2,0,0,0]
               	movl	$0x9, %edi
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	0x1d0(%rsp), %xmm14
               	vpinsrd	$0x2, %r11d, %xmm14, %xmm14
               	movups	%xmm14, 0x1c0(%rsp)
               	movups	0x1e0(%rsp), %xmm14
               	vpermilps	$0x3, %xmm14, %xmm0 # xmm0 = xmm14[3,0,0,0]
               	movl	$0x9, %edi
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	0x1c0(%rsp), %xmm0
               	vpinsrd	$0x3, %r11d, %xmm0, %xmm0
               	movups	0x1d0(%rsp), %xmm14
               	vmovq	%xmm14, %rax
               	movq	%rax, -0xe0(%rbp)
               	vpextrq	$0x1, %xmm0, %rax
               	movq	%rax, -0xd8(%rbp)
               	leaq	-0x28(%rbp), %rax
               	stmxcsr	(%rax)
               	movl	-0x28(%rbp), %eax
               	shrq	$0x5, %rax
               	movq	%rax, %r14
               	andq	$0x1, %r14
               	movl	<rip>, %eax # <addr>
               	movl	%eax, -0x28(%rbp)
               	leaq	-0x28(%rbp), %rax
               	ldmxcsr	(%rax)
               	movq	-0xe0(%rbp), %rax
               	movq	%rax, -0x200(%rbp)
               	movq	-0xd8(%rbp), %rax
               	movq	%rax, -0x1f8(%rbp)
               	xorl	%ebx, %ebx
               	leaq	-0x200(%rbp), %rcx
               	movq	%rbx, %rax
               	shlq	$0x2, %rax
               	addq	%rax, %rcx
               	movss	(%rcx), %xmm0
               	movss	%xmm0, -0x28(%rbp)
               	leaq	-0x20(%rbp), %rcx
               	leaq	-0x28(%rbp), %rdx
               	movl	(%rdx), %r10d
               	movl	%r10d, (%rcx)
               	movl	-0x28(%rbp), %r13d
               	leaq	-0x18(%rbp), %rcx
               	addq	%rcx, %rax
               	movss	(%rax), %xmm0
               	movl	$0x1, %edi
               	callq	<addr>
               	movss	%xmm0, -0x28(%rbp)
               	leaq	-0x20(%rbp), %rax
               	leaq	-0x28(%rbp), %rcx
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	movl	-0x28(%rbp), %eax
               	movl	$0x1, %ecx
               	cmpl	%eax, %r13d
               	cmovneq	%rcx, %r12
               	incq	%rbx
               	cmpl	$0x4, %ebx
               	jl	<addr>
               	movl	$0x1, %eax
               	testl	%r14d, %r14d
               	cmovneq	%rax, %r12
               	movups	0x1f0(%rsp), %xmm0
               	vmovq	%xmm0, %rax
               	movq	%rax, -0xd0(%rbp)
               	vpextrq	$0x1, %xmm0, %rax
               	movq	%rax, -0xc8(%rbp)
               	movq	$0x0, -0xc0(%rbp)
               	movq	$0x0, -0xb8(%rbp)
               	movl	<rip>, %eax # <addr>
               	movl	$0xffff9fc0, %r11d      # imm = 0xFFFF9FC0
               	andq	%r11, %rax
               	movl	%eax, -0x28(%rbp)
               	leaq	-0x28(%rbp), %rax
               	ldmxcsr	(%rax)
               	movq	-0xd0(%rbp), %rax
               	vmovq	%rax, %xmm14
               	movups	%xmm14, 0x1d0(%rsp)
               	movq	-0xc8(%rbp), %rax
               	movups	0x1d0(%rsp), %xmm0
               	movapd	%xmm0, %xmm14
               	vpinsrq	$0x1, %rax, %xmm14, %xmm14
               	movups	%xmm14, 0x1e0(%rsp)
               	movq	-0xc0(%rbp), %rax
               	movq	-0xb8(%rbp), %rax
               	movl	$0xa, %edi
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	0x1e0(%rsp), %xmm14
               	vpinsrd	$0x0, %r11d, %xmm14, %xmm14
               	movups	%xmm14, 0x1c0(%rsp)
               	movups	0x1d0(%rsp), %xmm14
               	vpermilps	$0x1, %xmm14, %xmm0 # xmm0 = xmm14[1,0,0,0]
               	movl	$0xa, %edi
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	0x1c0(%rsp), %xmm14
               	vpinsrd	$0x1, %r11d, %xmm14, %xmm14
               	movups	%xmm14, 0x1d0(%rsp)
               	movups	0x1e0(%rsp), %xmm14
               	vpermilps	$0x2, %xmm14, %xmm0 # xmm0 = xmm14[2,0,0,0]
               	movl	$0xa, %edi
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	0x1d0(%rsp), %xmm14
               	vpinsrd	$0x2, %r11d, %xmm14, %xmm14
               	movups	%xmm14, 0x1c0(%rsp)
               	movups	0x1e0(%rsp), %xmm14
               	vpermilps	$0x3, %xmm14, %xmm0 # xmm0 = xmm14[3,0,0,0]
               	movl	$0xa, %edi
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	0x1c0(%rsp), %xmm0
               	vpinsrd	$0x3, %r11d, %xmm0, %xmm0
               	movups	0x1d0(%rsp), %xmm14
               	vmovq	%xmm14, %rax
               	movq	%rax, -0xb0(%rbp)
               	vpextrq	$0x1, %xmm0, %rax
               	movq	%rax, -0xa8(%rbp)
               	leaq	-0x28(%rbp), %rax
               	stmxcsr	(%rax)
               	movl	-0x28(%rbp), %eax
               	shrq	$0x5, %rax
               	movq	%rax, %r14
               	andq	$0x1, %r14
               	movl	<rip>, %eax # <addr>
               	movl	%eax, -0x28(%rbp)
               	leaq	-0x28(%rbp), %rax
               	ldmxcsr	(%rax)
               	movq	-0xb0(%rbp), %rax
               	movq	%rax, -0x200(%rbp)
               	movq	-0xa8(%rbp), %rax
               	movq	%rax, -0x1f8(%rbp)
               	xorl	%ebx, %ebx
               	leaq	-0x200(%rbp), %rcx
               	movq	%rbx, %rax
               	shlq	$0x2, %rax
               	addq	%rax, %rcx
               	movss	(%rcx), %xmm0
               	movss	%xmm0, -0x28(%rbp)
               	leaq	-0x20(%rbp), %rcx
               	leaq	-0x28(%rbp), %rdx
               	movl	(%rdx), %r10d
               	movl	%r10d, (%rcx)
               	movl	-0x28(%rbp), %r13d
               	leaq	-0x18(%rbp), %rcx
               	addq	%rcx, %rax
               	movss	(%rax), %xmm0
               	movl	$0x2, %edi
               	callq	<addr>
               	movss	%xmm0, -0x28(%rbp)
               	leaq	-0x20(%rbp), %rax
               	leaq	-0x28(%rbp), %rcx
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	movl	-0x28(%rbp), %eax
               	movl	$0x1, %ecx
               	cmpl	%eax, %r13d
               	cmovneq	%rcx, %r12
               	incq	%rbx
               	cmpl	$0x4, %ebx
               	jl	<addr>
               	movl	$0x1, %eax
               	testl	%r14d, %r14d
               	cmovneq	%rax, %r12
               	movups	0x1f0(%rsp), %xmm0
               	vmovq	%xmm0, %rax
               	movq	%rax, -0xa0(%rbp)
               	vpextrq	$0x1, %xmm0, %rax
               	movq	%rax, -0x98(%rbp)
               	movq	$0x0, -0x90(%rbp)
               	movq	$0x0, -0x88(%rbp)
               	movl	<rip>, %eax # <addr>
               	movl	$0xffff9fc0, %r11d      # imm = 0xFFFF9FC0
               	andq	%r11, %rax
               	orq	$0x2000, %rax           # imm = 0x2000
               	movl	%eax, -0x28(%rbp)
               	leaq	-0x28(%rbp), %rax
               	ldmxcsr	(%rax)
               	movq	-0xa0(%rbp), %rax
               	vmovq	%rax, %xmm14
               	movups	%xmm14, 0x1e0(%rsp)
               	movq	-0x98(%rbp), %rax
               	movups	0x1e0(%rsp), %xmm0
               	movapd	%xmm0, %xmm14
               	vpinsrq	$0x1, %rax, %xmm14, %xmm14
               	movups	%xmm14, 0x1f0(%rsp)
               	movq	-0x90(%rbp), %rax
               	movq	-0x88(%rbp), %rax
               	movl	$0xb, %edi
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	0x1f0(%rsp), %xmm14
               	vpinsrd	$0x0, %r11d, %xmm14, %xmm14
               	movups	%xmm14, 0x1d0(%rsp)
               	movups	0x1e0(%rsp), %xmm14
               	vpermilps	$0x1, %xmm14, %xmm0 # xmm0 = xmm14[1,0,0,0]
               	movl	$0xb, %edi
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	0x1d0(%rsp), %xmm14
               	vpinsrd	$0x1, %r11d, %xmm14, %xmm14
               	movups	%xmm14, 0x1e0(%rsp)
               	movups	0x1f0(%rsp), %xmm14
               	vpermilps	$0x2, %xmm14, %xmm0 # xmm0 = xmm14[2,0,0,0]
               	movl	$0xb, %edi
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	0x1e0(%rsp), %xmm14
               	vpinsrd	$0x2, %r11d, %xmm14, %xmm14
               	movups	%xmm14, 0x1d0(%rsp)
               	movups	0x1f0(%rsp), %xmm14
               	vpermilps	$0x3, %xmm14, %xmm0 # xmm0 = xmm14[3,0,0,0]
               	movl	$0xb, %edi
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	0x1d0(%rsp), %xmm0
               	vpinsrd	$0x3, %r11d, %xmm0, %xmm0
               	movups	0x1e0(%rsp), %xmm14
               	vmovq	%xmm14, %rax
               	movq	%rax, -0x80(%rbp)
               	vpextrq	$0x1, %xmm0, %rax
               	movq	%rax, -0x78(%rbp)
               	leaq	-0x28(%rbp), %rax
               	stmxcsr	(%rax)
               	movl	-0x28(%rbp), %eax
               	shrq	$0x5, %rax
               	movq	%rax, %r14
               	andq	$0x1, %r14
               	movl	<rip>, %eax # <addr>
               	movl	%eax, -0x28(%rbp)
               	leaq	-0x28(%rbp), %rax
               	ldmxcsr	(%rax)
               	movq	-0x80(%rbp), %rax
               	movq	%rax, -0x200(%rbp)
               	movq	-0x78(%rbp), %rax
               	movq	%rax, -0x1f8(%rbp)
               	xorl	%ebx, %ebx
               	leaq	-0x200(%rbp), %rcx
               	movq	%rbx, %rax
               	shlq	$0x2, %rax
               	addq	%rax, %rcx
               	movss	(%rcx), %xmm0
               	movss	%xmm0, -0x28(%rbp)
               	leaq	-0x20(%rbp), %rcx
               	leaq	-0x28(%rbp), %rdx
               	movl	(%rdx), %r10d
               	movl	%r10d, (%rcx)
               	movl	-0x28(%rbp), %r13d
               	leaq	-0x18(%rbp), %rcx
               	addq	%rcx, %rax
               	movss	(%rax), %xmm0
               	movl	$0x3, %edi
               	callq	<addr>
               	movss	%xmm0, -0x28(%rbp)
               	leaq	-0x20(%rbp), %rax
               	leaq	-0x28(%rbp), %rcx
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	movl	-0x28(%rbp), %eax
               	movl	$0x1, %ecx
               	cmpl	%eax, %r13d
               	cmovneq	%rcx, %r12
               	incq	%rbx
               	cmpl	$0x4, %ebx
               	jl	<addr>
               	movl	$0x1, %eax
               	testl	%r14d, %r14d
               	cmoveq	%r12, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq

<check_round_pd>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x188, %rsp            # imm = 0x188
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	leaq	-0x18(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	callq	<addr>
               	movsd	%xmm0, -0x18(%rbp)
               	callq	<addr>
               	movsd	%xmm0, -0x10(%rbp)
               	movups	-0x18(%rbp), %xmm14
               	movups	%xmm14, 0x170(%rsp)
               	xorl	%ebx, %ebx
               	movq	%rbx, %r13
               	leaq	-0x18(%rbp), %rax
               	movq	%rbx, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rax
               	movsd	(%rax), %xmm0
               	ucomisd	%xmm0, %xmm0
               	sete	%cl
               	movzbq	%cl, %rcx
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rcx
               	xorl	%eax, %eax
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x3, %edi
               	callq	<addr>
               	leaq	-0x18(%rbp), %rax
               	movq	%rbx, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rax
               	movsd	(%rax), %xmm1
               	ucomisd	%xmm1, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	orq	%rax, %r13
               	incq	%rbx
               	cmpl	$0x2, %ebx
               	jl	<addr>
               	movups	0x170(%rsp), %xmm0
               	vmovq	%xmm0, %rax
               	movq	%rax, -0x170(%rbp)
               	vpextrq	$0x1, %xmm0, %rax
               	movq	%rax, -0x168(%rbp)
               	movq	$0x0, -0x160(%rbp)
               	movq	$0x0, -0x158(%rbp)
               	movl	<rip>, %eax # <addr>
               	movl	$0xffff9fc0, %r11d      # imm = 0xFFFF9FC0
               	andq	%r11, %rax
               	orq	$0x6000, %rax           # imm = 0x6000
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	ldmxcsr	(%rax)
               	movq	-0x170(%rbp), %rax
               	vmovq	%rax, %xmm0
               	movq	-0x168(%rbp), %rax
               	movapd	%xmm0, %xmm14
               	vpinsrq	$0x1, %rax, %xmm14, %xmm14
               	movups	%xmm14, 0x160(%rsp)
               	movq	-0x160(%rbp), %rax
               	movq	-0x158(%rbp), %rax
               	xorl	%edi, %edi
               	movups	0x160(%rsp), %xmm14
               	vpermilpd	$0x0, %xmm14, %xmm0 # xmm0 = xmm14[0,0]
               	callq	<addr>
               	vmovq	%xmm0, %r11
               	movups	0x160(%rsp), %xmm14
               	vpinsrq	$0x0, %r11, %xmm14, %xmm14
               	movups	%xmm14, 0x160(%rsp)
               	movups	0x160(%rsp), %xmm14
               	vpermilpd	$0x1, %xmm14, %xmm0 # xmm0 = xmm14[1,0]
               	xorl	%edi, %edi
               	callq	<addr>
               	vmovq	%xmm0, %r11
               	movups	0x160(%rsp), %xmm0
               	vpinsrq	$0x1, %r11, %xmm0, %xmm0
               	vmovq	%xmm0, %rax
               	movq	%rax, -0x150(%rbp)
               	vpextrq	$0x1, %xmm0, %rax
               	movq	%rax, -0x148(%rbp)
               	leaq	-0x8(%rbp), %rax
               	stmxcsr	(%rax)
               	movl	-0x8(%rbp), %eax
               	shrq	$0x5, %rax
               	movq	%rax, %r15
               	andq	$0x1, %r15
               	movl	<rip>, %eax # <addr>
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	ldmxcsr	(%rax)
               	movq	-0x150(%rbp), %rax
               	movq	%rax, -0x180(%rbp)
               	movq	-0x148(%rbp), %rax
               	movq	%rax, -0x178(%rbp)
               	xorl	%ebx, %ebx
               	xorl	%r12d, %r12d
               	leaq	-0x180(%rbp), %rcx
               	movq	%rbx, %rax
               	shlq	$0x3, %rax
               	addq	%rax, %rcx
               	movsd	(%rcx), %xmm0
               	movsd	%xmm0, -0x20(%rbp)
               	leaq	-0x28(%rbp), %rcx
               	leaq	-0x20(%rbp), %rdx
               	movq	(%rdx), %r10
               	movq	%r10, (%rcx)
               	movq	-0x20(%rbp), %r14
               	leaq	-0x18(%rbp), %rcx
               	addq	%rcx, %rax
               	movsd	(%rax), %xmm0
               	xorl	%edi, %edi
               	callq	<addr>
               	movsd	%xmm0, -0x20(%rbp)
               	leaq	-0x28(%rbp), %rax
               	leaq	-0x20(%rbp), %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movq	-0x20(%rbp), %rax
               	movl	$0x2, %ecx
               	cmpq	%rax, %r14
               	cmovneq	%rcx, %r12
               	incq	%rbx
               	cmpl	$0x2, %ebx
               	jl	<addr>
               	testl	%r13d, %r13d
               	setne	%al
               	movzbq	%al, %rax
               	movl	$0x2, %ecx
               	cmpl	%eax, %r15d
               	cmovneq	%rcx, %r12
               	movups	0x170(%rsp), %xmm0
               	vmovq	%xmm0, %rax
               	movq	%rax, -0x140(%rbp)
               	vpextrq	$0x1, %xmm0, %rax
               	movq	%rax, -0x138(%rbp)
               	movq	$0x0, -0x130(%rbp)
               	movq	$0x0, -0x128(%rbp)
               	movl	<rip>, %eax # <addr>
               	movl	$0xffff9fc0, %r11d      # imm = 0xFFFF9FC0
               	andq	%r11, %rax
               	orq	$0x4000, %rax           # imm = 0x4000
               	movl	%eax, -0x28(%rbp)
               	leaq	-0x28(%rbp), %rax
               	ldmxcsr	(%rax)
               	movq	-0x140(%rbp), %rax
               	vmovq	%rax, %xmm0
               	movq	-0x138(%rbp), %rax
               	movapd	%xmm0, %xmm14
               	vpinsrq	$0x1, %rax, %xmm14, %xmm14
               	movups	%xmm14, 0x160(%rsp)
               	movq	-0x130(%rbp), %rax
               	movq	-0x128(%rbp), %rax
               	movl	$0x1, %edi
               	movups	0x160(%rsp), %xmm14
               	vpermilpd	$0x0, %xmm14, %xmm0 # xmm0 = xmm14[0,0]
               	callq	<addr>
               	vmovq	%xmm0, %r11
               	movups	0x160(%rsp), %xmm14
               	vpinsrq	$0x0, %r11, %xmm14, %xmm14
               	movups	%xmm14, 0x160(%rsp)
               	movups	0x160(%rsp), %xmm14
               	vpermilpd	$0x1, %xmm14, %xmm0 # xmm0 = xmm14[1,0]
               	movl	$0x1, %edi
               	callq	<addr>
               	vmovq	%xmm0, %r11
               	movups	0x160(%rsp), %xmm0
               	vpinsrq	$0x1, %r11, %xmm0, %xmm0
               	vmovq	%xmm0, %rax
               	movq	%rax, -0x120(%rbp)
               	vpextrq	$0x1, %xmm0, %rax
               	movq	%rax, -0x118(%rbp)
               	leaq	-0x28(%rbp), %rax
               	stmxcsr	(%rax)
               	movl	-0x28(%rbp), %eax
               	shrq	$0x5, %rax
               	movq	%rax, %r15
               	andq	$0x1, %r15
               	movl	<rip>, %eax # <addr>
               	movl	%eax, -0x28(%rbp)
               	leaq	-0x28(%rbp), %rax
               	ldmxcsr	(%rax)
               	movq	-0x120(%rbp), %rax
               	movq	%rax, -0x180(%rbp)
               	movq	-0x118(%rbp), %rax
               	movq	%rax, -0x178(%rbp)
               	xorl	%ebx, %ebx
               	leaq	-0x180(%rbp), %rcx
               	movq	%rbx, %rax
               	shlq	$0x3, %rax
               	addq	%rax, %rcx
               	movsd	(%rcx), %xmm0
               	movsd	%xmm0, -0x20(%rbp)
               	leaq	-0x28(%rbp), %rcx
               	leaq	-0x20(%rbp), %rdx
               	movq	(%rdx), %r10
               	movq	%r10, (%rcx)
               	movq	-0x20(%rbp), %r14
               	leaq	-0x18(%rbp), %rcx
               	addq	%rcx, %rax
               	movsd	(%rax), %xmm0
               	movl	$0x1, %edi
               	callq	<addr>
               	movsd	%xmm0, -0x20(%rbp)
               	leaq	-0x28(%rbp), %rax
               	leaq	-0x20(%rbp), %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movq	-0x20(%rbp), %rax
               	movl	$0x2, %ecx
               	cmpq	%rax, %r14
               	cmovneq	%rcx, %r12
               	incq	%rbx
               	cmpl	$0x2, %ebx
               	jl	<addr>
               	testl	%r13d, %r13d
               	setne	%al
               	movzbq	%al, %rax
               	movl	$0x2, %ecx
               	cmpl	%eax, %r15d
               	cmovneq	%rcx, %r12
               	movups	0x170(%rsp), %xmm0
               	vmovq	%xmm0, %rax
               	movq	%rax, -0x110(%rbp)
               	vpextrq	$0x1, %xmm0, %rax
               	movq	%rax, -0x108(%rbp)
               	movq	$0x0, -0x100(%rbp)
               	movq	$0x0, -0xf8(%rbp)
               	movl	<rip>, %eax # <addr>
               	movl	$0xffff9fc0, %r11d      # imm = 0xFFFF9FC0
               	andq	%r11, %rax
               	orq	$0x2000, %rax           # imm = 0x2000
               	movl	%eax, -0x28(%rbp)
               	leaq	-0x28(%rbp), %rax
               	ldmxcsr	(%rax)
               	movq	-0x110(%rbp), %rax
               	vmovq	%rax, %xmm0
               	movq	-0x108(%rbp), %rax
               	movapd	%xmm0, %xmm14
               	vpinsrq	$0x1, %rax, %xmm14, %xmm14
               	movups	%xmm14, 0x160(%rsp)
               	movq	-0x100(%rbp), %rax
               	movq	-0xf8(%rbp), %rax
               	movl	$0x2, %edi
               	movups	0x160(%rsp), %xmm14
               	vpermilpd	$0x0, %xmm14, %xmm0 # xmm0 = xmm14[0,0]
               	callq	<addr>
               	vmovq	%xmm0, %r11
               	movups	0x160(%rsp), %xmm14
               	vpinsrq	$0x0, %r11, %xmm14, %xmm14
               	movups	%xmm14, 0x160(%rsp)
               	movups	0x160(%rsp), %xmm14
               	vpermilpd	$0x1, %xmm14, %xmm0 # xmm0 = xmm14[1,0]
               	movl	$0x2, %edi
               	callq	<addr>
               	vmovq	%xmm0, %r11
               	movups	0x160(%rsp), %xmm0
               	vpinsrq	$0x1, %r11, %xmm0, %xmm0
               	vmovq	%xmm0, %rax
               	movq	%rax, -0xf0(%rbp)
               	vpextrq	$0x1, %xmm0, %rax
               	movq	%rax, -0xe8(%rbp)
               	leaq	-0x28(%rbp), %rax
               	stmxcsr	(%rax)
               	movl	-0x28(%rbp), %eax
               	shrq	$0x5, %rax
               	movq	%rax, %r15
               	andq	$0x1, %r15
               	movl	<rip>, %eax # <addr>
               	movl	%eax, -0x28(%rbp)
               	leaq	-0x28(%rbp), %rax
               	ldmxcsr	(%rax)
               	movq	-0xf0(%rbp), %rax
               	movq	%rax, -0x180(%rbp)
               	movq	-0xe8(%rbp), %rax
               	movq	%rax, -0x178(%rbp)
               	xorl	%ebx, %ebx
               	leaq	-0x180(%rbp), %rcx
               	movq	%rbx, %rax
               	shlq	$0x3, %rax
               	addq	%rax, %rcx
               	movsd	(%rcx), %xmm0
               	movsd	%xmm0, -0x20(%rbp)
               	leaq	-0x28(%rbp), %rcx
               	leaq	-0x20(%rbp), %rdx
               	movq	(%rdx), %r10
               	movq	%r10, (%rcx)
               	movq	-0x20(%rbp), %r14
               	leaq	-0x18(%rbp), %rcx
               	addq	%rcx, %rax
               	movsd	(%rax), %xmm0
               	movl	$0x2, %edi
               	callq	<addr>
               	movsd	%xmm0, -0x20(%rbp)
               	leaq	-0x28(%rbp), %rax
               	leaq	-0x20(%rbp), %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movq	-0x20(%rbp), %rax
               	movl	$0x2, %ecx
               	cmpq	%rax, %r14
               	cmovneq	%rcx, %r12
               	incq	%rbx
               	cmpl	$0x2, %ebx
               	jl	<addr>
               	testl	%r13d, %r13d
               	setne	%al
               	movzbq	%al, %rax
               	movl	$0x2, %ecx
               	cmpl	%eax, %r15d
               	cmovneq	%rcx, %r12
               	movups	0x170(%rsp), %xmm0
               	vmovq	%xmm0, %rax
               	movq	%rax, -0xe0(%rbp)
               	vpextrq	$0x1, %xmm0, %rax
               	movq	%rax, -0xd8(%rbp)
               	movq	$0x0, -0xd0(%rbp)
               	movq	$0x0, -0xc8(%rbp)
               	movl	<rip>, %eax # <addr>
               	movl	$0xffff9fc0, %r11d      # imm = 0xFFFF9FC0
               	andq	%r11, %rax
               	movl	%eax, -0x28(%rbp)
               	leaq	-0x28(%rbp), %rax
               	ldmxcsr	(%rax)
               	movq	-0xe0(%rbp), %rax
               	vmovq	%rax, %xmm0
               	movq	-0xd8(%rbp), %rax
               	movapd	%xmm0, %xmm14
               	vpinsrq	$0x1, %rax, %xmm14, %xmm14
               	movups	%xmm14, 0x160(%rsp)
               	movq	-0xd0(%rbp), %rax
               	movq	-0xc8(%rbp), %rax
               	movl	$0x3, %edi
               	movups	0x160(%rsp), %xmm14
               	vpermilpd	$0x0, %xmm14, %xmm0 # xmm0 = xmm14[0,0]
               	callq	<addr>
               	vmovq	%xmm0, %r11
               	movups	0x160(%rsp), %xmm14
               	vpinsrq	$0x0, %r11, %xmm14, %xmm14
               	movups	%xmm14, 0x160(%rsp)
               	movups	0x160(%rsp), %xmm14
               	vpermilpd	$0x1, %xmm14, %xmm0 # xmm0 = xmm14[1,0]
               	movl	$0x3, %edi
               	callq	<addr>
               	vmovq	%xmm0, %r11
               	movups	0x160(%rsp), %xmm0
               	vpinsrq	$0x1, %r11, %xmm0, %xmm0
               	vmovq	%xmm0, %rax
               	movq	%rax, -0xc0(%rbp)
               	vpextrq	$0x1, %xmm0, %rax
               	movq	%rax, -0xb8(%rbp)
               	leaq	-0x28(%rbp), %rax
               	stmxcsr	(%rax)
               	movl	-0x28(%rbp), %eax
               	shrq	$0x5, %rax
               	movq	%rax, %r15
               	andq	$0x1, %r15
               	movl	<rip>, %eax # <addr>
               	movl	%eax, -0x28(%rbp)
               	leaq	-0x28(%rbp), %rax
               	ldmxcsr	(%rax)
               	movq	-0xc0(%rbp), %rax
               	movq	%rax, -0x180(%rbp)
               	movq	-0xb8(%rbp), %rax
               	movq	%rax, -0x178(%rbp)
               	xorl	%ebx, %ebx
               	leaq	-0x180(%rbp), %rcx
               	movq	%rbx, %rax
               	shlq	$0x3, %rax
               	addq	%rax, %rcx
               	movsd	(%rcx), %xmm0
               	movsd	%xmm0, -0x20(%rbp)
               	leaq	-0x28(%rbp), %rcx
               	leaq	-0x20(%rbp), %rdx
               	movq	(%rdx), %r10
               	movq	%r10, (%rcx)
               	movq	-0x20(%rbp), %r14
               	leaq	-0x18(%rbp), %rcx
               	addq	%rcx, %rax
               	movsd	(%rax), %xmm0
               	movl	$0x3, %edi
               	callq	<addr>
               	movsd	%xmm0, -0x20(%rbp)
               	leaq	-0x28(%rbp), %rax
               	leaq	-0x20(%rbp), %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movq	-0x20(%rbp), %rax
               	movl	$0x2, %ecx
               	cmpq	%rax, %r14
               	cmovneq	%rcx, %r12
               	incq	%rbx
               	cmpl	$0x2, %ebx
               	jl	<addr>
               	testl	%r13d, %r13d
               	setne	%al
               	movzbq	%al, %rax
               	movl	$0x2, %ecx
               	cmpl	%eax, %r15d
               	cmovneq	%rcx, %r12
               	movups	0x170(%rsp), %xmm0
               	vmovq	%xmm0, %rax
               	movq	%rax, -0xb0(%rbp)
               	vpextrq	$0x1, %xmm0, %rax
               	movq	%rax, -0xa8(%rbp)
               	movq	$0x0, -0xa0(%rbp)
               	movq	$0x0, -0x98(%rbp)
               	movl	<rip>, %eax # <addr>
               	movl	$0xffff9fc0, %r11d      # imm = 0xFFFF9FC0
               	andq	%r11, %rax
               	movl	%eax, -0x28(%rbp)
               	leaq	-0x28(%rbp), %rax
               	ldmxcsr	(%rax)
               	movq	-0xb0(%rbp), %rax
               	vmovq	%rax, %xmm0
               	movq	-0xa8(%rbp), %rax
               	movapd	%xmm0, %xmm14
               	vpinsrq	$0x1, %rax, %xmm14, %xmm14
               	movups	%xmm14, 0x160(%rsp)
               	movq	-0xa0(%rbp), %rax
               	movq	-0x98(%rbp), %rax
               	movl	$0x9, %edi
               	movups	0x160(%rsp), %xmm14
               	vpermilpd	$0x0, %xmm14, %xmm0 # xmm0 = xmm14[0,0]
               	callq	<addr>
               	vmovq	%xmm0, %r11
               	movups	0x160(%rsp), %xmm14
               	vpinsrq	$0x0, %r11, %xmm14, %xmm14
               	movups	%xmm14, 0x160(%rsp)
               	movups	0x160(%rsp), %xmm14
               	vpermilpd	$0x1, %xmm14, %xmm0 # xmm0 = xmm14[1,0]
               	movl	$0x9, %edi
               	callq	<addr>
               	vmovq	%xmm0, %r11
               	movups	0x160(%rsp), %xmm0
               	vpinsrq	$0x1, %r11, %xmm0, %xmm0
               	vmovq	%xmm0, %rax
               	movq	%rax, -0x90(%rbp)
               	vpextrq	$0x1, %xmm0, %rax
               	movq	%rax, -0x88(%rbp)
               	leaq	-0x28(%rbp), %rax
               	stmxcsr	(%rax)
               	movl	-0x28(%rbp), %eax
               	shrq	$0x5, %rax
               	movq	%rax, %r14
               	andq	$0x1, %r14
               	movl	<rip>, %eax # <addr>
               	movl	%eax, -0x28(%rbp)
               	leaq	-0x28(%rbp), %rax
               	ldmxcsr	(%rax)
               	movq	-0x90(%rbp), %rax
               	movq	%rax, -0x180(%rbp)
               	movq	-0x88(%rbp), %rax
               	movq	%rax, -0x178(%rbp)
               	xorl	%ebx, %ebx
               	leaq	-0x180(%rbp), %rcx
               	movq	%rbx, %rax
               	shlq	$0x3, %rax
               	addq	%rax, %rcx
               	movsd	(%rcx), %xmm0
               	movsd	%xmm0, -0x20(%rbp)
               	leaq	-0x28(%rbp), %rcx
               	leaq	-0x20(%rbp), %rdx
               	movq	(%rdx), %r10
               	movq	%r10, (%rcx)
               	movq	-0x20(%rbp), %r13
               	leaq	-0x18(%rbp), %rcx
               	addq	%rcx, %rax
               	movsd	(%rax), %xmm0
               	movl	$0x1, %edi
               	callq	<addr>
               	movsd	%xmm0, -0x20(%rbp)
               	leaq	-0x28(%rbp), %rax
               	leaq	-0x20(%rbp), %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movq	-0x20(%rbp), %rax
               	movl	$0x2, %ecx
               	cmpq	%rax, %r13
               	cmovneq	%rcx, %r12
               	incq	%rbx
               	cmpl	$0x2, %ebx
               	jl	<addr>
               	movl	$0x2, %eax
               	testl	%r14d, %r14d
               	cmovneq	%rax, %r12
               	movups	0x170(%rsp), %xmm0
               	vmovq	%xmm0, %rax
               	movq	%rax, -0x80(%rbp)
               	vpextrq	$0x1, %xmm0, %rax
               	movq	%rax, -0x78(%rbp)
               	movq	$0x0, -0x70(%rbp)
               	movq	$0x0, -0x68(%rbp)
               	movl	<rip>, %eax # <addr>
               	movl	$0xffff9fc0, %r11d      # imm = 0xFFFF9FC0
               	andq	%r11, %rax
               	movl	%eax, -0x28(%rbp)
               	leaq	-0x28(%rbp), %rax
               	ldmxcsr	(%rax)
               	movq	-0x80(%rbp), %rax
               	vmovq	%rax, %xmm0
               	movq	-0x78(%rbp), %rax
               	movapd	%xmm0, %xmm14
               	vpinsrq	$0x1, %rax, %xmm14, %xmm14
               	movups	%xmm14, 0x170(%rsp)
               	movq	-0x70(%rbp), %rax
               	movq	-0x68(%rbp), %rax
               	movl	$0xa, %edi
               	movups	0x170(%rsp), %xmm14
               	vpermilpd	$0x0, %xmm14, %xmm0 # xmm0 = xmm14[0,0]
               	callq	<addr>
               	vmovq	%xmm0, %r11
               	movups	0x170(%rsp), %xmm14
               	vpinsrq	$0x0, %r11, %xmm14, %xmm14
               	movups	%xmm14, 0x170(%rsp)
               	movups	0x170(%rsp), %xmm14
               	vpermilpd	$0x1, %xmm14, %xmm0 # xmm0 = xmm14[1,0]
               	movl	$0xa, %edi
               	callq	<addr>
               	vmovq	%xmm0, %r11
               	movups	0x170(%rsp), %xmm0
               	vpinsrq	$0x1, %r11, %xmm0, %xmm0
               	vmovq	%xmm0, %rax
               	movq	%rax, -0x60(%rbp)
               	vpextrq	$0x1, %xmm0, %rax
               	movq	%rax, -0x58(%rbp)
               	leaq	-0x28(%rbp), %rax
               	stmxcsr	(%rax)
               	movl	-0x28(%rbp), %eax
               	shrq	$0x5, %rax
               	movq	%rax, %r14
               	andq	$0x1, %r14
               	movl	<rip>, %eax # <addr>
               	movl	%eax, -0x28(%rbp)
               	leaq	-0x28(%rbp), %rax
               	ldmxcsr	(%rax)
               	movq	-0x60(%rbp), %rax
               	movq	%rax, -0x180(%rbp)
               	movq	-0x58(%rbp), %rax
               	movq	%rax, -0x178(%rbp)
               	xorl	%ebx, %ebx
               	leaq	-0x180(%rbp), %rcx
               	movq	%rbx, %rax
               	shlq	$0x3, %rax
               	addq	%rax, %rcx
               	movsd	(%rcx), %xmm0
               	movsd	%xmm0, -0x20(%rbp)
               	leaq	-0x28(%rbp), %rcx
               	leaq	-0x20(%rbp), %rdx
               	movq	(%rdx), %r10
               	movq	%r10, (%rcx)
               	movq	-0x20(%rbp), %r13
               	leaq	-0x18(%rbp), %rcx
               	addq	%rcx, %rax
               	movsd	(%rax), %xmm0
               	movl	$0x2, %edi
               	callq	<addr>
               	movsd	%xmm0, -0x20(%rbp)
               	leaq	-0x28(%rbp), %rax
               	leaq	-0x20(%rbp), %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movq	-0x20(%rbp), %rax
               	movl	$0x2, %ecx
               	cmpq	%rax, %r13
               	cmovneq	%rcx, %r12
               	incq	%rbx
               	cmpl	$0x2, %ebx
               	jl	<addr>
               	movl	$0x2, %eax
               	testl	%r14d, %r14d
               	cmoveq	%r12, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq

<check_round_scalar>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	pushq	%r12
               	pushq	%rbx
               	callq	<addr>
               	callq	<addr>
               	movsd	%xmm0, 0x78(%rsp)
               	callq	<addr>
               	movsd	%xmm0, 0x30(%rsp)
               	callq	<addr>
               	movsd	%xmm0, 0x60(%rsp)
               	callq	<addr>
               	movsd	%xmm0, 0x58(%rsp)
               	callq	<addr>
               	movsd	%xmm0, 0x50(%rsp)
               	callq	<addr>
               	movsd	%xmm0, 0x48(%rsp)
               	callq	<addr>
               	movsd	%xmm0, 0x40(%rsp)
               	callq	<addr>
               	callq	<addr>
               	movsd	%xmm0, 0x70(%rsp)
               	callq	<addr>
               	movsd	%xmm0, 0x68(%rsp)
               	callq	<addr>
               	movsd	%xmm0, 0x38(%rsp)
               	movl	$0x3, %edi
               	movsd	0x78(%rsp), %xmm0
               	callq	<addr>
               	movss	%xmm0, -0x10(%rbp)
               	leaq	-0x8(%rbp), %rax
               	leaq	-0x10(%rbp), %rcx
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	movl	-0x10(%rbp), %ebx
               	movsd	0x78(%rsp), %xmm0
               	movl	$0x3, %edi
               	callq	<addr>
               	movss	%xmm0, -0x10(%rbp)
               	leaq	-0x8(%rbp), %rax
               	leaq	-0x10(%rbp), %rcx
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	movl	-0x10(%rbp), %edx
               	cmpl	%edx, %ebx
               	setne	%dl
               	movzbq	%dl, %rdx
               	movsd	0x30(%rsp), %xmm0
               	movss	%xmm0, -0x10(%rbp)
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	movl	-0x10(%rbp), %esi
               	movsd	0x30(%rsp), %xmm0
               	movss	%xmm0, -0x10(%rbp)
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	movl	-0x10(%rbp), %ecx
               	cmpl	%ecx, %esi
               	setne	%cl
               	movzbq	%cl, %rcx
               	orq	%rcx, %rdx
               	movsd	0x58(%rsp), %xmm0
               	movss	%xmm0, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rcx
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	movl	-0x10(%rbp), %esi
               	movsd	0x58(%rsp), %xmm0
               	movss	%xmm0, -0x10(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	movl	-0x10(%rbp), %edi
               	cmpl	%edi, %esi
               	setne	%sil
               	movzbq	%sil, %rsi
               	orq	%rsi, %rdx
               	movsd	0x48(%rsp), %xmm0
               	movss	%xmm0, -0x10(%rbp)
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	movl	-0x10(%rbp), %ecx
               	movsd	0x48(%rsp), %xmm0
               	movss	%xmm0, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rsi
               	movl	(%rsi), %r10d
               	movl	%r10d, (%rax)
               	movl	-0x10(%rbp), %eax
               	cmpl	%eax, %ecx
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rdx, %rbx
               	orq	%rax, %rbx
               	movl	$0x2, %edi
               	movsd	0x70(%rsp), %xmm0
               	callq	<addr>
               	movsd	%xmm0, -0x8(%rbp)
               	leaq	-0x10(%rbp), %rax
               	leaq	-0x8(%rbp), %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movq	-0x8(%rbp), %r12
               	movsd	0x70(%rsp), %xmm0
               	movl	$0x2, %edi
               	callq	<addr>
               	movsd	%xmm0, -0x8(%rbp)
               	leaq	-0x10(%rbp), %rax
               	leaq	-0x8(%rbp), %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movq	-0x8(%rbp), %rdx
               	cmpq	%rdx, %r12
               	movl	$0x1, %edx
               	jne	<addr>
               	movsd	0x68(%rsp), %xmm0
               	movsd	%xmm0, -0x8(%rbp)
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movq	-0x8(%rbp), %rdx
               	movsd	0x68(%rsp), %xmm0
               	movsd	%xmm0, -0x8(%rbp)
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movq	-0x8(%rbp), %rax
               	cmpq	%rax, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	orq	%rdx, %rbx
               	movl	$0x1, %edi
               	movsd	0x78(%rsp), %xmm0
               	callq	<addr>
               	movsd	%xmm0, 0x30(%rsp)
               	movsd	0x60(%rsp), %xmm0
               	movl	$0x1, %edi
               	callq	<addr>
               	movsd	%xmm0, 0x28(%rsp)
               	movsd	0x50(%rsp), %xmm0
               	movl	$0x1, %edi
               	callq	<addr>
               	movsd	%xmm0, 0x20(%rsp)
               	movsd	0x40(%rsp), %xmm0
               	movl	$0x1, %edi
               	callq	<addr>
               	movsd	%xmm0, 0x18(%rsp)
               	movsd	0x30(%rsp), %xmm0
               	movss	%xmm0, -0x10(%rbp)
               	leaq	-0x8(%rbp), %rax
               	leaq	-0x10(%rbp), %rcx
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	movl	-0x10(%rbp), %r12d
               	movsd	0x78(%rsp), %xmm0
               	movl	$0x1, %edi
               	callq	<addr>
               	movss	%xmm0, -0x10(%rbp)
               	leaq	-0x8(%rbp), %rax
               	leaq	-0x10(%rbp), %rcx
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	movl	-0x10(%rbp), %edx
               	cmpl	%edx, %r12d
               	setne	%dl
               	movzbq	%dl, %rdx
               	orq	%rdx, %rbx
               	movsd	0x28(%rsp), %xmm0
               	movss	%xmm0, -0x10(%rbp)
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	movl	-0x10(%rbp), %r12d
               	movsd	0x60(%rsp), %xmm0
               	movl	$0x1, %edi
               	callq	<addr>
               	movss	%xmm0, -0x10(%rbp)
               	leaq	-0x8(%rbp), %rax
               	leaq	-0x10(%rbp), %rcx
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	movl	-0x10(%rbp), %edx
               	cmpl	%edx, %r12d
               	setne	%dl
               	movzbq	%dl, %rdx
               	orq	%rdx, %rbx
               	movsd	0x20(%rsp), %xmm0
               	movss	%xmm0, -0x10(%rbp)
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	movl	-0x10(%rbp), %r12d
               	movsd	0x50(%rsp), %xmm0
               	movl	$0x1, %edi
               	callq	<addr>
               	movss	%xmm0, -0x10(%rbp)
               	leaq	-0x8(%rbp), %rax
               	leaq	-0x10(%rbp), %rcx
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	movl	-0x10(%rbp), %edx
               	cmpl	%edx, %r12d
               	setne	%dl
               	movzbq	%dl, %rdx
               	orq	%rdx, %rbx
               	movsd	0x18(%rsp), %xmm0
               	movss	%xmm0, -0x10(%rbp)
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	movl	-0x10(%rbp), %r12d
               	movsd	0x40(%rsp), %xmm0
               	movl	$0x1, %edi
               	callq	<addr>
               	movss	%xmm0, -0x10(%rbp)
               	leaq	-0x8(%rbp), %rax
               	leaq	-0x10(%rbp), %rcx
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	movl	-0x10(%rbp), %eax
               	cmpl	%eax, %r12d
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rax, %rbx
               	movl	$0x2, %edi
               	movsd	0x78(%rsp), %xmm0
               	callq	<addr>
               	movsd	%xmm0, 0x30(%rsp)
               	movsd	0x60(%rsp), %xmm0
               	movl	$0x2, %edi
               	callq	<addr>
               	movsd	%xmm0, 0x28(%rsp)
               	movsd	0x50(%rsp), %xmm0
               	movl	$0x2, %edi
               	callq	<addr>
               	movsd	%xmm0, 0x20(%rsp)
               	movsd	0x40(%rsp), %xmm0
               	movl	$0x2, %edi
               	callq	<addr>
               	movsd	%xmm0, 0x18(%rsp)
               	movsd	0x30(%rsp), %xmm0
               	movss	%xmm0, -0x10(%rbp)
               	leaq	-0x8(%rbp), %rax
               	leaq	-0x10(%rbp), %rcx
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	movl	-0x10(%rbp), %r12d
               	movsd	0x78(%rsp), %xmm0
               	movl	$0x2, %edi
               	callq	<addr>
               	movss	%xmm0, -0x10(%rbp)
               	leaq	-0x8(%rbp), %rax
               	leaq	-0x10(%rbp), %rcx
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	movl	-0x10(%rbp), %edx
               	cmpl	%edx, %r12d
               	setne	%dl
               	movzbq	%dl, %rdx
               	orq	%rdx, %rbx
               	movsd	0x28(%rsp), %xmm0
               	movss	%xmm0, -0x10(%rbp)
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	movl	-0x10(%rbp), %r12d
               	movsd	0x60(%rsp), %xmm0
               	movl	$0x2, %edi
               	callq	<addr>
               	movss	%xmm0, -0x10(%rbp)
               	leaq	-0x8(%rbp), %rax
               	leaq	-0x10(%rbp), %rcx
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	movl	-0x10(%rbp), %edx
               	cmpl	%edx, %r12d
               	setne	%dl
               	movzbq	%dl, %rdx
               	orq	%rdx, %rbx
               	movsd	0x20(%rsp), %xmm0
               	movss	%xmm0, -0x10(%rbp)
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	movl	-0x10(%rbp), %r12d
               	movsd	0x50(%rsp), %xmm0
               	movl	$0x2, %edi
               	callq	<addr>
               	movss	%xmm0, -0x10(%rbp)
               	leaq	-0x8(%rbp), %rax
               	leaq	-0x10(%rbp), %rcx
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	movl	-0x10(%rbp), %edx
               	cmpl	%edx, %r12d
               	setne	%dl
               	movzbq	%dl, %rdx
               	orq	%rdx, %rbx
               	movsd	0x18(%rsp), %xmm0
               	movss	%xmm0, -0x10(%rbp)
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	movl	-0x10(%rbp), %r12d
               	movsd	0x40(%rsp), %xmm0
               	movl	$0x2, %edi
               	callq	<addr>
               	movss	%xmm0, -0x10(%rbp)
               	leaq	-0x8(%rbp), %rax
               	leaq	-0x10(%rbp), %rcx
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	movl	-0x10(%rbp), %eax
               	cmpl	%eax, %r12d
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rax, %rbx
               	movl	$0x1, %edi
               	movsd	0x70(%rsp), %xmm0
               	callq	<addr>
               	movsd	%xmm0, 0x60(%rsp)
               	movsd	0x38(%rsp), %xmm0
               	movl	$0x1, %edi
               	callq	<addr>
               	movsd	0x60(%rsp), %xmm0
               	movsd	%xmm0, -0x8(%rbp)
               	leaq	-0x10(%rbp), %rax
               	leaq	-0x8(%rbp), %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movq	-0x8(%rbp), %r12
               	movsd	0x70(%rsp), %xmm0
               	movl	$0x1, %edi
               	callq	<addr>
               	movsd	%xmm0, -0x8(%rbp)
               	leaq	-0x10(%rbp), %rax
               	leaq	-0x8(%rbp), %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movq	-0x8(%rbp), %rax
               	cmpq	%rax, %r12
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rax, %rbx
               	movl	$0x2, %edi
               	movsd	0x70(%rsp), %xmm0
               	callq	<addr>
               	movsd	0x38(%rsp), %xmm0
               	movl	$0x2, %edi
               	callq	<addr>
               	movsd	%xmm0, -0x8(%rbp)
               	leaq	-0x10(%rbp), %rax
               	leaq	-0x8(%rbp), %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movq	-0x8(%rbp), %r12
               	movsd	0x38(%rsp), %xmm0
               	movl	$0x2, %edi
               	callq	<addr>
               	movsd	%xmm0, -0x8(%rbp)
               	leaq	-0x10(%rbp), %rax
               	leaq	-0x8(%rbp), %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movq	-0x8(%rbp), %rax
               	cmpq	%rax, %r12
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rax, %rbx
               	movl	$0x1, %edi
               	movsd	0x78(%rsp), %xmm0
               	callq	<addr>
               	movss	%xmm0, -0x10(%rbp)
               	leaq	-0x8(%rbp), %rax
               	leaq	-0x10(%rbp), %rcx
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	movl	-0x10(%rbp), %r12d
               	movsd	0x78(%rsp), %xmm0
               	movl	$0x1, %edi
               	callq	<addr>
               	movss	%xmm0, -0x10(%rbp)
               	leaq	-0x8(%rbp), %rax
               	leaq	-0x10(%rbp), %rcx
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	movl	-0x10(%rbp), %edx
               	cmpl	%edx, %r12d
               	movl	$0x1, %edx
               	jne	<addr>
               	movsd	0x48(%rsp), %xmm0
               	movss	%xmm0, -0x10(%rbp)
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	movl	-0x10(%rbp), %edx
               	movsd	0x48(%rsp), %xmm0
               	movss	%xmm0, -0x10(%rbp)
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	movl	-0x10(%rbp), %eax
               	cmpl	%eax, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	orq	%rdx, %rbx
               	movl	$0x2, %edi
               	movsd	0x78(%rsp), %xmm0
               	callq	<addr>
               	movss	%xmm0, -0x10(%rbp)
               	leaq	-0x8(%rbp), %rax
               	leaq	-0x10(%rbp), %rcx
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	movl	-0x10(%rbp), %r12d
               	movsd	0x78(%rsp), %xmm0
               	movl	$0x2, %edi
               	callq	<addr>
               	movss	%xmm0, -0x10(%rbp)
               	leaq	-0x8(%rbp), %rax
               	leaq	-0x10(%rbp), %rcx
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	movl	-0x10(%rbp), %edx
               	cmpl	%edx, %r12d
               	movl	$0x1, %edx
               	jne	<addr>
               	movsd	0x58(%rsp), %xmm0
               	movss	%xmm0, -0x10(%rbp)
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	movl	-0x10(%rbp), %edx
               	movsd	0x58(%rsp), %xmm0
               	movss	%xmm0, -0x10(%rbp)
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	movl	-0x10(%rbp), %eax
               	cmpl	%eax, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	orq	%rdx, %rbx
               	movl	$0x1, %edi
               	movsd	0x70(%rsp), %xmm0
               	callq	<addr>
               	movsd	%xmm0, -0x8(%rbp)
               	leaq	-0x10(%rbp), %rax
               	leaq	-0x8(%rbp), %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movq	-0x8(%rbp), %r12
               	movsd	0x70(%rsp), %xmm0
               	movl	$0x1, %edi
               	callq	<addr>
               	movsd	%xmm0, -0x8(%rbp)
               	leaq	-0x10(%rbp), %rax
               	leaq	-0x8(%rbp), %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movq	-0x8(%rbp), %rdx
               	cmpq	%rdx, %r12
               	movl	$0x1, %edx
               	jne	<addr>
               	movsd	0x68(%rsp), %xmm0
               	movsd	%xmm0, -0x8(%rbp)
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movq	-0x8(%rbp), %rdx
               	movsd	0x68(%rsp), %xmm0
               	movsd	%xmm0, -0x8(%rbp)
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movq	-0x8(%rbp), %rax
               	cmpq	%rax, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	orq	%rdx, %rbx
               	movl	$0x2, %edi
               	movsd	0x70(%rsp), %xmm0
               	callq	<addr>
               	movsd	%xmm0, -0x8(%rbp)
               	leaq	-0x10(%rbp), %rax
               	leaq	-0x8(%rbp), %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movq	-0x8(%rbp), %r12
               	movsd	0x70(%rsp), %xmm0
               	movl	$0x2, %edi
               	callq	<addr>
               	movsd	%xmm0, -0x8(%rbp)
               	leaq	-0x10(%rbp), %rax
               	leaq	-0x8(%rbp), %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movq	-0x8(%rbp), %rdx
               	cmpq	%rdx, %r12
               	movl	$0x1, %edx
               	jne	<addr>
               	movsd	0x68(%rsp), %xmm0
               	movsd	%xmm0, -0x8(%rbp)
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movq	-0x8(%rbp), %rdx
               	movsd	0x68(%rsp), %xmm0
               	movsd	%xmm0, -0x8(%rbp)
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movq	-0x8(%rbp), %rax
               	cmpq	%rax, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	orq	%rbx, %rdx
               	movl	$0x4, %eax
               	xorl	%ecx, %ecx
               	testq	%rdx, %rdx
               	cmoveq	%rcx, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq

<check_current_direction>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x1a8, %rsp            # imm = 0x1A8
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	callq	<addr>
               	movsd	%xmm0, 0x118(%rsp)
               	movsd	0x118(%rsp), %xmm15
               	vmovq	%xmm15, %r11
               	vmovq	%r11, %xmm14
               	movups	%xmm14, 0x190(%rsp)
               	callq	<addr>
               	movsd	%xmm0, 0x110(%rsp)
               	movsd	0x110(%rsp), %xmm15
               	vmovq	%xmm15, %r11
               	movups	0x190(%rsp), %xmm14
               	vpinsrq	$0x1, %r11, %xmm14, %xmm14
               	movups	%xmm14, 0x100(%rsp)
               	callq	<addr>
               	movss	%xmm0, -0x18(%rbp)
               	callq	<addr>
               	movss	%xmm0, -0x14(%rbp)
               	callq	<addr>
               	movss	%xmm0, -0x10(%rbp)
               	callq	<addr>
               	movss	%xmm0, -0xc(%rbp)
               	movups	-0x18(%rbp), %xmm14
               	movups	%xmm14, 0x140(%rsp)
               	xorl	%ebx, %ebx
               	movq	%rbx, %r12
               	leaq	-0x18(%rbp), %rax
               	movq	%rbx, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	movss	(%rax), %xmm0
               	ucomiss	%xmm0, %xmm0
               	sete	%cl
               	movzbq	%cl, %rcx
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rcx
               	xorl	%eax, %eax
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x3, %edi
               	callq	<addr>
               	leaq	-0x18(%rbp), %rax
               	movq	%rbx, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	movss	(%rax), %xmm1
               	ucomiss	%xmm1, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	orq	%rax, %r12
               	incq	%rbx
               	cmpl	$0x4, %ebx
               	jl	<addr>
               	xorl	%ebx, %ebx
               	xorl	%r14d, %r14d
               	movups	0x140(%rsp), %xmm0
               	vmovq	%xmm0, %rax
               	movq	%rax, -0x1a0(%rbp)
               	vpextrq	$0x1, %xmm0, %rax
               	movq	%rax, -0x198(%rbp)
               	movq	$0x0, -0x190(%rbp)
               	movq	$0x0, -0x188(%rbp)
               	movl	<rip>, %eax # <addr>
               	movl	$0xffff9fc0, %r11d      # imm = 0xFFFF9FC0
               	andq	%r11, %rax
               	movq	%rbx, %rcx
               	shlq	$0xd, %rcx
               	orq	%rcx, %rax
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	ldmxcsr	(%rax)
               	movq	-0x1a0(%rbp), %rax
               	movups	0x170(%rsp), %xmm14
               	vpinsrq	$0x0, %rax, %xmm14, %xmm14
               	movups	%xmm14, 0x120(%rsp)
               	movq	-0x198(%rbp), %rax
               	movups	0x120(%rsp), %xmm0
               	movapd	%xmm0, %xmm14
               	vpinsrq	$0x1, %rax, %xmm14, %xmm14
               	movups	%xmm14, 0x170(%rsp)
               	movq	-0x190(%rbp), %rax
               	movq	-0x188(%rbp), %rax
               	movl	$0x4, %r13d
               	movq	%r13, %rdi
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	0x170(%rsp), %xmm14
               	vpinsrd	$0x0, %r11d, %xmm14, %xmm14
               	movups	%xmm14, 0xf0(%rsp)
               	movups	0x120(%rsp), %xmm14
               	vpermilps	$0x1, %xmm14, %xmm0 # xmm0 = xmm14[1,0,0,0]
               	movq	%r13, %rdi
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	0xf0(%rsp), %xmm14
               	vpinsrd	$0x1, %r11d, %xmm14, %xmm14
               	movups	%xmm14, 0x120(%rsp)
               	movups	0x170(%rsp), %xmm14
               	vpermilps	$0x2, %xmm14, %xmm0 # xmm0 = xmm14[2,0,0,0]
               	movq	%r13, %rdi
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	0x120(%rsp), %xmm14
               	vpinsrd	$0x2, %r11d, %xmm14, %xmm14
               	movups	%xmm14, 0xf0(%rsp)
               	movups	0x170(%rsp), %xmm14
               	vpermilps	$0x3, %xmm14, %xmm0 # xmm0 = xmm14[3,0,0,0]
               	movq	%r13, %rdi
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	0xf0(%rsp), %xmm0
               	vpinsrd	$0x3, %r11d, %xmm0, %xmm0
               	movups	0x120(%rsp), %xmm14
               	vmovq	%xmm14, %rax
               	movq	%rax, -0x180(%rbp)
               	vpextrq	$0x1, %xmm0, %rax
               	movq	%rax, -0x178(%rbp)
               	leaq	-0x8(%rbp), %rax
               	stmxcsr	(%rax)
               	movl	-0x8(%rbp), %eax
               	shrq	$0x5, %rax
               	movq	%rax, %r13
               	andq	$0x1, %r13
               	movl	<rip>, %eax # <addr>
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	ldmxcsr	(%rax)
               	movq	-0x180(%rbp), %rax
               	movups	0x130(%rsp), %xmm14
               	vpinsrq	$0x0, %rax, %xmm14, %xmm14
               	movups	%xmm14, 0x120(%rsp)
               	movq	-0x178(%rbp), %rax
               	movups	0x120(%rsp), %xmm0
               	movapd	%xmm0, %xmm14
               	vpinsrq	$0x1, %rax, %xmm14, %xmm14
               	movups	%xmm14, 0x130(%rsp)
               	movss	%xmm0, -0x28(%rbp)
               	leaq	-0x20(%rbp), %rax
               	leaq	-0x28(%rbp), %rcx
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	movl	-0x28(%rbp), %r15d
               	movss	-0x18(%rbp), %xmm0
               	movq	%rbx, %rdi
               	callq	<addr>
               	movss	%xmm0, -0x28(%rbp)
               	leaq	-0x20(%rbp), %rax
               	leaq	-0x28(%rbp), %rcx
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	movl	-0x28(%rbp), %ecx
               	cmpl	%ecx, %r15d
               	setne	%cl
               	movzbq	%cl, %rcx
               	orq	%rcx, %r14
               	movups	0x120(%rsp), %xmm14
               	vpermilps	$0x1, %xmm14, %xmm0 # xmm0 = xmm14[1,0,0,0]
               	movss	%xmm0, -0x28(%rbp)
               	leaq	-0x28(%rbp), %rcx
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	movl	-0x28(%rbp), %r15d
               	movss	-0x14(%rbp), %xmm0
               	movq	%rbx, %rdi
               	callq	<addr>
               	movss	%xmm0, -0x28(%rbp)
               	leaq	-0x20(%rbp), %rax
               	leaq	-0x28(%rbp), %rcx
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	movl	-0x28(%rbp), %ecx
               	cmpl	%ecx, %r15d
               	setne	%cl
               	movzbq	%cl, %rcx
               	orq	%rcx, %r14
               	movups	0x130(%rsp), %xmm14
               	vpermilps	$0x2, %xmm14, %xmm0 # xmm0 = xmm14[2,0,0,0]
               	movss	%xmm0, -0x28(%rbp)
               	leaq	-0x28(%rbp), %rcx
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	movl	-0x28(%rbp), %r15d
               	movss	-0x10(%rbp), %xmm0
               	movq	%rbx, %rdi
               	callq	<addr>
               	movss	%xmm0, -0x28(%rbp)
               	leaq	-0x20(%rbp), %rax
               	leaq	-0x28(%rbp), %rcx
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	movl	-0x28(%rbp), %ecx
               	cmpl	%ecx, %r15d
               	setne	%cl
               	movzbq	%cl, %rcx
               	orq	%rcx, %r14
               	movups	0x130(%rsp), %xmm14
               	vpermilps	$0x3, %xmm14, %xmm0 # xmm0 = xmm14[3,0,0,0]
               	movss	%xmm0, -0x28(%rbp)
               	leaq	-0x28(%rbp), %rcx
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	movl	-0x28(%rbp), %r15d
               	movss	-0xc(%rbp), %xmm0
               	movq	%rbx, %rdi
               	callq	<addr>
               	movss	%xmm0, -0x28(%rbp)
               	leaq	-0x20(%rbp), %rax
               	leaq	-0x28(%rbp), %rcx
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	movl	-0x28(%rbp), %eax
               	cmpl	%eax, %r15d
               	setne	%al
               	movzbq	%al, %rax
               	orq	%r14, %rax
               	cmpl	%r12d, %r13d
               	setne	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %r14
               	orq	%rcx, %r14
               	movups	0x140(%rsp), %xmm0
               	vmovq	%xmm0, %rax
               	movq	%rax, -0x170(%rbp)
               	vpextrq	$0x1, %xmm0, %rax
               	movq	%rax, -0x168(%rbp)
               	movq	$0x0, -0x160(%rbp)
               	movq	$0x0, -0x158(%rbp)
               	movl	<rip>, %eax # <addr>
               	movl	$0xffff9fc0, %r11d      # imm = 0xFFFF9FC0
               	andq	%r11, %rax
               	movq	%rbx, %rcx
               	shlq	$0xd, %rcx
               	orq	%rcx, %rax
               	movl	%eax, -0x28(%rbp)
               	leaq	-0x28(%rbp), %rax
               	ldmxcsr	(%rax)
               	movq	-0x170(%rbp), %rax
               	movups	0x180(%rsp), %xmm14
               	vpinsrq	$0x0, %rax, %xmm14, %xmm14
               	movups	%xmm14, 0x120(%rsp)
               	movq	-0x168(%rbp), %rax
               	movups	0x120(%rsp), %xmm0
               	movapd	%xmm0, %xmm14
               	vpinsrq	$0x1, %rax, %xmm14, %xmm14
               	movups	%xmm14, 0x180(%rsp)
               	movq	-0x160(%rbp), %rax
               	movq	-0x158(%rbp), %rax
               	movl	$0x4, %r13d
               	movq	%r13, %rdi
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	0x180(%rsp), %xmm14
               	vpinsrd	$0x0, %r11d, %xmm14, %xmm14
               	movups	%xmm14, 0xf0(%rsp)
               	movups	0x120(%rsp), %xmm14
               	vpermilps	$0x1, %xmm14, %xmm0 # xmm0 = xmm14[1,0,0,0]
               	movq	%r13, %rdi
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	0xf0(%rsp), %xmm14
               	vpinsrd	$0x1, %r11d, %xmm14, %xmm14
               	movups	%xmm14, 0x120(%rsp)
               	movups	0x180(%rsp), %xmm14
               	vpermilps	$0x2, %xmm14, %xmm0 # xmm0 = xmm14[2,0,0,0]
               	movq	%r13, %rdi
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	0x120(%rsp), %xmm14
               	vpinsrd	$0x2, %r11d, %xmm14, %xmm14
               	movups	%xmm14, 0xf0(%rsp)
               	movups	0x180(%rsp), %xmm14
               	vpermilps	$0x3, %xmm14, %xmm0 # xmm0 = xmm14[3,0,0,0]
               	movq	%r13, %rdi
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	0xf0(%rsp), %xmm0
               	vpinsrd	$0x3, %r11d, %xmm0, %xmm0
               	movups	0x120(%rsp), %xmm14
               	vmovq	%xmm14, %rax
               	movq	%rax, -0x150(%rbp)
               	vpextrq	$0x1, %xmm0, %rax
               	movq	%rax, -0x148(%rbp)
               	leaq	-0x28(%rbp), %rax
               	stmxcsr	(%rax)
               	movl	-0x28(%rbp), %eax
               	shrq	$0x5, %rax
               	movq	%rax, %r13
               	andq	$0x1, %r13
               	movl	<rip>, %eax # <addr>
               	movl	%eax, -0x28(%rbp)
               	leaq	-0x28(%rbp), %rax
               	ldmxcsr	(%rax)
               	movq	-0x150(%rbp), %rax
               	movups	0x130(%rsp), %xmm0
               	vpinsrq	$0x0, %rax, %xmm0, %xmm0
               	movq	-0x148(%rbp), %rax
               	movapd	%xmm0, %xmm14
               	vpinsrq	$0x1, %rax, %xmm14, %xmm14
               	movups	%xmm14, 0x120(%rsp)
               	vpermilps	$0x1, %xmm0, %xmm0 # xmm0 = xmm0[1,0,0,0]
               	movss	%xmm0, -0x28(%rbp)
               	leaq	-0x20(%rbp), %rax
               	leaq	-0x28(%rbp), %rcx
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	movl	-0x28(%rbp), %r15d
               	movss	-0x14(%rbp), %xmm0
               	movq	%rbx, %rdi
               	callq	<addr>
               	movss	%xmm0, -0x28(%rbp)
               	leaq	-0x20(%rbp), %rax
               	leaq	-0x28(%rbp), %rcx
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	movl	-0x28(%rbp), %eax
               	movl	$0x1, %ecx
               	cmpl	%r12d, %r13d
               	setne	%dl
               	movzbq	%dl, %rdx
               	cmpl	%eax, %r15d
               	cmoveq	%rdx, %rcx
               	orq	%rcx, %r14
               	movups	0x140(%rsp), %xmm0
               	vmovq	%xmm0, %rax
               	movq	%rax, -0x140(%rbp)
               	vpextrq	$0x1, %xmm0, %rax
               	movq	%rax, -0x138(%rbp)
               	movq	$0x0, -0x130(%rbp)
               	movq	$0x0, -0x128(%rbp)
               	movl	<rip>, %eax # <addr>
               	movl	$0xffff9fc0, %r11d      # imm = 0xFFFF9FC0
               	andq	%r11, %rax
               	movq	%rbx, %rcx
               	shlq	$0xd, %rcx
               	orq	%rcx, %rax
               	movl	%eax, -0x28(%rbp)
               	leaq	-0x28(%rbp), %rax
               	ldmxcsr	(%rax)
               	movq	-0x140(%rbp), %rax
               	movups	0x190(%rsp), %xmm14
               	vpinsrq	$0x0, %rax, %xmm14, %xmm14
               	movups	%xmm14, 0x130(%rsp)
               	movq	-0x138(%rbp), %rax
               	movups	0x130(%rsp), %xmm0
               	movapd	%xmm0, %xmm14
               	vpinsrq	$0x1, %rax, %xmm14, %xmm14
               	movups	%xmm14, 0x190(%rsp)
               	movq	-0x130(%rbp), %rax
               	movq	-0x128(%rbp), %rax
               	movl	$0xc, %r13d
               	movq	%r13, %rdi
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	0x190(%rsp), %xmm14
               	vpinsrd	$0x0, %r11d, %xmm14, %xmm14
               	movups	%xmm14, 0xf0(%rsp)
               	movups	0x130(%rsp), %xmm14
               	vpermilps	$0x1, %xmm14, %xmm0 # xmm0 = xmm14[1,0,0,0]
               	movq	%r13, %rdi
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	0xf0(%rsp), %xmm14
               	vpinsrd	$0x1, %r11d, %xmm14, %xmm14
               	movups	%xmm14, 0x130(%rsp)
               	movups	0x190(%rsp), %xmm14
               	vpermilps	$0x2, %xmm14, %xmm0 # xmm0 = xmm14[2,0,0,0]
               	movq	%r13, %rdi
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	0x130(%rsp), %xmm14
               	vpinsrd	$0x2, %r11d, %xmm14, %xmm14
               	movups	%xmm14, 0xf0(%rsp)
               	movups	0x190(%rsp), %xmm14
               	vpermilps	$0x3, %xmm14, %xmm0 # xmm0 = xmm14[3,0,0,0]
               	movq	%r13, %rdi
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	0xf0(%rsp), %xmm0
               	vpinsrd	$0x3, %r11d, %xmm0, %xmm0
               	movups	0x130(%rsp), %xmm14
               	vmovq	%xmm14, %rax
               	movq	%rax, -0x120(%rbp)
               	vpextrq	$0x1, %xmm0, %rax
               	movq	%rax, -0x118(%rbp)
               	leaq	-0x28(%rbp), %rax
               	stmxcsr	(%rax)
               	movl	-0x28(%rbp), %eax
               	shrq	$0x5, %rax
               	movq	%rax, %r13
               	andq	$0x1, %r13
               	movl	<rip>, %eax # <addr>
               	movl	%eax, -0x28(%rbp)
               	leaq	-0x28(%rbp), %rax
               	ldmxcsr	(%rax)
               	movq	-0x120(%rbp), %rax
               	movups	0x120(%rsp), %xmm0
               	vpinsrq	$0x0, %rax, %xmm0, %xmm0
               	movq	-0x118(%rbp), %rax
               	movapd	%xmm0, %xmm14
               	vpinsrq	$0x1, %rax, %xmm14, %xmm14
               	movups	%xmm14, 0x130(%rsp)
               	movups	0x130(%rsp), %xmm14
               	vpermilps	$0x2, %xmm14, %xmm0 # xmm0 = xmm14[2,0,0,0]
               	movss	%xmm0, -0x28(%rbp)
               	leaq	-0x20(%rbp), %rax
               	leaq	-0x28(%rbp), %rcx
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	movl	-0x28(%rbp), %r15d
               	movss	-0x10(%rbp), %xmm0
               	movq	%rbx, %rdi
               	callq	<addr>
               	movss	%xmm0, -0x28(%rbp)
               	leaq	-0x20(%rbp), %rax
               	leaq	-0x28(%rbp), %rcx
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	movl	-0x28(%rbp), %eax
               	movl	$0x1, %ecx
               	testl	%r13d, %r13d
               	setne	%dl
               	movzbq	%dl, %rdx
               	cmpl	%eax, %r15d
               	cmoveq	%rdx, %rcx
               	orq	%rcx, %r14
               	movups	0x100(%rsp), %xmm0
               	vmovq	%xmm0, %rax
               	movq	%rax, -0x110(%rbp)
               	vpextrq	$0x1, %xmm0, %rax
               	movq	%rax, -0x108(%rbp)
               	vmovq	%xmm0, %rax
               	movq	%rax, -0x100(%rbp)
               	vpextrq	$0x1, %xmm0, %rax
               	movq	%rax, -0xf8(%rbp)
               	movl	<rip>, %eax # <addr>
               	movl	$0xffff9fc0, %r11d      # imm = 0xFFFF9FC0
               	andq	%r11, %rax
               	movq	%rbx, %rcx
               	shlq	$0xd, %rcx
               	orq	%rcx, %rax
               	movl	%eax, -0x28(%rbp)
               	leaq	-0x28(%rbp), %rax
               	ldmxcsr	(%rax)
               	movq	-0x110(%rbp), %rax
               	movups	0x160(%rsp), %xmm0
               	vpinsrq	$0x0, %rax, %xmm0, %xmm0
               	movq	-0x108(%rbp), %rax
               	movapd	%xmm0, %xmm14
               	vpinsrq	$0x1, %rax, %xmm14, %xmm14
               	movups	%xmm14, 0x160(%rsp)
               	movq	-0x100(%rbp), %rax
               	movq	-0xf8(%rbp), %rax
               	movl	$0xc, %r13d
               	movups	0x160(%rsp), %xmm14
               	vpermilpd	$0x0, %xmm14, %xmm0 # xmm0 = xmm14[0,0]
               	movq	%r13, %rdi
               	callq	<addr>
               	vmovq	%xmm0, %r11
               	movups	0x160(%rsp), %xmm14
               	vpinsrq	$0x0, %r11, %xmm14, %xmm14
               	movups	%xmm14, 0x120(%rsp)
               	movups	0x120(%rsp), %xmm14
               	vpermilpd	$0x1, %xmm14, %xmm0 # xmm0 = xmm14[1,0]
               	movq	%r13, %rdi
               	callq	<addr>
               	vmovq	%xmm0, %r11
               	movups	0x120(%rsp), %xmm0
               	vpinsrq	$0x1, %r11, %xmm0, %xmm0
               	vmovq	%xmm0, %rax
               	movq	%rax, -0xf0(%rbp)
               	vpextrq	$0x1, %xmm0, %rax
               	movq	%rax, -0xe8(%rbp)
               	leaq	-0x28(%rbp), %rax
               	stmxcsr	(%rax)
               	movl	-0x28(%rbp), %eax
               	shrq	$0x5, %rax
               	movq	%rax, %r13
               	andq	$0x1, %r13
               	movl	<rip>, %eax # <addr>
               	movl	%eax, -0x28(%rbp)
               	leaq	-0x28(%rbp), %rax
               	ldmxcsr	(%rax)
               	movq	-0xf0(%rbp), %rax
               	movups	0x150(%rsp), %xmm0
               	vpinsrq	$0x0, %rax, %xmm0, %xmm0
               	movq	-0xe8(%rbp), %rax
               	movapd	%xmm0, %xmm14
               	vpinsrq	$0x1, %rax, %xmm14, %xmm14
               	movups	%xmm14, 0x150(%rsp)
               	movups	0x150(%rsp), %xmm14
               	vpermilpd	$0x0, %xmm14, %xmm0 # xmm0 = xmm14[0,0]
               	movsd	%xmm0, -0x20(%rbp)
               	leaq	-0x28(%rbp), %rax
               	leaq	-0x20(%rbp), %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movq	-0x20(%rbp), %r15
               	movsd	0x118(%rsp), %xmm0
               	movq	%rbx, %rdi
               	callq	<addr>
               	movsd	%xmm0, -0x20(%rbp)
               	leaq	-0x28(%rbp), %rax
               	leaq	-0x20(%rbp), %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movq	-0x20(%rbp), %rcx
               	movl	$0x1, %edx
               	testl	%r13d, %r13d
               	setne	%sil
               	movzbq	%sil, %rsi
               	cmpq	%rcx, %r15
               	cmoveq	%rsi, %rdx
               	orq	%rdx, %r14
               	movups	0x150(%rsp), %xmm14
               	vpermilpd	$0x1, %xmm14, %xmm0 # xmm0 = xmm14[1,0]
               	movsd	%xmm0, -0x20(%rbp)
               	leaq	-0x20(%rbp), %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movq	-0x20(%rbp), %r13
               	movsd	0x110(%rsp), %xmm0
               	movq	%rbx, %rdi
               	callq	<addr>
               	movsd	%xmm0, -0x20(%rbp)
               	leaq	-0x28(%rbp), %rax
               	leaq	-0x20(%rbp), %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movq	-0x20(%rbp), %rax
               	cmpq	%rax, %r13
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rax, %r14
               	incq	%rbx
               	cmpl	$0x4, %ebx
               	jl	<addr>
               	movl	$0x8, %eax
               	xorl	%ecx, %ecx
               	testq	%r14, %r14
               	cmoveq	%rcx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq

<check_dot_products>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x160, %rsp            # imm = 0x160
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
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rax
               	movq	%rax, %rcx
               	shrq	$0x3d, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx # <addr>
               	shrq	$0x28, %rax
               	andq	$0x7, %rax
               	shlq	$0x2, %rax
               	addq	%rcx, %rax
               	movss	(%rax), %xmm0
               	movss	%xmm0, -0x120(%rbp)
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
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rax
               	movq	%rax, %rcx
               	shrq	$0x3d, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx # <addr>
               	shrq	$0x28, %rax
               	andq	$0x7, %rax
               	shlq	$0x2, %rax
               	addq	%rcx, %rax
               	movss	(%rax), %xmm0
               	movss	%xmm0, -0x110(%rbp)
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
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rax
               	movq	%rax, %rcx
               	shrq	$0x3d, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx # <addr>
               	shrq	$0x28, %rax
               	andq	$0x7, %rax
               	shlq	$0x2, %rax
               	addq	%rcx, %rax
               	movss	(%rax), %xmm0
               	movss	%xmm0, -0x11c(%rbp)
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
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rax
               	movq	%rax, %rcx
               	shrq	$0x3d, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx # <addr>
               	shrq	$0x28, %rax
               	andq	$0x7, %rax
               	shlq	$0x2, %rax
               	addq	%rcx, %rax
               	movss	(%rax), %xmm0
               	movss	%xmm0, -0x10c(%rbp)
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
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rax
               	movq	%rax, %rcx
               	shrq	$0x3d, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx # <addr>
               	shrq	$0x28, %rax
               	andq	$0x7, %rax
               	shlq	$0x2, %rax
               	addq	%rcx, %rax
               	movss	(%rax), %xmm0
               	movss	%xmm0, -0x118(%rbp)
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
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rax
               	movq	%rax, %rcx
               	shrq	$0x3d, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx # <addr>
               	shrq	$0x28, %rax
               	andq	$0x7, %rax
               	shlq	$0x2, %rax
               	addq	%rcx, %rax
               	movss	(%rax), %xmm0
               	movss	%xmm0, -0x108(%rbp)
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
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rax
               	movq	%rax, %rcx
               	shrq	$0x3d, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx # <addr>
               	shrq	$0x28, %rax
               	andq	$0x7, %rax
               	shlq	$0x2, %rax
               	addq	%rcx, %rax
               	movss	(%rax), %xmm0
               	movss	%xmm0, -0x114(%rbp)
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
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rax
               	movq	%rax, %rcx
               	shrq	$0x3d, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx # <addr>
               	shrq	$0x28, %rax
               	andq	$0x7, %rax
               	shlq	$0x2, %rax
               	addq	%rcx, %rax
               	movss	(%rax), %xmm0
               	movss	%xmm0, -0x104(%rbp)
               	movups	-0x120(%rbp), %xmm2
               	movups	-0x110(%rbp), %xmm3
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	leaq	-0x80(%rbp), %rsi
               	movq	%rcx, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %rsi
               	movl	$0xff, %edi
               	leaq	0x4(%rcx), %r8
               	sarxq	%r8, %rdi, %rdi
               	testb	$0x1, %dil
               	je	<addr>
               	leaq	-0x120(%rbp), %rdi
               	addq	%rdx, %rdi
               	movss	(%rdi), %xmm0
               	leaq	-0x110(%rbp), %rdi
               	addq	%rdi, %rdx
               	movss	(%rdx), %xmm1
               	mulss	%xmm1, %xmm0
               	jmp	<addr>
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm0
               	movss	%xmm0, (%rsi)
               	incq	%rcx
               	cmpl	$0x4, %ecx
               	jl	<addr>
               	xorl	%ecx, %ecx
               	movss	-0x80(%rbp), %xmm0
               	movss	-0x7c(%rbp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	-0x78(%rbp), %xmm1
               	movss	-0x74(%rbp), %xmm4
               	addss	%xmm4, %xmm1
               	addss	%xmm1, %xmm0
               	leaq	-0x100(%rbp), %rdx
               	movq	%rcx, %rsi
               	shlq	$0x2, %rsi
               	addq	%rsi, %rdx
               	movl	$0xff, %esi
               	sarxq	%rcx, %rsi, %rsi
               	testb	$0x1, %sil
               	je	<addr>
               	movapd	%xmm0, %xmm1
               	jmp	<addr>
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm1
               	movss	%xmm1, (%rdx)
               	incq	%rcx
               	cmpl	$0x4, %ecx
               	jl	<addr>
               	leaq	-0x140(%rbp), %rdi
               	movups	%xmm2, -0x140(%rbp)
               	movups	%xmm3, -0x150(%rbp)
               	movl	$0xff, %esi
               	xorl	%ecx, %ecx
               	leaq	-0xf0(%rbp), %r8
               	movq	%rcx, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %r8
               	leaq	0x4(%rcx), %r9
               	sarxq	%r9, %rsi, %r9
               	testb	$0x1, %r9b
               	je	<addr>
               	leaq	(%rdi,%rdx), %r9
               	movss	(%r9), %xmm0
               	leaq	-0x150(%rbp), %r9
               	addq	%r9, %rdx
               	movss	(%rdx), %xmm1
               	mulss	%xmm1, %xmm0
               	jmp	<addr>
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm0
               	movss	%xmm0, (%r8)
               	incq	%rcx
               	cmpl	$0x4, %ecx
               	jl	<addr>
               	xorl	%ecx, %ecx
               	movss	-0xf0(%rbp), %xmm0
               	movss	-0xec(%rbp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	-0xe8(%rbp), %xmm1
               	movss	-0xe4(%rbp), %xmm4
               	addss	%xmm4, %xmm1
               	addss	%xmm1, %xmm0
               	leaq	-0x140(%rbp), %rdx
               	movq	%rcx, %rdi
               	shlq	$0x2, %rdi
               	addq	%rdi, %rdx
               	sarxq	%rcx, %rsi, %rdi
               	testb	$0x1, %dil
               	je	<addr>
               	movapd	%xmm0, %xmm1
               	jmp	<addr>
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm1
               	movss	%xmm1, (%rdx)
               	incq	%rcx
               	cmpl	$0x4, %ecx
               	jl	<addr>
               	movups	-0x140(%rbp), %xmm0
               	movups	%xmm0, -0x160(%rbp)
               	xorl	%ecx, %ecx
               	leaq	-0x160(%rbp), %rsi
               	movq	%rcx, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %rsi
               	movss	(%rsi), %xmm0
               	movss	%xmm0, -0x130(%rbp)
               	leaq	-0x128(%rbp), %rsi
               	leaq	-0x130(%rbp), %rdi
               	movl	(%rdi), %r10d
               	movl	%r10d, (%rsi)
               	movl	-0x130(%rbp), %r8d
               	leaq	-0x100(%rbp), %r9
               	addq	%r9, %rdx
               	movss	(%rdx), %xmm0
               	movss	%xmm0, -0x130(%rbp)
               	movl	(%rdi), %r10d
               	movl	%r10d, (%rsi)
               	movl	-0x130(%rbp), %edx
               	movl	$0x10, %esi
               	cmpl	%edx, %r8d
               	cmovneq	%rsi, %rax
               	incq	%rcx
               	cmpl	$0x4, %ecx
               	jl	<addr>
               	xorl	%ecx, %ecx
               	leaq	-0x70(%rbp), %rsi
               	movq	%rcx, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %rsi
               	movl	$0xf1, %edi
               	leaq	0x4(%rcx), %r8
               	sarxq	%r8, %rdi, %rdi
               	testb	$0x1, %dil
               	je	<addr>
               	leaq	-0x120(%rbp), %rdi
               	addq	%rdx, %rdi
               	movss	(%rdi), %xmm0
               	leaq	-0x110(%rbp), %rdi
               	addq	%rdi, %rdx
               	movss	(%rdx), %xmm1
               	mulss	%xmm1, %xmm0
               	jmp	<addr>
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm0
               	movss	%xmm0, (%rsi)
               	incq	%rcx
               	cmpl	$0x4, %ecx
               	jl	<addr>
               	xorl	%ecx, %ecx
               	movss	-0x70(%rbp), %xmm0
               	movss	-0x6c(%rbp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	-0x68(%rbp), %xmm1
               	movss	-0x64(%rbp), %xmm4
               	addss	%xmm4, %xmm1
               	addss	%xmm1, %xmm0
               	leaq	-0x100(%rbp), %rdx
               	movq	%rcx, %rsi
               	shlq	$0x2, %rsi
               	addq	%rsi, %rdx
               	movl	$0xf1, %esi
               	sarxq	%rcx, %rsi, %rsi
               	testb	$0x1, %sil
               	je	<addr>
               	movapd	%xmm0, %xmm1
               	jmp	<addr>
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm1
               	movss	%xmm1, (%rdx)
               	incq	%rcx
               	cmpl	$0x4, %ecx
               	jl	<addr>
               	leaq	-0x140(%rbp), %rdi
               	movups	%xmm2, -0x140(%rbp)
               	movups	%xmm3, -0x150(%rbp)
               	movl	$0xf1, %esi
               	xorl	%ecx, %ecx
               	leaq	-0xf0(%rbp), %r8
               	movq	%rcx, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %r8
               	leaq	0x4(%rcx), %r9
               	sarxq	%r9, %rsi, %r9
               	testb	$0x1, %r9b
               	je	<addr>
               	leaq	(%rdi,%rdx), %r9
               	movss	(%r9), %xmm0
               	leaq	-0x150(%rbp), %r9
               	addq	%r9, %rdx
               	movss	(%rdx), %xmm1
               	mulss	%xmm1, %xmm0
               	jmp	<addr>
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm0
               	movss	%xmm0, (%r8)
               	incq	%rcx
               	cmpl	$0x4, %ecx
               	jl	<addr>
               	xorl	%ecx, %ecx
               	movss	-0xf0(%rbp), %xmm0
               	movss	-0xec(%rbp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	-0xe8(%rbp), %xmm1
               	movss	-0xe4(%rbp), %xmm4
               	addss	%xmm4, %xmm1
               	addss	%xmm1, %xmm0
               	leaq	-0x140(%rbp), %rdx
               	movq	%rcx, %rdi
               	shlq	$0x2, %rdi
               	addq	%rdi, %rdx
               	sarxq	%rcx, %rsi, %rdi
               	testb	$0x1, %dil
               	je	<addr>
               	movapd	%xmm0, %xmm1
               	jmp	<addr>
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm1
               	movss	%xmm1, (%rdx)
               	incq	%rcx
               	cmpl	$0x4, %ecx
               	jl	<addr>
               	movups	-0x140(%rbp), %xmm0
               	movups	%xmm0, -0x160(%rbp)
               	xorl	%ecx, %ecx
               	leaq	-0x160(%rbp), %rsi
               	movq	%rcx, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %rsi
               	movss	(%rsi), %xmm0
               	movss	%xmm0, -0x130(%rbp)
               	leaq	-0x128(%rbp), %rsi
               	leaq	-0x130(%rbp), %rdi
               	movl	(%rdi), %r10d
               	movl	%r10d, (%rsi)
               	movl	-0x130(%rbp), %r8d
               	leaq	-0x100(%rbp), %r9
               	addq	%r9, %rdx
               	movss	(%rdx), %xmm0
               	movss	%xmm0, -0x130(%rbp)
               	movl	(%rdi), %r10d
               	movl	%r10d, (%rsi)
               	movl	-0x130(%rbp), %edx
               	movl	$0x10, %esi
               	cmpl	%edx, %r8d
               	cmovneq	%rsi, %rax
               	incq	%rcx
               	cmpl	$0x4, %ecx
               	jl	<addr>
               	xorl	%ecx, %ecx
               	leaq	-0x60(%rbp), %rsi
               	movq	%rcx, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %rsi
               	movl	$0x7f, %edi
               	leaq	0x4(%rcx), %r8
               	sarxq	%r8, %rdi, %rdi
               	testb	$0x1, %dil
               	je	<addr>
               	leaq	-0x120(%rbp), %rdi
               	addq	%rdx, %rdi
               	movss	(%rdi), %xmm0
               	leaq	-0x110(%rbp), %rdi
               	addq	%rdi, %rdx
               	movss	(%rdx), %xmm1
               	mulss	%xmm1, %xmm0
               	jmp	<addr>
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm0
               	movss	%xmm0, (%rsi)
               	incq	%rcx
               	cmpl	$0x4, %ecx
               	jl	<addr>
               	xorl	%ecx, %ecx
               	movss	-0x60(%rbp), %xmm0
               	movss	-0x5c(%rbp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	-0x58(%rbp), %xmm1
               	movss	-0x54(%rbp), %xmm4
               	addss	%xmm4, %xmm1
               	addss	%xmm1, %xmm0
               	leaq	-0x100(%rbp), %rdx
               	movq	%rcx, %rsi
               	shlq	$0x2, %rsi
               	addq	%rsi, %rdx
               	movl	$0x7f, %esi
               	sarxq	%rcx, %rsi, %rsi
               	testb	$0x1, %sil
               	je	<addr>
               	movapd	%xmm0, %xmm1
               	jmp	<addr>
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm1
               	movss	%xmm1, (%rdx)
               	incq	%rcx
               	cmpl	$0x4, %ecx
               	jl	<addr>
               	leaq	-0x140(%rbp), %rdi
               	movups	%xmm2, -0x140(%rbp)
               	movups	%xmm3, -0x150(%rbp)
               	movl	$0x7f, %esi
               	xorl	%ecx, %ecx
               	leaq	-0xf0(%rbp), %r8
               	movq	%rcx, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %r8
               	leaq	0x4(%rcx), %r9
               	sarxq	%r9, %rsi, %r9
               	testb	$0x1, %r9b
               	je	<addr>
               	leaq	(%rdi,%rdx), %r9
               	movss	(%r9), %xmm0
               	leaq	-0x150(%rbp), %r9
               	addq	%r9, %rdx
               	movss	(%rdx), %xmm1
               	mulss	%xmm1, %xmm0
               	jmp	<addr>
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm0
               	movss	%xmm0, (%r8)
               	incq	%rcx
               	cmpl	$0x4, %ecx
               	jl	<addr>
               	xorl	%ecx, %ecx
               	movss	-0xf0(%rbp), %xmm0
               	movss	-0xec(%rbp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	-0xe8(%rbp), %xmm1
               	movss	-0xe4(%rbp), %xmm4
               	addss	%xmm4, %xmm1
               	addss	%xmm1, %xmm0
               	leaq	-0x140(%rbp), %rdx
               	movq	%rcx, %rdi
               	shlq	$0x2, %rdi
               	addq	%rdi, %rdx
               	sarxq	%rcx, %rsi, %rdi
               	testb	$0x1, %dil
               	je	<addr>
               	movapd	%xmm0, %xmm1
               	jmp	<addr>
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm1
               	movss	%xmm1, (%rdx)
               	incq	%rcx
               	cmpl	$0x4, %ecx
               	jl	<addr>
               	movups	-0x140(%rbp), %xmm0
               	movups	%xmm0, -0x160(%rbp)
               	xorl	%ecx, %ecx
               	leaq	-0x160(%rbp), %rsi
               	movq	%rcx, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %rsi
               	movss	(%rsi), %xmm0
               	movss	%xmm0, -0x130(%rbp)
               	leaq	-0x128(%rbp), %rsi
               	leaq	-0x130(%rbp), %rdi
               	movl	(%rdi), %r10d
               	movl	%r10d, (%rsi)
               	movl	-0x130(%rbp), %r8d
               	leaq	-0x100(%rbp), %r9
               	addq	%r9, %rdx
               	movss	(%rdx), %xmm0
               	movss	%xmm0, -0x130(%rbp)
               	movl	(%rdi), %r10d
               	movl	%r10d, (%rsi)
               	movl	-0x130(%rbp), %edx
               	movl	$0x10, %esi
               	cmpl	%edx, %r8d
               	cmovneq	%rsi, %rax
               	incq	%rcx
               	cmpl	$0x4, %ecx
               	jl	<addr>
               	xorl	%ecx, %ecx
               	leaq	-0x50(%rbp), %rsi
               	movq	%rcx, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %rsi
               	movl	$0x3c, %edi
               	leaq	0x4(%rcx), %r8
               	sarxq	%r8, %rdi, %rdi
               	testb	$0x1, %dil
               	je	<addr>
               	leaq	-0x120(%rbp), %rdi
               	addq	%rdx, %rdi
               	movss	(%rdi), %xmm0
               	leaq	-0x110(%rbp), %rdi
               	addq	%rdi, %rdx
               	movss	(%rdx), %xmm1
               	mulss	%xmm1, %xmm0
               	jmp	<addr>
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm0
               	movss	%xmm0, (%rsi)
               	incq	%rcx
               	cmpl	$0x4, %ecx
               	jl	<addr>
               	xorl	%ecx, %ecx
               	movss	-0x50(%rbp), %xmm0
               	movss	-0x4c(%rbp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	-0x48(%rbp), %xmm1
               	movss	-0x44(%rbp), %xmm4
               	addss	%xmm4, %xmm1
               	addss	%xmm1, %xmm0
               	leaq	-0x100(%rbp), %rdx
               	movq	%rcx, %rsi
               	shlq	$0x2, %rsi
               	addq	%rsi, %rdx
               	movl	$0x3c, %esi
               	sarxq	%rcx, %rsi, %rsi
               	testb	$0x1, %sil
               	je	<addr>
               	movapd	%xmm0, %xmm1
               	jmp	<addr>
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm1
               	movss	%xmm1, (%rdx)
               	incq	%rcx
               	cmpl	$0x4, %ecx
               	jl	<addr>
               	leaq	-0x140(%rbp), %rdi
               	movups	%xmm2, -0x140(%rbp)
               	movups	%xmm3, -0x150(%rbp)
               	movl	$0x3c, %esi
               	xorl	%ecx, %ecx
               	leaq	-0xf0(%rbp), %r8
               	movq	%rcx, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %r8
               	leaq	0x4(%rcx), %r9
               	sarxq	%r9, %rsi, %r9
               	testb	$0x1, %r9b
               	je	<addr>
               	leaq	(%rdi,%rdx), %r9
               	movss	(%r9), %xmm0
               	leaq	-0x150(%rbp), %r9
               	addq	%r9, %rdx
               	movss	(%rdx), %xmm1
               	mulss	%xmm1, %xmm0
               	jmp	<addr>
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm0
               	movss	%xmm0, (%r8)
               	incq	%rcx
               	cmpl	$0x4, %ecx
               	jl	<addr>
               	xorl	%ecx, %ecx
               	movss	-0xf0(%rbp), %xmm0
               	movss	-0xec(%rbp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	-0xe8(%rbp), %xmm1
               	movss	-0xe4(%rbp), %xmm4
               	addss	%xmm4, %xmm1
               	addss	%xmm1, %xmm0
               	leaq	-0x140(%rbp), %rdx
               	movq	%rcx, %rdi
               	shlq	$0x2, %rdi
               	addq	%rdi, %rdx
               	sarxq	%rcx, %rsi, %rdi
               	testb	$0x1, %dil
               	je	<addr>
               	movapd	%xmm0, %xmm1
               	jmp	<addr>
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm1
               	movss	%xmm1, (%rdx)
               	incq	%rcx
               	cmpl	$0x4, %ecx
               	jl	<addr>
               	movups	-0x140(%rbp), %xmm0
               	movups	%xmm0, -0x160(%rbp)
               	xorl	%ecx, %ecx
               	leaq	-0x160(%rbp), %rsi
               	movq	%rcx, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %rsi
               	movss	(%rsi), %xmm0
               	movss	%xmm0, -0x130(%rbp)
               	leaq	-0x128(%rbp), %rsi
               	leaq	-0x130(%rbp), %rdi
               	movl	(%rdi), %r10d
               	movl	%r10d, (%rsi)
               	movl	-0x130(%rbp), %r8d
               	leaq	-0x100(%rbp), %r9
               	addq	%r9, %rdx
               	movss	(%rdx), %xmm0
               	movss	%xmm0, -0x130(%rbp)
               	movl	(%rdi), %r10d
               	movl	%r10d, (%rsi)
               	movl	-0x130(%rbp), %edx
               	movl	$0x10, %esi
               	cmpl	%edx, %r8d
               	cmovneq	%rsi, %rax
               	incq	%rcx
               	cmpl	$0x4, %ecx
               	jl	<addr>
               	xorl	%ecx, %ecx
               	leaq	-0x40(%rbp), %rsi
               	movq	%rcx, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %rsi
               	movl	$0xa5, %edi
               	leaq	0x4(%rcx), %r8
               	sarxq	%r8, %rdi, %rdi
               	testb	$0x1, %dil
               	je	<addr>
               	leaq	-0x120(%rbp), %rdi
               	addq	%rdx, %rdi
               	movss	(%rdi), %xmm0
               	leaq	-0x110(%rbp), %rdi
               	addq	%rdi, %rdx
               	movss	(%rdx), %xmm1
               	mulss	%xmm1, %xmm0
               	jmp	<addr>
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm0
               	movss	%xmm0, (%rsi)
               	incq	%rcx
               	cmpl	$0x4, %ecx
               	jl	<addr>
               	xorl	%ecx, %ecx
               	movss	-0x40(%rbp), %xmm0
               	movss	-0x3c(%rbp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	-0x38(%rbp), %xmm1
               	movss	-0x34(%rbp), %xmm4
               	addss	%xmm4, %xmm1
               	addss	%xmm1, %xmm0
               	leaq	-0x100(%rbp), %rdx
               	movq	%rcx, %rsi
               	shlq	$0x2, %rsi
               	addq	%rsi, %rdx
               	movl	$0xa5, %esi
               	sarxq	%rcx, %rsi, %rsi
               	testb	$0x1, %sil
               	je	<addr>
               	movapd	%xmm0, %xmm1
               	jmp	<addr>
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm1
               	movss	%xmm1, (%rdx)
               	incq	%rcx
               	cmpl	$0x4, %ecx
               	jl	<addr>
               	leaq	-0x140(%rbp), %rdi
               	movups	%xmm2, -0x140(%rbp)
               	movups	%xmm3, -0x150(%rbp)
               	movl	$0xa5, %esi
               	xorl	%ecx, %ecx
               	leaq	-0xf0(%rbp), %r8
               	movq	%rcx, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %r8
               	leaq	0x4(%rcx), %r9
               	sarxq	%r9, %rsi, %r9
               	testb	$0x1, %r9b
               	je	<addr>
               	leaq	(%rdi,%rdx), %r9
               	movss	(%r9), %xmm0
               	leaq	-0x150(%rbp), %r9
               	addq	%r9, %rdx
               	movss	(%rdx), %xmm1
               	mulss	%xmm1, %xmm0
               	jmp	<addr>
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm0
               	movss	%xmm0, (%r8)
               	incq	%rcx
               	cmpl	$0x4, %ecx
               	jl	<addr>
               	xorl	%ecx, %ecx
               	movss	-0xf0(%rbp), %xmm0
               	movss	-0xec(%rbp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	-0xe8(%rbp), %xmm1
               	movss	-0xe4(%rbp), %xmm4
               	addss	%xmm4, %xmm1
               	addss	%xmm1, %xmm0
               	leaq	-0x140(%rbp), %rdx
               	movq	%rcx, %rdi
               	shlq	$0x2, %rdi
               	addq	%rdi, %rdx
               	sarxq	%rcx, %rsi, %rdi
               	testb	$0x1, %dil
               	je	<addr>
               	movapd	%xmm0, %xmm1
               	jmp	<addr>
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm1
               	movss	%xmm1, (%rdx)
               	incq	%rcx
               	cmpl	$0x4, %ecx
               	jl	<addr>
               	movups	-0x140(%rbp), %xmm0
               	movups	%xmm0, -0x160(%rbp)
               	xorl	%ecx, %ecx
               	leaq	-0x160(%rbp), %rsi
               	movq	%rcx, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %rsi
               	movss	(%rsi), %xmm0
               	movss	%xmm0, -0x130(%rbp)
               	leaq	-0x128(%rbp), %rsi
               	leaq	-0x130(%rbp), %rdi
               	movl	(%rdi), %r10d
               	movl	%r10d, (%rsi)
               	movl	-0x130(%rbp), %r8d
               	leaq	-0x100(%rbp), %r9
               	addq	%r9, %rdx
               	movss	(%rdx), %xmm0
               	movss	%xmm0, -0x130(%rbp)
               	movl	(%rdi), %r10d
               	movl	%r10d, (%rsi)
               	movl	-0x130(%rbp), %edx
               	movl	$0x10, %esi
               	cmpl	%edx, %r8d
               	cmovneq	%rsi, %rax
               	incq	%rcx
               	cmpl	$0x4, %ecx
               	jl	<addr>
               	xorl	%ecx, %ecx
               	leaq	-0x30(%rbp), %rsi
               	movq	%rcx, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %rsi
               	movl	$0xf, %edi
               	leaq	0x4(%rcx), %r8
               	sarxq	%r8, %rdi, %rdi
               	testb	$0x1, %dil
               	je	<addr>
               	leaq	-0x120(%rbp), %rdi
               	addq	%rdx, %rdi
               	movss	(%rdi), %xmm0
               	leaq	-0x110(%rbp), %rdi
               	addq	%rdi, %rdx
               	movss	(%rdx), %xmm1
               	mulss	%xmm1, %xmm0
               	jmp	<addr>
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm0
               	movss	%xmm0, (%rsi)
               	incq	%rcx
               	cmpl	$0x4, %ecx
               	jl	<addr>
               	xorl	%ecx, %ecx
               	movss	-0x30(%rbp), %xmm0
               	movss	-0x2c(%rbp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	-0x28(%rbp), %xmm1
               	movss	-0x24(%rbp), %xmm4
               	addss	%xmm4, %xmm1
               	addss	%xmm1, %xmm0
               	leaq	-0x100(%rbp), %rdx
               	movq	%rcx, %rsi
               	shlq	$0x2, %rsi
               	addq	%rsi, %rdx
               	movl	$0xf, %esi
               	sarxq	%rcx, %rsi, %rsi
               	testb	$0x1, %sil
               	je	<addr>
               	movapd	%xmm0, %xmm1
               	jmp	<addr>
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm1
               	movss	%xmm1, (%rdx)
               	incq	%rcx
               	cmpl	$0x4, %ecx
               	jl	<addr>
               	leaq	-0x140(%rbp), %rdi
               	movups	%xmm2, -0x140(%rbp)
               	movups	%xmm3, -0x150(%rbp)
               	movl	$0xf, %esi
               	xorl	%ecx, %ecx
               	leaq	-0xf0(%rbp), %r8
               	movq	%rcx, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %r8
               	leaq	0x4(%rcx), %r9
               	sarxq	%r9, %rsi, %r9
               	testb	$0x1, %r9b
               	je	<addr>
               	leaq	(%rdi,%rdx), %r9
               	movss	(%r9), %xmm0
               	leaq	-0x150(%rbp), %r9
               	addq	%r9, %rdx
               	movss	(%rdx), %xmm1
               	mulss	%xmm1, %xmm0
               	jmp	<addr>
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm0
               	movss	%xmm0, (%r8)
               	incq	%rcx
               	cmpl	$0x4, %ecx
               	jl	<addr>
               	xorl	%ecx, %ecx
               	movss	-0xf0(%rbp), %xmm0
               	movss	-0xec(%rbp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	-0xe8(%rbp), %xmm1
               	movss	-0xe4(%rbp), %xmm4
               	addss	%xmm4, %xmm1
               	addss	%xmm1, %xmm0
               	leaq	-0x140(%rbp), %rdx
               	movq	%rcx, %rdi
               	shlq	$0x2, %rdi
               	addq	%rdi, %rdx
               	sarxq	%rcx, %rsi, %rdi
               	testb	$0x1, %dil
               	je	<addr>
               	movapd	%xmm0, %xmm1
               	jmp	<addr>
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm1
               	movss	%xmm1, (%rdx)
               	incq	%rcx
               	cmpl	$0x4, %ecx
               	jl	<addr>
               	movups	-0x140(%rbp), %xmm0
               	movups	%xmm0, -0x160(%rbp)
               	xorl	%ecx, %ecx
               	leaq	-0x160(%rbp), %rsi
               	movq	%rcx, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %rsi
               	movss	(%rsi), %xmm0
               	movss	%xmm0, -0x130(%rbp)
               	leaq	-0x128(%rbp), %rsi
               	leaq	-0x130(%rbp), %rdi
               	movl	(%rdi), %r10d
               	movl	%r10d, (%rsi)
               	movl	-0x130(%rbp), %r8d
               	leaq	-0x100(%rbp), %r9
               	addq	%r9, %rdx
               	movss	(%rdx), %xmm0
               	movss	%xmm0, -0x130(%rbp)
               	movl	(%rdi), %r10d
               	movl	%r10d, (%rsi)
               	movl	-0x130(%rbp), %edx
               	movl	$0x10, %esi
               	cmpl	%edx, %r8d
               	cmovneq	%rsi, %rax
               	incq	%rcx
               	cmpl	$0x4, %ecx
               	jl	<addr>
               	xorl	%ecx, %ecx
               	leaq	-0x20(%rbp), %rsi
               	movq	%rcx, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %rsi
               	movl	$0xf0, %edi
               	leaq	0x4(%rcx), %r8
               	sarxq	%r8, %rdi, %rdi
               	testb	$0x1, %dil
               	je	<addr>
               	leaq	-0x120(%rbp), %rdi
               	addq	%rdx, %rdi
               	movss	(%rdi), %xmm0
               	leaq	-0x110(%rbp), %rdi
               	addq	%rdi, %rdx
               	movss	(%rdx), %xmm1
               	mulss	%xmm1, %xmm0
               	jmp	<addr>
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm0
               	movss	%xmm0, (%rsi)
               	incq	%rcx
               	cmpl	$0x4, %ecx
               	jl	<addr>
               	xorl	%ecx, %ecx
               	movss	-0x20(%rbp), %xmm0
               	movss	-0x1c(%rbp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	-0x18(%rbp), %xmm1
               	movss	-0x14(%rbp), %xmm4
               	addss	%xmm4, %xmm1
               	addss	%xmm1, %xmm0
               	leaq	-0x100(%rbp), %rdx
               	movq	%rcx, %rsi
               	shlq	$0x2, %rsi
               	addq	%rsi, %rdx
               	movl	$0xf0, %esi
               	sarxq	%rcx, %rsi, %rsi
               	testb	$0x1, %sil
               	je	<addr>
               	movapd	%xmm0, %xmm1
               	jmp	<addr>
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm1
               	movss	%xmm1, (%rdx)
               	incq	%rcx
               	cmpl	$0x4, %ecx
               	jl	<addr>
               	leaq	-0x140(%rbp), %rdi
               	movups	%xmm2, -0x140(%rbp)
               	movups	%xmm3, -0x150(%rbp)
               	movl	$0xf0, %esi
               	xorl	%ecx, %ecx
               	leaq	-0xf0(%rbp), %r8
               	movq	%rcx, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %r8
               	leaq	0x4(%rcx), %r9
               	sarxq	%r9, %rsi, %r9
               	testb	$0x1, %r9b
               	je	<addr>
               	leaq	(%rdi,%rdx), %r9
               	movss	(%r9), %xmm0
               	leaq	-0x150(%rbp), %r9
               	addq	%r9, %rdx
               	movss	(%rdx), %xmm1
               	mulss	%xmm1, %xmm0
               	jmp	<addr>
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm0
               	movss	%xmm0, (%r8)
               	incq	%rcx
               	cmpl	$0x4, %ecx
               	jl	<addr>
               	xorl	%ecx, %ecx
               	movss	-0xf0(%rbp), %xmm0
               	movss	-0xec(%rbp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	-0xe8(%rbp), %xmm1
               	movss	-0xe4(%rbp), %xmm4
               	addss	%xmm4, %xmm1
               	addss	%xmm1, %xmm0
               	leaq	-0x140(%rbp), %rdx
               	movq	%rcx, %rdi
               	shlq	$0x2, %rdi
               	addq	%rdi, %rdx
               	sarxq	%rcx, %rsi, %rdi
               	testb	$0x1, %dil
               	je	<addr>
               	movapd	%xmm0, %xmm1
               	jmp	<addr>
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm1
               	movss	%xmm1, (%rdx)
               	incq	%rcx
               	cmpl	$0x4, %ecx
               	jl	<addr>
               	movups	-0x140(%rbp), %xmm0
               	movups	%xmm0, -0x160(%rbp)
               	xorl	%ecx, %ecx
               	leaq	-0x160(%rbp), %rsi
               	movq	%rcx, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %rsi
               	movss	(%rsi), %xmm0
               	movss	%xmm0, -0x130(%rbp)
               	leaq	-0x128(%rbp), %rsi
               	leaq	-0x130(%rbp), %rdi
               	movl	(%rdi), %r10d
               	movl	%r10d, (%rsi)
               	movl	-0x130(%rbp), %r8d
               	leaq	-0x100(%rbp), %r9
               	addq	%r9, %rdx
               	movss	(%rdx), %xmm0
               	movss	%xmm0, -0x130(%rbp)
               	movl	(%rdi), %r10d
               	movl	%r10d, (%rsi)
               	movl	-0x130(%rbp), %edx
               	movl	$0x10, %esi
               	cmpl	%edx, %r8d
               	cmovneq	%rsi, %rax
               	incq	%rcx
               	cmpl	$0x4, %ecx
               	jl	<addr>
               	xorl	%ecx, %ecx
               	leaq	-0x10(%rbp), %rsi
               	movq	%rcx, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %rsi
               	movl	$0x82, %edi
               	leaq	0x4(%rcx), %r8
               	sarxq	%r8, %rdi, %rdi
               	testb	$0x1, %dil
               	je	<addr>
               	leaq	-0x120(%rbp), %rdi
               	addq	%rdx, %rdi
               	movss	(%rdi), %xmm0
               	leaq	-0x110(%rbp), %rdi
               	addq	%rdi, %rdx
               	movss	(%rdx), %xmm1
               	mulss	%xmm1, %xmm0
               	jmp	<addr>
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm0
               	movss	%xmm0, (%rsi)
               	incq	%rcx
               	cmpl	$0x4, %ecx
               	jl	<addr>
               	xorl	%ecx, %ecx
               	movss	-0x10(%rbp), %xmm0
               	movss	-0xc(%rbp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	-0x8(%rbp), %xmm1
               	movss	-0x4(%rbp), %xmm4
               	addss	%xmm4, %xmm1
               	addss	%xmm1, %xmm0
               	leaq	-0x100(%rbp), %rdx
               	movq	%rcx, %rsi
               	shlq	$0x2, %rsi
               	addq	%rsi, %rdx
               	movl	$0x82, %esi
               	sarxq	%rcx, %rsi, %rsi
               	testb	$0x1, %sil
               	je	<addr>
               	movapd	%xmm0, %xmm1
               	jmp	<addr>
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm1
               	movss	%xmm1, (%rdx)
               	incq	%rcx
               	cmpl	$0x4, %ecx
               	jl	<addr>
               	leaq	-0x140(%rbp), %rdi
               	movups	%xmm2, -0x140(%rbp)
               	movups	%xmm3, -0x150(%rbp)
               	movl	$0x82, %esi
               	xorl	%ecx, %ecx
               	leaq	-0xf0(%rbp), %r8
               	movq	%rcx, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %r8
               	leaq	0x4(%rcx), %r9
               	sarxq	%r9, %rsi, %r9
               	testb	$0x1, %r9b
               	je	<addr>
               	leaq	(%rdi,%rdx), %r9
               	movss	(%r9), %xmm0
               	leaq	-0x150(%rbp), %r9
               	addq	%r9, %rdx
               	movss	(%rdx), %xmm1
               	mulss	%xmm1, %xmm0
               	jmp	<addr>
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm0
               	movss	%xmm0, (%r8)
               	incq	%rcx
               	cmpl	$0x4, %ecx
               	jl	<addr>
               	xorl	%ecx, %ecx
               	movss	-0xf0(%rbp), %xmm0
               	movss	-0xec(%rbp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	-0xe8(%rbp), %xmm1
               	movss	-0xe4(%rbp), %xmm2
               	addss	%xmm2, %xmm1
               	addss	%xmm1, %xmm0
               	leaq	-0x140(%rbp), %rdx
               	movq	%rcx, %rdi
               	shlq	$0x2, %rdi
               	addq	%rdi, %rdx
               	sarxq	%rcx, %rsi, %rdi
               	testb	$0x1, %dil
               	je	<addr>
               	movapd	%xmm0, %xmm1
               	jmp	<addr>
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm1
               	movss	%xmm1, (%rdx)
               	incq	%rcx
               	cmpl	$0x4, %ecx
               	jl	<addr>
               	movups	-0x140(%rbp), %xmm0
               	movups	%xmm0, -0x150(%rbp)
               	xorl	%ecx, %ecx
               	leaq	-0x150(%rbp), %rsi
               	movq	%rcx, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %rsi
               	movss	(%rsi), %xmm0
               	movss	%xmm0, -0x130(%rbp)
               	leaq	-0x128(%rbp), %rsi
               	leaq	-0x130(%rbp), %rdi
               	movl	(%rdi), %r10d
               	movl	%r10d, (%rsi)
               	movl	-0x130(%rbp), %r8d
               	leaq	-0x100(%rbp), %r9
               	addq	%r9, %rdx
               	movss	(%rdx), %xmm0
               	movss	%xmm0, -0x130(%rbp)
               	movl	(%rdi), %r10d
               	movl	%r10d, (%rsi)
               	movl	-0x130(%rbp), %edx
               	movl	$0x10, %esi
               	cmpl	%edx, %r8d
               	cmovneq	%rsi, %rax
               	incq	%rcx
               	cmpl	$0x4, %ecx
               	jl	<addr>
               	movss	-0x120(%rbp), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movss	-0x11c(%rbp), %xmm1
               	movabsq	$0x3f50624dd2f1a9fc, %rcx # imm = 0x3F50624DD2F1A9FC
               	cvtss2sd	%xmm1, %xmm1
               	movq	%rcx, %xmm15
               	mulsd	%xmm15, %xmm1
               	movss	-0x108(%rbp), %xmm2
               	cvtss2sd	%xmm2, %xmm2
               	movss	-0x104(%rbp), %xmm3
               	cvtss2sd	%xmm3, %xmm3
               	movapd	%xmm0, %xmm4
               	movapd	%xmm2, %xmm5
               	mulsd	%xmm5, %xmm4
               	movsd	%xmm4, -0xe0(%rbp)
               	movapd	%xmm1, %xmm4
               	movapd	%xmm3, %xmm5
               	mulsd	%xmm5, %xmm4
               	movsd	%xmm4, -0xd8(%rbp)
               	movsd	-0xe0(%rbp), %xmm4
               	movsd	-0xd8(%rbp), %xmm5
               	addsd	%xmm5, %xmm4
               	movapd	%xmm0, %xmm5
               	movapd	%xmm2, %xmm6
               	mulsd	%xmm6, %xmm5
               	movapd	%xmm1, %xmm6
               	movapd	%xmm3, %xmm7
               	mulsd	%xmm7, %xmm6
               	addsd	%xmm6, %xmm5
               	movapd	%xmm5, %xmm6
               	movsd	%xmm6, -0x128(%rbp)
               	leaq	-0x130(%rbp), %rcx
               	leaq	-0x128(%rbp), %rdx
               	movq	(%rdx), %r10
               	movq	%r10, (%rcx)
               	movq	-0x128(%rbp), %rsi
               	movsd	%xmm4, -0x128(%rbp)
               	movq	(%rdx), %r10
               	movq	%r10, (%rcx)
               	movq	-0x128(%rbp), %rdi
               	cmpq	%rdi, %rsi
               	jne	<addr>
               	movsd	%xmm5, -0x128(%rbp)
               	movq	(%rdx), %r10
               	movq	%r10, (%rcx)
               	movq	-0x128(%rbp), %rdx
               	movsd	%xmm4, -0x128(%rbp)
               	leaq	-0x128(%rbp), %rsi
               	movq	(%rsi), %r10
               	movq	%r10, (%rcx)
               	movq	-0x128(%rbp), %rcx
               	cmpq	%rcx, %rdx
               	je	<addr>
               	movl	$0x10, %eax
               	movapd	%xmm0, %xmm4
               	movapd	%xmm2, %xmm5
               	mulsd	%xmm5, %xmm4
               	movsd	%xmm4, -0xd0(%rbp)
               	movapd	%xmm1, %xmm4
               	movapd	%xmm3, %xmm5
               	mulsd	%xmm5, %xmm4
               	movsd	%xmm4, -0xc8(%rbp)
               	movsd	-0xd0(%rbp), %xmm4
               	movsd	-0xc8(%rbp), %xmm5
               	addsd	%xmm5, %xmm4
               	movapd	%xmm0, %xmm5
               	movapd	%xmm2, %xmm6
               	mulsd	%xmm6, %xmm5
               	movapd	%xmm1, %xmm6
               	movapd	%xmm3, %xmm7
               	mulsd	%xmm7, %xmm6
               	addsd	%xmm6, %xmm5
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm6
               	movsd	%xmm5, -0x128(%rbp)
               	leaq	-0x130(%rbp), %rdx
               	leaq	-0x128(%rbp), %rsi
               	movq	(%rsi), %r10
               	movq	%r10, (%rdx)
               	movq	-0x128(%rbp), %rdi
               	movsd	%xmm4, -0x128(%rbp)
               	movq	(%rsi), %r10
               	movq	%r10, (%rdx)
               	movq	-0x128(%rbp), %rdx
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	movapd	%xmm6, %xmm4
               	movsd	%xmm4, -0x128(%rbp)
               	leaq	-0x130(%rbp), %rdx
               	leaq	-0x128(%rbp), %rsi
               	movq	(%rsi), %r10
               	movq	%r10, (%rdx)
               	movq	-0x128(%rbp), %rdi
               	movq	$0x0, -0x128(%rbp)
               	movq	(%rsi), %r10
               	movq	%r10, (%rdx)
               	testq	%rdi, %rdi
               	je	<addr>
               	movl	$0x10, %eax
               	movapd	%xmm0, %xmm4
               	movapd	%xmm2, %xmm5
               	mulsd	%xmm5, %xmm4
               	movsd	%xmm4, -0xc0(%rbp)
               	movq	$0x0, -0xb8(%rbp)
               	movsd	-0xc0(%rbp), %xmm4
               	movsd	-0xb8(%rbp), %xmm5
               	addsd	%xmm5, %xmm4
               	movapd	%xmm0, %xmm5
               	movapd	%xmm2, %xmm6
               	mulsd	%xmm6, %xmm5
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm6
               	addsd	%xmm6, %xmm5
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm6
               	movsd	%xmm6, -0x128(%rbp)
               	leaq	-0x130(%rbp), %rdx
               	leaq	-0x128(%rbp), %rsi
               	movq	(%rsi), %r10
               	movq	%r10, (%rdx)
               	movq	-0x128(%rbp), %rdi
               	movq	$0x0, -0x128(%rbp)
               	movq	(%rsi), %r10
               	movq	%r10, (%rdx)
               	testq	%rdi, %rdi
               	jne	<addr>
               	movsd	%xmm5, -0x128(%rbp)
               	leaq	-0x130(%rbp), %rsi
               	leaq	-0x128(%rbp), %rdi
               	movq	(%rdi), %r10
               	movq	%r10, (%rsi)
               	movq	-0x128(%rbp), %r8
               	movsd	%xmm4, -0x128(%rbp)
               	movq	(%rdi), %r10
               	movq	%r10, (%rsi)
               	movq	-0x128(%rbp), %rsi
               	cmpq	%rsi, %r8
               	je	<addr>
               	movl	$0x10, %eax
               	movq	$0x0, -0xb0(%rbp)
               	movapd	%xmm1, %xmm4
               	movapd	%xmm3, %xmm5
               	mulsd	%xmm5, %xmm4
               	movsd	%xmm4, -0xa8(%rbp)
               	movsd	-0xb0(%rbp), %xmm4
               	movsd	-0xa8(%rbp), %xmm5
               	addsd	%xmm5, %xmm4
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm5
               	movapd	%xmm1, %xmm6
               	movapd	%xmm3, %xmm7
               	mulsd	%xmm7, %xmm6
               	addsd	%xmm6, %xmm5
               	movapd	%xmm5, %xmm6
               	movsd	%xmm6, -0x128(%rbp)
               	leaq	-0x128(%rbp), %rsi
               	movq	(%rsi), %r10
               	movq	%r10, (%rdx)
               	movq	-0x128(%rbp), %rdx
               	movsd	%xmm4, -0x128(%rbp)
               	leaq	-0x130(%rbp), %rdi
               	movq	(%rsi), %r10
               	movq	%r10, (%rdi)
               	movq	-0x128(%rbp), %rsi
               	cmpq	%rsi, %rdx
               	jne	<addr>
               	movsd	%xmm5, -0x128(%rbp)
               	leaq	-0x130(%rbp), %rdx
               	leaq	-0x128(%rbp), %rsi
               	movq	(%rsi), %r10
               	movq	%r10, (%rdx)
               	movq	-0x128(%rbp), %rdi
               	movsd	%xmm4, -0x128(%rbp)
               	movq	(%rsi), %r10
               	movq	%r10, (%rdx)
               	movq	-0x128(%rbp), %rdx
               	cmpq	%rdx, %rdi
               	je	<addr>
               	movl	$0x10, %eax
               	movq	$0x0, -0xa0(%rbp)
               	movq	$0x0, -0x98(%rbp)
               	movsd	-0xa0(%rbp), %xmm4
               	movsd	-0x98(%rbp), %xmm5
               	addsd	%xmm5, %xmm4
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm5
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm6
               	addsd	%xmm6, %xmm5
               	movapd	%xmm5, %xmm6
               	movsd	%xmm6, -0x128(%rbp)
               	leaq	-0x130(%rbp), %rdx
               	leaq	-0x128(%rbp), %rsi
               	movq	(%rsi), %r10
               	movq	%r10, (%rdx)
               	movq	-0x128(%rbp), %rcx
               	movsd	%xmm4, -0x128(%rbp)
               	movq	(%rsi), %r10
               	movq	%r10, (%rdx)
               	movq	-0x128(%rbp), %rdi
               	cmpq	%rdi, %rcx
               	jne	<addr>
               	movsd	%xmm5, -0x128(%rbp)
               	leaq	-0x130(%rbp), %rcx
               	leaq	-0x128(%rbp), %rdi
               	movq	(%rdi), %r10
               	movq	%r10, (%rcx)
               	movq	-0x128(%rbp), %r8
               	movsd	%xmm4, -0x128(%rbp)
               	movq	(%rdi), %r10
               	movq	%r10, (%rcx)
               	movq	-0x128(%rbp), %rcx
               	cmpq	%rcx, %r8
               	je	<addr>
               	movl	$0x10, %eax
               	mulsd	%xmm2, %xmm0
               	movsd	%xmm0, -0x90(%rbp)
               	movapd	%xmm1, %xmm0
               	movapd	%xmm3, %xmm1
               	mulsd	%xmm1, %xmm0
               	movsd	%xmm0, -0x88(%rbp)
               	movsd	-0x90(%rbp), %xmm0
               	movsd	-0x88(%rbp), %xmm0
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm0
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm1
               	movsd	%xmm0, -0x128(%rbp)
               	movq	(%rsi), %r10
               	movq	%r10, (%rdx)
               	movq	-0x128(%rbp), %rdx
               	movq	$0x0, -0x128(%rbp)
               	leaq	-0x130(%rbp), %rsi
               	leaq	-0x128(%rbp), %rdi
               	movq	(%rdi), %r10
               	movq	%r10, (%rsi)
               	testq	%rdx, %rdx
               	jne	<addr>
               	movapd	%xmm1, %xmm0
               	movsd	%xmm0, -0x128(%rbp)
               	leaq	-0x130(%rbp), %rdx
               	leaq	-0x128(%rbp), %rsi
               	movq	(%rsi), %r10
               	movq	%r10, (%rdx)
               	movq	-0x128(%rbp), %rdi
               	movq	$0x0, -0x128(%rbp)
               	movq	(%rsi), %r10
               	movq	%r10, (%rdx)
               	testq	%rdi, %rdi
               	je	<addr>
               	movl	$0x10, %eax
               	leave
               	retq
               	shrq	$0x2c, %rax
               	subq	$0x80000, %rax          # imm = 0x80000
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rax, %xmm0
               	movl	$0x43800000, %eax       # imm = 0x43800000
               	movq	%rax, %xmm15
               	divss	%xmm15, %xmm0
               	jmp	<addr>
               	shrq	$0x2c, %rax
               	subq	$0x80000, %rax          # imm = 0x80000
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rax, %xmm0
               	movl	$0x43800000, %eax       # imm = 0x43800000
               	movq	%rax, %xmm15
               	divss	%xmm15, %xmm0
               	jmp	<addr>
               	shrq	$0x2c, %rax
               	subq	$0x80000, %rax          # imm = 0x80000
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rax, %xmm0
               	movl	$0x43800000, %eax       # imm = 0x43800000
               	movq	%rax, %xmm15
               	divss	%xmm15, %xmm0
               	jmp	<addr>
               	shrq	$0x2c, %rax
               	subq	$0x80000, %rax          # imm = 0x80000
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rax, %xmm0
               	movl	$0x43800000, %eax       # imm = 0x43800000
               	movq	%rax, %xmm15
               	divss	%xmm15, %xmm0
               	jmp	<addr>
               	shrq	$0x2c, %rax
               	subq	$0x80000, %rax          # imm = 0x80000
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rax, %xmm0
               	movl	$0x43800000, %eax       # imm = 0x43800000
               	movq	%rax, %xmm15
               	divss	%xmm15, %xmm0
               	jmp	<addr>
               	shrq	$0x2c, %rax
               	subq	$0x80000, %rax          # imm = 0x80000
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rax, %xmm0
               	movl	$0x43800000, %eax       # imm = 0x43800000
               	movq	%rax, %xmm15
               	divss	%xmm15, %xmm0
               	jmp	<addr>
               	shrq	$0x2c, %rax
               	subq	$0x80000, %rax          # imm = 0x80000
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rax, %xmm0
               	movl	$0x43800000, %eax       # imm = 0x43800000
               	movq	%rax, %xmm15
               	divss	%xmm15, %xmm0
               	jmp	<addr>
               	shrq	$0x2c, %rax
               	subq	$0x80000, %rax          # imm = 0x80000
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rax, %xmm0
               	movl	$0x43800000, %eax       # imm = 0x43800000
               	movq	%rax, %xmm15
               	divss	%xmm15, %xmm0
               	jmp	<addr>

<check_insert_extract>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x48, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
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
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %rcx # imm = 0x2545F4914F6CDD1D
               	imulq	%rax, %rcx
               	vmovd	%ecx, %xmm0
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
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %rbx # imm = 0x2545F4914F6CDD1D
               	imulq	%rax, %rbx
               	shrq	$0x7, %rbx
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
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %rcx # imm = 0x2545F4914F6CDD1D
               	imulq	%rax, %rcx
               	vpinsrd	$0x1, %ecx, %xmm0, %xmm0
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
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r14 # imm = 0x2545F4914F6CDD1D
               	imulq	%rax, %r14
               	shrq	$0x7, %r14
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
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %rcx # imm = 0x2545F4914F6CDD1D
               	imulq	%rax, %rcx
               	vpinsrd	$0x2, %ecx, %xmm0, %xmm0
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
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r12 # imm = 0x2545F4914F6CDD1D
               	imulq	%rax, %r12
               	shrq	$0x7, %r12
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
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rax
               	movapd	%xmm0, %xmm14
               	vpinsrd	$0x3, %eax, %xmm14, %xmm14
               	movups	%xmm14, 0x40(%rsp)
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
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r13 # imm = 0x2545F4914F6CDD1D
               	imulq	%rax, %r13
               	shrq	$0x7, %r13
               	movups	0x40(%rsp), %xmm14
               	movups	%xmm14, -0x20(%rbp)
               	xorl	%eax, %eax
               	movl	%ebx, -0x20(%rbp)
               	xorl	%ecx, %ecx
               	sarxq	%rax, %rcx, %rcx
               	testb	$0x1, %cl
               	je	<addr>
               	leaq	-0x20(%rbp), %rcx
               	movl	$0x0, (%rcx,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%ecx, %ecx
               	movups	0x40(%rsp), %xmm14
               	movups	%xmm14, -0x40(%rbp)
               	movl	%ebx, -0x40(%rbp)
               	xorl	%eax, %eax
               	sarxq	%rax, %rcx, %rdx
               	testb	$0x1, %dl
               	je	<addr>
               	leaq	-0x40(%rbp), %rdx
               	movl	$0x0, (%rdx,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movups	-0x40(%rbp), %xmm0
               	movups	%xmm0, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rdi
               	leaq	-0x20(%rbp), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x20, %ecx
               	xorl	%edx, %edx
               	testq	%rax, %rax
               	movq	%rdx, %r15
               	cmovneq	%rcx, %r15
               	movups	0x40(%rsp), %xmm14
               	movups	%xmm14, -0x20(%rbp)
               	xorl	%eax, %eax
               	movl	%ebx, -0x1c(%rbp)
               	movl	$0x10, %ecx
               	sarxq	%rax, %rcx, %rcx
               	testb	$0x1, %cl
               	je	<addr>
               	leaq	-0x20(%rbp), %rcx
               	movl	$0x0, (%rcx,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movl	$0x10, %ecx
               	movups	0x40(%rsp), %xmm14
               	movups	%xmm14, -0x40(%rbp)
               	movl	%ebx, -0x3c(%rbp)
               	xorl	%eax, %eax
               	sarxq	%rax, %rcx, %rdx
               	testb	$0x1, %dl
               	je	<addr>
               	leaq	-0x40(%rbp), %rdx
               	movl	$0x0, (%rdx,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movups	-0x40(%rbp), %xmm0
               	movups	%xmm0, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rdi
               	leaq	-0x20(%rbp), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x20, %ecx
               	testq	%rax, %rax
               	cmovneq	%rcx, %r15
               	movups	0x40(%rsp), %xmm14
               	movups	%xmm14, -0x20(%rbp)
               	movl	%r14d, -0x18(%rbp)
               	xorl	%eax, %eax
               	movl	$0x6c, %ecx
               	sarxq	%rax, %rcx, %rcx
               	testb	$0x1, %cl
               	je	<addr>
               	leaq	-0x20(%rbp), %rcx
               	movl	$0x0, (%rcx,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movl	$0x6c, %ecx
               	movups	0x40(%rsp), %xmm14
               	movups	%xmm14, -0x40(%rbp)
               	movl	%r14d, -0x38(%rbp)
               	xorl	%eax, %eax
               	sarxq	%rax, %rcx, %rdx
               	testb	$0x1, %dl
               	je	<addr>
               	leaq	-0x40(%rbp), %rdx
               	movl	$0x0, (%rdx,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movups	-0x40(%rbp), %xmm0
               	movups	%xmm0, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rdi
               	leaq	-0x20(%rbp), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x20, %ecx
               	testq	%rax, %rax
               	movq	%r15, %r14
               	cmovneq	%rcx, %r14
               	movups	0x40(%rsp), %xmm14
               	movups	%xmm14, -0x20(%rbp)
               	movl	%r12d, -0x14(%rbp)
               	xorl	%eax, %eax
               	movl	$0xb1, %ecx
               	sarxq	%rax, %rcx, %rcx
               	testb	$0x1, %cl
               	je	<addr>
               	leaq	-0x20(%rbp), %rcx
               	movl	$0x0, (%rcx,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movl	$0xb1, %ecx
               	movups	0x40(%rsp), %xmm14
               	movups	%xmm14, -0x40(%rbp)
               	movl	%r12d, -0x34(%rbp)
               	xorl	%eax, %eax
               	sarxq	%rax, %rcx, %rdx
               	testb	$0x1, %dl
               	je	<addr>
               	leaq	-0x40(%rbp), %rdx
               	movl	$0x0, (%rdx,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movups	-0x40(%rbp), %xmm0
               	movups	%xmm0, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rdi
               	leaq	-0x20(%rbp), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x20, %ecx
               	testq	%rax, %rax
               	cmovneq	%rcx, %r14
               	movups	0x40(%rsp), %xmm14
               	movups	%xmm14, -0x20(%rbp)
               	movl	%r13d, -0x14(%rbp)
               	xorl	%eax, %eax
               	movl	$0xf0, %ecx
               	sarxq	%rax, %rcx, %rcx
               	testb	$0x1, %cl
               	je	<addr>
               	leaq	-0x20(%rbp), %rcx
               	movl	$0x0, (%rcx,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movl	$0xf0, %ecx
               	movups	0x40(%rsp), %xmm14
               	movups	%xmm14, -0x40(%rbp)
               	movl	%r13d, -0x34(%rbp)
               	xorl	%eax, %eax
               	sarxq	%rax, %rcx, %rdx
               	testb	$0x1, %dl
               	je	<addr>
               	leaq	-0x40(%rbp), %rdx
               	movl	$0x0, (%rdx,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movups	-0x40(%rbp), %xmm0
               	movups	%xmm0, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rdi
               	leaq	-0x20(%rbp), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x20, %ecx
               	testq	%rax, %rax
               	cmovneq	%rcx, %r14
               	movups	0x40(%rsp), %xmm14
               	movups	%xmm14, -0x20(%rbp)
               	xorl	%eax, %eax
               	movl	%r13d, -0x20(%rbp)
               	movl	$0xcf, %ecx
               	sarxq	%rax, %rcx, %rcx
               	testb	$0x1, %cl
               	je	<addr>
               	leaq	-0x20(%rbp), %rcx
               	movl	$0x0, (%rcx,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movl	$0xcf, %ecx
               	movups	0x40(%rsp), %xmm14
               	movups	%xmm14, -0x40(%rbp)
               	movl	%r13d, -0x40(%rbp)
               	xorl	%eax, %eax
               	sarxq	%rax, %rcx, %rdx
               	testb	$0x1, %dl
               	je	<addr>
               	leaq	-0x40(%rbp), %rdx
               	movl	$0x0, (%rdx,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movups	-0x40(%rbp), %xmm0
               	movups	%xmm0, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rdi
               	leaq	-0x20(%rbp), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x20, %ecx
               	testq	%rax, %rax
               	movq	%r14, %r13
               	cmovneq	%rcx, %r13
               	movups	0x40(%rsp), %xmm14
               	movups	%xmm14, -0x20(%rbp)
               	xorl	%eax, %eax
               	movl	%ebx, -0x14(%rbp)
               	movl	$0x3a, %ecx
               	sarxq	%rax, %rcx, %rcx
               	testb	$0x1, %cl
               	je	<addr>
               	leaq	-0x20(%rbp), %rcx
               	movl	$0x0, (%rcx,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movl	$0x3a, %ecx
               	movups	0x40(%rsp), %xmm14
               	movups	%xmm14, -0x40(%rbp)
               	movl	%ebx, -0x34(%rbp)
               	xorl	%eax, %eax
               	sarxq	%rax, %rcx, %rdx
               	testb	$0x1, %dl
               	je	<addr>
               	leaq	-0x40(%rbp), %rdx
               	movl	$0x0, (%rdx,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movups	-0x40(%rbp), %xmm0
               	leaq	-0x10(%rbp), %rdi
               	movups	%xmm0, -0x10(%rbp)
               	leaq	-0x20(%rbp), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x20, %ecx
               	testq	%rax, %rax
               	movq	%r13, %rbx
               	cmovneq	%rcx, %rbx
               	movups	0x40(%rsp), %xmm14
               	movups	%xmm14, -0x20(%rbp)
               	movl	%r12d, -0x1c(%rbp)
               	xorl	%eax, %eax
               	movl	$0x96, %ecx
               	sarxq	%rax, %rcx, %rcx
               	testb	$0x1, %cl
               	je	<addr>
               	leaq	-0x20(%rbp), %rcx
               	movl	$0x0, (%rcx,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movl	$0x96, %ecx
               	movups	0x40(%rsp), %xmm14
               	movups	%xmm14, -0x40(%rbp)
               	movl	%r12d, -0x3c(%rbp)
               	xorl	%eax, %eax
               	sarxq	%rax, %rcx, %rdx
               	testb	$0x1, %dl
               	je	<addr>
               	leaq	-0x40(%rbp), %rdx
               	movl	$0x0, (%rdx,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movups	-0x40(%rbp), %xmm0
               	leaq	-0x10(%rbp), %rdi
               	movups	%xmm0, -0x10(%rbp)
               	leaq	-0x20(%rbp), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x20, %ecx
               	testq	%rax, %rax
               	movq	%rbx, %rax
               	cmovneq	%rcx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq

<check_blends>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xb8, %rsp
               	pushq	%rbx
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
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rax
               	movl	%eax, -0x50(%rbp)
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
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rax
               	shrq	$0x3, %rax
               	movl	%eax, -0x40(%rbp)
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
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rax
               	shrq	$0x11, %rax
               	movl	%eax, -0x30(%rbp)
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
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rax
               	movl	%eax, -0x4c(%rbp)
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
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rax
               	shrq	$0x3, %rax
               	movl	%eax, -0x3c(%rbp)
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
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rax
               	shrq	$0x11, %rax
               	movl	%eax, -0x2c(%rbp)
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
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rax
               	movl	%eax, -0x48(%rbp)
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
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rax
               	shrq	$0x3, %rax
               	movl	%eax, -0x38(%rbp)
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
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rax
               	shrq	$0x11, %rax
               	movl	%eax, -0x28(%rbp)
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
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rax
               	movl	%eax, -0x44(%rbp)
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
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rax
               	shrq	$0x3, %rax
               	movl	%eax, -0x34(%rbp)
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
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rax
               	shrq	$0x11, %rax
               	movl	%eax, -0x24(%rbp)
               	leaq	-0x50(%rbp), %rsi
               	movups	-0x50(%rbp), %xmm14
               	movups	%xmm14, 0x60(%rsp)
               	leaq	-0x40(%rbp), %rdi
               	movups	-0x40(%rbp), %xmm14
               	movups	%xmm14, 0x50(%rsp)
               	movups	-0x30(%rbp), %xmm14
               	movups	%xmm14, 0x40(%rsp)
               	xorl	%edx, %edx
               	movq	%rdx, %rax
               	leaq	-0x20(%rbp), %r8
               	sarxq	%rax, %rdx, %rcx
               	testb	$0x1, %cl
               	je	<addr>
               	movl	(%rdi,%rax,4), %ecx
               	jmp	<addr>
               	movl	(%rsi,%rax,4), %ecx
               	movl	%ecx, (%r8,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movups	0x60(%rsp), %xmm14
               	movups	0x50(%rsp), %xmm15
               	vblendps	$0x0, %xmm15, %xmm14, %xmm0 # xmm0 = xmm14[0,1,2,3]
               	leaq	-0x10(%rbp), %rdi
               	movups	%xmm0, -0x10(%rbp)
               	leaq	-0x20(%rbp), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x40, %ecx
               	xorl	%edx, %edx
               	testq	%rax, %rax
               	movq	%rdx, %rbx
               	cmovneq	%rcx, %rbx
               	xorl	%eax, %eax
               	leaq	-0x20(%rbp), %rdx
               	movl	$0x5, %ecx
               	sarxq	%rax, %rcx, %rcx
               	testb	$0x1, %cl
               	je	<addr>
               	leaq	-0x40(%rbp), %rcx
               	movl	(%rcx,%rax,4), %ecx
               	jmp	<addr>
               	leaq	-0x50(%rbp), %rcx
               	movl	(%rcx,%rax,4), %ecx
               	movl	%ecx, (%rdx,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movups	0x60(%rsp), %xmm14
               	movups	0x50(%rsp), %xmm15
               	vblendps	$0x5, %xmm15, %xmm14, %xmm0 # xmm0 = xmm15[0],xmm14[1],xmm15[2],xmm14[3]
               	leaq	-0x10(%rbp), %rdi
               	movups	%xmm0, -0x10(%rbp)
               	leaq	-0x20(%rbp), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x40, %ecx
               	testq	%rax, %rax
               	cmovneq	%rcx, %rbx
               	xorl	%eax, %eax
               	leaq	-0x20(%rbp), %rdx
               	movl	$0xa, %ecx
               	sarxq	%rax, %rcx, %rcx
               	testb	$0x1, %cl
               	je	<addr>
               	leaq	-0x40(%rbp), %rcx
               	movl	(%rcx,%rax,4), %ecx
               	jmp	<addr>
               	leaq	-0x50(%rbp), %rcx
               	movl	(%rcx,%rax,4), %ecx
               	movl	%ecx, (%rdx,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movups	0x60(%rsp), %xmm14
               	movups	0x50(%rsp), %xmm15
               	vblendps	$0xa, %xmm15, %xmm14, %xmm0 # xmm0 = xmm14[0],xmm15[1],xmm14[2],xmm15[3]
               	leaq	-0x10(%rbp), %rdi
               	movups	%xmm0, -0x10(%rbp)
               	leaq	-0x20(%rbp), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x40, %ecx
               	testq	%rax, %rax
               	cmovneq	%rcx, %rbx
               	xorl	%eax, %eax
               	leaq	-0x20(%rbp), %rdx
               	movl	$0xf, %ecx
               	sarxq	%rax, %rcx, %rcx
               	testb	$0x1, %cl
               	je	<addr>
               	leaq	-0x40(%rbp), %rcx
               	movl	(%rcx,%rax,4), %ecx
               	jmp	<addr>
               	leaq	-0x50(%rbp), %rcx
               	movl	(%rcx,%rax,4), %ecx
               	movl	%ecx, (%rdx,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movups	0x60(%rsp), %xmm14
               	movups	0x50(%rsp), %xmm15
               	vblendps	$0xf, %xmm15, %xmm14, %xmm0 # xmm0 = xmm15[0,1,2,3]
               	leaq	-0x10(%rbp), %rdi
               	movups	%xmm0, -0x10(%rbp)
               	leaq	-0x20(%rbp), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x40, %ecx
               	testq	%rax, %rax
               	cmovneq	%rcx, %rbx
               	xorl	%eax, %eax
               	leaq	-0x20(%rbp), %rdx
               	movl	$0x9, %ecx
               	sarxq	%rax, %rcx, %rcx
               	testb	$0x1, %cl
               	je	<addr>
               	leaq	-0x40(%rbp), %rcx
               	movl	(%rcx,%rax,4), %ecx
               	jmp	<addr>
               	leaq	-0x50(%rbp), %rcx
               	movl	(%rcx,%rax,4), %ecx
               	movl	%ecx, (%rdx,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movups	0x60(%rsp), %xmm14
               	movups	0x50(%rsp), %xmm15
               	vblendps	$0x9, %xmm15, %xmm14, %xmm0 # xmm0 = xmm15[0],xmm14[1,2],xmm15[3]
               	leaq	-0x10(%rbp), %rdi
               	movups	%xmm0, -0x10(%rbp)
               	leaq	-0x20(%rbp), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x40, %ecx
               	testq	%rax, %rax
               	cmovneq	%rcx, %rbx
               	xorl	%eax, %eax
               	leaq	-0x20(%rbp), %rdx
               	leaq	-0x30(%rbp), %rcx
               	movl	(%rcx,%rax,4), %ecx
               	shrq	$0x1f, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	-0x40(%rbp), %rcx
               	movl	(%rcx,%rax,4), %ecx
               	jmp	<addr>
               	leaq	-0x50(%rbp), %rcx
               	movl	(%rcx,%rax,4), %ecx
               	movl	%ecx, (%rdx,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0xb0(%rbp), %rcx
               	movups	0x60(%rsp), %xmm14
               	movups	%xmm14, -0xb0(%rbp)
               	leaq	-0xa0(%rbp), %rdx
               	movups	0x50(%rsp), %xmm14
               	movups	%xmm14, -0xa0(%rbp)
               	leaq	-0x90(%rbp), %rsi
               	movups	0x40(%rsp), %xmm14
               	movups	%xmm14, -0x90(%rbp)
               	xorl	%eax, %eax
               	movl	(%rsi,%rax,4), %edi
               	testl	%edi, %edi
               	jge	<addr>
               	movl	(%rdx,%rax,4), %edi
               	movl	%edi, (%rcx,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movups	-0xb0(%rbp), %xmm0
               	leaq	-0x10(%rbp), %rdi
               	movups	%xmm0, -0x10(%rbp)
               	leaq	-0x20(%rbp), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x40, %ecx
               	testq	%rax, %rax
               	cmoveq	%rbx, %rcx
               	movups	0x60(%rsp), %xmm14
               	movups	0x50(%rsp), %xmm15
               	vblendpd	$0x2, %xmm15, %xmm14, %xmm0 # xmm0 = xmm14[0],xmm15[1]
               	movups	%xmm0, -0x10(%rbp)
               	vmovd	%xmm0, %eax
               	leaq	-0x50(%rbp), %rsi
               	movl	-0x50(%rbp), %edx
               	cmpl	%edx, %eax
               	jne	<addr>
               	vpextrd	$0x1, %xmm0, %eax
               	movl	-0x4c(%rbp), %edx
               	cmpl	%edx, %eax
               	jne	<addr>
               	vpextrd	$0x2, %xmm0, %eax
               	movl	-0x38(%rbp), %edx
               	cmpl	%edx, %eax
               	jne	<addr>
               	vpextrd	$0x3, %xmm0, %eax
               	movl	-0x34(%rbp), %edx
               	cmpl	%edx, %eax
               	je	<addr>
               	movl	$0x40, %ecx
               	leaq	-0xb0(%rbp), %rdx
               	movups	0x60(%rsp), %xmm14
               	movups	%xmm14, -0xb0(%rbp)
               	leaq	-0xa0(%rbp), %rdi
               	movups	0x50(%rsp), %xmm14
               	movups	%xmm14, -0xa0(%rbp)
               	leaq	-0x90(%rbp), %r8
               	movups	0x40(%rsp), %xmm14
               	movups	%xmm14, -0x90(%rbp)
               	xorl	%eax, %eax
               	movq	(%r8,%rax,8), %r9
               	testq	%r9, %r9
               	jge	<addr>
               	movq	(%rdi,%rax,8), %r9
               	movq	%r9, (%rdx,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	movups	-0xb0(%rbp), %xmm0
               	movups	%xmm0, -0x10(%rbp)
               	xorl	%eax, %eax
               	leaq	-0x10(%rbp), %rdx
               	movl	(%rdx,%rax,4), %edi
               	leaq	-0x30(%rbp), %rdx
               	movq	%rax, %r8
               	orq	$0x1, %r8
               	movl	(%rdx,%r8,4), %edx
               	shrq	$0x1f, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	leaq	-0x40(%rbp), %rdx
               	movl	(%rdx,%rax,4), %edx
               	movl	$0x40, %r8d
               	cmpl	%edx, %edi
               	cmovneq	%r8, %rcx
               	jmp	<addr>
               	movl	(%rsi,%rax,4), %edx
               	jmp	<addr>
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, %rax
               	popq	%rbx
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	pushq	%r12
               	pushq	%rbx
               	leaq	-0x8(%rbp), %rax
               	stmxcsr	(%rax)
               	movl	-0x8(%rbp), %eax
               	movl	%eax, <rip> # <addr>
               	xorl	%ebx, %ebx
               	movq	%rbx, %r12
               	callq	<addr>
               	orq	%rax, %r12
               	callq	<addr>
               	orq	%rax, %r12
               	callq	<addr>
               	orq	%rax, %r12
               	callq	<addr>
               	orq	%rax, %r12
               	callq	<addr>
               	orq	%rax, %r12
               	callq	<addr>
               	orq	%rax, %r12
               	callq	<addr>
               	orq	%rax, %r12
               	incq	%rbx
               	cmpl	$0x12c, %ebx            # imm = 0x12C
               	jl	<addr>
               	movq	%r12, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
