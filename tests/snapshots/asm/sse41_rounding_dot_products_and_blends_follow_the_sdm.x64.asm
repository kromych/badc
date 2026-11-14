
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
               	movq	%r10, %rax
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
               	vpinsrd	$0x3, %r11d, %xmm0, %xmm0
               	vmovd	%xmm0, %eax
               	movslq	%eax, %rax
               	movl	%eax, %edi
               	movl	$0x17, %esi
               	movl	$0x7f, %edx
               	movups	%xmm0, (%rsp)
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
               	vpinsrq	$0x1, %r11, %xmm0, %xmm0
               	vmovq	%xmm0, %rdi
               	movl	$0x34, %esi
               	movl	$0x3ff, %edx            # imm = 0x3FF
               	movups	%xmm0, (%rsp)
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
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
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
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
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

<bits_f>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movss	%xmm0, -0x8(%rbp)
               	movl	-0x8(%rbp), %eax
               	leave
               	retq

<model_round>:
               	movapd	%xmm0, %xmm1
               	movq	%xmm1, %rcx
               	movq	%rcx, %rax
               	shrq	$0x34, %rax
               	andq	$0x7ff, %rax            # imm = 0x7FF
               	cmpl	$0x7ff, %eax            # imm = 0x7FF
               	jne	<addr>
               	movabsq	$0x8000000000000, %rax  # imm = 0x8000000000000
               	xorl	%edx, %edx
               	movabsq	$0xfffffffffffff, %rsi  # imm = 0xFFFFFFFFFFFFF
               	andq	%rcx, %rsi
               	testq	%rsi, %rsi
               	cmoveq	%rdx, %rax
               	orq	%rcx, %rax
               	movq	%rax, %xmm0
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
               	movq	%rdi, 0x8(%rsp)
               	movss	%xmm0, -0x8(%rbp)
               	movss	-0x8(%rbp), %xmm0
               	callq	<addr>
               	movl	%eax, %ecx
               	shrq	$0x17, %rcx
               	andq	$0xff, %rcx
               	cmpl	$0xff, %ecx
               	jne	<addr>
               	movl	$0x400000, %ecx         # imm = 0x400000
               	xorl	%edx, %edx
               	testl	$0x7fffff, %eax         # imm = 0x7FFFFF
               	cmoveq	%rdx, %rcx
               	orq	%rcx, %rax
               	movl	%eax, -0x8(%rbp)
               	movss	-0x8(%rbp), %xmm0
               	leave
               	retq
               	movss	-0x8(%rbp), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movq	0x8(%rsp), %rdi
               	callq	<addr>
               	cvtsd2ss	%xmm0, %xmm0
               	leave
               	retq

<check_round_ps>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x278, %rsp            # imm = 0x278
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
               	movups	%xmm14, 0x270(%rsp)
               	xorl	%ebx, %ebx
               	movq	%rbx, %r13
               	jmp	<addr>
               	orq	%rax, %r13
               	incq	%rbx
               	cmpl	$0x4, %ebx
               	jge	<addr>
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
               	jmp	<addr>
               	movups	0x270(%rsp), %xmm0
               	vmovq	%xmm0, %rax
               	movq	%rax, -0x260(%rbp)
               	vpextrq	$0x1, %xmm0, %rax
               	movq	%rax, -0x258(%rbp)
               	movq	$0x0, -0x250(%rbp)
               	movq	$0x0, -0x248(%rbp)
               	movl	<rip>, %eax # <addr>
               	movl	$0xffff9fc0, %r11d      # imm = 0xFFFF9FC0
               	andq	%r11, %rax
               	orq	$0x2000, %rax           # imm = 0x2000
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	ldmxcsr	(%rax)
               	movq	-0x260(%rbp), %rax
               	vmovq	%rax, %xmm1
               	movq	-0x258(%rbp), %rax
               	movapd	%xmm1, %xmm14
               	vpinsrq	$0x1, %rax, %xmm14, %xmm14
               	movups	%xmm14, 0x260(%rsp)
               	movq	-0x250(%rbp), %rax
               	movq	-0x248(%rbp), %rax
               	xorl	%edi, %edi
               	vpermilps	$0x0, %xmm1, %xmm0 # xmm0 = xmm1[0,0,0,0]
               	movups	%xmm1, 0x230(%rsp)
               	callq	<addr>
               	movups	0x230(%rsp), %xmm1
               	vmovd	%xmm0, %r11d
               	movups	0x260(%rsp), %xmm14
               	vpinsrd	$0x0, %r11d, %xmm14, %xmm14
               	movups	%xmm14, 0x250(%rsp)
               	vpermilps	$0x1, %xmm1, %xmm0 # xmm0 = xmm1[1,0,0,0]
               	xorl	%edi, %edi
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	0x250(%rsp), %xmm14
               	vpinsrd	$0x1, %r11d, %xmm14, %xmm14
               	movups	%xmm14, 0x250(%rsp)
               	movups	0x260(%rsp), %xmm14
               	vpermilps	$0x2, %xmm14, %xmm0 # xmm0 = xmm14[2,0,0,0]
               	xorl	%edi, %edi
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	0x250(%rsp), %xmm14
               	vpinsrd	$0x2, %r11d, %xmm14, %xmm14
               	movups	%xmm14, 0x240(%rsp)
               	movups	0x260(%rsp), %xmm14
               	vpermilps	$0x3, %xmm14, %xmm0 # xmm0 = xmm14[3,0,0,0]
               	xorl	%edi, %edi
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	0x240(%rsp), %xmm0
               	vpinsrd	$0x3, %r11d, %xmm0, %xmm0
               	movups	0x250(%rsp), %xmm14
               	vmovq	%xmm14, %rax
               	movq	%rax, -0x240(%rbp)
               	vpextrq	$0x1, %xmm0, %rax
               	movq	%rax, -0x238(%rbp)
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
               	movq	-0x240(%rbp), %rax
               	movq	%rax, -0x270(%rbp)
               	movq	-0x238(%rbp), %rax
               	movq	%rax, -0x268(%rbp)
               	xorl	%ebx, %ebx
               	xorl	%r12d, %r12d
               	leaq	-0x270(%rbp), %rax
               	movq	%rbx, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	movss	(%rax), %xmm0
               	callq	<addr>
               	movq	%rax, %r14
               	leaq	-0x18(%rbp), %rax
               	movq	%rbx, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	movss	(%rax), %xmm0
               	xorl	%edi, %edi
               	callq	<addr>
               	callq	<addr>
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
               	movups	0x270(%rsp), %xmm0
               	vmovq	%xmm0, %rax
               	movq	%rax, -0x230(%rbp)
               	vpextrq	$0x1, %xmm0, %rax
               	movq	%rax, -0x228(%rbp)
               	movq	$0x0, -0x220(%rbp)
               	movq	$0x0, -0x218(%rbp)
               	movl	<rip>, %eax # <addr>
               	movl	$0xffff9fc0, %r11d      # imm = 0xFFFF9FC0
               	andq	%r11, %rax
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	ldmxcsr	(%rax)
               	movq	-0x230(%rbp), %rax
               	vmovq	%rax, %xmm1
               	movq	-0x228(%rbp), %rax
               	movapd	%xmm1, %xmm14
               	vpinsrq	$0x1, %rax, %xmm14, %xmm14
               	movups	%xmm14, 0x260(%rsp)
               	movq	-0x220(%rbp), %rax
               	movq	-0x218(%rbp), %rax
               	movl	$0x1, %edi
               	vpermilps	$0x0, %xmm1, %xmm0 # xmm0 = xmm1[0,0,0,0]
               	movups	%xmm1, 0x220(%rsp)
               	callq	<addr>
               	movups	0x220(%rsp), %xmm1
               	vmovd	%xmm0, %r11d
               	movups	0x260(%rsp), %xmm14
               	vpinsrd	$0x0, %r11d, %xmm14, %xmm14
               	movups	%xmm14, 0x250(%rsp)
               	vpermilps	$0x1, %xmm1, %xmm0 # xmm0 = xmm1[1,0,0,0]
               	movl	$0x1, %edi
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	0x250(%rsp), %xmm14
               	vpinsrd	$0x1, %r11d, %xmm14, %xmm14
               	movups	%xmm14, 0x250(%rsp)
               	movups	0x260(%rsp), %xmm14
               	vpermilps	$0x2, %xmm14, %xmm0 # xmm0 = xmm14[2,0,0,0]
               	movl	$0x1, %edi
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	0x250(%rsp), %xmm14
               	vpinsrd	$0x2, %r11d, %xmm14, %xmm14
               	movups	%xmm14, 0x240(%rsp)
               	movups	0x260(%rsp), %xmm14
               	vpermilps	$0x3, %xmm14, %xmm0 # xmm0 = xmm14[3,0,0,0]
               	movl	$0x1, %edi
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	0x240(%rsp), %xmm0
               	vpinsrd	$0x3, %r11d, %xmm0, %xmm0
               	movups	0x250(%rsp), %xmm14
               	vmovq	%xmm14, %rax
               	movq	%rax, -0x210(%rbp)
               	vpextrq	$0x1, %xmm0, %rax
               	movq	%rax, -0x208(%rbp)
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
               	movq	-0x210(%rbp), %rax
               	movq	%rax, -0x270(%rbp)
               	movq	-0x208(%rbp), %rax
               	movq	%rax, -0x268(%rbp)
               	xorl	%ebx, %ebx
               	leaq	-0x270(%rbp), %rax
               	movq	%rbx, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	movss	(%rax), %xmm0
               	callq	<addr>
               	movq	%rax, %r14
               	leaq	-0x18(%rbp), %rax
               	movq	%rbx, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	movss	(%rax), %xmm0
               	movl	$0x1, %edi
               	callq	<addr>
               	callq	<addr>
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
               	movups	0x270(%rsp), %xmm0
               	vmovq	%xmm0, %rax
               	movq	%rax, -0x200(%rbp)
               	vpextrq	$0x1, %xmm0, %rax
               	movq	%rax, -0x1f8(%rbp)
               	movq	$0x0, -0x1f0(%rbp)
               	movq	$0x0, -0x1e8(%rbp)
               	movl	<rip>, %eax # <addr>
               	movl	$0xffff9fc0, %r11d      # imm = 0xFFFF9FC0
               	andq	%r11, %rax
               	orq	$0x6000, %rax           # imm = 0x6000
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	ldmxcsr	(%rax)
               	movq	-0x200(%rbp), %rax
               	vmovq	%rax, %xmm1
               	movq	-0x1f8(%rbp), %rax
               	movapd	%xmm1, %xmm14
               	vpinsrq	$0x1, %rax, %xmm14, %xmm14
               	movups	%xmm14, 0x260(%rsp)
               	movq	-0x1f0(%rbp), %rax
               	movq	-0x1e8(%rbp), %rax
               	movl	$0x2, %edi
               	vpermilps	$0x0, %xmm1, %xmm0 # xmm0 = xmm1[0,0,0,0]
               	movups	%xmm1, 0x210(%rsp)
               	callq	<addr>
               	movups	0x210(%rsp), %xmm1
               	vmovd	%xmm0, %r11d
               	movups	0x260(%rsp), %xmm14
               	vpinsrd	$0x0, %r11d, %xmm14, %xmm14
               	movups	%xmm14, 0x250(%rsp)
               	vpermilps	$0x1, %xmm1, %xmm0 # xmm0 = xmm1[1,0,0,0]
               	movl	$0x2, %edi
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	0x250(%rsp), %xmm14
               	vpinsrd	$0x1, %r11d, %xmm14, %xmm14
               	movups	%xmm14, 0x250(%rsp)
               	movups	0x260(%rsp), %xmm14
               	vpermilps	$0x2, %xmm14, %xmm0 # xmm0 = xmm14[2,0,0,0]
               	movl	$0x2, %edi
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	0x250(%rsp), %xmm14
               	vpinsrd	$0x2, %r11d, %xmm14, %xmm14
               	movups	%xmm14, 0x240(%rsp)
               	movups	0x260(%rsp), %xmm14
               	vpermilps	$0x3, %xmm14, %xmm0 # xmm0 = xmm14[3,0,0,0]
               	movl	$0x2, %edi
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	0x240(%rsp), %xmm0
               	vpinsrd	$0x3, %r11d, %xmm0, %xmm0
               	movups	0x250(%rsp), %xmm14
               	vmovq	%xmm14, %rax
               	movq	%rax, -0x1e0(%rbp)
               	vpextrq	$0x1, %xmm0, %rax
               	movq	%rax, -0x1d8(%rbp)
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
               	movq	-0x1e0(%rbp), %rax
               	movq	%rax, -0x270(%rbp)
               	movq	-0x1d8(%rbp), %rax
               	movq	%rax, -0x268(%rbp)
               	xorl	%ebx, %ebx
               	leaq	-0x270(%rbp), %rax
               	movq	%rbx, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	movss	(%rax), %xmm0
               	callq	<addr>
               	movq	%rax, %r14
               	leaq	-0x18(%rbp), %rax
               	movq	%rbx, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	movss	(%rax), %xmm0
               	movl	$0x2, %edi
               	callq	<addr>
               	callq	<addr>
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
               	movups	0x270(%rsp), %xmm0
               	vmovq	%xmm0, %rax
               	movq	%rax, -0x1d0(%rbp)
               	vpextrq	$0x1, %xmm0, %rax
               	movq	%rax, -0x1c8(%rbp)
               	movq	$0x0, -0x1c0(%rbp)
               	movq	$0x0, -0x1b8(%rbp)
               	movl	<rip>, %eax # <addr>
               	movl	$0xffff9fc0, %r11d      # imm = 0xFFFF9FC0
               	andq	%r11, %rax
               	orq	$0x4000, %rax           # imm = 0x4000
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	ldmxcsr	(%rax)
               	movq	-0x1d0(%rbp), %rax
               	vmovq	%rax, %xmm1
               	movq	-0x1c8(%rbp), %rax
               	movapd	%xmm1, %xmm14
               	vpinsrq	$0x1, %rax, %xmm14, %xmm14
               	movups	%xmm14, 0x260(%rsp)
               	movq	-0x1c0(%rbp), %rax
               	movq	-0x1b8(%rbp), %rax
               	movl	$0x3, %edi
               	vpermilps	$0x0, %xmm1, %xmm0 # xmm0 = xmm1[0,0,0,0]
               	movups	%xmm1, 0x200(%rsp)
               	callq	<addr>
               	movups	0x200(%rsp), %xmm1
               	vmovd	%xmm0, %r11d
               	movups	0x260(%rsp), %xmm14
               	vpinsrd	$0x0, %r11d, %xmm14, %xmm14
               	movups	%xmm14, 0x250(%rsp)
               	vpermilps	$0x1, %xmm1, %xmm0 # xmm0 = xmm1[1,0,0,0]
               	movl	$0x3, %edi
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	0x250(%rsp), %xmm14
               	vpinsrd	$0x1, %r11d, %xmm14, %xmm14
               	movups	%xmm14, 0x250(%rsp)
               	movups	0x260(%rsp), %xmm14
               	vpermilps	$0x2, %xmm14, %xmm0 # xmm0 = xmm14[2,0,0,0]
               	movl	$0x3, %edi
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	0x250(%rsp), %xmm14
               	vpinsrd	$0x2, %r11d, %xmm14, %xmm14
               	movups	%xmm14, 0x240(%rsp)
               	movups	0x260(%rsp), %xmm14
               	vpermilps	$0x3, %xmm14, %xmm0 # xmm0 = xmm14[3,0,0,0]
               	movl	$0x3, %edi
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	0x240(%rsp), %xmm0
               	vpinsrd	$0x3, %r11d, %xmm0, %xmm0
               	movups	0x250(%rsp), %xmm14
               	vmovq	%xmm14, %rax
               	movq	%rax, -0x1b0(%rbp)
               	vpextrq	$0x1, %xmm0, %rax
               	movq	%rax, -0x1a8(%rbp)
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
               	movq	-0x1b0(%rbp), %rax
               	movq	%rax, -0x270(%rbp)
               	movq	-0x1a8(%rbp), %rax
               	movq	%rax, -0x268(%rbp)
               	xorl	%ebx, %ebx
               	leaq	-0x270(%rbp), %rax
               	movq	%rbx, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	movss	(%rax), %xmm0
               	callq	<addr>
               	movq	%rax, %r14
               	leaq	-0x18(%rbp), %rax
               	movq	%rbx, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	movss	(%rax), %xmm0
               	movl	$0x3, %edi
               	callq	<addr>
               	callq	<addr>
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
               	movups	0x270(%rsp), %xmm0
               	vmovq	%xmm0, %rax
               	movq	%rax, -0x1a0(%rbp)
               	vpextrq	$0x1, %xmm0, %rax
               	movq	%rax, -0x198(%rbp)
               	movq	$0x0, -0x190(%rbp)
               	movq	$0x0, -0x188(%rbp)
               	movl	<rip>, %eax # <addr>
               	movl	$0xffff9fc0, %r11d      # imm = 0xFFFF9FC0
               	andq	%r11, %rax
               	orq	$0x4000, %rax           # imm = 0x4000
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	ldmxcsr	(%rax)
               	movq	-0x1a0(%rbp), %rax
               	vmovq	%rax, %xmm1
               	movq	-0x198(%rbp), %rax
               	movapd	%xmm1, %xmm14
               	vpinsrq	$0x1, %rax, %xmm14, %xmm14
               	movups	%xmm14, 0x260(%rsp)
               	movq	-0x190(%rbp), %rax
               	movq	-0x188(%rbp), %rax
               	movl	$0x8, %edi
               	vpermilps	$0x0, %xmm1, %xmm0 # xmm0 = xmm1[0,0,0,0]
               	movups	%xmm1, 0x1f0(%rsp)
               	callq	<addr>
               	movups	0x1f0(%rsp), %xmm1
               	vmovd	%xmm0, %r11d
               	movups	0x260(%rsp), %xmm14
               	vpinsrd	$0x0, %r11d, %xmm14, %xmm14
               	movups	%xmm14, 0x250(%rsp)
               	vpermilps	$0x1, %xmm1, %xmm0 # xmm0 = xmm1[1,0,0,0]
               	movl	$0x8, %edi
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	0x250(%rsp), %xmm14
               	vpinsrd	$0x1, %r11d, %xmm14, %xmm14
               	movups	%xmm14, 0x250(%rsp)
               	movups	0x260(%rsp), %xmm14
               	vpermilps	$0x2, %xmm14, %xmm0 # xmm0 = xmm14[2,0,0,0]
               	movl	$0x8, %edi
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	0x250(%rsp), %xmm14
               	vpinsrd	$0x2, %r11d, %xmm14, %xmm14
               	movups	%xmm14, 0x240(%rsp)
               	movups	0x260(%rsp), %xmm14
               	vpermilps	$0x3, %xmm14, %xmm0 # xmm0 = xmm14[3,0,0,0]
               	movl	$0x8, %edi
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	0x240(%rsp), %xmm0
               	vpinsrd	$0x3, %r11d, %xmm0, %xmm0
               	movups	0x250(%rsp), %xmm14
               	vmovq	%xmm14, %rax
               	movq	%rax, -0x180(%rbp)
               	vpextrq	$0x1, %xmm0, %rax
               	movq	%rax, -0x178(%rbp)
               	leaq	-0x8(%rbp), %rax
               	stmxcsr	(%rax)
               	movl	-0x8(%rbp), %eax
               	shrq	$0x5, %rax
               	movq	%rax, %r14
               	andq	$0x1, %r14
               	movl	<rip>, %eax # <addr>
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	ldmxcsr	(%rax)
               	movq	-0x180(%rbp), %rax
               	movq	%rax, -0x270(%rbp)
               	movq	-0x178(%rbp), %rax
               	movq	%rax, -0x268(%rbp)
               	xorl	%ebx, %ebx
               	leaq	-0x270(%rbp), %rax
               	movq	%rbx, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	movss	(%rax), %xmm0
               	callq	<addr>
               	movq	%rax, %r13
               	leaq	-0x18(%rbp), %rax
               	movq	%rbx, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	movss	(%rax), %xmm0
               	xorl	%edi, %edi
               	callq	<addr>
               	callq	<addr>
               	movl	$0x1, %ecx
               	cmpl	%eax, %r13d
               	cmovneq	%rcx, %r12
               	incq	%rbx
               	cmpl	$0x4, %ebx
               	jl	<addr>
               	movl	$0x1, %eax
               	testl	%r14d, %r14d
               	cmovneq	%rax, %r12
               	movups	0x270(%rsp), %xmm0
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
               	vmovq	%rax, %xmm1
               	movq	-0x168(%rbp), %rax
               	movapd	%xmm1, %xmm14
               	vpinsrq	$0x1, %rax, %xmm14, %xmm14
               	movups	%xmm14, 0x260(%rsp)
               	movq	-0x160(%rbp), %rax
               	movq	-0x158(%rbp), %rax
               	movl	$0x9, %edi
               	vpermilps	$0x0, %xmm1, %xmm0 # xmm0 = xmm1[0,0,0,0]
               	movups	%xmm1, 0x1e0(%rsp)
               	callq	<addr>
               	movups	0x1e0(%rsp), %xmm1
               	vmovd	%xmm0, %r11d
               	movups	0x260(%rsp), %xmm14
               	vpinsrd	$0x0, %r11d, %xmm14, %xmm14
               	movups	%xmm14, 0x250(%rsp)
               	vpermilps	$0x1, %xmm1, %xmm0 # xmm0 = xmm1[1,0,0,0]
               	movl	$0x9, %edi
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	0x250(%rsp), %xmm14
               	vpinsrd	$0x1, %r11d, %xmm14, %xmm14
               	movups	%xmm14, 0x250(%rsp)
               	movups	0x260(%rsp), %xmm14
               	vpermilps	$0x2, %xmm14, %xmm0 # xmm0 = xmm14[2,0,0,0]
               	movl	$0x9, %edi
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	0x250(%rsp), %xmm14
               	vpinsrd	$0x2, %r11d, %xmm14, %xmm14
               	movups	%xmm14, 0x240(%rsp)
               	movups	0x260(%rsp), %xmm14
               	vpermilps	$0x3, %xmm14, %xmm0 # xmm0 = xmm14[3,0,0,0]
               	movl	$0x9, %edi
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	0x240(%rsp), %xmm0
               	vpinsrd	$0x3, %r11d, %xmm0, %xmm0
               	movups	0x250(%rsp), %xmm14
               	vmovq	%xmm14, %rax
               	movq	%rax, -0x150(%rbp)
               	vpextrq	$0x1, %xmm0, %rax
               	movq	%rax, -0x148(%rbp)
               	leaq	-0x8(%rbp), %rax
               	stmxcsr	(%rax)
               	movl	-0x8(%rbp), %eax
               	shrq	$0x5, %rax
               	movq	%rax, %r14
               	andq	$0x1, %r14
               	movl	<rip>, %eax # <addr>
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	ldmxcsr	(%rax)
               	movq	-0x150(%rbp), %rax
               	movq	%rax, -0x270(%rbp)
               	movq	-0x148(%rbp), %rax
               	movq	%rax, -0x268(%rbp)
               	xorl	%ebx, %ebx
               	leaq	-0x270(%rbp), %rax
               	movq	%rbx, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	movss	(%rax), %xmm0
               	callq	<addr>
               	movq	%rax, %r13
               	leaq	-0x18(%rbp), %rax
               	movq	%rbx, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	movss	(%rax), %xmm0
               	movl	$0x1, %edi
               	callq	<addr>
               	callq	<addr>
               	movl	$0x1, %ecx
               	cmpl	%eax, %r13d
               	cmovneq	%rcx, %r12
               	incq	%rbx
               	cmpl	$0x4, %ebx
               	jl	<addr>
               	movl	$0x1, %eax
               	testl	%r14d, %r14d
               	cmovneq	%rax, %r12
               	movups	0x270(%rsp), %xmm0
               	vmovq	%xmm0, %rax
               	movq	%rax, -0x140(%rbp)
               	vpextrq	$0x1, %xmm0, %rax
               	movq	%rax, -0x138(%rbp)
               	movq	$0x0, -0x130(%rbp)
               	movq	$0x0, -0x128(%rbp)
               	movl	<rip>, %eax # <addr>
               	movl	$0xffff9fc0, %r11d      # imm = 0xFFFF9FC0
               	andq	%r11, %rax
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	ldmxcsr	(%rax)
               	movq	-0x140(%rbp), %rax
               	vmovq	%rax, %xmm1
               	movq	-0x138(%rbp), %rax
               	movapd	%xmm1, %xmm14
               	vpinsrq	$0x1, %rax, %xmm14, %xmm14
               	movups	%xmm14, 0x260(%rsp)
               	movq	-0x130(%rbp), %rax
               	movq	-0x128(%rbp), %rax
               	movl	$0xa, %edi
               	vpermilps	$0x0, %xmm1, %xmm0 # xmm0 = xmm1[0,0,0,0]
               	movups	%xmm1, 0x1d0(%rsp)
               	callq	<addr>
               	movups	0x1d0(%rsp), %xmm1
               	vmovd	%xmm0, %r11d
               	movups	0x260(%rsp), %xmm14
               	vpinsrd	$0x0, %r11d, %xmm14, %xmm14
               	movups	%xmm14, 0x250(%rsp)
               	vpermilps	$0x1, %xmm1, %xmm0 # xmm0 = xmm1[1,0,0,0]
               	movl	$0xa, %edi
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	0x250(%rsp), %xmm14
               	vpinsrd	$0x1, %r11d, %xmm14, %xmm14
               	movups	%xmm14, 0x250(%rsp)
               	movups	0x260(%rsp), %xmm14
               	vpermilps	$0x2, %xmm14, %xmm0 # xmm0 = xmm14[2,0,0,0]
               	movl	$0xa, %edi
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	0x250(%rsp), %xmm14
               	vpinsrd	$0x2, %r11d, %xmm14, %xmm14
               	movups	%xmm14, 0x240(%rsp)
               	movups	0x260(%rsp), %xmm14
               	vpermilps	$0x3, %xmm14, %xmm0 # xmm0 = xmm14[3,0,0,0]
               	movl	$0xa, %edi
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	0x240(%rsp), %xmm0
               	vpinsrd	$0x3, %r11d, %xmm0, %xmm0
               	movups	0x250(%rsp), %xmm14
               	vmovq	%xmm14, %rax
               	movq	%rax, -0x120(%rbp)
               	vpextrq	$0x1, %xmm0, %rax
               	movq	%rax, -0x118(%rbp)
               	leaq	-0x8(%rbp), %rax
               	stmxcsr	(%rax)
               	movl	-0x8(%rbp), %eax
               	shrq	$0x5, %rax
               	movq	%rax, %r14
               	andq	$0x1, %r14
               	movl	<rip>, %eax # <addr>
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	ldmxcsr	(%rax)
               	movq	-0x120(%rbp), %rax
               	movq	%rax, -0x270(%rbp)
               	movq	-0x118(%rbp), %rax
               	movq	%rax, -0x268(%rbp)
               	xorl	%ebx, %ebx
               	leaq	-0x270(%rbp), %rax
               	movq	%rbx, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	movss	(%rax), %xmm0
               	callq	<addr>
               	movq	%rax, %r13
               	leaq	-0x18(%rbp), %rax
               	movq	%rbx, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	movss	(%rax), %xmm0
               	movl	$0x2, %edi
               	callq	<addr>
               	callq	<addr>
               	movl	$0x1, %ecx
               	cmpl	%eax, %r13d
               	cmovneq	%rcx, %r12
               	incq	%rbx
               	cmpl	$0x4, %ebx
               	jl	<addr>
               	movl	$0x1, %eax
               	testl	%r14d, %r14d
               	cmovneq	%rax, %r12
               	movups	0x270(%rsp), %xmm0
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
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	ldmxcsr	(%rax)
               	movq	-0x110(%rbp), %rax
               	vmovq	%rax, %xmm1
               	movq	-0x108(%rbp), %rax
               	movapd	%xmm1, %xmm14
               	vpinsrq	$0x1, %rax, %xmm14, %xmm14
               	movups	%xmm14, 0x270(%rsp)
               	movq	-0x100(%rbp), %rax
               	movq	-0xf8(%rbp), %rax
               	movl	$0xb, %edi
               	vpermilps	$0x0, %xmm1, %xmm0 # xmm0 = xmm1[0,0,0,0]
               	movups	%xmm1, 0x1c0(%rsp)
               	callq	<addr>
               	movups	0x1c0(%rsp), %xmm1
               	vmovd	%xmm0, %r11d
               	movups	0x270(%rsp), %xmm14
               	vpinsrd	$0x0, %r11d, %xmm14, %xmm14
               	movups	%xmm14, 0x260(%rsp)
               	vpermilps	$0x1, %xmm1, %xmm0 # xmm0 = xmm1[1,0,0,0]
               	movl	$0xb, %edi
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	0x260(%rsp), %xmm14
               	vpinsrd	$0x1, %r11d, %xmm14, %xmm14
               	movups	%xmm14, 0x260(%rsp)
               	movups	0x270(%rsp), %xmm14
               	vpermilps	$0x2, %xmm14, %xmm0 # xmm0 = xmm14[2,0,0,0]
               	movl	$0xb, %edi
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	0x260(%rsp), %xmm14
               	vpinsrd	$0x2, %r11d, %xmm14, %xmm14
               	movups	%xmm14, 0x250(%rsp)
               	movups	0x270(%rsp), %xmm14
               	vpermilps	$0x3, %xmm14, %xmm0 # xmm0 = xmm14[3,0,0,0]
               	movl	$0xb, %edi
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	0x250(%rsp), %xmm0
               	vpinsrd	$0x3, %r11d, %xmm0, %xmm0
               	movups	0x260(%rsp), %xmm14
               	vmovq	%xmm14, %rax
               	movq	%rax, -0xf0(%rbp)
               	vpextrq	$0x1, %xmm0, %rax
               	movq	%rax, -0xe8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	stmxcsr	(%rax)
               	movl	-0x8(%rbp), %eax
               	shrq	$0x5, %rax
               	movq	%rax, %r14
               	andq	$0x1, %r14
               	movl	<rip>, %eax # <addr>
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	ldmxcsr	(%rax)
               	movq	-0xf0(%rbp), %rax
               	movq	%rax, -0x270(%rbp)
               	movq	-0xe8(%rbp), %rax
               	movq	%rax, -0x268(%rbp)
               	xorl	%ebx, %ebx
               	leaq	-0x270(%rbp), %rax
               	movq	%rbx, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	movss	(%rax), %xmm0
               	callq	<addr>
               	movq	%rax, %r13
               	leaq	-0x18(%rbp), %rax
               	movq	%rbx, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	movss	(%rax), %xmm0
               	movl	$0x3, %edi
               	callq	<addr>
               	callq	<addr>
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
               	subq	$0x228, %rsp            # imm = 0x228
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	callq	<addr>
               	movsd	%xmm0, -0x18(%rbp)
               	callq	<addr>
               	movsd	%xmm0, -0x10(%rbp)
               	movups	-0x18(%rbp), %xmm14
               	movups	%xmm14, 0x220(%rsp)
               	xorl	%ebx, %ebx
               	movq	%rbx, %r13
               	jmp	<addr>
               	orq	%rax, %r13
               	incq	%rbx
               	cmpl	$0x2, %ebx
               	jge	<addr>
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
               	jmp	<addr>
               	movups	0x220(%rsp), %xmm0
               	vmovq	%xmm0, %rax
               	movq	%rax, -0x210(%rbp)
               	vpextrq	$0x1, %xmm0, %rax
               	movq	%rax, -0x208(%rbp)
               	movq	$0x0, -0x200(%rbp)
               	movq	$0x0, -0x1f8(%rbp)
               	movl	<rip>, %eax # <addr>
               	movl	$0xffff9fc0, %r11d      # imm = 0xFFFF9FC0
               	andq	%r11, %rax
               	orq	$0x6000, %rax           # imm = 0x6000
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	ldmxcsr	(%rax)
               	movq	-0x210(%rbp), %rax
               	vmovq	%rax, %xmm0
               	movq	-0x208(%rbp), %rax
               	movapd	%xmm0, %xmm1
               	vpinsrq	$0x1, %rax, %xmm1, %xmm1
               	movq	-0x200(%rbp), %rax
               	movq	-0x1f8(%rbp), %rax
               	xorl	%edi, %edi
               	vpermilpd	$0x0, %xmm1, %xmm0 # xmm0 = xmm1[0,0]
               	movups	%xmm1, 0x210(%rsp)
               	callq	<addr>
               	movups	0x210(%rsp), %xmm1
               	vmovq	%xmm0, %r11
               	vpinsrq	$0x0, %r11, %xmm1, %xmm1
               	vpermilpd	$0x1, %xmm1, %xmm0 # xmm0 = xmm1[1,0]
               	xorl	%edi, %edi
               	movups	%xmm1, 0x200(%rsp)
               	callq	<addr>
               	movups	0x200(%rsp), %xmm1
               	vunpcklpd	%xmm0, %xmm1, %xmm0 # xmm0 = xmm1[0],xmm0[0]
               	vmovq	%xmm0, %rax
               	movq	%rax, -0x1f0(%rbp)
               	vpextrq	$0x1, %xmm0, %rax
               	movq	%rax, -0x1e8(%rbp)
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
               	movq	-0x1f0(%rbp), %rax
               	movq	%rax, -0x220(%rbp)
               	movq	-0x1e8(%rbp), %rax
               	movq	%rax, -0x218(%rbp)
               	xorl	%ebx, %ebx
               	xorl	%r12d, %r12d
               	leaq	-0x220(%rbp), %rcx
               	movq	%rbx, %rax
               	shlq	$0x3, %rax
               	addq	%rax, %rcx
               	movsd	(%rcx), %xmm0
               	movq	%xmm0, %r14
               	leaq	-0x18(%rbp), %rcx
               	addq	%rcx, %rax
               	movsd	(%rax), %xmm0
               	xorl	%edi, %edi
               	callq	<addr>
               	movq	%xmm0, %rax
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
               	movups	0x220(%rsp), %xmm0
               	vmovq	%xmm0, %rax
               	movq	%rax, -0x1e0(%rbp)
               	vpextrq	$0x1, %xmm0, %rax
               	movq	%rax, -0x1d8(%rbp)
               	movq	$0x0, -0x1d0(%rbp)
               	movq	$0x0, -0x1c8(%rbp)
               	movl	<rip>, %eax # <addr>
               	movl	$0xffff9fc0, %r11d      # imm = 0xFFFF9FC0
               	andq	%r11, %rax
               	orq	$0x4000, %rax           # imm = 0x4000
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	ldmxcsr	(%rax)
               	movq	-0x1e0(%rbp), %rax
               	vmovq	%rax, %xmm0
               	movq	-0x1d8(%rbp), %rax
               	movapd	%xmm0, %xmm1
               	vpinsrq	$0x1, %rax, %xmm1, %xmm1
               	movq	-0x1d0(%rbp), %rax
               	movq	-0x1c8(%rbp), %rax
               	movl	$0x1, %edi
               	vpermilpd	$0x0, %xmm1, %xmm0 # xmm0 = xmm1[0,0]
               	movups	%xmm1, 0x1f0(%rsp)
               	callq	<addr>
               	movups	0x1f0(%rsp), %xmm1
               	vmovq	%xmm0, %r11
               	vpinsrq	$0x0, %r11, %xmm1, %xmm1
               	vpermilpd	$0x1, %xmm1, %xmm0 # xmm0 = xmm1[1,0]
               	movl	$0x1, %edi
               	movups	%xmm1, 0x1e0(%rsp)
               	callq	<addr>
               	movups	0x1e0(%rsp), %xmm1
               	vunpcklpd	%xmm0, %xmm1, %xmm0 # xmm0 = xmm1[0],xmm0[0]
               	vmovq	%xmm0, %rax
               	movq	%rax, -0x1c0(%rbp)
               	vpextrq	$0x1, %xmm0, %rax
               	movq	%rax, -0x1b8(%rbp)
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
               	movq	-0x1c0(%rbp), %rax
               	movq	%rax, -0x220(%rbp)
               	movq	-0x1b8(%rbp), %rax
               	movq	%rax, -0x218(%rbp)
               	xorl	%ebx, %ebx
               	leaq	-0x220(%rbp), %rcx
               	movq	%rbx, %rax
               	shlq	$0x3, %rax
               	addq	%rax, %rcx
               	movsd	(%rcx), %xmm0
               	movq	%xmm0, %r14
               	leaq	-0x18(%rbp), %rcx
               	addq	%rcx, %rax
               	movsd	(%rax), %xmm0
               	movl	$0x1, %edi
               	callq	<addr>
               	movq	%xmm0, %rax
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
               	movups	0x220(%rsp), %xmm0
               	vmovq	%xmm0, %rax
               	movq	%rax, -0x1b0(%rbp)
               	vpextrq	$0x1, %xmm0, %rax
               	movq	%rax, -0x1a8(%rbp)
               	movq	$0x0, -0x1a0(%rbp)
               	movq	$0x0, -0x198(%rbp)
               	movl	<rip>, %eax # <addr>
               	movl	$0xffff9fc0, %r11d      # imm = 0xFFFF9FC0
               	andq	%r11, %rax
               	orq	$0x2000, %rax           # imm = 0x2000
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	ldmxcsr	(%rax)
               	movq	-0x1b0(%rbp), %rax
               	vmovq	%rax, %xmm0
               	movq	-0x1a8(%rbp), %rax
               	movapd	%xmm0, %xmm1
               	vpinsrq	$0x1, %rax, %xmm1, %xmm1
               	movq	-0x1a0(%rbp), %rax
               	movq	-0x198(%rbp), %rax
               	movl	$0x2, %edi
               	vpermilpd	$0x0, %xmm1, %xmm0 # xmm0 = xmm1[0,0]
               	movups	%xmm1, 0x1d0(%rsp)
               	callq	<addr>
               	movups	0x1d0(%rsp), %xmm1
               	vmovq	%xmm0, %r11
               	vpinsrq	$0x0, %r11, %xmm1, %xmm1
               	vpermilpd	$0x1, %xmm1, %xmm0 # xmm0 = xmm1[1,0]
               	movl	$0x2, %edi
               	movups	%xmm1, 0x1c0(%rsp)
               	callq	<addr>
               	movups	0x1c0(%rsp), %xmm1
               	vunpcklpd	%xmm0, %xmm1, %xmm0 # xmm0 = xmm1[0],xmm0[0]
               	vmovq	%xmm0, %rax
               	movq	%rax, -0x190(%rbp)
               	vpextrq	$0x1, %xmm0, %rax
               	movq	%rax, -0x188(%rbp)
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
               	movq	-0x190(%rbp), %rax
               	movq	%rax, -0x220(%rbp)
               	movq	-0x188(%rbp), %rax
               	movq	%rax, -0x218(%rbp)
               	xorl	%ebx, %ebx
               	leaq	-0x220(%rbp), %rcx
               	movq	%rbx, %rax
               	shlq	$0x3, %rax
               	addq	%rax, %rcx
               	movsd	(%rcx), %xmm0
               	movq	%xmm0, %r14
               	leaq	-0x18(%rbp), %rcx
               	addq	%rcx, %rax
               	movsd	(%rax), %xmm0
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%xmm0, %rax
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
               	movups	0x220(%rsp), %xmm0
               	vmovq	%xmm0, %rax
               	movq	%rax, -0x180(%rbp)
               	vpextrq	$0x1, %xmm0, %rax
               	movq	%rax, -0x178(%rbp)
               	movq	$0x0, -0x170(%rbp)
               	movq	$0x0, -0x168(%rbp)
               	movl	<rip>, %eax # <addr>
               	movl	$0xffff9fc0, %r11d      # imm = 0xFFFF9FC0
               	andq	%r11, %rax
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	ldmxcsr	(%rax)
               	movq	-0x180(%rbp), %rax
               	vmovq	%rax, %xmm0
               	movq	-0x178(%rbp), %rax
               	movapd	%xmm0, %xmm1
               	vpinsrq	$0x1, %rax, %xmm1, %xmm1
               	movq	-0x170(%rbp), %rax
               	movq	-0x168(%rbp), %rax
               	movl	$0x3, %edi
               	vpermilpd	$0x0, %xmm1, %xmm0 # xmm0 = xmm1[0,0]
               	movups	%xmm1, 0x1b0(%rsp)
               	callq	<addr>
               	movups	0x1b0(%rsp), %xmm1
               	vmovq	%xmm0, %r11
               	vpinsrq	$0x0, %r11, %xmm1, %xmm1
               	vpermilpd	$0x1, %xmm1, %xmm0 # xmm0 = xmm1[1,0]
               	movl	$0x3, %edi
               	movups	%xmm1, 0x1a0(%rsp)
               	callq	<addr>
               	movups	0x1a0(%rsp), %xmm1
               	vunpcklpd	%xmm0, %xmm1, %xmm0 # xmm0 = xmm1[0],xmm0[0]
               	vmovq	%xmm0, %rax
               	movq	%rax, -0x160(%rbp)
               	vpextrq	$0x1, %xmm0, %rax
               	movq	%rax, -0x158(%rbp)
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
               	movq	-0x160(%rbp), %rax
               	movq	%rax, -0x220(%rbp)
               	movq	-0x158(%rbp), %rax
               	movq	%rax, -0x218(%rbp)
               	xorl	%ebx, %ebx
               	leaq	-0x220(%rbp), %rcx
               	movq	%rbx, %rax
               	shlq	$0x3, %rax
               	addq	%rax, %rcx
               	movsd	(%rcx), %xmm0
               	movq	%xmm0, %r14
               	leaq	-0x18(%rbp), %rcx
               	addq	%rcx, %rax
               	movsd	(%rax), %xmm0
               	movl	$0x3, %edi
               	callq	<addr>
               	movq	%xmm0, %rax
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
               	movups	0x220(%rsp), %xmm0
               	vmovq	%xmm0, %rax
               	movq	%rax, -0x150(%rbp)
               	vpextrq	$0x1, %xmm0, %rax
               	movq	%rax, -0x148(%rbp)
               	movq	$0x0, -0x140(%rbp)
               	movq	$0x0, -0x138(%rbp)
               	movl	<rip>, %eax # <addr>
               	movl	$0xffff9fc0, %r11d      # imm = 0xFFFF9FC0
               	andq	%r11, %rax
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	ldmxcsr	(%rax)
               	movq	-0x150(%rbp), %rax
               	vmovq	%rax, %xmm0
               	movq	-0x148(%rbp), %rax
               	movapd	%xmm0, %xmm1
               	vpinsrq	$0x1, %rax, %xmm1, %xmm1
               	movq	-0x140(%rbp), %rax
               	movq	-0x138(%rbp), %rax
               	movl	$0x9, %edi
               	vpermilpd	$0x0, %xmm1, %xmm0 # xmm0 = xmm1[0,0]
               	movups	%xmm1, 0x190(%rsp)
               	callq	<addr>
               	movups	0x190(%rsp), %xmm1
               	vmovq	%xmm0, %r11
               	vpinsrq	$0x0, %r11, %xmm1, %xmm1
               	vpermilpd	$0x1, %xmm1, %xmm0 # xmm0 = xmm1[1,0]
               	movl	$0x9, %edi
               	movups	%xmm1, 0x180(%rsp)
               	callq	<addr>
               	movups	0x180(%rsp), %xmm1
               	vunpcklpd	%xmm0, %xmm1, %xmm0 # xmm0 = xmm1[0],xmm0[0]
               	vmovq	%xmm0, %rax
               	movq	%rax, -0x130(%rbp)
               	vpextrq	$0x1, %xmm0, %rax
               	movq	%rax, -0x128(%rbp)
               	leaq	-0x8(%rbp), %rax
               	stmxcsr	(%rax)
               	movl	-0x8(%rbp), %eax
               	shrq	$0x5, %rax
               	movq	%rax, %r14
               	andq	$0x1, %r14
               	movl	<rip>, %eax # <addr>
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	ldmxcsr	(%rax)
               	movq	-0x130(%rbp), %rax
               	movq	%rax, -0x220(%rbp)
               	movq	-0x128(%rbp), %rax
               	movq	%rax, -0x218(%rbp)
               	xorl	%ebx, %ebx
               	leaq	-0x220(%rbp), %rcx
               	movq	%rbx, %rax
               	shlq	$0x3, %rax
               	addq	%rax, %rcx
               	movsd	(%rcx), %xmm0
               	movq	%xmm0, %r13
               	leaq	-0x18(%rbp), %rcx
               	addq	%rcx, %rax
               	movsd	(%rax), %xmm0
               	movl	$0x1, %edi
               	callq	<addr>
               	movq	%xmm0, %rax
               	movl	$0x2, %ecx
               	cmpq	%rax, %r13
               	cmovneq	%rcx, %r12
               	incq	%rbx
               	cmpl	$0x2, %ebx
               	jl	<addr>
               	movl	$0x2, %eax
               	testl	%r14d, %r14d
               	cmovneq	%rax, %r12
               	movups	0x220(%rsp), %xmm0
               	vmovq	%xmm0, %rax
               	movq	%rax, -0x120(%rbp)
               	vpextrq	$0x1, %xmm0, %rax
               	movq	%rax, -0x118(%rbp)
               	movq	$0x0, -0x110(%rbp)
               	movq	$0x0, -0x108(%rbp)
               	movl	<rip>, %eax # <addr>
               	movl	$0xffff9fc0, %r11d      # imm = 0xFFFF9FC0
               	andq	%r11, %rax
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	ldmxcsr	(%rax)
               	movq	-0x120(%rbp), %rax
               	vmovq	%rax, %xmm0
               	movq	-0x118(%rbp), %rax
               	movapd	%xmm0, %xmm1
               	vpinsrq	$0x1, %rax, %xmm1, %xmm1
               	movq	-0x110(%rbp), %rax
               	movq	-0x108(%rbp), %rax
               	movl	$0xa, %edi
               	vpermilpd	$0x0, %xmm1, %xmm0 # xmm0 = xmm1[0,0]
               	movups	%xmm1, 0x170(%rsp)
               	callq	<addr>
               	movups	0x170(%rsp), %xmm1
               	vmovq	%xmm0, %r11
               	vpinsrq	$0x0, %r11, %xmm1, %xmm1
               	vpermilpd	$0x1, %xmm1, %xmm0 # xmm0 = xmm1[1,0]
               	movl	$0xa, %edi
               	movups	%xmm1, 0x160(%rsp)
               	callq	<addr>
               	movups	0x160(%rsp), %xmm1
               	vunpcklpd	%xmm0, %xmm1, %xmm0 # xmm0 = xmm1[0],xmm0[0]
               	vmovq	%xmm0, %rax
               	movq	%rax, -0x100(%rbp)
               	vpextrq	$0x1, %xmm0, %rax
               	movq	%rax, -0xf8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	stmxcsr	(%rax)
               	movl	-0x8(%rbp), %eax
               	shrq	$0x5, %rax
               	movq	%rax, %r14
               	andq	$0x1, %r14
               	movl	<rip>, %eax # <addr>
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	ldmxcsr	(%rax)
               	movq	-0x100(%rbp), %rax
               	movq	%rax, -0x220(%rbp)
               	movq	-0xf8(%rbp), %rax
               	movq	%rax, -0x218(%rbp)
               	xorl	%ebx, %ebx
               	leaq	-0x220(%rbp), %rcx
               	movq	%rbx, %rax
               	shlq	$0x3, %rax
               	addq	%rax, %rcx
               	movsd	(%rcx), %xmm0
               	movq	%xmm0, %r13
               	leaq	-0x18(%rbp), %rcx
               	addq	%rcx, %rax
               	movsd	(%rax), %xmm0
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%xmm0, %rax
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
               	subq	$0x70, %rsp
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
               	callq	<addr>
               	movq	%rax, %rbx
               	movsd	0x78(%rsp), %xmm0
               	movl	$0x3, %edi
               	callq	<addr>
               	callq	<addr>
               	cmpl	%eax, %ebx
               	setne	%bl
               	movzbq	%bl, %rbx
               	movsd	0x30(%rsp), %xmm0
               	callq	<addr>
               	movq	%rax, %r12
               	movsd	0x30(%rsp), %xmm0
               	callq	<addr>
               	cmpl	%eax, %r12d
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rax, %rbx
               	movsd	0x58(%rsp), %xmm0
               	callq	<addr>
               	movq	%rax, %r12
               	movsd	0x58(%rsp), %xmm0
               	callq	<addr>
               	cmpl	%eax, %r12d
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rax, %rbx
               	movsd	0x48(%rsp), %xmm0
               	callq	<addr>
               	movq	%rax, %r12
               	movsd	0x48(%rsp), %xmm0
               	callq	<addr>
               	cmpl	%eax, %r12d
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rax, %rbx
               	movl	$0x2, %edi
               	movsd	0x70(%rsp), %xmm0
               	callq	<addr>
               	movq	%xmm0, %r12
               	movsd	0x70(%rsp), %xmm0
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%xmm0, %rax
               	cmpq	%rax, %r12
               	movl	$0x1, %eax
               	jne	<addr>
               	movsd	0x68(%rsp), %xmm0
               	movq	%xmm0, %rcx
               	movsd	0x68(%rsp), %xmm0
               	movq	%xmm0, %rdx
               	cmpq	%rdx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	orq	%rcx, %rbx
               	movsd	0x78(%rsp), %xmm0
               	movq	%rax, %rdi
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
               	callq	<addr>
               	movq	%rax, %r12
               	movsd	0x78(%rsp), %xmm0
               	movl	$0x1, %edi
               	callq	<addr>
               	callq	<addr>
               	cmpl	%eax, %r12d
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rax, %rbx
               	movsd	0x28(%rsp), %xmm0
               	callq	<addr>
               	movq	%rax, %r12
               	movsd	0x60(%rsp), %xmm0
               	movl	$0x1, %edi
               	callq	<addr>
               	callq	<addr>
               	cmpl	%eax, %r12d
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rax, %rbx
               	movsd	0x20(%rsp), %xmm0
               	callq	<addr>
               	movq	%rax, %r12
               	movsd	0x50(%rsp), %xmm0
               	movl	$0x1, %edi
               	callq	<addr>
               	callq	<addr>
               	cmpl	%eax, %r12d
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rax, %rbx
               	movsd	0x18(%rsp), %xmm0
               	callq	<addr>
               	movq	%rax, %r12
               	movsd	0x40(%rsp), %xmm0
               	movl	$0x1, %edi
               	callq	<addr>
               	callq	<addr>
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
               	callq	<addr>
               	movq	%rax, %r12
               	movsd	0x78(%rsp), %xmm0
               	movl	$0x2, %edi
               	callq	<addr>
               	callq	<addr>
               	cmpl	%eax, %r12d
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rax, %rbx
               	movsd	0x28(%rsp), %xmm0
               	callq	<addr>
               	movq	%rax, %r12
               	movsd	0x60(%rsp), %xmm0
               	movl	$0x2, %edi
               	callq	<addr>
               	callq	<addr>
               	cmpl	%eax, %r12d
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rax, %rbx
               	movsd	0x20(%rsp), %xmm0
               	callq	<addr>
               	movq	%rax, %r12
               	movsd	0x50(%rsp), %xmm0
               	movl	$0x2, %edi
               	callq	<addr>
               	callq	<addr>
               	cmpl	%eax, %r12d
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rax, %rbx
               	movsd	0x18(%rsp), %xmm0
               	callq	<addr>
               	movq	%rax, %r12
               	movsd	0x40(%rsp), %xmm0
               	movl	$0x2, %edi
               	callq	<addr>
               	callq	<addr>
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
               	movq	%xmm0, %r12
               	movsd	0x70(%rsp), %xmm0
               	movl	$0x1, %edi
               	callq	<addr>
               	movq	%xmm0, %rax
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
               	movq	%xmm0, %r12
               	movsd	0x38(%rsp), %xmm0
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%xmm0, %rax
               	cmpq	%rax, %r12
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rax, %rbx
               	movl	$0x1, %edi
               	movsd	0x78(%rsp), %xmm0
               	callq	<addr>
               	callq	<addr>
               	movq	%rax, %r12
               	movsd	0x78(%rsp), %xmm0
               	movl	$0x1, %edi
               	callq	<addr>
               	callq	<addr>
               	cmpl	%eax, %r12d
               	movl	$0x1, %eax
               	jne	<addr>
               	movsd	0x48(%rsp), %xmm0
               	callq	<addr>
               	movq	%rax, %r12
               	movsd	0x48(%rsp), %xmm0
               	callq	<addr>
               	cmpl	%eax, %r12d
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rax, %rbx
               	movl	$0x2, %edi
               	movsd	0x78(%rsp), %xmm0
               	callq	<addr>
               	callq	<addr>
               	movq	%rax, %r12
               	movsd	0x78(%rsp), %xmm0
               	movl	$0x2, %edi
               	callq	<addr>
               	callq	<addr>
               	cmpl	%eax, %r12d
               	movl	$0x1, %eax
               	jne	<addr>
               	movsd	0x58(%rsp), %xmm0
               	callq	<addr>
               	movq	%rax, %r12
               	movsd	0x58(%rsp), %xmm0
               	callq	<addr>
               	cmpl	%eax, %r12d
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rax, %rbx
               	movl	$0x1, %edi
               	movsd	0x70(%rsp), %xmm0
               	callq	<addr>
               	movq	%xmm0, %r12
               	movsd	0x70(%rsp), %xmm0
               	movl	$0x1, %edi
               	callq	<addr>
               	movq	%xmm0, %rax
               	cmpq	%rax, %r12
               	movl	$0x1, %eax
               	jne	<addr>
               	movsd	0x68(%rsp), %xmm0
               	movq	%xmm0, %rax
               	movsd	0x68(%rsp), %xmm0
               	movq	%xmm0, %rcx
               	cmpq	%rcx, %rax
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rax, %rbx
               	movl	$0x2, %edi
               	movsd	0x70(%rsp), %xmm0
               	callq	<addr>
               	movq	%xmm0, %r12
               	movsd	0x70(%rsp), %xmm0
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%xmm0, %rax
               	cmpq	%rax, %r12
               	movl	$0x1, %eax
               	jne	<addr>
               	movsd	0x68(%rsp), %xmm0
               	movq	%xmm0, %rax
               	movsd	0x68(%rsp), %xmm0
               	movq	%xmm0, %rcx
               	cmpq	%rcx, %rax
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rbx, %rax
               	movl	$0x4, %ecx
               	xorl	%edx, %edx
               	testq	%rax, %rax
               	cmoveq	%rdx, %rcx
               	movq	%rcx, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movq	%rax, %rcx
               	jmp	<addr>

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
               	movsd	%xmm0, 0x178(%rsp)
               	movapd	%xmm0, %xmm15
               	vmovq	%xmm15, %r11
               	vmovq	%r11, %xmm14
               	movups	%xmm14, 0x1a0(%rsp)
               	callq	<addr>
               	movsd	%xmm0, 0x170(%rsp)
               	movapd	%xmm0, %xmm15
               	vmovq	%xmm15, %r11
               	movups	0x1a0(%rsp), %xmm14
               	vpinsrq	$0x1, %r11, %xmm14, %xmm14
               	movups	%xmm14, 0x160(%rsp)
               	callq	<addr>
               	movss	%xmm0, -0x18(%rbp)
               	callq	<addr>
               	movss	%xmm0, -0x14(%rbp)
               	callq	<addr>
               	movss	%xmm0, -0x10(%rbp)
               	callq	<addr>
               	movss	%xmm0, -0xc(%rbp)
               	movups	-0x18(%rbp), %xmm14
               	movups	%xmm14, 0x1a0(%rsp)
               	xorl	%ebx, %ebx
               	movq	%rbx, %r12
               	jmp	<addr>
               	orq	%rax, %r12
               	incq	%rbx
               	cmpl	$0x4, %ebx
               	jge	<addr>
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
               	jmp	<addr>
               	xorl	%ebx, %ebx
               	xorl	%r14d, %r14d
               	movups	0x1a0(%rsp), %xmm0
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
               	vmovq	%rax, %xmm1
               	movq	-0x198(%rbp), %rax
               	movapd	%xmm1, %xmm14
               	vpinsrq	$0x1, %rax, %xmm14, %xmm14
               	movups	%xmm14, 0x190(%rsp)
               	movq	-0x190(%rbp), %rax
               	movq	-0x188(%rbp), %rax
               	movl	$0x4, %r13d
               	vpermilps	$0x0, %xmm1, %xmm0 # xmm0 = xmm1[0,0,0,0]
               	movups	%xmm1, 0x140(%rsp)
               	movq	%r13, %rdi
               	callq	<addr>
               	movups	0x140(%rsp), %xmm1
               	vmovd	%xmm0, %r11d
               	movups	0x190(%rsp), %xmm14
               	vpinsrd	$0x0, %r11d, %xmm14, %xmm14
               	movups	%xmm14, 0x180(%rsp)
               	vpermilps	$0x1, %xmm1, %xmm0 # xmm0 = xmm1[1,0,0,0]
               	movq	%r13, %rdi
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	0x180(%rsp), %xmm14
               	vpinsrd	$0x1, %r11d, %xmm14, %xmm14
               	movups	%xmm14, 0x180(%rsp)
               	movups	0x190(%rsp), %xmm14
               	vpermilps	$0x2, %xmm14, %xmm0 # xmm0 = xmm14[2,0,0,0]
               	movq	%r13, %rdi
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	0x180(%rsp), %xmm14
               	vpinsrd	$0x2, %r11d, %xmm14, %xmm14
               	movups	%xmm14, 0x150(%rsp)
               	movups	0x190(%rsp), %xmm14
               	vpermilps	$0x3, %xmm14, %xmm0 # xmm0 = xmm14[3,0,0,0]
               	movq	%r13, %rdi
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	0x150(%rsp), %xmm0
               	vpinsrd	$0x3, %r11d, %xmm0, %xmm0
               	movups	0x180(%rsp), %xmm14
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
               	vmovq	%rax, %xmm14
               	movups	%xmm14, 0x190(%rsp)
               	movq	-0x178(%rbp), %rax
               	movups	0x190(%rsp), %xmm0
               	movapd	%xmm0, %xmm14
               	vpinsrq	$0x1, %rax, %xmm14, %xmm14
               	movups	%xmm14, 0x180(%rsp)
               	callq	<addr>
               	movq	%rax, %r15
               	movss	-0x18(%rbp), %xmm0
               	movq	%rbx, %rdi
               	callq	<addr>
               	callq	<addr>
               	cmpl	%eax, %r15d
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rax, %r14
               	movups	0x190(%rsp), %xmm14
               	vpermilps	$0x1, %xmm14, %xmm0 # xmm0 = xmm14[1,0,0,0]
               	callq	<addr>
               	movq	%rax, %r15
               	movss	-0x14(%rbp), %xmm0
               	movq	%rbx, %rdi
               	callq	<addr>
               	callq	<addr>
               	cmpl	%eax, %r15d
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rax, %r14
               	movups	0x180(%rsp), %xmm14
               	vpermilps	$0x2, %xmm14, %xmm0 # xmm0 = xmm14[2,0,0,0]
               	callq	<addr>
               	movq	%rax, %r15
               	movss	-0x10(%rbp), %xmm0
               	movq	%rbx, %rdi
               	callq	<addr>
               	callq	<addr>
               	cmpl	%eax, %r15d
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rax, %r14
               	movups	0x180(%rsp), %xmm14
               	vpermilps	$0x3, %xmm14, %xmm0 # xmm0 = xmm14[3,0,0,0]
               	callq	<addr>
               	movq	%rax, %r15
               	movss	-0xc(%rbp), %xmm0
               	movq	%rbx, %rdi
               	callq	<addr>
               	callq	<addr>
               	cmpl	%eax, %r15d
               	setne	%al
               	movzbq	%al, %rax
               	orq	%r14, %rax
               	cmpl	%r12d, %r13d
               	setne	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %r14
               	orq	%rcx, %r14
               	movups	0x1a0(%rsp), %xmm0
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
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	ldmxcsr	(%rax)
               	movq	-0x170(%rbp), %rax
               	vmovq	%rax, %xmm1
               	movq	-0x168(%rbp), %rax
               	movapd	%xmm1, %xmm14
               	vpinsrq	$0x1, %rax, %xmm14, %xmm14
               	movups	%xmm14, 0x190(%rsp)
               	movq	-0x160(%rbp), %rax
               	movq	-0x158(%rbp), %rax
               	movl	$0x4, %r13d
               	vpermilps	$0x0, %xmm1, %xmm0 # xmm0 = xmm1[0,0,0,0]
               	movups	%xmm1, 0x130(%rsp)
               	movq	%r13, %rdi
               	callq	<addr>
               	movups	0x130(%rsp), %xmm1
               	vmovd	%xmm0, %r11d
               	movups	0x190(%rsp), %xmm14
               	vpinsrd	$0x0, %r11d, %xmm14, %xmm14
               	movups	%xmm14, 0x180(%rsp)
               	vpermilps	$0x1, %xmm1, %xmm0 # xmm0 = xmm1[1,0,0,0]
               	movq	%r13, %rdi
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	0x180(%rsp), %xmm14
               	vpinsrd	$0x1, %r11d, %xmm14, %xmm14
               	movups	%xmm14, 0x180(%rsp)
               	movups	0x190(%rsp), %xmm14
               	vpermilps	$0x2, %xmm14, %xmm0 # xmm0 = xmm14[2,0,0,0]
               	movq	%r13, %rdi
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	0x180(%rsp), %xmm14
               	vpinsrd	$0x2, %r11d, %xmm14, %xmm14
               	movups	%xmm14, 0x150(%rsp)
               	movups	0x190(%rsp), %xmm14
               	vpermilps	$0x3, %xmm14, %xmm0 # xmm0 = xmm14[3,0,0,0]
               	movq	%r13, %rdi
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	0x150(%rsp), %xmm0
               	vpinsrd	$0x3, %r11d, %xmm0, %xmm0
               	movups	0x180(%rsp), %xmm14
               	vmovq	%xmm14, %rax
               	movq	%rax, -0x150(%rbp)
               	vpextrq	$0x1, %xmm0, %rax
               	movq	%rax, -0x148(%rbp)
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
               	movq	-0x150(%rbp), %rax
               	vmovq	%rax, %xmm0
               	movq	-0x148(%rbp), %rax
               	vpermilps	$0x1, %xmm0, %xmm0 # xmm0 = xmm0[1,0,0,0]
               	callq	<addr>
               	movq	%rax, %r15
               	movss	-0x14(%rbp), %xmm0
               	movq	%rbx, %rdi
               	callq	<addr>
               	callq	<addr>
               	movl	$0x1, %ecx
               	cmpl	%r12d, %r13d
               	setne	%dl
               	movzbq	%dl, %rdx
               	cmpl	%eax, %r15d
               	cmoveq	%rdx, %rcx
               	orq	%rcx, %r14
               	movups	0x1a0(%rsp), %xmm0
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
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	ldmxcsr	(%rax)
               	movq	-0x140(%rbp), %rax
               	vmovq	%rax, %xmm1
               	movq	-0x138(%rbp), %rax
               	movapd	%xmm1, %xmm14
               	vpinsrq	$0x1, %rax, %xmm14, %xmm14
               	movups	%xmm14, 0x190(%rsp)
               	movq	-0x130(%rbp), %rax
               	movq	-0x128(%rbp), %rax
               	movl	$0xc, %r13d
               	vpermilps	$0x0, %xmm1, %xmm0 # xmm0 = xmm1[0,0,0,0]
               	movups	%xmm1, 0x120(%rsp)
               	movq	%r13, %rdi
               	callq	<addr>
               	movups	0x120(%rsp), %xmm1
               	vmovd	%xmm0, %r11d
               	movups	0x190(%rsp), %xmm14
               	vpinsrd	$0x0, %r11d, %xmm14, %xmm14
               	movups	%xmm14, 0x180(%rsp)
               	vpermilps	$0x1, %xmm1, %xmm0 # xmm0 = xmm1[1,0,0,0]
               	movq	%r13, %rdi
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	0x180(%rsp), %xmm14
               	vpinsrd	$0x1, %r11d, %xmm14, %xmm14
               	movups	%xmm14, 0x180(%rsp)
               	movups	0x190(%rsp), %xmm14
               	vpermilps	$0x2, %xmm14, %xmm0 # xmm0 = xmm14[2,0,0,0]
               	movq	%r13, %rdi
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	0x180(%rsp), %xmm14
               	vpinsrd	$0x2, %r11d, %xmm14, %xmm14
               	movups	%xmm14, 0x150(%rsp)
               	movups	0x190(%rsp), %xmm14
               	vpermilps	$0x3, %xmm14, %xmm0 # xmm0 = xmm14[3,0,0,0]
               	movq	%r13, %rdi
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	0x150(%rsp), %xmm0
               	vpinsrd	$0x3, %r11d, %xmm0, %xmm0
               	movups	0x180(%rsp), %xmm14
               	vmovq	%xmm14, %rax
               	movq	%rax, -0x120(%rbp)
               	vpextrq	$0x1, %xmm0, %rax
               	movq	%rax, -0x118(%rbp)
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
               	movq	-0x120(%rbp), %rax
               	vmovq	%rax, %xmm0
               	movq	-0x118(%rbp), %rax
               	vpinsrq	$0x1, %rax, %xmm0, %xmm0
               	vpermilps	$0x2, %xmm0, %xmm0 # xmm0 = xmm0[2,0,0,0]
               	callq	<addr>
               	movq	%rax, %r15
               	movss	-0x10(%rbp), %xmm0
               	movq	%rbx, %rdi
               	callq	<addr>
               	callq	<addr>
               	movl	$0x1, %ecx
               	testl	%r13d, %r13d
               	setne	%dl
               	movzbq	%dl, %rdx
               	cmpl	%eax, %r15d
               	cmoveq	%rdx, %rcx
               	orq	%rcx, %r14
               	movups	0x160(%rsp), %xmm0
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
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	ldmxcsr	(%rax)
               	movq	-0x110(%rbp), %rax
               	vmovq	%rax, %xmm0
               	movq	-0x108(%rbp), %rax
               	movapd	%xmm0, %xmm1
               	vpinsrq	$0x1, %rax, %xmm1, %xmm1
               	movq	-0x100(%rbp), %rax
               	movq	-0xf8(%rbp), %rax
               	movl	$0xc, %r13d
               	vpermilpd	$0x0, %xmm1, %xmm0 # xmm0 = xmm1[0,0]
               	movups	%xmm1, 0x110(%rsp)
               	movq	%r13, %rdi
               	callq	<addr>
               	movups	0x110(%rsp), %xmm1
               	vmovq	%xmm0, %r11
               	vpinsrq	$0x0, %r11, %xmm1, %xmm1
               	vpermilpd	$0x1, %xmm1, %xmm0 # xmm0 = xmm1[1,0]
               	movups	%xmm1, 0x100(%rsp)
               	movq	%r13, %rdi
               	callq	<addr>
               	movups	0x100(%rsp), %xmm1
               	vunpcklpd	%xmm0, %xmm1, %xmm0 # xmm0 = xmm1[0],xmm0[0]
               	vmovq	%xmm0, %rax
               	movq	%rax, -0xf0(%rbp)
               	vpextrq	$0x1, %xmm0, %rax
               	movq	%rax, -0xe8(%rbp)
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
               	movq	-0xf0(%rbp), %rax
               	vmovq	%rax, %xmm0
               	movq	-0xe8(%rbp), %rax
               	movapd	%xmm0, %xmm1
               	vpinsrq	$0x1, %rax, %xmm1, %xmm1
               	vpermilpd	$0x0, %xmm1, %xmm0 # xmm0 = xmm1[0,0]
               	movq	%xmm0, %r15
               	movsd	0x178(%rsp), %xmm0
               	movups	%xmm1, 0xf0(%rsp)
               	movq	%rbx, %rdi
               	callq	<addr>
               	movups	0xf0(%rsp), %xmm1
               	movq	%xmm0, %rax
               	movl	$0x1, %ecx
               	testl	%r13d, %r13d
               	setne	%dl
               	movzbq	%dl, %rdx
               	cmpq	%rax, %r15
               	cmoveq	%rdx, %rcx
               	orq	%rcx, %r14
               	vpermilpd	$0x1, %xmm1, %xmm0 # xmm0 = xmm1[1,0]
               	movq	%xmm0, %r13
               	movsd	0x170(%rsp), %xmm0
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%xmm0, %rax
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
               	subq	$0x178, %rsp            # imm = 0x178
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rcx
               	shrq	$0xc, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
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
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
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
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
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
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
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
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
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
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
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
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
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
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
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
               	movups	-0x120(%rbp), %xmm14
               	movups	%xmm14, 0x60(%rsp)
               	movups	-0x110(%rbp), %xmm14
               	movups	%xmm14, 0x50(%rsp)
               	xorl	%ebx, %ebx
               	movq	%rbx, %rax
               	jmp	<addr>
               	movss	%xmm0, (%rdx)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	leaq	-0x80(%rbp), %rdx
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rdx
               	movl	$0xff, %esi
               	leaq	0x4(%rax), %rdi
               	sarxq	%rdi, %rsi, %rsi
               	testb	$0x1, %sil
               	je	<addr>
               	leaq	-0x120(%rbp), %rsi
               	addq	%rcx, %rsi
               	movss	(%rsi), %xmm0
               	leaq	-0x110(%rbp), %rsi
               	addq	%rsi, %rcx
               	movss	(%rcx), %xmm1
               	mulss	%xmm1, %xmm0
               	jmp	<addr>
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm0
               	jmp	<addr>
               	xorl	%eax, %eax
               	movss	-0x80(%rbp), %xmm0
               	movss	-0x7c(%rbp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	-0x78(%rbp), %xmm1
               	movss	-0x74(%rbp), %xmm2
               	addss	%xmm2, %xmm1
               	addss	%xmm1, %xmm0
               	jmp	<addr>
               	movss	%xmm1, (%rcx)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	leaq	-0x100(%rbp), %rcx
               	movq	%rax, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %rcx
               	movl	$0xff, %edx
               	sarxq	%rax, %rdx, %rdx
               	testb	$0x1, %dl
               	je	<addr>
               	movapd	%xmm0, %xmm1
               	jmp	<addr>
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm1
               	jmp	<addr>
               	leaq	-0x150(%rbp), %rsi
               	movups	0x60(%rsp), %xmm14
               	movups	%xmm14, -0x150(%rbp)
               	movups	0x50(%rsp), %xmm14
               	movups	%xmm14, -0x160(%rbp)
               	movl	$0xff, %edx
               	xorl	%eax, %eax
               	jmp	<addr>
               	movss	%xmm0, (%rdi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	leaq	-0xf0(%rbp), %rdi
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rdi
               	leaq	0x4(%rax), %r8
               	sarxq	%r8, %rdx, %r8
               	testb	$0x1, %r8b
               	je	<addr>
               	leaq	(%rsi,%rcx), %r8
               	movss	(%r8), %xmm0
               	leaq	-0x160(%rbp), %r8
               	addq	%r8, %rcx
               	movss	(%rcx), %xmm1
               	mulss	%xmm1, %xmm0
               	jmp	<addr>
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm0
               	jmp	<addr>
               	xorl	%eax, %eax
               	movss	-0xf0(%rbp), %xmm0
               	movss	-0xec(%rbp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	-0xe8(%rbp), %xmm1
               	movss	-0xe4(%rbp), %xmm2
               	addss	%xmm2, %xmm1
               	addss	%xmm1, %xmm0
               	jmp	<addr>
               	movss	%xmm1, (%rcx)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	leaq	-0x150(%rbp), %rcx
               	movq	%rax, %rsi
               	shlq	$0x2, %rsi
               	addq	%rsi, %rcx
               	sarxq	%rax, %rdx, %rsi
               	testb	$0x1, %sil
               	je	<addr>
               	movapd	%xmm0, %xmm1
               	jmp	<addr>
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm1
               	jmp	<addr>
               	movups	-0x150(%rbp), %xmm0
               	movups	%xmm0, -0x170(%rbp)
               	xorl	%r12d, %r12d
               	leaq	-0x170(%rbp), %rax
               	movq	%r12, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	movss	(%rax), %xmm0
               	callq	<addr>
               	movq	%rax, %r13
               	leaq	-0x100(%rbp), %rax
               	movq	%r12, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	movss	(%rax), %xmm0
               	callq	<addr>
               	movl	$0x10, %ecx
               	cmpl	%eax, %r13d
               	cmovneq	%rcx, %rbx
               	incq	%r12
               	cmpl	$0x4, %r12d
               	jl	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movss	%xmm0, (%rdx)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	leaq	-0x70(%rbp), %rdx
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rdx
               	movl	$0xf1, %esi
               	leaq	0x4(%rax), %rdi
               	sarxq	%rdi, %rsi, %rsi
               	testb	$0x1, %sil
               	je	<addr>
               	leaq	-0x120(%rbp), %rsi
               	addq	%rcx, %rsi
               	movss	(%rsi), %xmm0
               	leaq	-0x110(%rbp), %rsi
               	addq	%rsi, %rcx
               	movss	(%rcx), %xmm1
               	mulss	%xmm1, %xmm0
               	jmp	<addr>
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm0
               	jmp	<addr>
               	xorl	%eax, %eax
               	movss	-0x70(%rbp), %xmm0
               	movss	-0x6c(%rbp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	-0x68(%rbp), %xmm1
               	movss	-0x64(%rbp), %xmm2
               	addss	%xmm2, %xmm1
               	addss	%xmm1, %xmm0
               	jmp	<addr>
               	movss	%xmm1, (%rcx)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	leaq	-0x100(%rbp), %rcx
               	movq	%rax, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %rcx
               	movl	$0xf1, %edx
               	sarxq	%rax, %rdx, %rdx
               	testb	$0x1, %dl
               	je	<addr>
               	movapd	%xmm0, %xmm1
               	jmp	<addr>
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm1
               	jmp	<addr>
               	leaq	-0x150(%rbp), %rsi
               	movups	0x60(%rsp), %xmm14
               	movups	%xmm14, -0x150(%rbp)
               	movups	0x50(%rsp), %xmm14
               	movups	%xmm14, -0x160(%rbp)
               	movl	$0xf1, %edx
               	xorl	%eax, %eax
               	jmp	<addr>
               	movss	%xmm0, (%rdi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	leaq	-0xf0(%rbp), %rdi
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rdi
               	leaq	0x4(%rax), %r8
               	sarxq	%r8, %rdx, %r8
               	testb	$0x1, %r8b
               	je	<addr>
               	leaq	(%rsi,%rcx), %r8
               	movss	(%r8), %xmm0
               	leaq	-0x160(%rbp), %r8
               	addq	%r8, %rcx
               	movss	(%rcx), %xmm1
               	mulss	%xmm1, %xmm0
               	jmp	<addr>
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm0
               	jmp	<addr>
               	xorl	%eax, %eax
               	movss	-0xf0(%rbp), %xmm0
               	movss	-0xec(%rbp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	-0xe8(%rbp), %xmm1
               	movss	-0xe4(%rbp), %xmm2
               	addss	%xmm2, %xmm1
               	addss	%xmm1, %xmm0
               	jmp	<addr>
               	movss	%xmm1, (%rcx)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	leaq	-0x150(%rbp), %rcx
               	movq	%rax, %rsi
               	shlq	$0x2, %rsi
               	addq	%rsi, %rcx
               	sarxq	%rax, %rdx, %rsi
               	testb	$0x1, %sil
               	je	<addr>
               	movapd	%xmm0, %xmm1
               	jmp	<addr>
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm1
               	jmp	<addr>
               	movups	-0x150(%rbp), %xmm0
               	movups	%xmm0, -0x170(%rbp)
               	xorl	%r12d, %r12d
               	leaq	-0x170(%rbp), %rax
               	movq	%r12, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	movss	(%rax), %xmm0
               	callq	<addr>
               	movq	%rax, %r13
               	leaq	-0x100(%rbp), %rax
               	movq	%r12, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	movss	(%rax), %xmm0
               	callq	<addr>
               	movl	$0x10, %ecx
               	cmpl	%eax, %r13d
               	cmovneq	%rcx, %rbx
               	incq	%r12
               	cmpl	$0x4, %r12d
               	jl	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movss	%xmm0, (%rdx)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	leaq	-0x60(%rbp), %rdx
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rdx
               	movl	$0x7f, %esi
               	leaq	0x4(%rax), %rdi
               	sarxq	%rdi, %rsi, %rsi
               	testb	$0x1, %sil
               	je	<addr>
               	leaq	-0x120(%rbp), %rsi
               	addq	%rcx, %rsi
               	movss	(%rsi), %xmm0
               	leaq	-0x110(%rbp), %rsi
               	addq	%rsi, %rcx
               	movss	(%rcx), %xmm1
               	mulss	%xmm1, %xmm0
               	jmp	<addr>
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm0
               	jmp	<addr>
               	xorl	%eax, %eax
               	movss	-0x60(%rbp), %xmm0
               	movss	-0x5c(%rbp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	-0x58(%rbp), %xmm1
               	movss	-0x54(%rbp), %xmm2
               	addss	%xmm2, %xmm1
               	addss	%xmm1, %xmm0
               	jmp	<addr>
               	movss	%xmm1, (%rcx)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	leaq	-0x100(%rbp), %rcx
               	movq	%rax, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %rcx
               	movl	$0x7f, %edx
               	sarxq	%rax, %rdx, %rdx
               	testb	$0x1, %dl
               	je	<addr>
               	movapd	%xmm0, %xmm1
               	jmp	<addr>
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm1
               	jmp	<addr>
               	leaq	-0x150(%rbp), %rsi
               	movups	0x60(%rsp), %xmm14
               	movups	%xmm14, -0x150(%rbp)
               	movups	0x50(%rsp), %xmm14
               	movups	%xmm14, -0x160(%rbp)
               	movl	$0x7f, %edx
               	xorl	%eax, %eax
               	jmp	<addr>
               	movss	%xmm0, (%rdi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	leaq	-0xf0(%rbp), %rdi
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rdi
               	leaq	0x4(%rax), %r8
               	sarxq	%r8, %rdx, %r8
               	testb	$0x1, %r8b
               	je	<addr>
               	leaq	(%rsi,%rcx), %r8
               	movss	(%r8), %xmm0
               	leaq	-0x160(%rbp), %r8
               	addq	%r8, %rcx
               	movss	(%rcx), %xmm1
               	mulss	%xmm1, %xmm0
               	jmp	<addr>
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm0
               	jmp	<addr>
               	xorl	%eax, %eax
               	movss	-0xf0(%rbp), %xmm0
               	movss	-0xec(%rbp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	-0xe8(%rbp), %xmm1
               	movss	-0xe4(%rbp), %xmm2
               	addss	%xmm2, %xmm1
               	addss	%xmm1, %xmm0
               	jmp	<addr>
               	movss	%xmm1, (%rcx)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	leaq	-0x150(%rbp), %rcx
               	movq	%rax, %rsi
               	shlq	$0x2, %rsi
               	addq	%rsi, %rcx
               	sarxq	%rax, %rdx, %rsi
               	testb	$0x1, %sil
               	je	<addr>
               	movapd	%xmm0, %xmm1
               	jmp	<addr>
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm1
               	jmp	<addr>
               	movups	-0x150(%rbp), %xmm0
               	movups	%xmm0, -0x170(%rbp)
               	xorl	%r12d, %r12d
               	leaq	-0x170(%rbp), %rax
               	movq	%r12, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	movss	(%rax), %xmm0
               	callq	<addr>
               	movq	%rax, %r13
               	leaq	-0x100(%rbp), %rax
               	movq	%r12, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	movss	(%rax), %xmm0
               	callq	<addr>
               	movl	$0x10, %ecx
               	cmpl	%eax, %r13d
               	cmovneq	%rcx, %rbx
               	incq	%r12
               	cmpl	$0x4, %r12d
               	jl	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movss	%xmm0, (%rdx)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	leaq	-0x50(%rbp), %rdx
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rdx
               	movl	$0x3c, %esi
               	leaq	0x4(%rax), %rdi
               	sarxq	%rdi, %rsi, %rsi
               	testb	$0x1, %sil
               	je	<addr>
               	leaq	-0x120(%rbp), %rsi
               	addq	%rcx, %rsi
               	movss	(%rsi), %xmm0
               	leaq	-0x110(%rbp), %rsi
               	addq	%rsi, %rcx
               	movss	(%rcx), %xmm1
               	mulss	%xmm1, %xmm0
               	jmp	<addr>
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm0
               	jmp	<addr>
               	xorl	%eax, %eax
               	movss	-0x50(%rbp), %xmm0
               	movss	-0x4c(%rbp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	-0x48(%rbp), %xmm1
               	movss	-0x44(%rbp), %xmm2
               	addss	%xmm2, %xmm1
               	addss	%xmm1, %xmm0
               	jmp	<addr>
               	movss	%xmm1, (%rcx)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	leaq	-0x100(%rbp), %rcx
               	movq	%rax, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %rcx
               	movl	$0x3c, %edx
               	sarxq	%rax, %rdx, %rdx
               	testb	$0x1, %dl
               	je	<addr>
               	movapd	%xmm0, %xmm1
               	jmp	<addr>
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm1
               	jmp	<addr>
               	leaq	-0x150(%rbp), %rsi
               	movups	0x60(%rsp), %xmm14
               	movups	%xmm14, -0x150(%rbp)
               	movups	0x50(%rsp), %xmm14
               	movups	%xmm14, -0x160(%rbp)
               	movl	$0x3c, %edx
               	xorl	%eax, %eax
               	jmp	<addr>
               	movss	%xmm0, (%rdi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	leaq	-0xf0(%rbp), %rdi
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rdi
               	leaq	0x4(%rax), %r8
               	sarxq	%r8, %rdx, %r8
               	testb	$0x1, %r8b
               	je	<addr>
               	leaq	(%rsi,%rcx), %r8
               	movss	(%r8), %xmm0
               	leaq	-0x160(%rbp), %r8
               	addq	%r8, %rcx
               	movss	(%rcx), %xmm1
               	mulss	%xmm1, %xmm0
               	jmp	<addr>
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm0
               	jmp	<addr>
               	xorl	%eax, %eax
               	movss	-0xf0(%rbp), %xmm0
               	movss	-0xec(%rbp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	-0xe8(%rbp), %xmm1
               	movss	-0xe4(%rbp), %xmm2
               	addss	%xmm2, %xmm1
               	addss	%xmm1, %xmm0
               	jmp	<addr>
               	movss	%xmm1, (%rcx)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	leaq	-0x150(%rbp), %rcx
               	movq	%rax, %rsi
               	shlq	$0x2, %rsi
               	addq	%rsi, %rcx
               	sarxq	%rax, %rdx, %rsi
               	testb	$0x1, %sil
               	je	<addr>
               	movapd	%xmm0, %xmm1
               	jmp	<addr>
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm1
               	jmp	<addr>
               	movups	-0x150(%rbp), %xmm0
               	movups	%xmm0, -0x170(%rbp)
               	xorl	%r12d, %r12d
               	leaq	-0x170(%rbp), %rax
               	movq	%r12, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	movss	(%rax), %xmm0
               	callq	<addr>
               	movq	%rax, %r13
               	leaq	-0x100(%rbp), %rax
               	movq	%r12, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	movss	(%rax), %xmm0
               	callq	<addr>
               	movl	$0x10, %ecx
               	cmpl	%eax, %r13d
               	cmovneq	%rcx, %rbx
               	incq	%r12
               	cmpl	$0x4, %r12d
               	jl	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movss	%xmm0, (%rdx)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	leaq	-0x40(%rbp), %rdx
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rdx
               	movl	$0xa5, %esi
               	leaq	0x4(%rax), %rdi
               	sarxq	%rdi, %rsi, %rsi
               	testb	$0x1, %sil
               	je	<addr>
               	leaq	-0x120(%rbp), %rsi
               	addq	%rcx, %rsi
               	movss	(%rsi), %xmm0
               	leaq	-0x110(%rbp), %rsi
               	addq	%rsi, %rcx
               	movss	(%rcx), %xmm1
               	mulss	%xmm1, %xmm0
               	jmp	<addr>
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm0
               	jmp	<addr>
               	xorl	%eax, %eax
               	movss	-0x40(%rbp), %xmm0
               	movss	-0x3c(%rbp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	-0x38(%rbp), %xmm1
               	movss	-0x34(%rbp), %xmm2
               	addss	%xmm2, %xmm1
               	addss	%xmm1, %xmm0
               	jmp	<addr>
               	movss	%xmm1, (%rcx)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	leaq	-0x100(%rbp), %rcx
               	movq	%rax, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %rcx
               	movl	$0xa5, %edx
               	sarxq	%rax, %rdx, %rdx
               	testb	$0x1, %dl
               	je	<addr>
               	movapd	%xmm0, %xmm1
               	jmp	<addr>
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm1
               	jmp	<addr>
               	leaq	-0x150(%rbp), %rsi
               	movups	0x60(%rsp), %xmm14
               	movups	%xmm14, -0x150(%rbp)
               	movups	0x50(%rsp), %xmm14
               	movups	%xmm14, -0x160(%rbp)
               	movl	$0xa5, %edx
               	xorl	%eax, %eax
               	jmp	<addr>
               	movss	%xmm0, (%rdi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	leaq	-0xf0(%rbp), %rdi
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rdi
               	leaq	0x4(%rax), %r8
               	sarxq	%r8, %rdx, %r8
               	testb	$0x1, %r8b
               	je	<addr>
               	leaq	(%rsi,%rcx), %r8
               	movss	(%r8), %xmm0
               	leaq	-0x160(%rbp), %r8
               	addq	%r8, %rcx
               	movss	(%rcx), %xmm1
               	mulss	%xmm1, %xmm0
               	jmp	<addr>
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm0
               	jmp	<addr>
               	xorl	%eax, %eax
               	movss	-0xf0(%rbp), %xmm0
               	movss	-0xec(%rbp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	-0xe8(%rbp), %xmm1
               	movss	-0xe4(%rbp), %xmm2
               	addss	%xmm2, %xmm1
               	addss	%xmm1, %xmm0
               	jmp	<addr>
               	movss	%xmm1, (%rcx)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	leaq	-0x150(%rbp), %rcx
               	movq	%rax, %rsi
               	shlq	$0x2, %rsi
               	addq	%rsi, %rcx
               	sarxq	%rax, %rdx, %rsi
               	testb	$0x1, %sil
               	je	<addr>
               	movapd	%xmm0, %xmm1
               	jmp	<addr>
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm1
               	jmp	<addr>
               	movups	-0x150(%rbp), %xmm0
               	movups	%xmm0, -0x170(%rbp)
               	xorl	%r12d, %r12d
               	leaq	-0x170(%rbp), %rax
               	movq	%r12, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	movss	(%rax), %xmm0
               	callq	<addr>
               	movq	%rax, %r13
               	leaq	-0x100(%rbp), %rax
               	movq	%r12, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	movss	(%rax), %xmm0
               	callq	<addr>
               	movl	$0x10, %ecx
               	cmpl	%eax, %r13d
               	cmovneq	%rcx, %rbx
               	incq	%r12
               	cmpl	$0x4, %r12d
               	jl	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movss	%xmm0, (%rdx)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	leaq	-0x30(%rbp), %rdx
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rdx
               	movl	$0xf, %esi
               	leaq	0x4(%rax), %rdi
               	sarxq	%rdi, %rsi, %rsi
               	testb	$0x1, %sil
               	je	<addr>
               	leaq	-0x120(%rbp), %rsi
               	addq	%rcx, %rsi
               	movss	(%rsi), %xmm0
               	leaq	-0x110(%rbp), %rsi
               	addq	%rsi, %rcx
               	movss	(%rcx), %xmm1
               	mulss	%xmm1, %xmm0
               	jmp	<addr>
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm0
               	jmp	<addr>
               	xorl	%eax, %eax
               	movss	-0x30(%rbp), %xmm0
               	movss	-0x2c(%rbp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	-0x28(%rbp), %xmm1
               	movss	-0x24(%rbp), %xmm2
               	addss	%xmm2, %xmm1
               	addss	%xmm1, %xmm0
               	jmp	<addr>
               	movss	%xmm1, (%rcx)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	leaq	-0x100(%rbp), %rcx
               	movq	%rax, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %rcx
               	movl	$0xf, %edx
               	sarxq	%rax, %rdx, %rdx
               	testb	$0x1, %dl
               	je	<addr>
               	movapd	%xmm0, %xmm1
               	jmp	<addr>
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm1
               	jmp	<addr>
               	leaq	-0x150(%rbp), %rsi
               	movups	0x60(%rsp), %xmm14
               	movups	%xmm14, -0x150(%rbp)
               	movups	0x50(%rsp), %xmm14
               	movups	%xmm14, -0x160(%rbp)
               	movl	$0xf, %edx
               	xorl	%eax, %eax
               	jmp	<addr>
               	movss	%xmm0, (%rdi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	leaq	-0xf0(%rbp), %rdi
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rdi
               	leaq	0x4(%rax), %r8
               	sarxq	%r8, %rdx, %r8
               	testb	$0x1, %r8b
               	je	<addr>
               	leaq	(%rsi,%rcx), %r8
               	movss	(%r8), %xmm0
               	leaq	-0x160(%rbp), %r8
               	addq	%r8, %rcx
               	movss	(%rcx), %xmm1
               	mulss	%xmm1, %xmm0
               	jmp	<addr>
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm0
               	jmp	<addr>
               	xorl	%eax, %eax
               	movss	-0xf0(%rbp), %xmm0
               	movss	-0xec(%rbp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	-0xe8(%rbp), %xmm1
               	movss	-0xe4(%rbp), %xmm2
               	addss	%xmm2, %xmm1
               	addss	%xmm1, %xmm0
               	jmp	<addr>
               	movss	%xmm1, (%rcx)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	leaq	-0x150(%rbp), %rcx
               	movq	%rax, %rsi
               	shlq	$0x2, %rsi
               	addq	%rsi, %rcx
               	sarxq	%rax, %rdx, %rsi
               	testb	$0x1, %sil
               	je	<addr>
               	movapd	%xmm0, %xmm1
               	jmp	<addr>
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm1
               	jmp	<addr>
               	movups	-0x150(%rbp), %xmm0
               	movups	%xmm0, -0x170(%rbp)
               	xorl	%r12d, %r12d
               	leaq	-0x170(%rbp), %rax
               	movq	%r12, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	movss	(%rax), %xmm0
               	callq	<addr>
               	movq	%rax, %r13
               	leaq	-0x100(%rbp), %rax
               	movq	%r12, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	movss	(%rax), %xmm0
               	callq	<addr>
               	movl	$0x10, %ecx
               	cmpl	%eax, %r13d
               	cmovneq	%rcx, %rbx
               	incq	%r12
               	cmpl	$0x4, %r12d
               	jl	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movss	%xmm0, (%rdx)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	leaq	-0x20(%rbp), %rdx
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rdx
               	movl	$0xf0, %esi
               	leaq	0x4(%rax), %rdi
               	sarxq	%rdi, %rsi, %rsi
               	testb	$0x1, %sil
               	je	<addr>
               	leaq	-0x120(%rbp), %rsi
               	addq	%rcx, %rsi
               	movss	(%rsi), %xmm0
               	leaq	-0x110(%rbp), %rsi
               	addq	%rsi, %rcx
               	movss	(%rcx), %xmm1
               	mulss	%xmm1, %xmm0
               	jmp	<addr>
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm0
               	jmp	<addr>
               	xorl	%eax, %eax
               	movss	-0x20(%rbp), %xmm0
               	movss	-0x1c(%rbp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	-0x18(%rbp), %xmm1
               	movss	-0x14(%rbp), %xmm2
               	addss	%xmm2, %xmm1
               	addss	%xmm1, %xmm0
               	jmp	<addr>
               	movss	%xmm1, (%rcx)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	leaq	-0x100(%rbp), %rcx
               	movq	%rax, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %rcx
               	movl	$0xf0, %edx
               	sarxq	%rax, %rdx, %rdx
               	testb	$0x1, %dl
               	je	<addr>
               	movapd	%xmm0, %xmm1
               	jmp	<addr>
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm1
               	jmp	<addr>
               	leaq	-0x150(%rbp), %rsi
               	movups	0x60(%rsp), %xmm14
               	movups	%xmm14, -0x150(%rbp)
               	movups	0x50(%rsp), %xmm14
               	movups	%xmm14, -0x160(%rbp)
               	movl	$0xf0, %edx
               	xorl	%eax, %eax
               	jmp	<addr>
               	movss	%xmm0, (%rdi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	leaq	-0xf0(%rbp), %rdi
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rdi
               	leaq	0x4(%rax), %r8
               	sarxq	%r8, %rdx, %r8
               	testb	$0x1, %r8b
               	je	<addr>
               	leaq	(%rsi,%rcx), %r8
               	movss	(%r8), %xmm0
               	leaq	-0x160(%rbp), %r8
               	addq	%r8, %rcx
               	movss	(%rcx), %xmm1
               	mulss	%xmm1, %xmm0
               	jmp	<addr>
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm0
               	jmp	<addr>
               	xorl	%eax, %eax
               	movss	-0xf0(%rbp), %xmm0
               	movss	-0xec(%rbp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	-0xe8(%rbp), %xmm1
               	movss	-0xe4(%rbp), %xmm2
               	addss	%xmm2, %xmm1
               	addss	%xmm1, %xmm0
               	jmp	<addr>
               	movss	%xmm1, (%rcx)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	leaq	-0x150(%rbp), %rcx
               	movq	%rax, %rsi
               	shlq	$0x2, %rsi
               	addq	%rsi, %rcx
               	sarxq	%rax, %rdx, %rsi
               	testb	$0x1, %sil
               	je	<addr>
               	movapd	%xmm0, %xmm1
               	jmp	<addr>
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm1
               	jmp	<addr>
               	movups	-0x150(%rbp), %xmm0
               	movups	%xmm0, -0x170(%rbp)
               	xorl	%r12d, %r12d
               	leaq	-0x170(%rbp), %rax
               	movq	%r12, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	movss	(%rax), %xmm0
               	callq	<addr>
               	movq	%rax, %r13
               	leaq	-0x100(%rbp), %rax
               	movq	%r12, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	movss	(%rax), %xmm0
               	callq	<addr>
               	movl	$0x10, %ecx
               	cmpl	%eax, %r13d
               	cmovneq	%rcx, %rbx
               	incq	%r12
               	cmpl	$0x4, %r12d
               	jl	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movss	%xmm0, (%rdx)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	leaq	-0x10(%rbp), %rdx
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rdx
               	movl	$0x82, %esi
               	leaq	0x4(%rax), %rdi
               	sarxq	%rdi, %rsi, %rsi
               	testb	$0x1, %sil
               	je	<addr>
               	leaq	-0x120(%rbp), %rsi
               	addq	%rcx, %rsi
               	movss	(%rsi), %xmm0
               	leaq	-0x110(%rbp), %rsi
               	addq	%rsi, %rcx
               	movss	(%rcx), %xmm1
               	mulss	%xmm1, %xmm0
               	jmp	<addr>
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm0
               	jmp	<addr>
               	xorl	%eax, %eax
               	movss	-0x10(%rbp), %xmm0
               	movss	-0xc(%rbp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	-0x8(%rbp), %xmm1
               	movss	-0x4(%rbp), %xmm2
               	addss	%xmm2, %xmm1
               	addss	%xmm1, %xmm0
               	jmp	<addr>
               	movss	%xmm1, (%rcx)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	leaq	-0x100(%rbp), %rcx
               	movq	%rax, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %rcx
               	movl	$0x82, %edx
               	sarxq	%rax, %rdx, %rdx
               	testb	$0x1, %dl
               	je	<addr>
               	movapd	%xmm0, %xmm1
               	jmp	<addr>
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm1
               	jmp	<addr>
               	leaq	-0x150(%rbp), %rsi
               	movups	0x60(%rsp), %xmm14
               	movups	%xmm14, -0x150(%rbp)
               	movups	0x50(%rsp), %xmm14
               	movups	%xmm14, -0x160(%rbp)
               	movl	$0x82, %edx
               	xorl	%eax, %eax
               	jmp	<addr>
               	movss	%xmm0, (%rdi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	leaq	-0xf0(%rbp), %rdi
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rdi
               	leaq	0x4(%rax), %r8
               	sarxq	%r8, %rdx, %r8
               	testb	$0x1, %r8b
               	je	<addr>
               	leaq	(%rsi,%rcx), %r8
               	movss	(%r8), %xmm0
               	leaq	-0x160(%rbp), %r8
               	addq	%r8, %rcx
               	movss	(%rcx), %xmm1
               	mulss	%xmm1, %xmm0
               	jmp	<addr>
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm0
               	jmp	<addr>
               	xorl	%eax, %eax
               	movss	-0xf0(%rbp), %xmm0
               	movss	-0xec(%rbp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	-0xe8(%rbp), %xmm1
               	movss	-0xe4(%rbp), %xmm2
               	addss	%xmm2, %xmm1
               	addss	%xmm1, %xmm0
               	jmp	<addr>
               	movss	%xmm1, (%rcx)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	leaq	-0x150(%rbp), %rcx
               	movq	%rax, %rsi
               	shlq	$0x2, %rsi
               	addq	%rsi, %rcx
               	sarxq	%rax, %rdx, %rsi
               	testb	$0x1, %sil
               	je	<addr>
               	movapd	%xmm0, %xmm1
               	jmp	<addr>
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm1
               	jmp	<addr>
               	movups	-0x150(%rbp), %xmm0
               	movups	%xmm0, -0x160(%rbp)
               	xorl	%r12d, %r12d
               	leaq	-0x160(%rbp), %rax
               	movq	%r12, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	movss	(%rax), %xmm0
               	callq	<addr>
               	movq	%rax, %r13
               	leaq	-0x100(%rbp), %rax
               	movq	%r12, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	movss	(%rax), %xmm0
               	callq	<addr>
               	movl	$0x10, %ecx
               	cmpl	%eax, %r13d
               	cmovneq	%rcx, %rbx
               	incq	%r12
               	cmpl	$0x4, %r12d
               	jl	<addr>
               	movss	-0x120(%rbp), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movss	-0x11c(%rbp), %xmm1
               	movabsq	$0x3f50624dd2f1a9fc, %rax # imm = 0x3F50624DD2F1A9FC
               	cvtss2sd	%xmm1, %xmm1
               	movq	%rax, %xmm15
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
               	vaddsd	%xmm5, %xmm4, %xmm5
               	movapd	%xmm0, %xmm4
               	movapd	%xmm2, %xmm6
               	mulsd	%xmm6, %xmm4
               	movapd	%xmm1, %xmm6
               	movapd	%xmm3, %xmm7
               	mulsd	%xmm7, %xmm6
               	addsd	%xmm6, %xmm4
               	movapd	%xmm4, %xmm6
               	movq	%xmm6, %rcx
               	movq	%xmm5, %rax
               	cmpq	%rax, %rcx
               	jne	<addr>
               	movq	%xmm4, %rcx
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x10, %ebx
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
               	movq	%xmm5, %rcx
               	movq	%xmm4, %rdx
               	cmpq	%rdx, %rcx
               	jne	<addr>
               	movapd	%xmm6, %xmm4
               	movq	%xmm4, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x10, %ebx
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
               	movq	%xmm6, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	%xmm5, %rcx
               	movq	%xmm4, %rdx
               	cmpq	%rdx, %rcx
               	je	<addr>
               	movl	$0x10, %ebx
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
               	movq	%xmm6, %rax
               	movq	%xmm4, %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movq	%xmm5, %rax
               	movq	%xmm4, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x10, %ebx
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
               	movq	%xmm6, %rax
               	movq	%xmm4, %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movq	%xmm5, %rax
               	movq	%xmm4, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x10, %ebx
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
               	movq	%xmm0, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movapd	%xmm1, %xmm0
               	movq	%xmm0, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x10, %ebx
               	movq	%rbx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
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
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x1b, %rcx
               	xorq	%rcx, %rax
               	movabsq	$0x2545f4914f6cdd1d, %rcx # imm = 0x2545F4914F6CDD1D
               	imulq	%rax, %rcx
               	vmovd	%ecx, %xmm0
               	movq	%rax, %rcx
               	shrq	$0xc, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x1b, %rcx
               	xorq	%rcx, %rax
               	movabsq	$0x2545f4914f6cdd1d, %rbx # imm = 0x2545F4914F6CDD1D
               	imulq	%rax, %rbx
               	shrq	$0x7, %rbx
               	movq	%rax, %rcx
               	shrq	$0xc, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x1b, %rcx
               	xorq	%rcx, %rax
               	movabsq	$0x2545f4914f6cdd1d, %rcx # imm = 0x2545F4914F6CDD1D
               	imulq	%rax, %rcx
               	vpinsrd	$0x1, %ecx, %xmm0, %xmm0
               	movq	%rax, %rcx
               	shrq	$0xc, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x1b, %rcx
               	xorq	%rcx, %rax
               	movabsq	$0x2545f4914f6cdd1d, %r14 # imm = 0x2545F4914F6CDD1D
               	imulq	%rax, %r14
               	shrq	$0x7, %r14
               	movq	%rax, %rcx
               	shrq	$0xc, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x1b, %rcx
               	xorq	%rcx, %rax
               	movabsq	$0x2545f4914f6cdd1d, %rcx # imm = 0x2545F4914F6CDD1D
               	imulq	%rax, %rcx
               	vpinsrd	$0x2, %ecx, %xmm0, %xmm0
               	movq	%rax, %rcx
               	shrq	$0xc, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
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
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x1b, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rax
               	vpinsrd	$0x3, %eax, %xmm0, %xmm0
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rcx
               	shrq	$0xc, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x1b, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r13 # imm = 0x2545F4914F6CDD1D
               	imulq	%rax, %r13
               	shrq	$0x7, %r13
               	movups	%xmm0, -0x20(%rbp)
               	xorl	%eax, %eax
               	movl	%ebx, -0x20(%rbp)
               	jmp	<addr>
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	xorl	%ecx, %ecx
               	sarxq	%rax, %rcx, %rcx
               	testb	$0x1, %cl
               	je	<addr>
               	movl	$0x0, -0x20(%rbp,%rax,4)
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movups	%xmm0, -0x40(%rbp)
               	movl	%ebx, -0x40(%rbp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	sarxq	%rax, %rcx, %rdx
               	testb	$0x1, %dl
               	je	<addr>
               	movl	$0x0, -0x40(%rbp,%rax,4)
               	jmp	<addr>
               	movups	-0x40(%rbp), %xmm1
               	movups	%xmm1, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rdi
               	leaq	-0x20(%rbp), %rsi
               	movl	$0x10, %edx
               	movups	%xmm0, 0x40(%rsp)
               	callq	<addr>
               	movslq	%eax, %rax
               	movups	0x40(%rsp), %xmm0
               	movl	$0x20, %ecx
               	xorl	%edx, %edx
               	testq	%rax, %rax
               	movq	%rdx, %r15
               	cmovneq	%rcx, %r15
               	movups	%xmm0, -0x20(%rbp)
               	xorl	%eax, %eax
               	movl	%ebx, -0x1c(%rbp)
               	jmp	<addr>
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movl	$0x10, %ecx
               	sarxq	%rax, %rcx, %rcx
               	testb	$0x1, %cl
               	je	<addr>
               	movl	$0x0, -0x20(%rbp,%rax,4)
               	jmp	<addr>
               	movl	$0x10, %ecx
               	movups	%xmm0, -0x40(%rbp)
               	movl	%ebx, -0x3c(%rbp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	sarxq	%rax, %rcx, %rdx
               	testb	$0x1, %dl
               	je	<addr>
               	movl	$0x0, -0x40(%rbp,%rax,4)
               	jmp	<addr>
               	movups	-0x40(%rbp), %xmm1
               	movups	%xmm1, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rdi
               	leaq	-0x20(%rbp), %rsi
               	movl	$0x10, %edx
               	movups	%xmm0, 0x40(%rsp)
               	callq	<addr>
               	movslq	%eax, %rax
               	movups	0x40(%rsp), %xmm0
               	movl	$0x20, %ecx
               	testq	%rax, %rax
               	cmovneq	%rcx, %r15
               	movups	%xmm0, -0x20(%rbp)
               	movl	%r14d, -0x18(%rbp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movl	$0x6c, %ecx
               	sarxq	%rax, %rcx, %rcx
               	testb	$0x1, %cl
               	je	<addr>
               	movl	$0x0, -0x20(%rbp,%rax,4)
               	jmp	<addr>
               	movl	$0x6c, %ecx
               	movups	%xmm0, -0x40(%rbp)
               	movl	%r14d, -0x38(%rbp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	sarxq	%rax, %rcx, %rdx
               	testb	$0x1, %dl
               	je	<addr>
               	movl	$0x0, -0x40(%rbp,%rax,4)
               	jmp	<addr>
               	movups	-0x40(%rbp), %xmm1
               	movups	%xmm1, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rdi
               	leaq	-0x20(%rbp), %rsi
               	movl	$0x10, %edx
               	movups	%xmm0, 0x40(%rsp)
               	callq	<addr>
               	movslq	%eax, %rax
               	movups	0x40(%rsp), %xmm0
               	movl	$0x20, %ecx
               	testq	%rax, %rax
               	movq	%r15, %r14
               	cmovneq	%rcx, %r14
               	movups	%xmm0, -0x20(%rbp)
               	movl	%r12d, -0x14(%rbp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movl	$0xb1, %ecx
               	sarxq	%rax, %rcx, %rcx
               	testb	$0x1, %cl
               	je	<addr>
               	movl	$0x0, -0x20(%rbp,%rax,4)
               	jmp	<addr>
               	movl	$0xb1, %ecx
               	movups	%xmm0, -0x40(%rbp)
               	movl	%r12d, -0x34(%rbp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	sarxq	%rax, %rcx, %rdx
               	testb	$0x1, %dl
               	je	<addr>
               	movl	$0x0, -0x40(%rbp,%rax,4)
               	jmp	<addr>
               	movups	-0x40(%rbp), %xmm1
               	movups	%xmm1, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rdi
               	leaq	-0x20(%rbp), %rsi
               	movl	$0x10, %edx
               	movups	%xmm0, 0x40(%rsp)
               	callq	<addr>
               	movslq	%eax, %rax
               	movups	0x40(%rsp), %xmm0
               	movl	$0x20, %ecx
               	testq	%rax, %rax
               	cmovneq	%rcx, %r14
               	movups	%xmm0, -0x20(%rbp)
               	movl	%r13d, -0x14(%rbp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movl	$0xf0, %ecx
               	sarxq	%rax, %rcx, %rcx
               	testb	$0x1, %cl
               	je	<addr>
               	movl	$0x0, -0x20(%rbp,%rax,4)
               	jmp	<addr>
               	movl	$0xf0, %ecx
               	movups	%xmm0, -0x40(%rbp)
               	movl	%r13d, -0x34(%rbp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	sarxq	%rax, %rcx, %rdx
               	testb	$0x1, %dl
               	je	<addr>
               	movl	$0x0, -0x40(%rbp,%rax,4)
               	jmp	<addr>
               	movups	-0x40(%rbp), %xmm1
               	movups	%xmm1, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rdi
               	leaq	-0x20(%rbp), %rsi
               	movl	$0x10, %edx
               	movups	%xmm0, 0x40(%rsp)
               	callq	<addr>
               	movslq	%eax, %rax
               	movups	0x40(%rsp), %xmm0
               	movl	$0x20, %ecx
               	testq	%rax, %rax
               	cmovneq	%rcx, %r14
               	movups	%xmm0, -0x20(%rbp)
               	xorl	%eax, %eax
               	movl	%r13d, -0x20(%rbp)
               	jmp	<addr>
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movl	$0xcf, %ecx
               	sarxq	%rax, %rcx, %rcx
               	testb	$0x1, %cl
               	je	<addr>
               	movl	$0x0, -0x20(%rbp,%rax,4)
               	jmp	<addr>
               	movl	$0xcf, %ecx
               	movups	%xmm0, -0x40(%rbp)
               	movl	%r13d, -0x40(%rbp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	sarxq	%rax, %rcx, %rdx
               	testb	$0x1, %dl
               	je	<addr>
               	movl	$0x0, -0x40(%rbp,%rax,4)
               	jmp	<addr>
               	movups	-0x40(%rbp), %xmm1
               	movups	%xmm1, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rdi
               	leaq	-0x20(%rbp), %rsi
               	movl	$0x10, %edx
               	movups	%xmm0, 0x40(%rsp)
               	callq	<addr>
               	movslq	%eax, %rax
               	movups	0x40(%rsp), %xmm0
               	movl	$0x20, %ecx
               	testq	%rax, %rax
               	movq	%r14, %r13
               	cmovneq	%rcx, %r13
               	movups	%xmm0, -0x20(%rbp)
               	xorl	%eax, %eax
               	movl	%ebx, -0x14(%rbp)
               	jmp	<addr>
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movl	$0x3a, %ecx
               	sarxq	%rax, %rcx, %rcx
               	testb	$0x1, %cl
               	je	<addr>
               	movl	$0x0, -0x20(%rbp,%rax,4)
               	jmp	<addr>
               	movl	$0x3a, %ecx
               	movups	%xmm0, -0x40(%rbp)
               	movl	%ebx, -0x34(%rbp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	sarxq	%rax, %rcx, %rdx
               	testb	$0x1, %dl
               	je	<addr>
               	movl	$0x0, -0x40(%rbp,%rax,4)
               	jmp	<addr>
               	movups	-0x40(%rbp), %xmm1
               	leaq	-0x10(%rbp), %rdi
               	movups	%xmm1, -0x10(%rbp)
               	leaq	-0x20(%rbp), %rsi
               	movl	$0x10, %edx
               	movups	%xmm0, 0x40(%rsp)
               	callq	<addr>
               	movslq	%eax, %rax
               	movups	0x40(%rsp), %xmm0
               	movl	$0x20, %ecx
               	testq	%rax, %rax
               	movq	%r13, %rbx
               	cmovneq	%rcx, %rbx
               	movups	%xmm0, -0x20(%rbp)
               	movl	%r12d, -0x1c(%rbp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movl	$0x96, %ecx
               	sarxq	%rax, %rcx, %rcx
               	testb	$0x1, %cl
               	je	<addr>
               	movl	$0x0, -0x20(%rbp,%rax,4)
               	jmp	<addr>
               	movl	$0x96, %ecx
               	movups	%xmm0, -0x40(%rbp)
               	movl	%r12d, -0x3c(%rbp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	sarxq	%rax, %rcx, %rdx
               	testb	$0x1, %dl
               	je	<addr>
               	movl	$0x0, -0x40(%rbp,%rax,4)
               	jmp	<addr>
               	movups	-0x40(%rbp), %xmm0
               	leaq	-0x10(%rbp), %rdi
               	movups	%xmm0, -0x10(%rbp)
               	leaq	-0x20(%rbp), %rsi
               	movl	$0x10, %edx
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
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
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
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
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
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
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
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
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
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
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
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
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
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
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
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
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
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
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
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
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
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
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
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x1b, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rax
               	shrq	$0x11, %rax
               	movl	%eax, -0x24(%rbp)
               	movups	-0x50(%rbp), %xmm14
               	movups	%xmm14, 0x60(%rsp)
               	movups	-0x40(%rbp), %xmm14
               	movups	%xmm14, 0x50(%rsp)
               	movups	-0x30(%rbp), %xmm14
               	movups	%xmm14, 0x40(%rsp)
               	xorl	%edx, %edx
               	movq	%rdx, %rax
               	jmp	<addr>
               	movl	%ecx, -0x20(%rbp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	sarxq	%rax, %rdx, %rcx
               	testb	$0x1, %cl
               	je	<addr>
               	movl	-0x40(%rbp,%rax,4), %ecx
               	jmp	<addr>
               	movl	-0x50(%rbp,%rax,4), %ecx
               	jmp	<addr>
               	movups	0x60(%rsp), %xmm14
               	movups	0x50(%rsp), %xmm15
               	vblendps	$0x0, %xmm15, %xmm14, %xmm0 # xmm0 = xmm14[0,1,2,3]
               	leaq	-0x10(%rbp), %rdi
               	movups	%xmm0, -0x10(%rbp)
               	leaq	-0x20(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x40, %ecx
               	xorl	%edx, %edx
               	testq	%rax, %rax
               	movq	%rdx, %rbx
               	cmovneq	%rcx, %rbx
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	%ecx, -0x20(%rbp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movl	$0x5, %ecx
               	sarxq	%rax, %rcx, %rcx
               	testb	$0x1, %cl
               	je	<addr>
               	movl	-0x40(%rbp,%rax,4), %ecx
               	jmp	<addr>
               	movl	-0x50(%rbp,%rax,4), %ecx
               	jmp	<addr>
               	movups	0x60(%rsp), %xmm14
               	movups	0x50(%rsp), %xmm15
               	vblendps	$0x5, %xmm15, %xmm14, %xmm0 # xmm0 = xmm15[0],xmm14[1],xmm15[2],xmm14[3]
               	leaq	-0x10(%rbp), %rdi
               	movups	%xmm0, -0x10(%rbp)
               	leaq	-0x20(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x40, %ecx
               	testq	%rax, %rax
               	cmovneq	%rcx, %rbx
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	%ecx, -0x20(%rbp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movl	$0xa, %ecx
               	sarxq	%rax, %rcx, %rcx
               	testb	$0x1, %cl
               	je	<addr>
               	movl	-0x40(%rbp,%rax,4), %ecx
               	jmp	<addr>
               	movl	-0x50(%rbp,%rax,4), %ecx
               	jmp	<addr>
               	movups	0x60(%rsp), %xmm14
               	movups	0x50(%rsp), %xmm15
               	vblendps	$0xa, %xmm15, %xmm14, %xmm0 # xmm0 = xmm14[0],xmm15[1],xmm14[2],xmm15[3]
               	leaq	-0x10(%rbp), %rdi
               	movups	%xmm0, -0x10(%rbp)
               	leaq	-0x20(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x40, %ecx
               	testq	%rax, %rax
               	cmovneq	%rcx, %rbx
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	%ecx, -0x20(%rbp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movl	$0xf, %ecx
               	sarxq	%rax, %rcx, %rcx
               	testb	$0x1, %cl
               	je	<addr>
               	movl	-0x40(%rbp,%rax,4), %ecx
               	jmp	<addr>
               	movl	-0x50(%rbp,%rax,4), %ecx
               	jmp	<addr>
               	movups	0x60(%rsp), %xmm14
               	movups	0x50(%rsp), %xmm15
               	vblendps	$0xf, %xmm15, %xmm14, %xmm0 # xmm0 = xmm15[0,1,2,3]
               	leaq	-0x10(%rbp), %rdi
               	movups	%xmm0, -0x10(%rbp)
               	leaq	-0x20(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x40, %ecx
               	testq	%rax, %rax
               	cmovneq	%rcx, %rbx
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	%ecx, -0x20(%rbp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movl	$0x9, %ecx
               	sarxq	%rax, %rcx, %rcx
               	testb	$0x1, %cl
               	je	<addr>
               	movl	-0x40(%rbp,%rax,4), %ecx
               	jmp	<addr>
               	movl	-0x50(%rbp,%rax,4), %ecx
               	jmp	<addr>
               	movups	0x60(%rsp), %xmm14
               	movups	0x50(%rsp), %xmm15
               	vblendps	$0x9, %xmm15, %xmm14, %xmm0 # xmm0 = xmm15[0],xmm14[1,2],xmm15[3]
               	leaq	-0x10(%rbp), %rdi
               	movups	%xmm0, -0x10(%rbp)
               	leaq	-0x20(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x40, %ecx
               	testq	%rax, %rax
               	cmovneq	%rcx, %rbx
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	%ecx, -0x20(%rbp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movl	-0x30(%rbp,%rax,4), %ecx
               	shrq	$0x1f, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	-0x40(%rbp,%rax,4), %ecx
               	jmp	<addr>
               	movl	-0x50(%rbp,%rax,4), %ecx
               	jmp	<addr>
               	movups	0x60(%rsp), %xmm14
               	movups	%xmm14, -0xb0(%rbp)
               	movups	0x50(%rsp), %xmm14
               	movups	%xmm14, -0xa0(%rbp)
               	movups	0x40(%rsp), %xmm14
               	movups	%xmm14, -0x90(%rbp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movl	-0x90(%rbp,%rax,4), %edi
               	testl	%edi, %edi
               	jge	<addr>
               	movl	-0xa0(%rbp,%rax,4), %edi
               	movl	%edi, -0xb0(%rbp,%rax,4)
               	jmp	<addr>
               	movups	-0xb0(%rbp), %xmm0
               	leaq	-0x10(%rbp), %rdi
               	movups	%xmm0, -0x10(%rbp)
               	leaq	-0x20(%rbp), %rsi
               	movl	$0x10, %edx
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
               	movups	0x60(%rsp), %xmm14
               	movups	%xmm14, -0xb0(%rbp)
               	movups	0x50(%rsp), %xmm14
               	movups	%xmm14, -0xa0(%rbp)
               	movups	0x40(%rsp), %xmm14
               	movups	%xmm14, -0x90(%rbp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	incq	%rax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	movq	-0x90(%rbp,%rax,8), %r9
               	testq	%r9, %r9
               	jge	<addr>
               	movq	-0xa0(%rbp,%rax,8), %r9
               	movq	%r9, -0xb0(%rbp,%rax,8)
               	jmp	<addr>
               	movups	-0xb0(%rbp), %xmm0
               	movups	%xmm0, -0x10(%rbp)
               	xorl	%eax, %eax
               	movl	-0x10(%rbp,%rax,4), %edi
               	movq	%rax, %r8
               	orq	$0x1, %r8
               	movl	-0x30(%rbp,%r8,4), %edx
               	shrq	$0x1f, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	-0x40(%rbp,%rax,4), %edx
               	movl	$0x40, %r8d
               	cmpl	%edx, %edi
               	cmovneq	%r8, %rcx
               	jmp	<addr>
               	movl	-0x50(%rbp,%rax,4), %edx
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
