
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
               	movq	%xmm1, %rax
               	movq	%rax, %rcx
               	shrq	$0x34, %rcx
               	andq	$0x7ff, %rcx            # imm = 0x7FF
               	cmpl	$0x7ff, %ecx            # imm = 0x7FF
               	jne	<addr>
               	movabsq	$0x8000000000000, %rcx  # imm = 0x8000000000000
               	xorl	%edx, %edx
               	movabsq	$0xfffffffffffff, %rsi  # imm = 0xFFFFFFFFFFFFF
               	andq	%rax, %rsi
               	testq	%rsi, %rsi
               	cmoveq	%rdx, %rcx
               	orq	%rax, %rcx
               	movq	%rcx, %xmm0
               	retq
               	movsd	<rip>, %xmm0 # <addr>
               	comisd	%xmm0, %xmm1
               	jae	<addr>
               	movsd	<rip>, %xmm0 # <addr>
               	comisd	%xmm1, %xmm0
               	jb	<addr>
               	movapd	%xmm1, %xmm0
               	retq
               	cvttsd2si	%xmm1, %rcx
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rcx, %xmm0
               	subsd	%xmm0, %xmm1
               	testl	%edi, %edi
               	jne	<addr>
               	movsd	<rip>, %xmm2 # <addr>
               	comisd	%xmm2, %xmm1
               	ja	<addr>
               	ucomisd	%xmm2, %xmm1
               	jp	<addr>
               	jne	<addr>
               	testb	$0x1, %cl
               	je	<addr>
               	movsd	<rip>, %xmm1 # <addr>
               	addsd	%xmm1, %xmm0
               	xorps	%xmm1, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	shrq	$0x3f, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%r11, %xmm0
               	retq
               	xorps	%xmm0, %xmm0
               	jmp	<addr>
               	movsd	<rip>, %xmm2 # <addr>
               	comisd	%xmm1, %xmm2
               	ja	<addr>
               	ucomisd	%xmm2, %xmm1
               	jp	<addr>
               	jne	<addr>
               	testb	$0x1, %cl
               	je	<addr>
               	movsd	<rip>, %xmm1 # <addr>
               	subsd	%xmm1, %xmm0
               	jmp	<addr>
               	cmpl	$0x1, %edi
               	jne	<addr>
               	xorps	%xmm2, %xmm2
               	comisd	%xmm1, %xmm2
               	jbe	<addr>
               	movsd	<rip>, %xmm1 # <addr>
               	subsd	%xmm1, %xmm0
               	jmp	<addr>
               	cmpl	$0x2, %edi
               	jne	<addr>
               	xorps	%xmm2, %xmm2
               	comisd	%xmm2, %xmm1
               	jbe	<addr>
               	movsd	<rip>, %xmm1 # <addr>
               	addsd	%xmm1, %xmm0
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
               	subq	$0x1c8, %rsp            # imm = 0x1C8
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
               	movups	%xmm14, 0x1c0(%rsp)
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
               	movups	0x1c0(%rsp), %xmm0
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
               	vpinsrq	$0x1, %rax, %xmm0, %xmm0
               	movq	-0x1a0(%rbp), %rax
               	movq	-0x198(%rbp), %rax
               	roundps	$0x0, %xmm0, %xmm0
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
               	movq	%rax, -0x1c0(%rbp)
               	movq	-0x188(%rbp), %rax
               	movq	%rax, -0x1b8(%rbp)
               	xorl	%ebx, %ebx
               	xorl	%r12d, %r12d
               	leaq	-0x1c0(%rbp), %rax
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
               	movups	0x1c0(%rsp), %xmm0
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
               	vpinsrq	$0x1, %rax, %xmm0, %xmm0
               	movq	-0x170(%rbp), %rax
               	movq	-0x168(%rbp), %rax
               	roundps	$0x1, %xmm0, %xmm0
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
               	movq	%rax, -0x1c0(%rbp)
               	movq	-0x158(%rbp), %rax
               	movq	%rax, -0x1b8(%rbp)
               	xorl	%ebx, %ebx
               	leaq	-0x1c0(%rbp), %rax
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
               	movups	0x1c0(%rsp), %xmm0
               	vmovq	%xmm0, %rax
               	movq	%rax, -0x150(%rbp)
               	vpextrq	$0x1, %xmm0, %rax
               	movq	%rax, -0x148(%rbp)
               	movq	$0x0, -0x140(%rbp)
               	movq	$0x0, -0x138(%rbp)
               	movl	<rip>, %eax # <addr>
               	movl	$0xffff9fc0, %r11d      # imm = 0xFFFF9FC0
               	andq	%r11, %rax
               	orq	$0x6000, %rax           # imm = 0x6000
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	ldmxcsr	(%rax)
               	movq	-0x150(%rbp), %rax
               	vmovq	%rax, %xmm0
               	movq	-0x148(%rbp), %rax
               	vpinsrq	$0x1, %rax, %xmm0, %xmm0
               	movq	-0x140(%rbp), %rax
               	movq	-0x138(%rbp), %rax
               	roundps	$0x2, %xmm0, %xmm0
               	vmovq	%xmm0, %rax
               	movq	%rax, -0x130(%rbp)
               	vpextrq	$0x1, %xmm0, %rax
               	movq	%rax, -0x128(%rbp)
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
               	movq	-0x130(%rbp), %rax
               	movq	%rax, -0x1c0(%rbp)
               	movq	-0x128(%rbp), %rax
               	movq	%rax, -0x1b8(%rbp)
               	xorl	%ebx, %ebx
               	leaq	-0x1c0(%rbp), %rax
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
               	movups	0x1c0(%rsp), %xmm0
               	vmovq	%xmm0, %rax
               	movq	%rax, -0x120(%rbp)
               	vpextrq	$0x1, %xmm0, %rax
               	movq	%rax, -0x118(%rbp)
               	movq	$0x0, -0x110(%rbp)
               	movq	$0x0, -0x108(%rbp)
               	movl	<rip>, %eax # <addr>
               	movl	$0xffff9fc0, %r11d      # imm = 0xFFFF9FC0
               	andq	%r11, %rax
               	orq	$0x4000, %rax           # imm = 0x4000
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	ldmxcsr	(%rax)
               	movq	-0x120(%rbp), %rax
               	vmovq	%rax, %xmm0
               	movq	-0x118(%rbp), %rax
               	vpinsrq	$0x1, %rax, %xmm0, %xmm0
               	movq	-0x110(%rbp), %rax
               	movq	-0x108(%rbp), %rax
               	roundps	$0x3, %xmm0, %xmm0
               	vmovq	%xmm0, %rax
               	movq	%rax, -0x100(%rbp)
               	vpextrq	$0x1, %xmm0, %rax
               	movq	%rax, -0xf8(%rbp)
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
               	movq	-0x100(%rbp), %rax
               	movq	%rax, -0x1c0(%rbp)
               	movq	-0xf8(%rbp), %rax
               	movq	%rax, -0x1b8(%rbp)
               	xorl	%ebx, %ebx
               	leaq	-0x1c0(%rbp), %rax
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
               	movups	0x1c0(%rsp), %xmm0
               	vmovq	%xmm0, %rax
               	movq	%rax, -0xf0(%rbp)
               	vpextrq	$0x1, %xmm0, %rax
               	movq	%rax, -0xe8(%rbp)
               	movq	$0x0, -0xe0(%rbp)
               	movq	$0x0, -0xd8(%rbp)
               	movl	<rip>, %eax # <addr>
               	movl	$0xffff9fc0, %r11d      # imm = 0xFFFF9FC0
               	andq	%r11, %rax
               	orq	$0x4000, %rax           # imm = 0x4000
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	ldmxcsr	(%rax)
               	movq	-0xf0(%rbp), %rax
               	vmovq	%rax, %xmm0
               	movq	-0xe8(%rbp), %rax
               	vpinsrq	$0x1, %rax, %xmm0, %xmm0
               	movq	-0xe0(%rbp), %rax
               	movq	-0xd8(%rbp), %rax
               	roundps	$0x8, %xmm0, %xmm0
               	vmovq	%xmm0, %rax
               	movq	%rax, -0xd0(%rbp)
               	vpextrq	$0x1, %xmm0, %rax
               	movq	%rax, -0xc8(%rbp)
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
               	movq	-0xd0(%rbp), %rax
               	movq	%rax, -0x1c0(%rbp)
               	movq	-0xc8(%rbp), %rax
               	movq	%rax, -0x1b8(%rbp)
               	xorl	%ebx, %ebx
               	leaq	-0x1c0(%rbp), %rax
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
               	movups	0x1c0(%rsp), %xmm0
               	vmovq	%xmm0, %rax
               	movq	%rax, -0xc0(%rbp)
               	vpextrq	$0x1, %xmm0, %rax
               	movq	%rax, -0xb8(%rbp)
               	movq	$0x0, -0xb0(%rbp)
               	movq	$0x0, -0xa8(%rbp)
               	movl	<rip>, %eax # <addr>
               	movl	$0xffff9fc0, %r11d      # imm = 0xFFFF9FC0
               	andq	%r11, %rax
               	orq	$0x6000, %rax           # imm = 0x6000
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	ldmxcsr	(%rax)
               	movq	-0xc0(%rbp), %rax
               	vmovq	%rax, %xmm0
               	movq	-0xb8(%rbp), %rax
               	vpinsrq	$0x1, %rax, %xmm0, %xmm0
               	movq	-0xb0(%rbp), %rax
               	movq	-0xa8(%rbp), %rax
               	roundps	$0x9, %xmm0, %xmm0
               	vmovq	%xmm0, %rax
               	movq	%rax, -0xa0(%rbp)
               	vpextrq	$0x1, %xmm0, %rax
               	movq	%rax, -0x98(%rbp)
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
               	movq	-0xa0(%rbp), %rax
               	movq	%rax, -0x1c0(%rbp)
               	movq	-0x98(%rbp), %rax
               	movq	%rax, -0x1b8(%rbp)
               	xorl	%ebx, %ebx
               	leaq	-0x1c0(%rbp), %rax
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
               	movups	0x1c0(%rsp), %xmm0
               	vmovq	%xmm0, %rax
               	movq	%rax, -0x90(%rbp)
               	vpextrq	$0x1, %xmm0, %rax
               	movq	%rax, -0x88(%rbp)
               	movq	$0x0, -0x80(%rbp)
               	movq	$0x0, -0x78(%rbp)
               	movl	<rip>, %eax # <addr>
               	movl	$0xffff9fc0, %r11d      # imm = 0xFFFF9FC0
               	andq	%r11, %rax
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	ldmxcsr	(%rax)
               	movq	-0x90(%rbp), %rax
               	vmovq	%rax, %xmm0
               	movq	-0x88(%rbp), %rax
               	vpinsrq	$0x1, %rax, %xmm0, %xmm0
               	movq	-0x80(%rbp), %rax
               	movq	-0x78(%rbp), %rax
               	roundps	$0xa, %xmm0, %xmm0
               	vmovq	%xmm0, %rax
               	movq	%rax, -0x70(%rbp)
               	vpextrq	$0x1, %xmm0, %rax
               	movq	%rax, -0x68(%rbp)
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
               	movq	-0x70(%rbp), %rax
               	movq	%rax, -0x1c0(%rbp)
               	movq	-0x68(%rbp), %rax
               	movq	%rax, -0x1b8(%rbp)
               	xorl	%ebx, %ebx
               	leaq	-0x1c0(%rbp), %rax
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
               	movups	0x1c0(%rsp), %xmm0
               	vmovq	%xmm0, %rax
               	movq	%rax, -0x60(%rbp)
               	vpextrq	$0x1, %xmm0, %rax
               	movq	%rax, -0x58(%rbp)
               	movq	$0x0, -0x50(%rbp)
               	movq	$0x0, -0x48(%rbp)
               	movl	<rip>, %eax # <addr>
               	movl	$0xffff9fc0, %r11d      # imm = 0xFFFF9FC0
               	andq	%r11, %rax
               	orq	$0x2000, %rax           # imm = 0x2000
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	ldmxcsr	(%rax)
               	movq	-0x60(%rbp), %rax
               	vmovq	%rax, %xmm0
               	movq	-0x58(%rbp), %rax
               	vpinsrq	$0x1, %rax, %xmm0, %xmm0
               	movq	-0x50(%rbp), %rax
               	movq	-0x48(%rbp), %rax
               	roundps	$0xb, %xmm0, %xmm0
               	vmovq	%xmm0, %rax
               	movq	%rax, -0x40(%rbp)
               	vpextrq	$0x1, %xmm0, %rax
               	movq	%rax, -0x38(%rbp)
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
               	movq	-0x40(%rbp), %rax
               	movq	%rax, -0x1c0(%rbp)
               	movq	-0x38(%rbp), %rax
               	movq	%rax, -0x1b8(%rbp)
               	xorl	%ebx, %ebx
               	leaq	-0x1c0(%rbp), %rax
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
               	subq	$0x168, %rsp            # imm = 0x168
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
               	movups	%xmm14, 0x160(%rsp)
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
               	movups	0x160(%rsp), %xmm0
               	vmovq	%xmm0, %rax
               	movq	%rax, -0x150(%rbp)
               	vpextrq	$0x1, %xmm0, %rax
               	movq	%rax, -0x148(%rbp)
               	movq	$0x0, -0x140(%rbp)
               	movq	$0x0, -0x138(%rbp)
               	movl	<rip>, %eax # <addr>
               	movl	$0xffff9fc0, %r11d      # imm = 0xFFFF9FC0
               	andq	%r11, %rax
               	orq	$0x6000, %rax           # imm = 0x6000
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	ldmxcsr	(%rax)
               	movq	-0x150(%rbp), %rax
               	vmovq	%rax, %xmm0
               	movq	-0x148(%rbp), %rax
               	vpinsrq	$0x1, %rax, %xmm0, %xmm0
               	movq	-0x140(%rbp), %rax
               	movq	-0x138(%rbp), %rax
               	roundpd	$0x0, %xmm0, %xmm0
               	vmovq	%xmm0, %rax
               	movq	%rax, -0x130(%rbp)
               	vpextrq	$0x1, %xmm0, %rax
               	movq	%rax, -0x128(%rbp)
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
               	movq	-0x130(%rbp), %rax
               	movq	%rax, -0x160(%rbp)
               	movq	-0x128(%rbp), %rax
               	movq	%rax, -0x158(%rbp)
               	xorl	%ebx, %ebx
               	xorl	%r12d, %r12d
               	leaq	-0x160(%rbp), %rcx
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
               	movups	0x160(%rsp), %xmm0
               	vmovq	%xmm0, %rax
               	movq	%rax, -0x120(%rbp)
               	vpextrq	$0x1, %xmm0, %rax
               	movq	%rax, -0x118(%rbp)
               	movq	$0x0, -0x110(%rbp)
               	movq	$0x0, -0x108(%rbp)
               	movl	<rip>, %eax # <addr>
               	movl	$0xffff9fc0, %r11d      # imm = 0xFFFF9FC0
               	andq	%r11, %rax
               	orq	$0x4000, %rax           # imm = 0x4000
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	ldmxcsr	(%rax)
               	movq	-0x120(%rbp), %rax
               	vmovq	%rax, %xmm0
               	movq	-0x118(%rbp), %rax
               	vpinsrq	$0x1, %rax, %xmm0, %xmm0
               	movq	-0x110(%rbp), %rax
               	movq	-0x108(%rbp), %rax
               	roundpd	$0x1, %xmm0, %xmm0
               	vmovq	%xmm0, %rax
               	movq	%rax, -0x100(%rbp)
               	vpextrq	$0x1, %xmm0, %rax
               	movq	%rax, -0xf8(%rbp)
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
               	movq	-0x100(%rbp), %rax
               	movq	%rax, -0x160(%rbp)
               	movq	-0xf8(%rbp), %rax
               	movq	%rax, -0x158(%rbp)
               	xorl	%ebx, %ebx
               	leaq	-0x160(%rbp), %rcx
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
               	movups	0x160(%rsp), %xmm0
               	vmovq	%xmm0, %rax
               	movq	%rax, -0xf0(%rbp)
               	vpextrq	$0x1, %xmm0, %rax
               	movq	%rax, -0xe8(%rbp)
               	movq	$0x0, -0xe0(%rbp)
               	movq	$0x0, -0xd8(%rbp)
               	movl	<rip>, %eax # <addr>
               	movl	$0xffff9fc0, %r11d      # imm = 0xFFFF9FC0
               	andq	%r11, %rax
               	orq	$0x2000, %rax           # imm = 0x2000
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	ldmxcsr	(%rax)
               	movq	-0xf0(%rbp), %rax
               	vmovq	%rax, %xmm0
               	movq	-0xe8(%rbp), %rax
               	vpinsrq	$0x1, %rax, %xmm0, %xmm0
               	movq	-0xe0(%rbp), %rax
               	movq	-0xd8(%rbp), %rax
               	roundpd	$0x2, %xmm0, %xmm0
               	vmovq	%xmm0, %rax
               	movq	%rax, -0xd0(%rbp)
               	vpextrq	$0x1, %xmm0, %rax
               	movq	%rax, -0xc8(%rbp)
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
               	movq	-0xd0(%rbp), %rax
               	movq	%rax, -0x160(%rbp)
               	movq	-0xc8(%rbp), %rax
               	movq	%rax, -0x158(%rbp)
               	xorl	%ebx, %ebx
               	leaq	-0x160(%rbp), %rcx
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
               	movups	0x160(%rsp), %xmm0
               	vmovq	%xmm0, %rax
               	movq	%rax, -0xc0(%rbp)
               	vpextrq	$0x1, %xmm0, %rax
               	movq	%rax, -0xb8(%rbp)
               	movq	$0x0, -0xb0(%rbp)
               	movq	$0x0, -0xa8(%rbp)
               	movl	<rip>, %eax # <addr>
               	movl	$0xffff9fc0, %r11d      # imm = 0xFFFF9FC0
               	andq	%r11, %rax
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	ldmxcsr	(%rax)
               	movq	-0xc0(%rbp), %rax
               	vmovq	%rax, %xmm0
               	movq	-0xb8(%rbp), %rax
               	vpinsrq	$0x1, %rax, %xmm0, %xmm0
               	movq	-0xb0(%rbp), %rax
               	movq	-0xa8(%rbp), %rax
               	roundpd	$0x3, %xmm0, %xmm0
               	vmovq	%xmm0, %rax
               	movq	%rax, -0xa0(%rbp)
               	vpextrq	$0x1, %xmm0, %rax
               	movq	%rax, -0x98(%rbp)
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
               	movq	-0xa0(%rbp), %rax
               	movq	%rax, -0x160(%rbp)
               	movq	-0x98(%rbp), %rax
               	movq	%rax, -0x158(%rbp)
               	xorl	%ebx, %ebx
               	leaq	-0x160(%rbp), %rcx
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
               	movups	0x160(%rsp), %xmm0
               	vmovq	%xmm0, %rax
               	movq	%rax, -0x90(%rbp)
               	vpextrq	$0x1, %xmm0, %rax
               	movq	%rax, -0x88(%rbp)
               	movq	$0x0, -0x80(%rbp)
               	movq	$0x0, -0x78(%rbp)
               	movl	<rip>, %eax # <addr>
               	movl	$0xffff9fc0, %r11d      # imm = 0xFFFF9FC0
               	andq	%r11, %rax
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	ldmxcsr	(%rax)
               	movq	-0x90(%rbp), %rax
               	vmovq	%rax, %xmm0
               	movq	-0x88(%rbp), %rax
               	vpinsrq	$0x1, %rax, %xmm0, %xmm0
               	movq	-0x80(%rbp), %rax
               	movq	-0x78(%rbp), %rax
               	roundpd	$0x9, %xmm0, %xmm0
               	vmovq	%xmm0, %rax
               	movq	%rax, -0x70(%rbp)
               	vpextrq	$0x1, %xmm0, %rax
               	movq	%rax, -0x68(%rbp)
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
               	movq	-0x70(%rbp), %rax
               	movq	%rax, -0x160(%rbp)
               	movq	-0x68(%rbp), %rax
               	movq	%rax, -0x158(%rbp)
               	xorl	%ebx, %ebx
               	leaq	-0x160(%rbp), %rcx
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
               	movups	0x160(%rsp), %xmm0
               	vmovq	%xmm0, %rax
               	movq	%rax, -0x60(%rbp)
               	vpextrq	$0x1, %xmm0, %rax
               	movq	%rax, -0x58(%rbp)
               	movq	$0x0, -0x50(%rbp)
               	movq	$0x0, -0x48(%rbp)
               	movl	<rip>, %eax # <addr>
               	movl	$0xffff9fc0, %r11d      # imm = 0xFFFF9FC0
               	andq	%r11, %rax
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	ldmxcsr	(%rax)
               	movq	-0x60(%rbp), %rax
               	vmovq	%rax, %xmm0
               	movq	-0x58(%rbp), %rax
               	vpinsrq	$0x1, %rax, %xmm0, %xmm0
               	movq	-0x50(%rbp), %rax
               	movq	-0x48(%rbp), %rax
               	roundpd	$0xa, %xmm0, %xmm0
               	vmovq	%xmm0, %rax
               	movq	%rax, -0x40(%rbp)
               	vpextrq	$0x1, %xmm0, %rax
               	movq	%rax, -0x38(%rbp)
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
               	movq	-0x40(%rbp), %rax
               	movq	%rax, -0x160(%rbp)
               	movq	-0x38(%rbp), %rax
               	movq	%rax, -0x158(%rbp)
               	xorl	%ebx, %ebx
               	leaq	-0x160(%rbp), %rcx
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

<check_current_direction>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x148, %rsp            # imm = 0x148
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	callq	<addr>
               	movsd	%xmm0, 0x118(%rsp)
               	movapd	%xmm0, %xmm15
               	vmovq	%xmm15, %r11
               	vmovq	%r11, %xmm14
               	movups	%xmm14, 0x140(%rsp)
               	callq	<addr>
               	movsd	%xmm0, 0x110(%rsp)
               	movapd	%xmm0, %xmm15
               	vmovq	%xmm15, %r11
               	movups	0x140(%rsp), %xmm14
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
               	xorl	%r13d, %r13d
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
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	ldmxcsr	(%rax)
               	movq	-0x140(%rbp), %rax
               	vmovq	%rax, %xmm0
               	movq	-0x138(%rbp), %rax
               	vpinsrq	$0x1, %rax, %xmm0, %xmm0
               	movq	-0x130(%rbp), %rax
               	movq	-0x128(%rbp), %rax
               	roundps	$0x4, %xmm0, %xmm0
               	vmovq	%xmm0, %rax
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
               	vmovq	%rax, %xmm14
               	movups	%xmm14, 0x130(%rsp)
               	movq	-0x118(%rbp), %rax
               	movups	0x130(%rsp), %xmm0
               	movapd	%xmm0, %xmm14
               	vpinsrq	$0x1, %rax, %xmm14, %xmm14
               	movups	%xmm14, 0x120(%rsp)
               	callq	<addr>
               	movq	%rax, %r15
               	movss	-0x18(%rbp), %xmm0
               	movq	%rbx, %rdi
               	callq	<addr>
               	callq	<addr>
               	cmpl	%eax, %r15d
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rax, %r13
               	movups	0x130(%rsp), %xmm14
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
               	orq	%rax, %r13
               	movups	0x120(%rsp), %xmm14
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
               	orq	%rax, %r13
               	movups	0x120(%rsp), %xmm14
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
               	orq	%r13, %rax
               	cmpl	%r12d, %r14d
               	setne	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %r13
               	orq	%rcx, %r13
               	movups	0x140(%rsp), %xmm0
               	vmovq	%xmm0, %rax
               	movq	%rax, -0x110(%rbp)
               	vpextrq	$0x1, %xmm0, %rax
               	movq	%rax, -0x108(%rbp)
               	movq	$0x0, -0x100(%rbp)
               	movq	$0x0, -0xf8(%rbp)
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
               	vpinsrq	$0x1, %rax, %xmm0, %xmm0
               	movq	-0x100(%rbp), %rax
               	movq	-0xf8(%rbp), %rax
               	roundps	$0x4, %xmm0, %xmm0
               	vmovq	%xmm0, %rax
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
               	vmovq	%rax, %xmm0
               	movq	-0xe8(%rbp), %rax
               	vpermilps	$0x1, %xmm0, %xmm0 # xmm0 = xmm0[1,0,0,0]
               	callq	<addr>
               	movq	%rax, %r15
               	movss	-0x14(%rbp), %xmm0
               	movq	%rbx, %rdi
               	callq	<addr>
               	callq	<addr>
               	movl	$0x1, %ecx
               	cmpl	%r12d, %r14d
               	setne	%dl
               	movzbq	%dl, %rdx
               	cmpl	%eax, %r15d
               	cmoveq	%rdx, %rcx
               	orq	%rcx, %r13
               	movups	0x140(%rsp), %xmm0
               	vmovq	%xmm0, %rax
               	movq	%rax, -0xe0(%rbp)
               	vpextrq	$0x1, %xmm0, %rax
               	movq	%rax, -0xd8(%rbp)
               	movq	$0x0, -0xd0(%rbp)
               	movq	$0x0, -0xc8(%rbp)
               	movl	<rip>, %eax # <addr>
               	movl	$0xffff9fc0, %r11d      # imm = 0xFFFF9FC0
               	andq	%r11, %rax
               	movq	%rbx, %rcx
               	shlq	$0xd, %rcx
               	orq	%rcx, %rax
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	ldmxcsr	(%rax)
               	movq	-0xe0(%rbp), %rax
               	vmovq	%rax, %xmm0
               	movq	-0xd8(%rbp), %rax
               	vpinsrq	$0x1, %rax, %xmm0, %xmm0
               	movq	-0xd0(%rbp), %rax
               	movq	-0xc8(%rbp), %rax
               	roundps	$0xc, %xmm0, %xmm0
               	vmovq	%xmm0, %rax
               	movq	%rax, -0xc0(%rbp)
               	vpextrq	$0x1, %xmm0, %rax
               	movq	%rax, -0xb8(%rbp)
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
               	movq	-0xc0(%rbp), %rax
               	vmovq	%rax, %xmm0
               	movq	-0xb8(%rbp), %rax
               	vpinsrq	$0x1, %rax, %xmm0, %xmm0
               	vpermilps	$0x2, %xmm0, %xmm0 # xmm0 = xmm0[2,0,0,0]
               	callq	<addr>
               	movq	%rax, %r15
               	movss	-0x10(%rbp), %xmm0
               	movq	%rbx, %rdi
               	callq	<addr>
               	callq	<addr>
               	movl	$0x1, %ecx
               	testl	%r14d, %r14d
               	setne	%dl
               	movzbq	%dl, %rdx
               	cmpl	%eax, %r15d
               	cmoveq	%rdx, %rcx
               	orq	%rcx, %r13
               	movups	0x100(%rsp), %xmm0
               	vmovq	%xmm0, %rax
               	movq	%rax, -0xb0(%rbp)
               	vpextrq	$0x1, %xmm0, %rax
               	movq	%rax, -0xa8(%rbp)
               	vmovq	%xmm0, %rax
               	movq	%rax, -0xa0(%rbp)
               	vpextrq	$0x1, %xmm0, %rax
               	movq	%rax, -0x98(%rbp)
               	movl	<rip>, %eax # <addr>
               	movl	$0xffff9fc0, %r11d      # imm = 0xFFFF9FC0
               	andq	%r11, %rax
               	movq	%rbx, %rcx
               	shlq	$0xd, %rcx
               	orq	%rcx, %rax
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	ldmxcsr	(%rax)
               	movq	-0xb0(%rbp), %rax
               	vmovq	%rax, %xmm0
               	movq	-0xa8(%rbp), %rax
               	vpinsrq	$0x1, %rax, %xmm0, %xmm0
               	movq	-0xa0(%rbp), %rax
               	movq	-0x98(%rbp), %rax
               	roundpd	$0xc, %xmm0, %xmm0
               	vmovq	%xmm0, %rax
               	movq	%rax, -0x90(%rbp)
               	vpextrq	$0x1, %xmm0, %rax
               	movq	%rax, -0x88(%rbp)
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
               	movq	-0x90(%rbp), %rax
               	vmovq	%rax, %xmm0
               	movq	-0x88(%rbp), %rax
               	movapd	%xmm0, %xmm1
               	vpinsrq	$0x1, %rax, %xmm1, %xmm1
               	vpermilpd	$0x0, %xmm1, %xmm0 # xmm0 = xmm1[0,0]
               	movq	%xmm0, %r15
               	movsd	0x118(%rsp), %xmm0
               	movups	%xmm1, 0xf0(%rsp)
               	movq	%rbx, %rdi
               	callq	<addr>
               	movups	0xf0(%rsp), %xmm1
               	movq	%xmm0, %rax
               	movl	$0x1, %ecx
               	testl	%r14d, %r14d
               	setne	%dl
               	movzbq	%dl, %rdx
               	cmpq	%rax, %r15
               	cmoveq	%rdx, %rcx
               	orq	%rcx, %r13
               	vpermilpd	$0x1, %xmm1, %xmm0 # xmm0 = xmm1[1,0]
               	movq	%xmm0, %r14
               	movsd	0x110(%rsp), %xmm0
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%xmm0, %rax
               	cmpq	%rax, %r14
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rax, %r13
               	incq	%rbx
               	cmpl	$0x4, %ebx
               	jl	<addr>
               	movl	$0x8, %eax
               	xorl	%ecx, %ecx
               	testq	%r13, %r13
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
               	xorps	%xmm0, %xmm0
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
               	xorps	%xmm1, %xmm1
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
               	xorps	%xmm0, %xmm0
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
               	xorps	%xmm1, %xmm1
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
               	xorps	%xmm0, %xmm0
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
               	xorps	%xmm1, %xmm1
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
               	xorps	%xmm0, %xmm0
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
               	xorps	%xmm1, %xmm1
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
               	xorps	%xmm0, %xmm0
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
               	xorps	%xmm1, %xmm1
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
               	xorps	%xmm0, %xmm0
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
               	xorps	%xmm1, %xmm1
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
               	xorps	%xmm0, %xmm0
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
               	xorps	%xmm1, %xmm1
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
               	xorps	%xmm0, %xmm0
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
               	xorps	%xmm1, %xmm1
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
               	xorps	%xmm0, %xmm0
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
               	xorps	%xmm1, %xmm1
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
               	xorps	%xmm0, %xmm0
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
               	xorps	%xmm1, %xmm1
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
               	xorps	%xmm0, %xmm0
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
               	xorps	%xmm1, %xmm1
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
               	xorps	%xmm0, %xmm0
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
               	xorps	%xmm1, %xmm1
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
               	xorps	%xmm0, %xmm0
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
               	xorps	%xmm1, %xmm1
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
               	xorps	%xmm0, %xmm0
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
               	xorps	%xmm1, %xmm1
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
               	xorps	%xmm0, %xmm0
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
               	xorps	%xmm1, %xmm1
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
               	xorps	%xmm0, %xmm0
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
               	xorps	%xmm1, %xmm1
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
               	movsd	<rip>, %xmm2 # <addr>
               	cvtss2sd	%xmm1, %xmm1
               	mulsd	%xmm2, %xmm1
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
               	vaddsd	%xmm5, %xmm4, %xmm5
               	movapd	%xmm0, %xmm4
               	movapd	%xmm2, %xmm6
               	mulsd	%xmm6, %xmm4
               	movapd	%xmm1, %xmm6
               	movapd	%xmm3, %xmm7
               	mulsd	%xmm7, %xmm6
               	vaddsd	%xmm6, %xmm4, %xmm6
               	xorps	%xmm7, %xmm7
               	movq	%xmm6, %rax
               	movq	%xmm5, %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movapd	%xmm7, %xmm5
               	movq	%xmm5, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x10, %ebx
               	movapd	%xmm0, %xmm5
               	movapd	%xmm2, %xmm6
               	mulsd	%xmm6, %xmm5
               	movsd	%xmm5, -0xc0(%rbp)
               	movq	$0x0, -0xb8(%rbp)
               	movsd	-0xc0(%rbp), %xmm5
               	movsd	-0xb8(%rbp), %xmm6
               	addsd	%xmm6, %xmm5
               	movapd	%xmm0, %xmm6
               	movapd	%xmm2, %xmm7
               	mulsd	%xmm7, %xmm6
               	xorps	%xmm7, %xmm7
               	addsd	%xmm7, %xmm6
               	xorps	%xmm7, %xmm7
               	movq	%xmm7, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	%xmm6, %rax
               	movq	%xmm5, %rcx
               	cmpq	%rcx, %rax
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
               	xorps	%xmm5, %xmm5
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
               	xorps	%xmm5, %xmm5
               	xorps	%xmm6, %xmm6
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
               	xorps	%xmm0, %xmm0
               	xorps	%xmm1, %xmm1
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
               	movss	<rip>, %xmm1 # <addr>
               	divss	%xmm1, %xmm0
               	jmp	<addr>
               	shrq	$0x2c, %rax
               	subq	$0x80000, %rax          # imm = 0x80000
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rax, %xmm0
               	movss	<rip>, %xmm1 # <addr>
               	divss	%xmm1, %xmm0
               	jmp	<addr>
               	shrq	$0x2c, %rax
               	subq	$0x80000, %rax          # imm = 0x80000
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rax, %xmm0
               	movss	<rip>, %xmm1 # <addr>
               	divss	%xmm1, %xmm0
               	jmp	<addr>
               	shrq	$0x2c, %rax
               	subq	$0x80000, %rax          # imm = 0x80000
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rax, %xmm0
               	movss	<rip>, %xmm1 # <addr>
               	divss	%xmm1, %xmm0
               	jmp	<addr>
               	shrq	$0x2c, %rax
               	subq	$0x80000, %rax          # imm = 0x80000
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rax, %xmm0
               	movss	<rip>, %xmm1 # <addr>
               	divss	%xmm1, %xmm0
               	jmp	<addr>
               	shrq	$0x2c, %rax
               	subq	$0x80000, %rax          # imm = 0x80000
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rax, %xmm0
               	movss	<rip>, %xmm1 # <addr>
               	divss	%xmm1, %xmm0
               	jmp	<addr>
               	shrq	$0x2c, %rax
               	subq	$0x80000, %rax          # imm = 0x80000
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rax, %xmm0
               	movss	<rip>, %xmm1 # <addr>
               	divss	%xmm1, %xmm0
               	jmp	<addr>
               	shrq	$0x2c, %rax
               	subq	$0x80000, %rax          # imm = 0x80000
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rax, %xmm0
               	movss	<rip>, %xmm1 # <addr>
               	divss	%xmm1, %xmm0
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
               	subq	$0x88, %rsp
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
               	movups	%xmm14, 0x30(%rsp)
               	movups	-0x40(%rbp), %xmm14
               	movups	%xmm14, 0x20(%rsp)
               	movups	-0x30(%rbp), %xmm14
               	movups	%xmm14, 0x10(%rsp)
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
               	movups	0x30(%rsp), %xmm14
               	movups	0x20(%rsp), %xmm15
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
               	movups	0x30(%rsp), %xmm14
               	movups	0x20(%rsp), %xmm15
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
               	movups	0x30(%rsp), %xmm14
               	movups	0x20(%rsp), %xmm15
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
               	movups	0x30(%rsp), %xmm14
               	movups	0x20(%rsp), %xmm15
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
               	movups	0x30(%rsp), %xmm14
               	movups	0x20(%rsp), %xmm15
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
               	vmovups	0x30(%rsp), %ymm14
               	vmovups	0x10(%rsp), %ymm15
               	vblendvps	%xmm15, 0x20(%rsp), %xmm14, %xmm0
               	leaq	-0x10(%rbp), %rdi
               	movups	%xmm0, -0x10(%rbp)
               	leaq	-0x20(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x40, %ecx
               	testq	%rax, %rax
               	cmoveq	%rbx, %rcx
               	movups	0x30(%rsp), %xmm14
               	movups	0x20(%rsp), %xmm15
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
               	vmovups	0x30(%rsp), %ymm14
               	vmovups	0x10(%rsp), %ymm15
               	vblendvpd	%xmm15, 0x20(%rsp), %xmm14, %xmm0
               	movups	%xmm0, -0x10(%rbp)
               	xorl	%eax, %eax
               	movl	-0x10(%rbp,%rax,4), %esi
               	movq	%rax, %rdi
               	orq	$0x1, %rdi
               	movl	-0x30(%rbp,%rdi,4), %edx
               	shrq	$0x1f, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	-0x40(%rbp,%rax,4), %edx
               	movl	$0x40, %edi
               	cmpl	%edx, %esi
               	cmovneq	%rdi, %rcx
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
               	subq	$0xe0, %rsp
               	pushq	%r14
               	pushq	%r13
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
               	vmovd	%xmm0, %r11d
               	vmovd	%r11d, %xmm14
               	movups	%xmm14, 0xd8(%rsp)
               	callq	<addr>
               	movsd	%xmm0, 0xe8(%rsp)
               	movapd	%xmm0, %xmm15
               	vmovd	%xmm15, %r11d
               	vmovd	%r11d, %xmm14
               	movups	%xmm14, 0xc8(%rsp)
               	callq	<addr>
               	movsd	%xmm0, 0x58(%rsp)
               	movapd	%xmm0, %xmm15
               	vmovd	%xmm15, %r11d
               	movups	0xd8(%rsp), %xmm14
               	vpinsrd	$0x1, %r11d, %xmm14, %xmm14
               	movups	%xmm14, 0xd8(%rsp)
               	callq	<addr>
               	movsd	%xmm0, 0xa0(%rsp)
               	movapd	%xmm0, %xmm15
               	vmovd	%xmm15, %r11d
               	movups	0xc8(%rsp), %xmm14
               	vpinsrd	$0x1, %r11d, %xmm14, %xmm14
               	movups	%xmm14, 0xc8(%rsp)
               	callq	<addr>
               	movsd	%xmm0, 0x98(%rsp)
               	movapd	%xmm0, %xmm15
               	vmovd	%xmm15, %r11d
               	movups	0xd8(%rsp), %xmm14
               	vpinsrd	$0x2, %r11d, %xmm14, %xmm14
               	movups	%xmm14, 0xd8(%rsp)
               	callq	<addr>
               	movsd	%xmm0, 0x90(%rsp)
               	movapd	%xmm0, %xmm15
               	vmovd	%xmm15, %r11d
               	movups	0xc8(%rsp), %xmm14
               	vpinsrd	$0x2, %r11d, %xmm14, %xmm14
               	movups	%xmm14, 0xc8(%rsp)
               	callq	<addr>
               	movsd	%xmm0, 0x88(%rsp)
               	movapd	%xmm0, %xmm15
               	vmovd	%xmm15, %r11d
               	movups	0xd8(%rsp), %xmm14
               	vpinsrd	$0x3, %r11d, %xmm14, %xmm14
               	movups	%xmm14, 0x78(%rsp)
               	callq	<addr>
               	movsd	%xmm0, 0x70(%rsp)
               	movapd	%xmm0, %xmm15
               	vmovd	%xmm15, %r11d
               	movups	0xc8(%rsp), %xmm14
               	vpinsrd	$0x3, %r11d, %xmm14, %xmm14
               	movups	%xmm14, 0xd8(%rsp)
               	callq	<addr>
               	vmovq	%xmm0, %xmm14           # xmm14 = xmm0[0],zero
               	movups	%xmm14, 0xc0(%rsp)
               	callq	<addr>
               	movsd	%xmm0, 0xd0(%rsp)
               	movapd	%xmm0, %xmm15
               	vmovq	%xmm15, %r11
               	vmovq	%r11, %xmm14
               	movups	%xmm14, 0xa8(%rsp)
               	callq	<addr>
               	movsd	%xmm0, 0xb8(%rsp)
               	movapd	%xmm0, %xmm15
               	vmovq	%xmm15, %r11
               	movups	0xc0(%rsp), %xmm14
               	vpinsrq	$0x1, %r11, %xmm14, %xmm14
               	movups	%xmm14, 0x60(%rsp)
               	callq	<addr>
               	movsd	%xmm0, 0x50(%rsp)
               	movapd	%xmm0, %xmm15
               	vmovq	%xmm15, %r11
               	movups	0xa8(%rsp), %xmm14
               	vpinsrq	$0x1, %r11, %xmm14, %xmm14
               	movups	%xmm14, 0xc0(%rsp)
               	movups	0x78(%rsp), %xmm14
               	movups	0xd8(%rsp), %xmm15
               	vroundss	$0x3, %xmm15, %xmm14, %xmm14
               	movups	%xmm14, 0xa8(%rsp)
               	movups	0xa8(%rsp), %xmm14
               	vpermilps	$0x0, %xmm14, %xmm0 # xmm0 = xmm14[0,0,0,0]
               	callq	<addr>
               	movq	%rax, %r13
               	movsd	0xe8(%rsp), %xmm0
               	movl	$0x3, %edi
               	callq	<addr>
               	callq	<addr>
               	cmpl	%eax, %r13d
               	setne	%r13b
               	movzbq	%r13b, %r13
               	movups	0xa8(%rsp), %xmm14
               	vpermilps	$0x1, %xmm14, %xmm0 # xmm0 = xmm14[1,0,0,0]
               	callq	<addr>
               	movq	%rax, %r14
               	movsd	0x58(%rsp), %xmm0
               	callq	<addr>
               	cmpl	%eax, %r14d
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rax, %r13
               	movups	0xa8(%rsp), %xmm14
               	vpermilps	$0x2, %xmm14, %xmm0 # xmm0 = xmm14[2,0,0,0]
               	callq	<addr>
               	movq	%rax, %r14
               	movsd	0x98(%rsp), %xmm0
               	callq	<addr>
               	cmpl	%eax, %r14d
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rax, %r13
               	movups	0xa8(%rsp), %xmm14
               	vpermilps	$0x3, %xmm14, %xmm0 # xmm0 = xmm14[3,0,0,0]
               	callq	<addr>
               	movq	%rax, %r14
               	movsd	0x88(%rsp), %xmm0
               	callq	<addr>
               	cmpl	%eax, %r14d
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rax, %r13
               	movups	0x60(%rsp), %xmm14
               	movups	0xc0(%rsp), %xmm15
               	vroundsd	$0x2, %xmm15, %xmm14, %xmm1
               	vpermilpd	$0x0, %xmm1, %xmm0 # xmm0 = xmm1[0,0]
               	movq	%xmm0, %r14
               	movsd	0xd0(%rsp), %xmm0
               	movl	$0x2, %edi
               	movups	%xmm1, 0x40(%rsp)
               	callq	<addr>
               	movups	0x40(%rsp), %xmm1
               	movq	%xmm0, %rax
               	cmpq	%rax, %r14
               	movl	$0x1, %eax
               	jne	<addr>
               	vpermilpd	$0x1, %xmm1, %xmm0 # xmm0 = xmm1[1,0]
               	movq	%xmm0, %rax
               	movsd	0xb8(%rsp), %xmm0
               	movq	%xmm0, %rcx
               	cmpq	%rcx, %rax
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rax, %r13
               	movups	0xd8(%rsp), %xmm14
               	roundps	$0x1, %xmm14, %xmm15
               	movups	%xmm15, 0xa8(%rsp)
               	movapd	%xmm15, %xmm14
               	vpermilps	$0x0, %xmm14, %xmm0 # xmm0 = xmm14[0,0,0,0]
               	callq	<addr>
               	movq	%rax, %r14
               	movsd	0xe8(%rsp), %xmm0
               	movl	$0x1, %edi
               	callq	<addr>
               	callq	<addr>
               	cmpl	%eax, %r14d
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rax, %r13
               	movups	0xa8(%rsp), %xmm14
               	vpermilps	$0x1, %xmm14, %xmm0 # xmm0 = xmm14[1,0,0,0]
               	callq	<addr>
               	movq	%rax, %r14
               	movsd	0xa0(%rsp), %xmm0
               	movl	$0x1, %edi
               	callq	<addr>
               	callq	<addr>
               	cmpl	%eax, %r14d
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rax, %r13
               	movups	0xa8(%rsp), %xmm14
               	vpermilps	$0x2, %xmm14, %xmm0 # xmm0 = xmm14[2,0,0,0]
               	callq	<addr>
               	movq	%rax, %r14
               	movsd	0x90(%rsp), %xmm0
               	movl	$0x1, %edi
               	callq	<addr>
               	callq	<addr>
               	cmpl	%eax, %r14d
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rax, %r13
               	movups	0xa8(%rsp), %xmm14
               	vpermilps	$0x3, %xmm14, %xmm0 # xmm0 = xmm14[3,0,0,0]
               	callq	<addr>
               	movq	%rax, %r14
               	movsd	0x70(%rsp), %xmm0
               	movl	$0x1, %edi
               	callq	<addr>
               	callq	<addr>
               	cmpl	%eax, %r14d
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rax, %r13
               	movups	0xd8(%rsp), %xmm14
               	roundps	$0x2, %xmm14, %xmm15
               	movups	%xmm15, 0xa8(%rsp)
               	movapd	%xmm15, %xmm14
               	vpermilps	$0x0, %xmm14, %xmm0 # xmm0 = xmm14[0,0,0,0]
               	callq	<addr>
               	movq	%rax, %r14
               	movsd	0xe8(%rsp), %xmm0
               	movl	$0x2, %edi
               	callq	<addr>
               	callq	<addr>
               	cmpl	%eax, %r14d
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rax, %r13
               	movups	0xa8(%rsp), %xmm14
               	vpermilps	$0x1, %xmm14, %xmm0 # xmm0 = xmm14[1,0,0,0]
               	callq	<addr>
               	movq	%rax, %r14
               	movsd	0xa0(%rsp), %xmm0
               	movl	$0x2, %edi
               	callq	<addr>
               	callq	<addr>
               	cmpl	%eax, %r14d
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rax, %r13
               	movups	0xa8(%rsp), %xmm14
               	vpermilps	$0x2, %xmm14, %xmm0 # xmm0 = xmm14[2,0,0,0]
               	callq	<addr>
               	movq	%rax, %r14
               	movsd	0x90(%rsp), %xmm0
               	movl	$0x2, %edi
               	callq	<addr>
               	callq	<addr>
               	cmpl	%eax, %r14d
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rax, %r13
               	movups	0xa8(%rsp), %xmm14
               	vpermilps	$0x3, %xmm14, %xmm0 # xmm0 = xmm14[3,0,0,0]
               	callq	<addr>
               	movq	%rax, %r14
               	movsd	0x70(%rsp), %xmm0
               	movl	$0x2, %edi
               	callq	<addr>
               	callq	<addr>
               	cmpl	%eax, %r14d
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rax, %r13
               	movups	0xc0(%rsp), %xmm14
               	roundpd	$0x1, %xmm14, %xmm0
               	movq	%xmm0, %r14
               	movsd	0xd0(%rsp), %xmm0
               	movl	$0x1, %edi
               	callq	<addr>
               	movq	%xmm0, %rax
               	cmpq	%rax, %r14
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rax, %r13
               	movups	0xc0(%rsp), %xmm14
               	roundpd	$0x2, %xmm14, %xmm0
               	vpermilpd	$0x1, %xmm0, %xmm0 # xmm0 = xmm0[1,0]
               	movq	%xmm0, %r14
               	movsd	0x50(%rsp), %xmm0
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%xmm0, %rax
               	cmpq	%rax, %r14
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rax, %r13
               	movups	0x78(%rsp), %xmm14
               	movups	0xd8(%rsp), %xmm15
               	vroundss	$0x1, %xmm15, %xmm14, %xmm14
               	movups	%xmm14, 0xa8(%rsp)
               	movups	0xa8(%rsp), %xmm14
               	vpermilps	$0x0, %xmm14, %xmm0 # xmm0 = xmm14[0,0,0,0]
               	callq	<addr>
               	movq	%rax, %r14
               	movsd	0xe8(%rsp), %xmm0
               	movl	$0x1, %edi
               	callq	<addr>
               	callq	<addr>
               	cmpl	%eax, %r14d
               	movl	$0x1, %eax
               	jne	<addr>
               	movups	0xa8(%rsp), %xmm14
               	vpermilps	$0x3, %xmm14, %xmm0 # xmm0 = xmm14[3,0,0,0]
               	callq	<addr>
               	movq	%rax, %r14
               	movsd	0x88(%rsp), %xmm0
               	callq	<addr>
               	cmpl	%eax, %r14d
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rax, %r13
               	movups	0x78(%rsp), %xmm14
               	movups	0xd8(%rsp), %xmm15
               	vroundss	$0x2, %xmm15, %xmm14, %xmm14
               	movups	%xmm14, 0xd8(%rsp)
               	movups	0xd8(%rsp), %xmm14
               	vpermilps	$0x0, %xmm14, %xmm0 # xmm0 = xmm14[0,0,0,0]
               	callq	<addr>
               	movq	%rax, %r14
               	movsd	0xe8(%rsp), %xmm0
               	movl	$0x2, %edi
               	callq	<addr>
               	callq	<addr>
               	cmpl	%eax, %r14d
               	movl	$0x1, %eax
               	jne	<addr>
               	movups	0xd8(%rsp), %xmm14
               	vpermilps	$0x2, %xmm14, %xmm0 # xmm0 = xmm14[2,0,0,0]
               	callq	<addr>
               	movq	%rax, %r14
               	movsd	0x98(%rsp), %xmm0
               	callq	<addr>
               	cmpl	%eax, %r14d
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rax, %r13
               	movups	0x60(%rsp), %xmm14
               	movups	0xc0(%rsp), %xmm15
               	vroundsd	$0x1, %xmm15, %xmm14, %xmm1
               	vpermilpd	$0x0, %xmm1, %xmm0 # xmm0 = xmm1[0,0]
               	movq	%xmm0, %r14
               	movsd	0xd0(%rsp), %xmm0
               	movl	$0x1, %edi
               	movups	%xmm1, 0x30(%rsp)
               	callq	<addr>
               	movups	0x30(%rsp), %xmm1
               	movq	%xmm0, %rax
               	cmpq	%rax, %r14
               	movl	$0x1, %eax
               	jne	<addr>
               	vpermilpd	$0x1, %xmm1, %xmm0 # xmm0 = xmm1[1,0]
               	movq	%xmm0, %rax
               	movsd	0xb8(%rsp), %xmm0
               	movq	%xmm0, %rcx
               	cmpq	%rcx, %rax
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rax, %r13
               	movups	0x60(%rsp), %xmm14
               	movups	0xc0(%rsp), %xmm15
               	vroundsd	$0x2, %xmm15, %xmm14, %xmm1
               	vpermilpd	$0x0, %xmm1, %xmm0 # xmm0 = xmm1[0,0]
               	movq	%xmm0, %r14
               	movsd	0xd0(%rsp), %xmm0
               	movl	$0x2, %edi
               	movups	%xmm1, 0x20(%rsp)
               	callq	<addr>
               	movups	0x20(%rsp), %xmm1
               	movq	%xmm0, %rax
               	cmpq	%rax, %r14
               	movl	$0x1, %eax
               	jne	<addr>
               	vpermilpd	$0x1, %xmm1, %xmm0 # xmm0 = xmm1[1,0]
               	movq	%xmm0, %rax
               	movsd	0xb8(%rsp), %xmm0
               	movq	%xmm0, %rcx
               	cmpq	%rcx, %rax
               	setne	%al
               	movzbq	%al, %rax
               	orq	%r13, %rax
               	movl	$0x4, %ecx
               	xorl	%edx, %edx
               	testq	%rax, %rax
               	cmoveq	%rdx, %rcx
               	orq	%rcx, %r12
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
               	popq	%r13
               	popq	%r14
               	leave
               	retq
