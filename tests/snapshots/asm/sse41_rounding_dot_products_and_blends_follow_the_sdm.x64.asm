
sse41_rounding_dot_products_and_blends_follow_the_sdm.x64:	file format elf64-x86-64

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

<fvalue>:
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
               	movabsq	$0x2545f4914f6cdd1d, %rcx # imm = 0x2545F4914F6CDD1D
               	imulq	%rax, %rcx
               	movq	%rcx, %rdx
               	shrq	$0x3b, %rdx
               	testl	%edx, %edx
               	jne	<addr>
               	leaq	<rip>, %rdx # <addr>
               	shrq	$0x20, %rcx
               	movl	$0xaaaaaaab, %eax       # imm = 0xAAAAAAAB
               	imulq	%rcx, %rax
               	shrq	$0x21, %rax
               	leaq	(%rax,%rax,2), %rax
               	subq	%rax, %rcx
               	shlq	$0x2, %rcx
               	leaq	(%rdx,%rcx), %rax
               	movss	(%rax), %xmm0
               	retq
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
               	leaq	<rip>, %rdx # <addr>
               	shrq	$0x20, %rax
               	movl	$0xaaaaaaab, %ecx       # imm = 0xAAAAAAAB
               	imulq	%rax, %rcx
               	shrq	$0x21, %rcx
               	leaq	(%rcx,%rcx,2), %rcx
               	subq	%rcx, %rax
               	shlq	$0x3, %rax
               	addq	%rdx, %rax
               	movsd	(%rax), %xmm0
               	cvtsd2ss	%xmm0, %xmm0
               	retq
               	movq	%rax, %rcx
               	shrq	$0x3e, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	leaq	<rip>, %rdx # <addr>
               	shrq	$0x20, %rax
               	movq	%rax, %rcx
               	shrq	$0x3, %rcx
               	imulq	$0x55555556, %rcx, %rcx # imm = 0x55555556
               	shrq	$0x20, %rcx
               	imulq	$0x18, %rcx, %rcx
               	subq	%rcx, %rax
               	vmovq	(%rdx,%rax,8), %xmm0
               	jmp	<addr>
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
               	movl	$0x1, %edx
               	movq	%rax, %rcx
               	shrq	$0x8, %rcx
               	andq	$0xf, %rcx
               	shlxq	%rcx, %rdx, %rcx
               	movslq	%ecx, %rcx
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rcx, %xmm1
               	divsd	%xmm1, %xmm0
               	testb	$0x1, %al
               	je	<addr>
               	vxorpd	<rip>, %xmm0, %xmm0 # <addr>
               	jmp	<addr>

<bits_f>:
               	subq	$0x18, %rsp
               	movss	%xmm0, 0x8(%rsp)
               	movl	0x8(%rsp), %eax
               	addq	$0x18, %rsp
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
               	comisd	<rip>, %xmm1 # <addr>
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
               	comisd	<rip>, %xmm1 # <addr>
               	ja	<addr>
               	ucomisd	<rip>, %xmm1 # <addr>
               	jp	<addr>
               	jne	<addr>
               	testb	$0x1, %cl
               	je	<addr>
               	vaddsd	<rip>, %xmm0, %xmm0 # <addr>
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
               	vsubsd	<rip>, %xmm0, %xmm0 # <addr>
               	jmp	<addr>
               	cmpl	$0x1, %edi
               	jne	<addr>
               	xorps	%xmm2, %xmm2
               	comisd	%xmm1, %xmm2
               	jbe	<addr>
               	vsubsd	<rip>, %xmm0, %xmm0 # <addr>
               	jmp	<addr>
               	cmpl	$0x2, %edi
               	jne	<addr>
               	xorps	%xmm2, %xmm2
               	comisd	%xmm2, %xmm1
               	jbe	<addr>
               	vaddsd	<rip>, %xmm0, %xmm0 # <addr>
               	jmp	<addr>

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
               	movss	%xmm0, -0x10(%rbp)
               	callq	<addr>
               	movss	%xmm0, -0xc(%rbp)
               	callq	<addr>
               	movss	%xmm0, -0x8(%rbp)
               	callq	<addr>
               	movss	%xmm0, -0x4(%rbp)
               	movups	-0x10(%rbp), %xmm14
               	movups	%xmm14, 0x1c0(%rsp)
               	xorl	%ebx, %ebx
               	movq	%rbx, %r13
               	jmp	<addr>
               	orq	%rax, %r13
               	incq	%rbx
               	nopw	(%rax,%rax)
               	cmpl	$0x4, %ebx
               	jge	<addr>
               	leaq	-0x10(%rbp), %rax
               	movss	-0x10(%rbp,%rbx,4), %xmm0
               	ucomiss	%xmm0, %xmm0
               	sete	%cl
               	movzbq	%cl, %rcx
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rcx
               	xorl	%eax, %eax
               	testq	%rcx, %rcx
               	je	<addr>
               	movss	%xmm0, -0x20(%rbp)
               	movss	-0x20(%rbp), %xmm0
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
               	movl	%eax, -0x20(%rbp)
               	movss	-0x20(%rbp), %xmm0
               	leaq	-0x10(%rbp), %rax
               	movss	-0x10(%rbp,%rbx,4), %xmm1
               	ucomiss	%xmm1, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	jmp	<addr>
               	movss	-0x20(%rbp), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movl	$0x3, %edi
               	callq	<addr>
               	cvtsd2ss	%xmm0, %xmm0
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
               	movl	%eax, -0x18(%rbp)
               	leaq	-0x18(%rbp), %rax
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
               	leaq	-0x18(%rbp), %rax
               	stmxcsr	(%rax)
               	movl	-0x18(%rbp), %eax
               	shrq	$0x5, %rax
               	movq	%rax, %r15
               	andq	$0x1, %r15
               	movl	<rip>, %eax # <addr>
               	movl	%eax, -0x18(%rbp)
               	leaq	-0x18(%rbp), %rax
               	ldmxcsr	(%rax)
               	movq	-0x190(%rbp), %rax
               	movq	%rax, -0x1c0(%rbp)
               	movq	-0x188(%rbp), %rax
               	movq	%rax, -0x1b8(%rbp)
               	xorl	%ebx, %ebx
               	xorl	%r12d, %r12d
               	leaq	-0x1c0(%rbp), %rax
               	movss	-0x1c0(%rbp,%rbx,4), %xmm0
               	callq	<addr>
               	movq	%rax, %r14
               	leaq	-0x10(%rbp), %rax
               	movss	-0x10(%rbp,%rbx,4), %xmm0
               	movss	%xmm0, -0x20(%rbp)
               	movss	-0x20(%rbp), %xmm0
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
               	movl	%eax, -0x20(%rbp)
               	movss	-0x20(%rbp), %xmm0
               	callq	<addr>
               	movl	$0x1, %ecx
               	cmpl	%eax, %r14d
               	cmovneq	%rcx, %r12
               	jmp	<addr>
               	movss	-0x20(%rbp), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	xorl	%edi, %edi
               	callq	<addr>
               	cvtsd2ss	%xmm0, %xmm0
               	jmp	<addr>
               	incq	%rbx
               	nopl	(%rax)
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
               	movl	%eax, -0x18(%rbp)
               	leaq	-0x18(%rbp), %rax
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
               	leaq	-0x18(%rbp), %rax
               	stmxcsr	(%rax)
               	movl	-0x18(%rbp), %eax
               	shrq	$0x5, %rax
               	movq	%rax, %r15
               	andq	$0x1, %r15
               	movl	<rip>, %eax # <addr>
               	movl	%eax, -0x18(%rbp)
               	leaq	-0x18(%rbp), %rax
               	ldmxcsr	(%rax)
               	movq	-0x160(%rbp), %rax
               	movq	%rax, -0x1c0(%rbp)
               	movq	-0x158(%rbp), %rax
               	movq	%rax, -0x1b8(%rbp)
               	xorl	%ebx, %ebx
               	leaq	-0x1c0(%rbp), %rax
               	movss	-0x1c0(%rbp,%rbx,4), %xmm0
               	callq	<addr>
               	movq	%rax, %r14
               	leaq	-0x10(%rbp), %rax
               	movss	-0x10(%rbp,%rbx,4), %xmm0
               	movss	%xmm0, -0x20(%rbp)
               	movss	-0x20(%rbp), %xmm0
               	callq	<addr>
               	movl	%eax, %ecx
               	shrq	$0x17, %rcx
               	andq	$0xff, %rcx
               	nopw	(%rax,%rax)
               	cmpl	$0xff, %ecx
               	jne	<addr>
               	movl	$0x400000, %ecx         # imm = 0x400000
               	xorl	%edx, %edx
               	testl	$0x7fffff, %eax         # imm = 0x7FFFFF
               	cmoveq	%rdx, %rcx
               	orq	%rcx, %rax
               	movl	%eax, -0x20(%rbp)
               	movss	-0x20(%rbp), %xmm0
               	callq	<addr>
               	movl	$0x1, %ecx
               	cmpl	%eax, %r14d
               	cmovneq	%rcx, %r12
               	jmp	<addr>
               	movss	-0x20(%rbp), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movl	$0x1, %edi
               	callq	<addr>
               	cvtsd2ss	%xmm0, %xmm0
               	jmp	<addr>
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
               	movl	%eax, -0x18(%rbp)
               	leaq	-0x18(%rbp), %rax
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
               	leaq	-0x18(%rbp), %rax
               	stmxcsr	(%rax)
               	movl	-0x18(%rbp), %eax
               	shrq	$0x5, %rax
               	movq	%rax, %r15
               	andq	$0x1, %r15
               	movl	<rip>, %eax # <addr>
               	movl	%eax, -0x18(%rbp)
               	leaq	-0x18(%rbp), %rax
               	ldmxcsr	(%rax)
               	movq	-0x130(%rbp), %rax
               	movq	%rax, -0x1c0(%rbp)
               	movq	-0x128(%rbp), %rax
               	movq	%rax, -0x1b8(%rbp)
               	xorl	%ebx, %ebx
               	leaq	-0x1c0(%rbp), %rax
               	movss	-0x1c0(%rbp,%rbx,4), %xmm0
               	callq	<addr>
               	movq	%rax, %r14
               	leaq	-0x10(%rbp), %rax
               	movss	-0x10(%rbp,%rbx,4), %xmm0
               	movss	%xmm0, -0x20(%rbp)
               	movss	-0x20(%rbp), %xmm0
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
               	movl	%eax, -0x20(%rbp)
               	movss	-0x20(%rbp), %xmm0
               	callq	<addr>
               	movl	$0x1, %ecx
               	cmpl	%eax, %r14d
               	cmovneq	%rcx, %r12
               	jmp	<addr>
               	movss	-0x20(%rbp), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movl	$0x2, %edi
               	callq	<addr>
               	cvtsd2ss	%xmm0, %xmm0
               	nopl	(%rax)
               	jmp	<addr>
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
               	movl	%eax, -0x18(%rbp)
               	leaq	-0x18(%rbp), %rax
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
               	leaq	-0x18(%rbp), %rax
               	stmxcsr	(%rax)
               	movl	-0x18(%rbp), %eax
               	shrq	$0x5, %rax
               	movq	%rax, %r15
               	andq	$0x1, %r15
               	movl	<rip>, %eax # <addr>
               	movl	%eax, -0x18(%rbp)
               	leaq	-0x18(%rbp), %rax
               	ldmxcsr	(%rax)
               	movq	-0x100(%rbp), %rax
               	movq	%rax, -0x1c0(%rbp)
               	movq	-0xf8(%rbp), %rax
               	movq	%rax, -0x1b8(%rbp)
               	xorl	%ebx, %ebx
               	leaq	-0x1c0(%rbp), %rax
               	movss	-0x1c0(%rbp,%rbx,4), %xmm0
               	callq	<addr>
               	movq	%rax, %r14
               	leaq	-0x10(%rbp), %rax
               	movss	-0x10(%rbp,%rbx,4), %xmm0
               	movss	%xmm0, -0x20(%rbp)
               	movss	-0x20(%rbp), %xmm0
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
               	movl	%eax, -0x20(%rbp)
               	movss	-0x20(%rbp), %xmm0
               	callq	<addr>
               	movl	$0x1, %ecx
               	cmpl	%eax, %r14d
               	cmovneq	%rcx, %r12
               	jmp	<addr>
               	movss	-0x20(%rbp), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movl	$0x3, %edi
               	callq	<addr>
               	cvtsd2ss	%xmm0, %xmm0
               	jmp	<addr>
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
               	movl	%eax, -0x18(%rbp)
               	leaq	-0x18(%rbp), %rax
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
               	leaq	-0x18(%rbp), %rax
               	stmxcsr	(%rax)
               	movl	-0x18(%rbp), %eax
               	shrq	$0x5, %rax
               	movq	%rax, %r14
               	andq	$0x1, %r14
               	movl	<rip>, %eax # <addr>
               	movl	%eax, -0x18(%rbp)
               	leaq	-0x18(%rbp), %rax
               	ldmxcsr	(%rax)
               	movq	-0xd0(%rbp), %rax
               	movq	%rax, -0x1c0(%rbp)
               	movq	-0xc8(%rbp), %rax
               	movq	%rax, -0x1b8(%rbp)
               	xorl	%ebx, %ebx
               	leaq	-0x1c0(%rbp), %rax
               	movss	-0x1c0(%rbp,%rbx,4), %xmm0
               	callq	<addr>
               	movq	%rax, %r13
               	leaq	-0x10(%rbp), %rax
               	movss	-0x10(%rbp,%rbx,4), %xmm0
               	movss	%xmm0, -0x20(%rbp)
               	movss	-0x20(%rbp), %xmm0
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
               	movl	%eax, -0x20(%rbp)
               	movss	-0x20(%rbp), %xmm0
               	callq	<addr>
               	movl	$0x1, %ecx
               	cmpl	%eax, %r13d
               	cmovneq	%rcx, %r12
               	jmp	<addr>
               	movss	-0x20(%rbp), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	xorl	%edi, %edi
               	callq	<addr>
               	cvtsd2ss	%xmm0, %xmm0
               	nopl	(%rax,%rax)
               	jmp	<addr>
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
               	movl	%eax, -0x18(%rbp)
               	leaq	-0x18(%rbp), %rax
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
               	leaq	-0x18(%rbp), %rax
               	stmxcsr	(%rax)
               	movl	-0x18(%rbp), %eax
               	shrq	$0x5, %rax
               	movq	%rax, %r14
               	andq	$0x1, %r14
               	movl	<rip>, %eax # <addr>
               	movl	%eax, -0x18(%rbp)
               	leaq	-0x18(%rbp), %rax
               	ldmxcsr	(%rax)
               	movq	-0xa0(%rbp), %rax
               	movq	%rax, -0x1c0(%rbp)
               	movq	-0x98(%rbp), %rax
               	movq	%rax, -0x1b8(%rbp)
               	xorl	%ebx, %ebx
               	leaq	-0x1c0(%rbp), %rax
               	movss	-0x1c0(%rbp,%rbx,4), %xmm0
               	callq	<addr>
               	movq	%rax, %r13
               	leaq	-0x10(%rbp), %rax
               	movss	-0x10(%rbp,%rbx,4), %xmm0
               	movss	%xmm0, -0x20(%rbp)
               	movss	-0x20(%rbp), %xmm0
               	callq	<addr>
               	movl	%eax, %ecx
               	shrq	$0x17, %rcx
               	andq	$0xff, %rcx
               	nopw	(%rax,%rax)
               	cmpl	$0xff, %ecx
               	jne	<addr>
               	movl	$0x400000, %ecx         # imm = 0x400000
               	xorl	%edx, %edx
               	testl	$0x7fffff, %eax         # imm = 0x7FFFFF
               	cmoveq	%rdx, %rcx
               	orq	%rcx, %rax
               	movl	%eax, -0x20(%rbp)
               	movss	-0x20(%rbp), %xmm0
               	callq	<addr>
               	movl	$0x1, %ecx
               	cmpl	%eax, %r13d
               	cmovneq	%rcx, %r12
               	jmp	<addr>
               	movss	-0x20(%rbp), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movl	$0x1, %edi
               	callq	<addr>
               	cvtsd2ss	%xmm0, %xmm0
               	jmp	<addr>
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
               	movl	%eax, -0x18(%rbp)
               	leaq	-0x18(%rbp), %rax
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
               	leaq	-0x18(%rbp), %rax
               	stmxcsr	(%rax)
               	movl	-0x18(%rbp), %eax
               	shrq	$0x5, %rax
               	movq	%rax, %r14
               	andq	$0x1, %r14
               	movl	<rip>, %eax # <addr>
               	movl	%eax, -0x18(%rbp)
               	leaq	-0x18(%rbp), %rax
               	ldmxcsr	(%rax)
               	movq	-0x70(%rbp), %rax
               	movq	%rax, -0x1c0(%rbp)
               	movq	-0x68(%rbp), %rax
               	movq	%rax, -0x1b8(%rbp)
               	xorl	%ebx, %ebx
               	leaq	-0x1c0(%rbp), %rax
               	movss	-0x1c0(%rbp,%rbx,4), %xmm0
               	callq	<addr>
               	movq	%rax, %r13
               	leaq	-0x10(%rbp), %rax
               	movss	-0x10(%rbp,%rbx,4), %xmm0
               	movss	%xmm0, -0x20(%rbp)
               	movss	-0x20(%rbp), %xmm0
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
               	movl	%eax, -0x20(%rbp)
               	movss	-0x20(%rbp), %xmm0
               	callq	<addr>
               	movl	$0x1, %ecx
               	cmpl	%eax, %r13d
               	cmovneq	%rcx, %r12
               	jmp	<addr>
               	movss	-0x20(%rbp), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movl	$0x2, %edi
               	callq	<addr>
               	cvtsd2ss	%xmm0, %xmm0
               	jmp	<addr>
               	incq	%rbx
               	nopl	(%rax,%rax)
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
               	movl	%eax, -0x18(%rbp)
               	leaq	-0x18(%rbp), %rax
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
               	leaq	-0x18(%rbp), %rax
               	stmxcsr	(%rax)
               	movl	-0x18(%rbp), %eax
               	shrq	$0x5, %rax
               	movq	%rax, %r14
               	andq	$0x1, %r14
               	movl	<rip>, %eax # <addr>
               	movl	%eax, -0x18(%rbp)
               	leaq	-0x18(%rbp), %rax
               	ldmxcsr	(%rax)
               	movq	-0x40(%rbp), %rax
               	movq	%rax, -0x1c0(%rbp)
               	movq	-0x38(%rbp), %rax
               	movq	%rax, -0x1b8(%rbp)
               	xorl	%ebx, %ebx
               	leaq	-0x1c0(%rbp), %rax
               	movss	-0x1c0(%rbp,%rbx,4), %xmm0
               	callq	<addr>
               	movq	%rax, %r13
               	leaq	-0x10(%rbp), %rax
               	movss	-0x10(%rbp,%rbx,4), %xmm0
               	movss	%xmm0, -0x20(%rbp)
               	movss	-0x20(%rbp), %xmm0
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
               	movl	%eax, -0x20(%rbp)
               	movss	-0x20(%rbp), %xmm0
               	callq	<addr>
               	movl	$0x1, %ecx
               	cmpl	%eax, %r13d
               	cmovneq	%rcx, %r12
               	jmp	<addr>
               	movss	-0x20(%rbp), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movl	$0x3, %edi
               	callq	<addr>
               	cvtsd2ss	%xmm0, %xmm0
               	nopl	(%rax,%rax)
               	jmp	<addr>
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
               	leaq	-0x8(%rbp), %rdx
               	leaq	<rip>, %rsi # <addr>
               	shrq	$0x20, %rax
               	movl	$0xaaaaaaab, %ecx       # imm = 0xAAAAAAAB
               	imulq	%rax, %rcx
               	shrq	$0x21, %rcx
               	leaq	(%rcx,%rcx,2), %rcx
               	subq	%rcx, %rax
               	shlq	$0x3, %rax
               	addq	%rsi, %rax
               	movq	(%rax), %r10
               	movq	%r10, (%rdx)
               	movsd	(%rax), %xmm0
               	movsd	%xmm0, -0x10(%rbp)
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
               	leaq	-0x18(%rbp), %rdx
               	leaq	<rip>, %rsi # <addr>
               	shrq	$0x20, %rax
               	movl	$0xaaaaaaab, %ecx       # imm = 0xAAAAAAAB
               	imulq	%rax, %rcx
               	shrq	$0x21, %rcx
               	leaq	(%rcx,%rcx,2), %rcx
               	subq	%rcx, %rax
               	shlq	$0x3, %rax
               	addq	%rsi, %rax
               	movq	(%rax), %r10
               	movq	%r10, (%rdx)
               	movsd	(%rax), %xmm0
               	movsd	%xmm0, -0x8(%rbp)
               	movups	-0x10(%rbp), %xmm14
               	movups	%xmm14, 0x160(%rsp)
               	xorl	%ebx, %ebx
               	movq	%rbx, %r13
               	jmp	<addr>
               	orq	%rax, %r13
               	incq	%rbx
               	cmpl	$0x2, %ebx
               	jge	<addr>
               	vmovq	-0x10(%rbp,%rbx,8), %xmm0
               	ucomisd	%xmm0, %xmm0
               	sete	%cl
               	movzbq	%cl, %rcx
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rcx
               	xorl	%eax, %eax
               	nopw	(%rax,%rax)
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x3, %edi
               	callq	<addr>
               	vmovq	-0x10(%rbp,%rbx,8), %xmm1
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
               	movl	%eax, -0x18(%rbp)
               	leaq	-0x18(%rbp), %rax
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
               	leaq	-0x18(%rbp), %rax
               	stmxcsr	(%rax)
               	movl	-0x18(%rbp), %eax
               	shrq	$0x5, %rax
               	movq	%rax, %r15
               	andq	$0x1, %r15
               	movl	<rip>, %eax # <addr>
               	movl	%eax, -0x18(%rbp)
               	leaq	-0x18(%rbp), %rax
               	ldmxcsr	(%rax)
               	movq	-0x130(%rbp), %rax
               	movq	%rax, -0x160(%rbp)
               	movq	-0x128(%rbp), %rax
               	movq	%rax, -0x158(%rbp)
               	xorl	%ebx, %ebx
               	xorl	%r12d, %r12d
               	vmovq	-0x160(%rbp,%rbx,8), %xmm0
               	movq	%xmm0, %r14
               	vmovq	-0x10(%rbp,%rbx,8), %xmm0
               	xorl	%edi, %edi
               	callq	<addr>
               	movq	%xmm0, %rax
               	movl	$0x2, %ecx
               	cmpq	%rax, %r14
               	cmovneq	%rcx, %r12
               	incq	%rbx
               	nop
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
               	movl	%eax, -0x18(%rbp)
               	leaq	-0x18(%rbp), %rax
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
               	leaq	-0x18(%rbp), %rax
               	stmxcsr	(%rax)
               	movl	-0x18(%rbp), %eax
               	shrq	$0x5, %rax
               	movq	%rax, %r15
               	andq	$0x1, %r15
               	movl	<rip>, %eax # <addr>
               	movl	%eax, -0x18(%rbp)
               	leaq	-0x18(%rbp), %rax
               	ldmxcsr	(%rax)
               	movq	-0x100(%rbp), %rax
               	movq	%rax, -0x160(%rbp)
               	movq	-0xf8(%rbp), %rax
               	movq	%rax, -0x158(%rbp)
               	xorl	%ebx, %ebx
               	vmovq	-0x160(%rbp,%rbx,8), %xmm0
               	movq	%xmm0, %r14
               	vmovq	-0x10(%rbp,%rbx,8), %xmm0
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
               	movl	%eax, -0x18(%rbp)
               	leaq	-0x18(%rbp), %rax
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
               	leaq	-0x18(%rbp), %rax
               	stmxcsr	(%rax)
               	movl	-0x18(%rbp), %eax
               	shrq	$0x5, %rax
               	movq	%rax, %r15
               	andq	$0x1, %r15
               	movl	<rip>, %eax # <addr>
               	movl	%eax, -0x18(%rbp)
               	leaq	-0x18(%rbp), %rax
               	ldmxcsr	(%rax)
               	movq	-0xd0(%rbp), %rax
               	movq	%rax, -0x160(%rbp)
               	movq	-0xc8(%rbp), %rax
               	movq	%rax, -0x158(%rbp)
               	xorl	%ebx, %ebx
               	vmovq	-0x160(%rbp,%rbx,8), %xmm0
               	movq	%xmm0, %r14
               	vmovq	-0x10(%rbp,%rbx,8), %xmm0
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%xmm0, %rax
               	movl	$0x2, %ecx
               	cmpq	%rax, %r14
               	cmovneq	%rcx, %r12
               	incq	%rbx
               	nopw	(%rax,%rax)
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
               	movl	%eax, -0x18(%rbp)
               	leaq	-0x18(%rbp), %rax
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
               	leaq	-0x18(%rbp), %rax
               	stmxcsr	(%rax)
               	movl	-0x18(%rbp), %eax
               	shrq	$0x5, %rax
               	movq	%rax, %r15
               	andq	$0x1, %r15
               	movl	<rip>, %eax # <addr>
               	movl	%eax, -0x18(%rbp)
               	leaq	-0x18(%rbp), %rax
               	ldmxcsr	(%rax)
               	movq	-0xa0(%rbp), %rax
               	movq	%rax, -0x160(%rbp)
               	movq	-0x98(%rbp), %rax
               	movq	%rax, -0x158(%rbp)
               	xorl	%ebx, %ebx
               	vmovq	-0x160(%rbp,%rbx,8), %xmm0
               	movq	%xmm0, %r14
               	vmovq	-0x10(%rbp,%rbx,8), %xmm0
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
               	movl	%eax, -0x18(%rbp)
               	leaq	-0x18(%rbp), %rax
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
               	leaq	-0x18(%rbp), %rax
               	stmxcsr	(%rax)
               	movl	-0x18(%rbp), %eax
               	shrq	$0x5, %rax
               	movq	%rax, %r14
               	andq	$0x1, %r14
               	movl	<rip>, %eax # <addr>
               	movl	%eax, -0x18(%rbp)
               	leaq	-0x18(%rbp), %rax
               	ldmxcsr	(%rax)
               	movq	-0x70(%rbp), %rax
               	movq	%rax, -0x160(%rbp)
               	movq	-0x68(%rbp), %rax
               	movq	%rax, -0x158(%rbp)
               	xorl	%ebx, %ebx
               	vmovq	-0x160(%rbp,%rbx,8), %xmm0
               	movq	%xmm0, %r13
               	vmovq	-0x10(%rbp,%rbx,8), %xmm0
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
               	movl	%eax, -0x18(%rbp)
               	leaq	-0x18(%rbp), %rax
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
               	leaq	-0x18(%rbp), %rax
               	stmxcsr	(%rax)
               	movl	-0x18(%rbp), %eax
               	shrq	$0x5, %rax
               	movq	%rax, %r14
               	andq	$0x1, %r14
               	movl	<rip>, %eax # <addr>
               	movl	%eax, -0x18(%rbp)
               	leaq	-0x18(%rbp), %rax
               	ldmxcsr	(%rax)
               	movq	-0x40(%rbp), %rax
               	movq	%rax, -0x160(%rbp)
               	movq	-0x38(%rbp), %rax
               	movq	%rax, -0x158(%rbp)
               	xorl	%ebx, %ebx
               	vmovq	-0x160(%rbp,%rbx,8), %xmm0
               	movq	%xmm0, %r13
               	vmovq	-0x10(%rbp,%rbx,8), %xmm0
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
               	movq	%rax, %rcx
               	shrq	$0x3e, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	leaq	<rip>, %rdx # <addr>
               	shrq	$0x20, %rax
               	movq	%rax, %rcx
               	shrq	$0x3, %rcx
               	imulq	$0x55555556, %rcx, %rcx # imm = 0x55555556
               	shrq	$0x20, %rcx
               	imulq	$0x18, %rcx, %rcx
               	subq	%rcx, %rax
               	vmovq	(%rdx,%rax,8), %xmm0
               	jmp	<addr>
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
               	movl	$0x1, %edx
               	movq	%rax, %rcx
               	shrq	$0x8, %rcx
               	andq	$0xf, %rcx
               	shlxq	%rcx, %rdx, %rcx
               	movslq	%ecx, %rcx
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rcx, %xmm1
               	divsd	%xmm1, %xmm0
               	testb	$0x1, %al
               	je	<addr>
               	vxorpd	<rip>, %xmm0, %xmm0 # <addr>
               	jmp	<addr>
               	movq	%rax, %rcx
               	shrq	$0x3e, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	leaq	<rip>, %rdx # <addr>
               	shrq	$0x20, %rax
               	movq	%rax, %rcx
               	shrq	$0x3, %rcx
               	imulq	$0x55555556, %rcx, %rcx # imm = 0x55555556
               	shrq	$0x20, %rcx
               	imulq	$0x18, %rcx, %rcx
               	subq	%rcx, %rax
               	vmovq	(%rdx,%rax,8), %xmm0
               	jmp	<addr>
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
               	movl	$0x1, %edx
               	movq	%rax, %rcx
               	shrq	$0x8, %rcx
               	andq	$0xf, %rcx
               	shlxq	%rcx, %rdx, %rcx
               	movslq	%ecx, %rcx
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rcx, %xmm1
               	divsd	%xmm1, %xmm0
               	testb	$0x1, %al
               	je	<addr>
               	vxorpd	<rip>, %xmm0, %xmm0 # <addr>
               	jmp	<addr>

<check_round_scalar>:
               	subq	$0xc8, %rsp
               	pushq	%r12
               	pushq	%rbx
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	vmovd	%r11d, %xmm14
               	movups	%xmm14, 0xb0(%rsp)
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	vmovd	%r11d, %xmm14
               	movups	%xmm14, 0x90(%rsp)
               	movsd	%xmm0, 0xa0(%rsp)
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	0xb0(%rsp), %xmm14
               	vpinsrd	$0x1, %r11d, %xmm14, %xmm14
               	movups	%xmm14, 0xb0(%rsp)
               	movsd	%xmm0, 0x20(%rsp)
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	0x90(%rsp), %xmm14
               	vpinsrd	$0x1, %r11d, %xmm14, %xmm14
               	movups	%xmm14, 0x90(%rsp)
               	movsd	%xmm0, 0x48(%rsp)
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	0xb0(%rsp), %xmm14
               	vpinsrd	$0x2, %r11d, %xmm14, %xmm14
               	movups	%xmm14, 0xb0(%rsp)
               	movsd	%xmm0, 0x30(%rsp)
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	0x90(%rsp), %xmm14
               	vpinsrd	$0x2, %r11d, %xmm14, %xmm14
               	movups	%xmm14, 0x90(%rsp)
               	movsd	%xmm0, 0x40(%rsp)
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	0xb0(%rsp), %xmm14
               	vpinsrd	$0x3, %r11d, %xmm14, %xmm14
               	movups	%xmm14, 0x70(%rsp)
               	movsd	%xmm0, 0x28(%rsp)
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	0x90(%rsp), %xmm14
               	vpinsrd	$0x3, %r11d, %xmm14, %xmm14
               	movups	%xmm14, 0x90(%rsp)
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
               	movsd	%xmm0, 0x38(%rsp)
               	movq	%rax, %rcx
               	shrq	$0x3b, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	leaq	<rip>, %rdx # <addr>
               	shrq	$0x20, %rax
               	movl	$0xaaaaaaab, %ecx       # imm = 0xAAAAAAAB
               	imulq	%rax, %rcx
               	shrq	$0x21, %rcx
               	leaq	(%rcx,%rcx,2), %rcx
               	subq	%rcx, %rax
               	shlq	$0x3, %rax
               	addq	%rdx, %rax
               	movsd	(%rax), %xmm0
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
               	leaq	<rip>, %rdx # <addr>
               	shrq	$0x20, %rax
               	movl	$0xaaaaaaab, %ecx       # imm = 0xAAAAAAAB
               	imulq	%rax, %rcx
               	shrq	$0x21, %rcx
               	leaq	(%rcx,%rcx,2), %rcx
               	subq	%rcx, %rax
               	shlq	$0x3, %rax
               	addq	%rdx, %rax
               	movsd	(%rax), %xmm14
               	movsd	%xmm14, 0xb8(%rsp)
               	movsd	0xb8(%rsp), %xmm15
               	vmovq	%xmm15, %r11
               	vmovq	%r11, %xmm1
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
               	leaq	<rip>, %rdx # <addr>
               	shrq	$0x20, %rax
               	movl	$0xaaaaaaab, %ecx       # imm = 0xAAAAAAAB
               	imulq	%rax, %rcx
               	shrq	$0x21, %rcx
               	leaq	(%rcx,%rcx,2), %rcx
               	subq	%rcx, %rax
               	shlq	$0x3, %rax
               	addq	%rdx, %rax
               	movsd	(%rax), %xmm14
               	movsd	%xmm14, 0xb0(%rsp)
               	movsd	0xb0(%rsp), %xmm15
               	vmovq	%xmm15, %r11
               	movapd	%xmm0, %xmm14
               	vpinsrq	$0x1, %r11, %xmm14, %xmm14
               	movups	%xmm14, 0x50(%rsp)
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
               	leaq	<rip>, %rdx # <addr>
               	shrq	$0x20, %rax
               	movl	$0xaaaaaaab, %ecx       # imm = 0xAAAAAAAB
               	imulq	%rax, %rcx
               	shrq	$0x21, %rcx
               	leaq	(%rcx,%rcx,2), %rcx
               	subq	%rcx, %rax
               	shlq	$0x3, %rax
               	addq	%rdx, %rax
               	movsd	(%rax), %xmm14
               	movsd	%xmm14, 0xa8(%rsp)
               	movsd	0xa8(%rsp), %xmm15
               	vmovq	%xmm15, %r11
               	movapd	%xmm1, %xmm14
               	vpinsrq	$0x1, %r11, %xmm14, %xmm14
               	movups	%xmm14, 0x80(%rsp)
               	movups	0x70(%rsp), %xmm14
               	movups	0x90(%rsp), %xmm15
               	vroundss	$0x3, %xmm15, %xmm14, %xmm1
               	vpermilps	$0x0, %xmm1, %xmm0 # xmm0 = xmm1[0,0,0,0]
               	movups	%xmm1, 0x60(%rsp)
               	callq	<addr>
               	movq	%rax, %rbx
               	movsd	0xa0(%rsp), %xmm0
               	movss	%xmm0, 0xc0(%rsp)
               	movss	0xc0(%rsp), %xmm0
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
               	movl	%eax, 0xc0(%rsp)
               	movss	0xc0(%rsp), %xmm0
               	callq	<addr>
               	cmpl	%eax, %ebx
               	setne	%bl
               	movzbq	%bl, %rbx
               	movups	0x60(%rsp), %xmm14
               	vpermilps	$0x1, %xmm14, %xmm0 # xmm0 = xmm14[1,0,0,0]
               	callq	<addr>
               	movq	%rax, %r12
               	movsd	0x20(%rsp), %xmm0
               	callq	<addr>
               	cmpl	%eax, %r12d
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rax, %rbx
               	movups	0x60(%rsp), %xmm14
               	vpermilps	$0x2, %xmm14, %xmm0 # xmm0 = xmm14[2,0,0,0]
               	callq	<addr>
               	movq	%rax, %r12
               	movsd	0x30(%rsp), %xmm0
               	callq	<addr>
               	cmpl	%eax, %r12d
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rax, %rbx
               	movups	0x60(%rsp), %xmm14
               	vpermilps	$0x3, %xmm14, %xmm0 # xmm0 = xmm14[3,0,0,0]
               	callq	<addr>
               	movq	%rax, %r12
               	movsd	0x28(%rsp), %xmm0
               	callq	<addr>
               	cmpl	%eax, %r12d
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rax, %rbx
               	movups	0x50(%rsp), %xmm14
               	movups	0x80(%rsp), %xmm15
               	vroundsd	$0x2, %xmm15, %xmm14, %xmm1
               	vpermilpd	$0x0, %xmm1, %xmm0 # xmm0 = xmm1[0,0]
               	movq	%xmm0, %r12
               	movsd	0xb8(%rsp), %xmm0
               	movups	%xmm1, 0x10(%rsp)
               	movl	$0x2, %edi
               	callq	<addr>
               	movups	0x10(%rsp), %xmm1
               	movq	%xmm0, %rax
               	cmpq	%rax, %r12
               	movl	$0x1, %eax
               	jne	<addr>
               	vpermilpd	$0x1, %xmm1, %xmm0 # xmm0 = xmm1[1,0]
               	movq	%xmm0, %rax
               	movsd	0xb0(%rsp), %xmm0
               	movq	%xmm0, %rcx
               	cmpq	%rcx, %rax
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rax, %rbx
               	movups	0x90(%rsp), %xmm14
               	roundps	$0x1, %xmm14, %xmm1
               	vpermilps	$0x0, %xmm1, %xmm0 # xmm0 = xmm1[0,0,0,0]
               	movups	%xmm1, 0x60(%rsp)
               	callq	<addr>
               	movq	%rax, %r12
               	movsd	0xa0(%rsp), %xmm0
               	movss	%xmm0, 0xc0(%rsp)
               	movss	0xc0(%rsp), %xmm0
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
               	movl	%eax, 0xc0(%rsp)
               	movss	0xc0(%rsp), %xmm0
               	callq	<addr>
               	cmpl	%eax, %r12d
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rax, %rbx
               	movups	0x60(%rsp), %xmm14
               	vpermilps	$0x1, %xmm14, %xmm0 # xmm0 = xmm14[1,0,0,0]
               	callq	<addr>
               	movq	%rax, %r12
               	movsd	0x48(%rsp), %xmm0
               	movss	%xmm0, 0xc0(%rsp)
               	movss	0xc0(%rsp), %xmm0
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
               	movl	%eax, 0xc0(%rsp)
               	movss	0xc0(%rsp), %xmm0
               	callq	<addr>
               	cmpl	%eax, %r12d
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rax, %rbx
               	movups	0x60(%rsp), %xmm14
               	vpermilps	$0x2, %xmm14, %xmm0 # xmm0 = xmm14[2,0,0,0]
               	callq	<addr>
               	movq	%rax, %r12
               	movsd	0x40(%rsp), %xmm0
               	movss	%xmm0, 0xc0(%rsp)
               	movss	0xc0(%rsp), %xmm0
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
               	movl	%eax, 0xc0(%rsp)
               	movss	0xc0(%rsp), %xmm0
               	callq	<addr>
               	cmpl	%eax, %r12d
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rax, %rbx
               	movups	0x60(%rsp), %xmm14
               	vpermilps	$0x3, %xmm14, %xmm0 # xmm0 = xmm14[3,0,0,0]
               	callq	<addr>
               	movq	%rax, %r12
               	movsd	0x38(%rsp), %xmm0
               	movss	%xmm0, 0xc0(%rsp)
               	movss	0xc0(%rsp), %xmm0
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
               	movl	%eax, 0xc0(%rsp)
               	movss	0xc0(%rsp), %xmm0
               	callq	<addr>
               	cmpl	%eax, %r12d
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rax, %rbx
               	movups	0x90(%rsp), %xmm14
               	roundps	$0x2, %xmm14, %xmm1
               	vpermilps	$0x0, %xmm1, %xmm0 # xmm0 = xmm1[0,0,0,0]
               	movups	%xmm1, 0x60(%rsp)
               	callq	<addr>
               	movq	%rax, %r12
               	movsd	0xa0(%rsp), %xmm0
               	movss	%xmm0, 0xc0(%rsp)
               	movss	0xc0(%rsp), %xmm0
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
               	movl	%eax, 0xc0(%rsp)
               	movss	0xc0(%rsp), %xmm0
               	callq	<addr>
               	cmpl	%eax, %r12d
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rax, %rbx
               	movups	0x60(%rsp), %xmm14
               	vpermilps	$0x1, %xmm14, %xmm0 # xmm0 = xmm14[1,0,0,0]
               	callq	<addr>
               	movq	%rax, %r12
               	movsd	0x48(%rsp), %xmm0
               	movss	%xmm0, 0xc0(%rsp)
               	movss	0xc0(%rsp), %xmm0
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
               	movl	%eax, 0xc0(%rsp)
               	movss	0xc0(%rsp), %xmm0
               	callq	<addr>
               	cmpl	%eax, %r12d
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rax, %rbx
               	movups	0x60(%rsp), %xmm14
               	vpermilps	$0x2, %xmm14, %xmm0 # xmm0 = xmm14[2,0,0,0]
               	callq	<addr>
               	movq	%rax, %r12
               	movsd	0x40(%rsp), %xmm0
               	movss	%xmm0, 0xc0(%rsp)
               	movss	0xc0(%rsp), %xmm0
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
               	movl	%eax, 0xc0(%rsp)
               	movss	0xc0(%rsp), %xmm0
               	callq	<addr>
               	cmpl	%eax, %r12d
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rax, %rbx
               	movups	0x60(%rsp), %xmm14
               	vpermilps	$0x3, %xmm14, %xmm0 # xmm0 = xmm14[3,0,0,0]
               	callq	<addr>
               	movq	%rax, %r12
               	movsd	0x38(%rsp), %xmm0
               	movss	%xmm0, 0xc0(%rsp)
               	movss	0xc0(%rsp), %xmm0
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
               	movl	%eax, 0xc0(%rsp)
               	movss	0xc0(%rsp), %xmm0
               	callq	<addr>
               	cmpl	%eax, %r12d
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rax, %rbx
               	movups	0x80(%rsp), %xmm14
               	roundpd	$0x1, %xmm14, %xmm0
               	movq	%xmm0, %r12
               	movsd	0xb8(%rsp), %xmm0
               	movl	$0x1, %edi
               	callq	<addr>
               	movq	%xmm0, %rax
               	cmpq	%rax, %r12
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rax, %rbx
               	movups	0x80(%rsp), %xmm14
               	roundpd	$0x2, %xmm14, %xmm0
               	vpermilpd	$0x1, %xmm0, %xmm0 # xmm0 = xmm0[1,0]
               	movq	%xmm0, %r12
               	movsd	0xa8(%rsp), %xmm0
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%xmm0, %rax
               	cmpq	%rax, %r12
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rax, %rbx
               	movups	0x70(%rsp), %xmm14
               	movups	0x90(%rsp), %xmm15
               	vroundss	$0x1, %xmm15, %xmm14, %xmm1
               	vpermilps	$0x0, %xmm1, %xmm0 # xmm0 = xmm1[0,0,0,0]
               	movups	%xmm1, 0x60(%rsp)
               	callq	<addr>
               	movq	%rax, %r12
               	movsd	0xa0(%rsp), %xmm0
               	movss	%xmm0, 0xc0(%rsp)
               	movss	0xc0(%rsp), %xmm0
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
               	movl	%eax, 0xc0(%rsp)
               	movss	0xc0(%rsp), %xmm0
               	callq	<addr>
               	cmpl	%eax, %r12d
               	movl	$0x1, %eax
               	jne	<addr>
               	movups	0x60(%rsp), %xmm14
               	vpermilps	$0x3, %xmm14, %xmm0 # xmm0 = xmm14[3,0,0,0]
               	callq	<addr>
               	movq	%rax, %r12
               	movsd	0x28(%rsp), %xmm0
               	callq	<addr>
               	cmpl	%eax, %r12d
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rax, %rbx
               	movups	0x70(%rsp), %xmm14
               	movups	0x90(%rsp), %xmm15
               	vroundss	$0x2, %xmm15, %xmm14, %xmm1
               	vpermilps	$0x0, %xmm1, %xmm0 # xmm0 = xmm1[0,0,0,0]
               	movups	%xmm1, 0x90(%rsp)
               	callq	<addr>
               	movq	%rax, %r12
               	movsd	0xa0(%rsp), %xmm0
               	movss	%xmm0, 0xc0(%rsp)
               	movss	0xc0(%rsp), %xmm0
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
               	movl	%eax, 0xc0(%rsp)
               	movss	0xc0(%rsp), %xmm0
               	callq	<addr>
               	cmpl	%eax, %r12d
               	movl	$0x1, %eax
               	jne	<addr>
               	movups	0x90(%rsp), %xmm14
               	vpermilps	$0x2, %xmm14, %xmm0 # xmm0 = xmm14[2,0,0,0]
               	callq	<addr>
               	movq	%rax, %r12
               	movsd	0x30(%rsp), %xmm0
               	callq	<addr>
               	cmpl	%eax, %r12d
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rax, %rbx
               	movups	0x50(%rsp), %xmm14
               	movups	0x80(%rsp), %xmm15
               	vroundsd	$0x1, %xmm15, %xmm14, %xmm1
               	vpermilpd	$0x0, %xmm1, %xmm0 # xmm0 = xmm1[0,0]
               	movq	%xmm0, %r12
               	movsd	0xb8(%rsp), %xmm0
               	movups	%xmm1, 0x10(%rsp)
               	movl	$0x1, %edi
               	callq	<addr>
               	movups	0x10(%rsp), %xmm1
               	movq	%xmm0, %rax
               	cmpq	%rax, %r12
               	movl	$0x1, %eax
               	jne	<addr>
               	vpermilpd	$0x1, %xmm1, %xmm0 # xmm0 = xmm1[1,0]
               	movq	%xmm0, %rax
               	movsd	0xb0(%rsp), %xmm0
               	movq	%xmm0, %rcx
               	cmpq	%rcx, %rax
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rax, %rbx
               	movups	0x50(%rsp), %xmm14
               	movups	0x80(%rsp), %xmm15
               	vroundsd	$0x2, %xmm15, %xmm14, %xmm1
               	vpermilpd	$0x0, %xmm1, %xmm0 # xmm0 = xmm1[0,0]
               	movq	%xmm0, %r12
               	movsd	0xb8(%rsp), %xmm0
               	movups	%xmm1, 0x10(%rsp)
               	movl	$0x2, %edi
               	callq	<addr>
               	movups	0x10(%rsp), %xmm1
               	movq	%xmm0, %rax
               	cmpq	%rax, %r12
               	movl	$0x1, %eax
               	jne	<addr>
               	vpermilpd	$0x1, %xmm1, %xmm0 # xmm0 = xmm1[1,0]
               	movq	%xmm0, %rax
               	movsd	0xb0(%rsp), %xmm0
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
               	addq	$0xc8, %rsp
               	retq
               	movss	0xc0(%rsp), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movl	$0x2, %edi
               	callq	<addr>
               	cvtsd2ss	%xmm0, %xmm0
               	jmp	<addr>
               	movss	0xc0(%rsp), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movl	$0x1, %edi
               	callq	<addr>
               	cvtsd2ss	%xmm0, %xmm0
               	jmp	<addr>
               	movss	0xc0(%rsp), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movl	$0x2, %edi
               	callq	<addr>
               	cvtsd2ss	%xmm0, %xmm0
               	jmp	<addr>
               	movss	0xc0(%rsp), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movl	$0x2, %edi
               	callq	<addr>
               	cvtsd2ss	%xmm0, %xmm0
               	jmp	<addr>
               	movss	0xc0(%rsp), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movl	$0x2, %edi
               	callq	<addr>
               	cvtsd2ss	%xmm0, %xmm0
               	jmp	<addr>
               	movss	0xc0(%rsp), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movl	$0x2, %edi
               	callq	<addr>
               	cvtsd2ss	%xmm0, %xmm0
               	jmp	<addr>
               	movss	0xc0(%rsp), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movl	$0x1, %edi
               	callq	<addr>
               	cvtsd2ss	%xmm0, %xmm0
               	jmp	<addr>
               	movss	0xc0(%rsp), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movl	$0x1, %edi
               	callq	<addr>
               	cvtsd2ss	%xmm0, %xmm0
               	jmp	<addr>
               	movss	0xc0(%rsp), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movl	$0x1, %edi
               	callq	<addr>
               	cvtsd2ss	%xmm0, %xmm0
               	jmp	<addr>
               	movss	0xc0(%rsp), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movl	$0x1, %edi
               	callq	<addr>
               	cvtsd2ss	%xmm0, %xmm0
               	jmp	<addr>
               	movss	0xc0(%rsp), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movl	$0x3, %edi
               	callq	<addr>
               	cvtsd2ss	%xmm0, %xmm0
               	jmp	<addr>
               	movq	%rax, %rcx
               	shrq	$0x3e, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	leaq	<rip>, %rdx # <addr>
               	shrq	$0x20, %rax
               	movq	%rax, %rcx
               	shrq	$0x3, %rcx
               	imulq	$0x55555556, %rcx, %rcx # imm = 0x55555556
               	shrq	$0x20, %rcx
               	imulq	$0x18, %rcx, %rcx
               	subq	%rcx, %rax
               	vmovq	(%rdx,%rax,8), %xmm14
               	movsd	%xmm14, 0xa8(%rsp)
               	jmp	<addr>
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
               	movl	$0x1, %edx
               	movq	%rax, %rcx
               	shrq	$0x8, %rcx
               	andq	$0xf, %rcx
               	shlxq	%rcx, %rdx, %rcx
               	movslq	%ecx, %rcx
               	xorps	%xmm2, %xmm2
               	cvtsi2sd	%rcx, %xmm2
               	vdivsd	%xmm2, %xmm0, %xmm14
               	movsd	%xmm14, 0xa8(%rsp)
               	testb	$0x1, %al
               	je	<addr>
               	movsd	0xa8(%rsp), %xmm14
               	vxorpd	<rip>, %xmm14, %xmm14 # <addr>
               	movsd	%xmm14, 0xa8(%rsp)
               	jmp	<addr>
               	movq	%rax, %rcx
               	shrq	$0x3e, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	leaq	<rip>, %rdx # <addr>
               	shrq	$0x20, %rax
               	movq	%rax, %rcx
               	shrq	$0x3, %rcx
               	imulq	$0x55555556, %rcx, %rcx # imm = 0x55555556
               	shrq	$0x20, %rcx
               	imulq	$0x18, %rcx, %rcx
               	subq	%rcx, %rax
               	vmovq	(%rdx,%rax,8), %xmm14
               	movsd	%xmm14, 0xb0(%rsp)
               	jmp	<addr>
               	movq	%rax, %rcx
               	shrq	$0x28, %rcx
               	xorps	%xmm2, %xmm2
               	movq	%rcx, %r10
               	testq	%r10, %r10
               	js	<addr>
               	cvtsi2sd	%r10, %xmm2
               	jmp	<addr>
               	movq	%r10, %r11
               	shrq	%r11
               	andq	$0x1, %r10
               	orq	%r10, %r11
               	cvtsi2sd	%r11, %xmm2
               	addsd	%xmm2, %xmm2
               	movl	$0x1, %edx
               	movq	%rax, %rcx
               	shrq	$0x8, %rcx
               	andq	$0xf, %rcx
               	shlxq	%rcx, %rdx, %rcx
               	movslq	%ecx, %rcx
               	xorps	%xmm3, %xmm3
               	cvtsi2sd	%rcx, %xmm3
               	vdivsd	%xmm3, %xmm2, %xmm14
               	movsd	%xmm14, 0xb0(%rsp)
               	testb	$0x1, %al
               	je	<addr>
               	movsd	0xb0(%rsp), %xmm14
               	vxorpd	<rip>, %xmm14, %xmm14 # <addr>
               	movsd	%xmm14, 0xb0(%rsp)
               	jmp	<addr>
               	movq	%rax, %rcx
               	shrq	$0x3e, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	leaq	<rip>, %rdx # <addr>
               	shrq	$0x20, %rax
               	movq	%rax, %rcx
               	shrq	$0x3, %rcx
               	imulq	$0x55555556, %rcx, %rcx # imm = 0x55555556
               	shrq	$0x20, %rcx
               	imulq	$0x18, %rcx, %rcx
               	subq	%rcx, %rax
               	vmovq	(%rdx,%rax,8), %xmm14
               	movsd	%xmm14, 0xb8(%rsp)
               	jmp	<addr>
               	movq	%rax, %rcx
               	shrq	$0x28, %rcx
               	xorps	%xmm1, %xmm1
               	movq	%rcx, %r10
               	testq	%r10, %r10
               	js	<addr>
               	cvtsi2sd	%r10, %xmm1
               	jmp	<addr>
               	movq	%r10, %r11
               	shrq	%r11
               	andq	$0x1, %r10
               	orq	%r10, %r11
               	cvtsi2sd	%r11, %xmm1
               	addsd	%xmm1, %xmm1
               	movl	$0x1, %edx
               	movq	%rax, %rcx
               	shrq	$0x8, %rcx
               	andq	$0xf, %rcx
               	shlxq	%rcx, %rdx, %rcx
               	movslq	%ecx, %rcx
               	xorps	%xmm2, %xmm2
               	cvtsi2sd	%rcx, %xmm2
               	vdivsd	%xmm2, %xmm1, %xmm14
               	movsd	%xmm14, 0xb8(%rsp)
               	testb	$0x1, %al
               	je	<addr>
               	movsd	0xb8(%rsp), %xmm14
               	vxorpd	<rip>, %xmm14, %xmm14 # <addr>
               	movsd	%xmm14, 0xb8(%rsp)
               	jmp	<addr>
               	movq	%rax, %rcx
               	shrq	$0x3e, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	leaq	<rip>, %rdx # <addr>
               	shrq	$0x20, %rax
               	movq	%rax, %rcx
               	shrq	$0x3, %rcx
               	imulq	$0x55555556, %rcx, %rcx # imm = 0x55555556
               	shrq	$0x20, %rcx
               	imulq	$0x18, %rcx, %rcx
               	subq	%rcx, %rax
               	vmovq	(%rdx,%rax,8), %xmm0
               	jmp	<addr>
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
               	movl	$0x1, %edx
               	movq	%rax, %rcx
               	shrq	$0x8, %rcx
               	andq	$0xf, %rcx
               	shlxq	%rcx, %rdx, %rcx
               	movslq	%ecx, %rcx
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rcx, %xmm1
               	divsd	%xmm1, %xmm0
               	testb	$0x1, %al
               	je	<addr>
               	vxorpd	<rip>, %xmm0, %xmm0 # <addr>
               	jmp	<addr>

<check_current_direction>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x148, %rsp            # imm = 0x148
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
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rax
               	movq	%rax, %rcx
               	shrq	$0x3b, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	leaq	-0x8(%rbp), %rdx
               	leaq	<rip>, %rsi # <addr>
               	shrq	$0x20, %rax
               	movl	$0xaaaaaaab, %ecx       # imm = 0xAAAAAAAB
               	imulq	%rax, %rcx
               	shrq	$0x21, %rcx
               	leaq	(%rcx,%rcx,2), %rcx
               	subq	%rcx, %rax
               	shlq	$0x3, %rax
               	addq	%rsi, %rax
               	movq	(%rax), %r10
               	movq	%r10, (%rdx)
               	movsd	(%rax), %xmm14
               	movsd	%xmm14, 0x128(%rsp)
               	movsd	0x128(%rsp), %xmm15
               	vmovq	%xmm15, %r11
               	vmovq	%r11, %xmm0
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
               	leaq	-0x8(%rbp), %rdx
               	leaq	<rip>, %rsi # <addr>
               	shrq	$0x20, %rax
               	movl	$0xaaaaaaab, %ecx       # imm = 0xAAAAAAAB
               	imulq	%rax, %rcx
               	shrq	$0x21, %rcx
               	leaq	(%rcx,%rcx,2), %rcx
               	subq	%rcx, %rax
               	shlq	$0x3, %rax
               	addq	%rsi, %rax
               	movq	(%rax), %r10
               	movq	%r10, (%rdx)
               	movsd	(%rax), %xmm14
               	movsd	%xmm14, 0x120(%rsp)
               	movsd	0x120(%rsp), %xmm15
               	vmovq	%xmm15, %r11
               	movapd	%xmm0, %xmm14
               	vpinsrq	$0x1, %r11, %xmm14, %xmm14
               	movups	%xmm14, 0x100(%rsp)
               	callq	<addr>
               	movss	%xmm0, -0x10(%rbp)
               	callq	<addr>
               	movss	%xmm0, -0xc(%rbp)
               	callq	<addr>
               	movss	%xmm0, -0x8(%rbp)
               	callq	<addr>
               	movss	%xmm0, -0x4(%rbp)
               	movups	-0x10(%rbp), %xmm14
               	movups	%xmm14, 0x140(%rsp)
               	xorl	%ebx, %ebx
               	movq	%rbx, %r13
               	jmp	<addr>
               	orq	%rax, %r13
               	incq	%rbx
               	nop
               	cmpl	$0x4, %ebx
               	jge	<addr>
               	leaq	-0x10(%rbp), %rax
               	movss	-0x10(%rbp,%rbx,4), %xmm0
               	ucomiss	%xmm0, %xmm0
               	sete	%cl
               	movzbq	%cl, %rcx
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rcx
               	xorl	%eax, %eax
               	testq	%rcx, %rcx
               	je	<addr>
               	movss	%xmm0, -0x20(%rbp)
               	movss	-0x20(%rbp), %xmm0
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
               	movl	%eax, -0x20(%rbp)
               	movss	-0x20(%rbp), %xmm0
               	leaq	-0x10(%rbp), %rax
               	movss	-0x10(%rbp,%rbx,4), %xmm1
               	ucomiss	%xmm1, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	jmp	<addr>
               	movss	-0x20(%rbp), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movl	$0x3, %edi
               	callq	<addr>
               	cvtsd2ss	%xmm0, %xmm0
               	jmp	<addr>
               	xorl	%ebx, %ebx
               	xorl	%r12d, %r12d
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
               	movl	%eax, -0x18(%rbp)
               	leaq	-0x18(%rbp), %rax
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
               	leaq	-0x18(%rbp), %rax
               	stmxcsr	(%rax)
               	movl	-0x18(%rbp), %eax
               	shrq	$0x5, %rax
               	movq	%rax, %r14
               	andq	$0x1, %r14
               	movl	<rip>, %eax # <addr>
               	movl	%eax, -0x18(%rbp)
               	leaq	-0x18(%rbp), %rax
               	ldmxcsr	(%rax)
               	movq	-0x120(%rbp), %rax
               	vmovq	%rax, %xmm1
               	movq	-0x118(%rbp), %rax
               	movapd	%xmm1, %xmm14
               	vpinsrq	$0x1, %rax, %xmm14, %xmm14
               	movups	%xmm14, 0x130(%rsp)
               	vpermilps	$0x0, %xmm1, %xmm0 # xmm0 = xmm1[0,0,0,0]
               	movups	%xmm1, 0x110(%rsp)
               	callq	<addr>
               	movq	%rax, %r15
               	movss	-0x10(%rbp), %xmm0
               	movss	%xmm0, -0x20(%rbp)
               	movss	-0x20(%rbp), %xmm0
               	callq	<addr>
               	movl	%eax, %ecx
               	shrq	$0x17, %rcx
               	andq	$0xff, %rcx
               	nopw	%cs:(%rax,%rax)
               	cmpl	$0xff, %ecx
               	jne	<addr>
               	movl	$0x400000, %ecx         # imm = 0x400000
               	xorl	%edx, %edx
               	testl	$0x7fffff, %eax         # imm = 0x7FFFFF
               	cmoveq	%rdx, %rcx
               	orq	%rcx, %rax
               	movl	%eax, -0x20(%rbp)
               	movss	-0x20(%rbp), %xmm0
               	callq	<addr>
               	cmpl	%eax, %r15d
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rax, %r12
               	movups	0x110(%rsp), %xmm14
               	vpermilps	$0x1, %xmm14, %xmm0 # xmm0 = xmm14[1,0,0,0]
               	callq	<addr>
               	movq	%rax, %r15
               	movss	-0xc(%rbp), %xmm0
               	movss	%xmm0, -0x20(%rbp)
               	movss	-0x20(%rbp), %xmm0
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
               	movl	%eax, -0x20(%rbp)
               	movss	-0x20(%rbp), %xmm0
               	callq	<addr>
               	cmpl	%eax, %r15d
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rax, %r12
               	movups	0x130(%rsp), %xmm14
               	vpermilps	$0x2, %xmm14, %xmm0 # xmm0 = xmm14[2,0,0,0]
               	callq	<addr>
               	movq	%rax, %r15
               	movss	-0x8(%rbp), %xmm0
               	movss	%xmm0, -0x20(%rbp)
               	movss	-0x20(%rbp), %xmm0
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
               	movl	%eax, -0x20(%rbp)
               	movss	-0x20(%rbp), %xmm0
               	callq	<addr>
               	cmpl	%eax, %r15d
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rax, %r12
               	movups	0x130(%rsp), %xmm14
               	vpermilps	$0x3, %xmm14, %xmm0 # xmm0 = xmm14[3,0,0,0]
               	callq	<addr>
               	movq	%rax, %r15
               	movss	-0x4(%rbp), %xmm0
               	movss	%xmm0, -0x20(%rbp)
               	movss	-0x20(%rbp), %xmm0
               	callq	<addr>
               	movl	%eax, %ecx
               	shrq	$0x17, %rcx
               	andq	$0xff, %rcx
               	nopw	%cs:(%rax,%rax)
               	cmpl	$0xff, %ecx
               	jne	<addr>
               	movl	$0x400000, %ecx         # imm = 0x400000
               	xorl	%edx, %edx
               	testl	$0x7fffff, %eax         # imm = 0x7FFFFF
               	cmoveq	%rdx, %rcx
               	orq	%rcx, %rax
               	movl	%eax, -0x20(%rbp)
               	movss	-0x20(%rbp), %xmm0
               	callq	<addr>
               	cmpl	%eax, %r15d
               	setne	%al
               	movzbq	%al, %rax
               	orq	%r12, %rax
               	cmpl	%r13d, %r14d
               	setne	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %r12
               	orq	%rcx, %r12
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
               	movl	%eax, -0x18(%rbp)
               	leaq	-0x18(%rbp), %rax
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
               	leaq	-0x18(%rbp), %rax
               	stmxcsr	(%rax)
               	movl	-0x18(%rbp), %eax
               	shrq	$0x5, %rax
               	movq	%rax, %r14
               	andq	$0x1, %r14
               	movl	<rip>, %eax # <addr>
               	movl	%eax, -0x18(%rbp)
               	leaq	-0x18(%rbp), %rax
               	ldmxcsr	(%rax)
               	movq	-0xf0(%rbp), %rax
               	vmovq	%rax, %xmm0
               	movq	-0xe8(%rbp), %rax
               	vpermilps	$0x1, %xmm0, %xmm0 # xmm0 = xmm0[1,0,0,0]
               	callq	<addr>
               	movq	%rax, %r15
               	movss	-0xc(%rbp), %xmm0
               	movss	%xmm0, -0x20(%rbp)
               	movss	-0x20(%rbp), %xmm0
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
               	movl	%eax, -0x20(%rbp)
               	movss	-0x20(%rbp), %xmm0
               	callq	<addr>
               	movl	$0x1, %ecx
               	cmpl	%r13d, %r14d
               	setne	%dl
               	movzbq	%dl, %rdx
               	cmpl	%eax, %r15d
               	cmoveq	%rdx, %rcx
               	orq	%rcx, %r12
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
               	movl	%eax, -0x18(%rbp)
               	leaq	-0x18(%rbp), %rax
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
               	leaq	-0x18(%rbp), %rax
               	stmxcsr	(%rax)
               	movl	-0x18(%rbp), %eax
               	shrq	$0x5, %rax
               	movq	%rax, %r14
               	andq	$0x1, %r14
               	movl	<rip>, %eax # <addr>
               	movl	%eax, -0x18(%rbp)
               	leaq	-0x18(%rbp), %rax
               	ldmxcsr	(%rax)
               	movq	-0xc0(%rbp), %rax
               	vmovq	%rax, %xmm0
               	movq	-0xb8(%rbp), %rax
               	vpinsrq	$0x1, %rax, %xmm0, %xmm0
               	vpermilps	$0x2, %xmm0, %xmm0 # xmm0 = xmm0[2,0,0,0]
               	callq	<addr>
               	movq	%rax, %r15
               	movss	-0x8(%rbp), %xmm0
               	movss	%xmm0, -0x20(%rbp)
               	movss	-0x20(%rbp), %xmm0
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
               	movl	%eax, -0x20(%rbp)
               	movss	-0x20(%rbp), %xmm0
               	callq	<addr>
               	movl	$0x1, %ecx
               	testl	%r14d, %r14d
               	setne	%dl
               	movzbq	%dl, %rdx
               	cmpl	%eax, %r15d
               	cmoveq	%rdx, %rcx
               	orq	%rcx, %r12
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
               	movl	%eax, -0x18(%rbp)
               	leaq	-0x18(%rbp), %rax
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
               	leaq	-0x18(%rbp), %rax
               	stmxcsr	(%rax)
               	movl	-0x18(%rbp), %eax
               	shrq	$0x5, %rax
               	movq	%rax, %r14
               	andq	$0x1, %r14
               	movl	<rip>, %eax # <addr>
               	movl	%eax, -0x18(%rbp)
               	leaq	-0x18(%rbp), %rax
               	ldmxcsr	(%rax)
               	movq	-0x90(%rbp), %rax
               	vmovq	%rax, %xmm0
               	movq	-0x88(%rbp), %rax
               	movapd	%xmm0, %xmm1
               	vpinsrq	$0x1, %rax, %xmm1, %xmm1
               	vpermilpd	$0x0, %xmm1, %xmm0 # xmm0 = xmm1[0,0]
               	movq	%xmm0, %r15
               	movsd	0x128(%rsp), %xmm0
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
               	jmp	<addr>
               	movss	-0x20(%rbp), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movq	%rbx, %rdi
               	callq	<addr>
               	cvtsd2ss	%xmm0, %xmm0
               	jmp	<addr>
               	movss	-0x20(%rbp), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movq	%rbx, %rdi
               	callq	<addr>
               	cvtsd2ss	%xmm0, %xmm0
               	jmp	<addr>
               	movss	-0x20(%rbp), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movq	%rbx, %rdi
               	callq	<addr>
               	cvtsd2ss	%xmm0, %xmm0
               	jmp	<addr>
               	movss	-0x20(%rbp), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movq	%rbx, %rdi
               	callq	<addr>
               	cvtsd2ss	%xmm0, %xmm0
               	jmp	<addr>
               	movss	-0x20(%rbp), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movq	%rbx, %rdi
               	callq	<addr>
               	cvtsd2ss	%xmm0, %xmm0
               	jmp	<addr>
               	movss	-0x20(%rbp), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movq	%rbx, %rdi
               	callq	<addr>
               	cvtsd2ss	%xmm0, %xmm0
               	jmp	<addr>
               	orq	%rcx, %r12
               	vpermilpd	$0x1, %xmm1, %xmm0 # xmm0 = xmm1[1,0]
               	movq	%xmm0, %r14
               	movsd	0x120(%rsp), %xmm0
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%xmm0, %rax
               	cmpq	%rax, %r14
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rax, %r12
               	incq	%rbx
               	cmpl	$0x4, %ebx
               	jl	<addr>
               	movl	$0x8, %eax
               	xorl	%ecx, %ecx
               	testq	%r12, %r12
               	cmoveq	%rcx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movq	%rax, %rcx
               	shrq	$0x3e, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	leaq	<rip>, %rdx # <addr>
               	shrq	$0x20, %rax
               	movq	%rax, %rcx
               	shrq	$0x3, %rcx
               	imulq	$0x55555556, %rcx, %rcx # imm = 0x55555556
               	shrq	$0x20, %rcx
               	imulq	$0x18, %rcx, %rcx
               	subq	%rcx, %rax
               	vmovq	(%rdx,%rax,8), %xmm14
               	movsd	%xmm14, 0x120(%rsp)
               	jmp	<addr>
               	movq	%rax, %rcx
               	shrq	$0x28, %rcx
               	xorps	%xmm1, %xmm1
               	movq	%rcx, %r10
               	testq	%r10, %r10
               	js	<addr>
               	cvtsi2sd	%r10, %xmm1
               	jmp	<addr>
               	movq	%r10, %r11
               	shrq	%r11
               	andq	$0x1, %r10
               	orq	%r10, %r11
               	cvtsi2sd	%r11, %xmm1
               	addsd	%xmm1, %xmm1
               	movl	$0x1, %edx
               	movq	%rax, %rcx
               	shrq	$0x8, %rcx
               	andq	$0xf, %rcx
               	shlxq	%rcx, %rdx, %rcx
               	movslq	%ecx, %rcx
               	xorps	%xmm2, %xmm2
               	cvtsi2sd	%rcx, %xmm2
               	vdivsd	%xmm2, %xmm1, %xmm14
               	movsd	%xmm14, 0x120(%rsp)
               	testb	$0x1, %al
               	je	<addr>
               	movsd	0x120(%rsp), %xmm14
               	vxorpd	<rip>, %xmm14, %xmm14 # <addr>
               	movsd	%xmm14, 0x120(%rsp)
               	jmp	<addr>
               	movq	%rax, %rcx
               	shrq	$0x3e, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	leaq	<rip>, %rdx # <addr>
               	shrq	$0x20, %rax
               	movq	%rax, %rcx
               	shrq	$0x3, %rcx
               	imulq	$0x55555556, %rcx, %rcx # imm = 0x55555556
               	shrq	$0x20, %rcx
               	imulq	$0x18, %rcx, %rcx
               	subq	%rcx, %rax
               	vmovq	(%rdx,%rax,8), %xmm14
               	movsd	%xmm14, 0x128(%rsp)
               	jmp	<addr>
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
               	movl	$0x1, %edx
               	movq	%rax, %rcx
               	shrq	$0x8, %rcx
               	andq	$0xf, %rcx
               	shlxq	%rcx, %rdx, %rcx
               	movslq	%ecx, %rcx
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rcx, %xmm1
               	vdivsd	%xmm1, %xmm0, %xmm14
               	movsd	%xmm14, 0x128(%rsp)
               	testb	$0x1, %al
               	je	<addr>
               	movsd	0x128(%rsp), %xmm14
               	vxorpd	<rip>, %xmm14, %xmm14 # <addr>
               	movsd	%xmm14, 0x128(%rsp)
               	jmp	<addr>

<check_dot_products>:
               	subq	$0x150, %rsp            # imm = 0x150
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
               	movss	(%rcx,%rax,4), %xmm0
               	movss	%xmm0, 0x50(%rsp)
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
               	movss	(%rcx,%rax,4), %xmm0
               	movss	%xmm0, 0x60(%rsp)
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
               	movss	(%rcx,%rax,4), %xmm0
               	movss	%xmm0, 0x54(%rsp)
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
               	movss	(%rcx,%rax,4), %xmm0
               	movss	%xmm0, 0x64(%rsp)
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
               	movss	(%rcx,%rax,4), %xmm0
               	movss	%xmm0, 0x58(%rsp)
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
               	movss	(%rcx,%rax,4), %xmm0
               	movss	%xmm0, 0x68(%rsp)
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
               	movss	(%rcx,%rax,4), %xmm0
               	movss	%xmm0, 0x5c(%rsp)
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
               	movss	(%rcx,%rax,4), %xmm0
               	movss	%xmm0, 0x6c(%rsp)
               	movups	0x50(%rsp), %xmm14
               	movups	%xmm14, 0x40(%rsp)
               	movups	0x60(%rsp), %xmm14
               	movups	%xmm14, 0x30(%rsp)
               	xorl	%ebx, %ebx
               	movq	%rbx, %rax
               	jmp	<addr>
               	movss	%xmm0, (%rdx)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	leaq	0xe0(%rsp), %rcx
               	movq	%rax, %rdx
               	shlq	$0x2, %rdx
               	addq	%rcx, %rdx
               	movl	$0xff, %ecx
               	leaq	0x4(%rax), %rsi
               	sarxq	%rsi, %rcx, %rcx
               	testb	$0x1, %cl
               	je	<addr>
               	leaq	0x50(%rsp), %rcx
               	movss	0x50(%rsp,%rax,4), %xmm0
               	leaq	0x60(%rsp), %rcx
               	vmulss	0x60(%rsp,%rax,4), %xmm0, %xmm0
               	jmp	<addr>
               	xorps	%xmm0, %xmm0
               	jmp	<addr>
               	xorl	%eax, %eax
               	movss	0xe0(%rsp), %xmm0
               	movss	0xe4(%rsp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	0xe8(%rsp), %xmm1
               	movss	0xec(%rsp), %xmm2
               	addss	%xmm2, %xmm1
               	addss	%xmm1, %xmm0
               	jmp	<addr>
               	movss	%xmm1, 0x70(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	leaq	0x70(%rsp), %rdx
               	movl	$0xff, %ecx
               	sarxq	%rax, %rcx, %rcx
               	testb	$0x1, %cl
               	je	<addr>
               	movapd	%xmm0, %xmm1
               	jmp	<addr>
               	xorps	%xmm1, %xmm1
               	jmp	<addr>
               	movups	0x40(%rsp), %xmm14
               	movups	0x30(%rsp), %xmm15
               	vdpps	$0xff, %xmm15, %xmm14, %xmm0
               	movups	%xmm0, 0x20(%rsp)
               	xorl	%r12d, %r12d
               	leaq	0x20(%rsp), %rax
               	movss	0x20(%rsp,%r12,4), %xmm0
               	callq	<addr>
               	movq	%rax, %r13
               	leaq	0x70(%rsp), %rax
               	movss	0x70(%rsp,%r12,4), %xmm0
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
               	leaq	0xf0(%rsp), %rcx
               	movq	%rax, %rdx
               	shlq	$0x2, %rdx
               	addq	%rcx, %rdx
               	movl	$0xf1, %ecx
               	leaq	0x4(%rax), %rsi
               	sarxq	%rsi, %rcx, %rcx
               	testb	$0x1, %cl
               	je	<addr>
               	leaq	0x50(%rsp), %rcx
               	movss	0x50(%rsp,%rax,4), %xmm0
               	leaq	0x60(%rsp), %rcx
               	vmulss	0x60(%rsp,%rax,4), %xmm0, %xmm0
               	jmp	<addr>
               	xorps	%xmm0, %xmm0
               	jmp	<addr>
               	xorl	%eax, %eax
               	movss	0xf0(%rsp), %xmm0
               	movss	0xf4(%rsp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	0xf8(%rsp), %xmm1
               	movss	0xfc(%rsp), %xmm2
               	addss	%xmm2, %xmm1
               	addss	%xmm1, %xmm0
               	jmp	<addr>
               	movss	%xmm1, 0x70(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	leaq	0x70(%rsp), %rdx
               	movl	$0xf1, %ecx
               	sarxq	%rax, %rcx, %rcx
               	testb	$0x1, %cl
               	je	<addr>
               	movapd	%xmm0, %xmm1
               	jmp	<addr>
               	xorps	%xmm1, %xmm1
               	jmp	<addr>
               	movups	0x40(%rsp), %xmm14
               	movups	0x30(%rsp), %xmm15
               	vdpps	$0xf1, %xmm15, %xmm14, %xmm0
               	movups	%xmm0, 0x20(%rsp)
               	xorl	%r12d, %r12d
               	leaq	0x20(%rsp), %rax
               	movss	0x20(%rsp,%r12,4), %xmm0
               	callq	<addr>
               	movq	%rax, %r13
               	leaq	0x70(%rsp), %rax
               	movss	0x70(%rsp,%r12,4), %xmm0
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
               	nopl	(%rax,%rax)
               	cmpl	$0x4, %eax
               	jge	<addr>
               	leaq	0x100(%rsp), %rcx
               	movq	%rax, %rdx
               	shlq	$0x2, %rdx
               	addq	%rcx, %rdx
               	movl	$0x7f, %ecx
               	leaq	0x4(%rax), %rsi
               	sarxq	%rsi, %rcx, %rcx
               	testb	$0x1, %cl
               	je	<addr>
               	leaq	0x50(%rsp), %rcx
               	movss	0x50(%rsp,%rax,4), %xmm0
               	leaq	0x60(%rsp), %rcx
               	vmulss	0x60(%rsp,%rax,4), %xmm0, %xmm0
               	jmp	<addr>
               	xorps	%xmm0, %xmm0
               	jmp	<addr>
               	xorl	%eax, %eax
               	movss	0x100(%rsp), %xmm0
               	movss	0x104(%rsp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	0x108(%rsp), %xmm1
               	movss	0x10c(%rsp), %xmm2
               	addss	%xmm2, %xmm1
               	addss	%xmm1, %xmm0
               	jmp	<addr>
               	movss	%xmm1, 0x70(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	leaq	0x70(%rsp), %rdx
               	movl	$0x7f, %ecx
               	sarxq	%rax, %rcx, %rcx
               	nopl	(%rax,%rax)
               	testb	$0x1, %cl
               	je	<addr>
               	movapd	%xmm0, %xmm1
               	jmp	<addr>
               	xorps	%xmm1, %xmm1
               	jmp	<addr>
               	movups	0x40(%rsp), %xmm14
               	movups	0x30(%rsp), %xmm15
               	vdpps	$0x7f, %xmm15, %xmm14, %xmm0
               	movups	%xmm0, 0x20(%rsp)
               	xorl	%r12d, %r12d
               	leaq	0x20(%rsp), %rax
               	movss	0x20(%rsp,%r12,4), %xmm0
               	callq	<addr>
               	movq	%rax, %r13
               	leaq	0x70(%rsp), %rax
               	movss	0x70(%rsp,%r12,4), %xmm0
               	callq	<addr>
               	movl	$0x10, %ecx
               	cmpl	%eax, %r13d
               	cmovneq	%rcx, %rbx
               	incq	%r12
               	nop
               	cmpl	$0x4, %r12d
               	jl	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movss	%xmm0, (%rdx)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	leaq	0x110(%rsp), %rcx
               	movq	%rax, %rdx
               	shlq	$0x2, %rdx
               	addq	%rcx, %rdx
               	movl	$0x3c, %ecx
               	leaq	0x4(%rax), %rsi
               	sarxq	%rsi, %rcx, %rcx
               	testb	$0x1, %cl
               	je	<addr>
               	leaq	0x50(%rsp), %rcx
               	movss	0x50(%rsp,%rax,4), %xmm0
               	leaq	0x60(%rsp), %rcx
               	vmulss	0x60(%rsp,%rax,4), %xmm0, %xmm0
               	jmp	<addr>
               	xorps	%xmm0, %xmm0
               	jmp	<addr>
               	xorl	%eax, %eax
               	movss	0x110(%rsp), %xmm0
               	movss	0x114(%rsp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	0x118(%rsp), %xmm1
               	movss	0x11c(%rsp), %xmm2
               	addss	%xmm2, %xmm1
               	addss	%xmm1, %xmm0
               	jmp	<addr>
               	movss	%xmm1, 0x70(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	leaq	0x70(%rsp), %rdx
               	movl	$0x3c, %ecx
               	sarxq	%rax, %rcx, %rcx
               	testb	$0x1, %cl
               	je	<addr>
               	movapd	%xmm0, %xmm1
               	jmp	<addr>
               	xorps	%xmm1, %xmm1
               	jmp	<addr>
               	movups	0x40(%rsp), %xmm14
               	movups	0x30(%rsp), %xmm15
               	vdpps	$0x3c, %xmm15, %xmm14, %xmm0
               	movups	%xmm0, 0x20(%rsp)
               	xorl	%r12d, %r12d
               	leaq	0x20(%rsp), %rax
               	movss	0x20(%rsp,%r12,4), %xmm0
               	callq	<addr>
               	movq	%rax, %r13
               	leaq	0x70(%rsp), %rax
               	movss	0x70(%rsp,%r12,4), %xmm0
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
               	nopl	(%rax,%rax)
               	cmpl	$0x4, %eax
               	jge	<addr>
               	leaq	0x120(%rsp), %rcx
               	movq	%rax, %rdx
               	shlq	$0x2, %rdx
               	addq	%rcx, %rdx
               	movl	$0xa5, %ecx
               	leaq	0x4(%rax), %rsi
               	sarxq	%rsi, %rcx, %rcx
               	testb	$0x1, %cl
               	je	<addr>
               	leaq	0x50(%rsp), %rcx
               	movss	0x50(%rsp,%rax,4), %xmm0
               	leaq	0x60(%rsp), %rcx
               	vmulss	0x60(%rsp,%rax,4), %xmm0, %xmm0
               	jmp	<addr>
               	xorps	%xmm0, %xmm0
               	jmp	<addr>
               	xorl	%eax, %eax
               	movss	0x120(%rsp), %xmm0
               	movss	0x124(%rsp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	0x128(%rsp), %xmm1
               	movss	0x12c(%rsp), %xmm2
               	addss	%xmm2, %xmm1
               	addss	%xmm1, %xmm0
               	jmp	<addr>
               	movss	%xmm1, 0x70(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	leaq	0x70(%rsp), %rdx
               	movl	$0xa5, %ecx
               	sarxq	%rax, %rcx, %rcx
               	nopl	(%rax,%rax)
               	testb	$0x1, %cl
               	je	<addr>
               	movapd	%xmm0, %xmm1
               	jmp	<addr>
               	xorps	%xmm1, %xmm1
               	jmp	<addr>
               	movups	0x40(%rsp), %xmm14
               	movups	0x30(%rsp), %xmm15
               	vdpps	$0xa5, %xmm15, %xmm14, %xmm0
               	movups	%xmm0, 0x20(%rsp)
               	xorl	%r12d, %r12d
               	leaq	0x20(%rsp), %rax
               	movss	0x20(%rsp,%r12,4), %xmm0
               	callq	<addr>
               	movq	%rax, %r13
               	leaq	0x70(%rsp), %rax
               	movss	0x70(%rsp,%r12,4), %xmm0
               	callq	<addr>
               	movl	$0x10, %ecx
               	cmpl	%eax, %r13d
               	cmovneq	%rcx, %rbx
               	incq	%r12
               	nop
               	cmpl	$0x4, %r12d
               	jl	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movss	%xmm0, (%rdx)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	leaq	0x130(%rsp), %rcx
               	movq	%rax, %rdx
               	shlq	$0x2, %rdx
               	addq	%rcx, %rdx
               	movl	$0xf, %ecx
               	leaq	0x4(%rax), %rsi
               	sarxq	%rsi, %rcx, %rcx
               	testb	$0x1, %cl
               	je	<addr>
               	leaq	0x50(%rsp), %rcx
               	movss	0x50(%rsp,%rax,4), %xmm0
               	leaq	0x60(%rsp), %rcx
               	vmulss	0x60(%rsp,%rax,4), %xmm0, %xmm0
               	jmp	<addr>
               	xorps	%xmm0, %xmm0
               	jmp	<addr>
               	xorl	%eax, %eax
               	movss	0x130(%rsp), %xmm0
               	movss	0x134(%rsp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	0x138(%rsp), %xmm1
               	movss	0x13c(%rsp), %xmm2
               	addss	%xmm2, %xmm1
               	addss	%xmm1, %xmm0
               	jmp	<addr>
               	movss	%xmm1, 0x70(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	leaq	0x70(%rsp), %rdx
               	movl	$0xf, %ecx
               	sarxq	%rax, %rcx, %rcx
               	testb	$0x1, %cl
               	je	<addr>
               	movapd	%xmm0, %xmm1
               	jmp	<addr>
               	xorps	%xmm1, %xmm1
               	jmp	<addr>
               	movups	0x40(%rsp), %xmm14
               	movups	0x30(%rsp), %xmm15
               	vdpps	$0xf, %xmm15, %xmm14, %xmm0
               	movups	%xmm0, 0x20(%rsp)
               	xorl	%r12d, %r12d
               	leaq	0x20(%rsp), %rax
               	movss	0x20(%rsp,%r12,4), %xmm0
               	callq	<addr>
               	movq	%rax, %r13
               	leaq	0x70(%rsp), %rax
               	movss	0x70(%rsp,%r12,4), %xmm0
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
               	nopl	(%rax,%rax)
               	cmpl	$0x4, %eax
               	jge	<addr>
               	leaq	0x140(%rsp), %rcx
               	movq	%rax, %rdx
               	shlq	$0x2, %rdx
               	addq	%rcx, %rdx
               	movl	$0xf0, %ecx
               	leaq	0x4(%rax), %rsi
               	sarxq	%rsi, %rcx, %rcx
               	testb	$0x1, %cl
               	je	<addr>
               	leaq	0x50(%rsp), %rcx
               	movss	0x50(%rsp,%rax,4), %xmm0
               	leaq	0x60(%rsp), %rcx
               	vmulss	0x60(%rsp,%rax,4), %xmm0, %xmm0
               	jmp	<addr>
               	xorps	%xmm0, %xmm0
               	jmp	<addr>
               	xorl	%eax, %eax
               	movss	0x140(%rsp), %xmm0
               	movss	0x144(%rsp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	0x148(%rsp), %xmm1
               	movss	0x14c(%rsp), %xmm2
               	addss	%xmm2, %xmm1
               	addss	%xmm1, %xmm0
               	jmp	<addr>
               	movss	%xmm1, 0x70(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	leaq	0x70(%rsp), %rdx
               	movl	$0xf0, %ecx
               	sarxq	%rax, %rcx, %rcx
               	nopl	(%rax,%rax)
               	testb	$0x1, %cl
               	je	<addr>
               	movapd	%xmm0, %xmm1
               	jmp	<addr>
               	xorps	%xmm1, %xmm1
               	jmp	<addr>
               	movups	0x40(%rsp), %xmm14
               	movups	0x30(%rsp), %xmm15
               	vdpps	$0xf0, %xmm15, %xmm14, %xmm0
               	movups	%xmm0, 0x20(%rsp)
               	xorl	%r12d, %r12d
               	leaq	0x20(%rsp), %rax
               	movss	0x20(%rsp,%r12,4), %xmm0
               	callq	<addr>
               	movq	%rax, %r13
               	leaq	0x70(%rsp), %rax
               	movss	0x70(%rsp,%r12,4), %xmm0
               	callq	<addr>
               	movl	$0x10, %ecx
               	cmpl	%eax, %r13d
               	cmovneq	%rcx, %rbx
               	incq	%r12
               	nop
               	cmpl	$0x4, %r12d
               	jl	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movss	%xmm0, (%rdx)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	leaq	0x150(%rsp), %rcx
               	movq	%rax, %rdx
               	shlq	$0x2, %rdx
               	addq	%rcx, %rdx
               	movl	$0x82, %ecx
               	leaq	0x4(%rax), %rsi
               	sarxq	%rsi, %rcx, %rcx
               	testb	$0x1, %cl
               	je	<addr>
               	leaq	0x50(%rsp), %rcx
               	movss	0x50(%rsp,%rax,4), %xmm0
               	leaq	0x60(%rsp), %rcx
               	vmulss	0x60(%rsp,%rax,4), %xmm0, %xmm0
               	jmp	<addr>
               	xorps	%xmm0, %xmm0
               	jmp	<addr>
               	xorl	%eax, %eax
               	movss	0x150(%rsp), %xmm0
               	movss	0x154(%rsp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	0x158(%rsp), %xmm1
               	movss	0x15c(%rsp), %xmm2
               	addss	%xmm2, %xmm1
               	addss	%xmm1, %xmm0
               	jmp	<addr>
               	movss	%xmm1, 0x70(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	leaq	0x70(%rsp), %rdx
               	movl	$0x82, %ecx
               	sarxq	%rax, %rcx, %rcx
               	testb	$0x1, %cl
               	je	<addr>
               	movapd	%xmm0, %xmm1
               	jmp	<addr>
               	xorps	%xmm1, %xmm1
               	jmp	<addr>
               	movups	0x40(%rsp), %xmm14
               	movups	0x30(%rsp), %xmm15
               	vdpps	$0x82, %xmm15, %xmm14, %xmm0
               	movups	%xmm0, 0x20(%rsp)
               	xorl	%r12d, %r12d
               	leaq	0x20(%rsp), %rax
               	movss	0x20(%rsp,%r12,4), %xmm0
               	callq	<addr>
               	movq	%rax, %r13
               	leaq	0x70(%rsp), %rax
               	movss	0x70(%rsp,%r12,4), %xmm0
               	callq	<addr>
               	movl	$0x10, %ecx
               	cmpl	%eax, %r13d
               	cmovneq	%rcx, %rbx
               	incq	%r12
               	cmpl	$0x4, %r12d
               	jl	<addr>
               	movss	0x50(%rsp), %xmm0
               	vcvtss2sd	%xmm0, %xmm0, %xmm2
               	vmovq	%xmm2, %xmm0            # xmm0 = xmm2[0],zero
               	movss	0x54(%rsp), %xmm1
               	cvtss2sd	%xmm1, %xmm1
               	vmulsd	<rip>, %xmm1, %xmm3 # <addr>
               	vunpcklpd	%xmm3, %xmm0, %xmm0 # xmm0 = xmm0[0],xmm3[0]
               	movss	0x68(%rsp), %xmm1
               	vcvtss2sd	%xmm1, %xmm1, %xmm4
               	vmovq	%xmm4, %xmm1            # xmm1 = xmm4[0],zero
               	movss	0x6c(%rsp), %xmm5
               	cvtss2sd	%xmm5, %xmm5
               	vunpcklpd	%xmm5, %xmm1, %xmm1 # xmm1 = xmm1[0],xmm5[0]
               	movapd	%xmm2, %xmm6
               	movapd	%xmm4, %xmm7
               	mulsd	%xmm7, %xmm6
               	movsd	%xmm6, 0x80(%rsp)
               	movapd	%xmm3, %xmm6
               	movapd	%xmm5, %xmm7
               	mulsd	%xmm7, %xmm6
               	movsd	%xmm6, 0x88(%rsp)
               	movsd	0x80(%rsp), %xmm6
               	movsd	0x88(%rsp), %xmm7
               	vaddsd	%xmm7, %xmm6, %xmm7
               	vdppd	$0x33, %xmm1, %xmm0, %xmm6
               	vpermilpd	$0x0, %xmm6, %xmm8 # xmm8 = xmm6[0,0]
               	movq	%xmm8, %rcx
               	movq	%xmm7, %rax
               	cmpq	%rax, %rcx
               	jne	<addr>
               	vpermilpd	$0x1, %xmm6, %xmm6 # xmm6 = xmm6[1,0]
               	movq	%xmm6, %rcx
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x10, %ebx
               	movapd	%xmm2, %xmm6
               	movapd	%xmm4, %xmm7
               	mulsd	%xmm7, %xmm6
               	movsd	%xmm6, 0x90(%rsp)
               	movapd	%xmm3, %xmm6
               	movapd	%xmm5, %xmm7
               	mulsd	%xmm7, %xmm6
               	movsd	%xmm6, 0x98(%rsp)
               	movsd	0x90(%rsp), %xmm6
               	movsd	0x98(%rsp), %xmm7
               	vaddsd	%xmm7, %xmm6, %xmm7
               	vdppd	$0x31, %xmm1, %xmm0, %xmm6
               	vpermilpd	$0x0, %xmm6, %xmm8 # xmm8 = xmm6[0,0]
               	movq	%xmm8, %rax
               	movq	%xmm7, %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	vpermilpd	$0x1, %xmm6, %xmm6 # xmm6 = xmm6[1,0]
               	movq	%xmm6, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x10, %ebx
               	movapd	%xmm2, %xmm7
               	movapd	%xmm4, %xmm8
               	mulsd	%xmm8, %xmm7
               	movsd	%xmm7, 0xa0(%rsp)
               	movq	$0x0, 0xa8(%rsp)
               	movsd	0xa0(%rsp), %xmm7
               	movsd	0xa8(%rsp), %xmm8
               	vaddsd	%xmm8, %xmm7, %xmm9
               	vdppd	$0x12, %xmm1, %xmm0, %xmm7
               	vpermilpd	$0x0, %xmm7, %xmm8 # xmm8 = xmm7[0,0]
               	movq	%xmm8, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	vpermilpd	$0x1, %xmm7, %xmm7 # xmm7 = xmm7[1,0]
               	movq	%xmm7, %rax
               	movq	%xmm9, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x10, %ebx
               	movq	$0x0, 0xb0(%rsp)
               	movapd	%xmm3, %xmm7
               	movapd	%xmm5, %xmm8
               	mulsd	%xmm8, %xmm7
               	movsd	%xmm7, 0xb8(%rsp)
               	movsd	0xb0(%rsp), %xmm7
               	movsd	0xb8(%rsp), %xmm8
               	vaddsd	%xmm8, %xmm7, %xmm8
               	vdppd	$0x23, %xmm1, %xmm0, %xmm7
               	vpermilpd	$0x0, %xmm7, %xmm9 # xmm9 = xmm7[0,0]
               	movq	%xmm9, %rcx
               	movq	%xmm8, %rax
               	cmpq	%rax, %rcx
               	jne	<addr>
               	vpermilpd	$0x1, %xmm7, %xmm7 # xmm7 = xmm7[1,0]
               	movq	%xmm7, %rcx
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x10, %ebx
               	movq	$0x0, 0xc0(%rsp)
               	movq	$0x0, 0xc8(%rsp)
               	movsd	0xc0(%rsp), %xmm6
               	movsd	0xc8(%rsp), %xmm7
               	vaddsd	%xmm7, %xmm6, %xmm7
               	vdppd	$0x3, %xmm1, %xmm0, %xmm6
               	vpermilpd	$0x0, %xmm6, %xmm8 # xmm8 = xmm6[0,0]
               	movq	%xmm8, %rcx
               	movq	%xmm7, %rax
               	cmpq	%rax, %rcx
               	jne	<addr>
               	vpermilpd	$0x1, %xmm6, %xmm6 # xmm6 = xmm6[1,0]
               	movq	%xmm6, %rcx
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x10, %ebx
               	mulsd	%xmm4, %xmm2
               	movsd	%xmm2, 0xd0(%rsp)
               	movapd	%xmm3, %xmm2
               	movapd	%xmm5, %xmm3
               	mulsd	%xmm3, %xmm2
               	movsd	%xmm2, 0xd8(%rsp)
               	movsd	0xd0(%rsp), %xmm2
               	movsd	0xd8(%rsp), %xmm2
               	vdppd	$0xf0, %xmm1, %xmm0, %xmm0
               	vpermilpd	$0x0, %xmm0, %xmm1 # xmm1 = xmm0[0,0]
               	movq	%xmm1, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	vpermilpd	$0x1, %xmm0, %xmm0 # xmm0 = xmm0[1,0]
               	movq	%xmm0, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x10, %ebx
               	movq	%rbx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0x150, %rsp            # imm = 0x150
               	retq
               	shrq	$0x2c, %rax
               	subq	$0x80000, %rax          # imm = 0x80000
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rax, %xmm0
               	vdivss	<rip>, %xmm0, %xmm0 # <addr>
               	jmp	<addr>
               	shrq	$0x2c, %rax
               	subq	$0x80000, %rax          # imm = 0x80000
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rax, %xmm0
               	vdivss	<rip>, %xmm0, %xmm0 # <addr>
               	jmp	<addr>
               	shrq	$0x2c, %rax
               	subq	$0x80000, %rax          # imm = 0x80000
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rax, %xmm0
               	vdivss	<rip>, %xmm0, %xmm0 # <addr>
               	jmp	<addr>
               	shrq	$0x2c, %rax
               	subq	$0x80000, %rax          # imm = 0x80000
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rax, %xmm0
               	vdivss	<rip>, %xmm0, %xmm0 # <addr>
               	jmp	<addr>
               	shrq	$0x2c, %rax
               	subq	$0x80000, %rax          # imm = 0x80000
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rax, %xmm0
               	vdivss	<rip>, %xmm0, %xmm0 # <addr>
               	jmp	<addr>
               	shrq	$0x2c, %rax
               	subq	$0x80000, %rax          # imm = 0x80000
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rax, %xmm0
               	vdivss	<rip>, %xmm0, %xmm0 # <addr>
               	jmp	<addr>
               	shrq	$0x2c, %rax
               	subq	$0x80000, %rax          # imm = 0x80000
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rax, %xmm0
               	vdivss	<rip>, %xmm0, %xmm0 # <addr>
               	jmp	<addr>
               	shrq	$0x2c, %rax
               	subq	$0x80000, %rax          # imm = 0x80000
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rax, %xmm0
               	vdivss	<rip>, %xmm0, %xmm0 # <addr>
               	jmp	<addr>

<check_insert_extract>:
               	subq	$0x50, %rsp
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
               	vmovd	%ebx, %xmm1
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
               	vpinsrd	$0x1, %r14d, %xmm1, %xmm1
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
               	movabsq	$0x2545f4914f6cdd1d, %r12 # imm = 0x2545F4914F6CDD1D
               	imulq	%rax, %r12
               	shrq	$0x7, %r12
               	vpinsrd	$0x2, %r12d, %xmm1, %xmm1
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
               	vpinsrd	$0x3, %ecx, %xmm0, %xmm0
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
               	movapd	%xmm1, %xmm14
               	vpinsrd	$0x3, %r13d, %xmm14, %xmm14
               	movups	%xmm14, 0x40(%rsp)
               	movups	%xmm0, 0x50(%rsp)
               	xorl	%eax, %eax
               	movl	%ebx, 0x50(%rsp)
               	jmp	<addr>
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	xorl	%ecx, %ecx
               	sarxq	%rax, %rcx, %rcx
               	nop
               	testb	$0x1, %cl
               	je	<addr>
               	movl	$0x0, 0x50(%rsp,%rax,4)
               	jmp	<addr>
               	movups	0x40(%rsp), %xmm15
               	vinsertps	$0x0, %xmm15, %xmm0, %xmm1 # xmm1 = xmm15[0],xmm0[1,2,3]
               	movups	%xmm1, 0x60(%rsp)
               	movups	%xmm0, 0x30(%rsp)
               	leaq	0x60(%rsp), %rdi
               	leaq	0x50(%rsp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	movups	0x30(%rsp), %xmm0
               	movl	$0x20, %ecx
               	xorl	%edx, %edx
               	testq	%rax, %rax
               	movq	%rdx, %r15
               	cmovneq	%rcx, %r15
               	movups	%xmm0, 0x50(%rsp)
               	xorl	%eax, %eax
               	movl	%ebx, 0x54(%rsp)
               	jmp	<addr>
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movl	$0x10, %ecx
               	sarxq	%rax, %rcx, %rcx
               	testb	$0x1, %cl
               	je	<addr>
               	movl	$0x0, 0x50(%rsp,%rax,4)
               	nop
               	jmp	<addr>
               	movups	0x40(%rsp), %xmm15
               	vinsertps	$0x10, %xmm15, %xmm0, %xmm1 # xmm1 = xmm0[0],xmm15[0],xmm0[2,3]
               	movups	%xmm1, 0x60(%rsp)
               	movups	%xmm0, 0x30(%rsp)
               	leaq	0x60(%rsp), %rdi
               	leaq	0x50(%rsp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	movups	0x30(%rsp), %xmm0
               	movl	$0x20, %ecx
               	testq	%rax, %rax
               	cmovneq	%rcx, %r15
               	movups	%xmm0, 0x50(%rsp)
               	movl	%r14d, 0x58(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movl	$0x6c, %ecx
               	sarxq	%rax, %rcx, %rcx
               	testb	$0x1, %cl
               	je	<addr>
               	movl	$0x0, 0x50(%rsp,%rax,4)
               	jmp	<addr>
               	movups	0x40(%rsp), %xmm15
               	vinsertps	$0x6c, %xmm15, %xmm0, %xmm1 # xmm1 = xmm0[0,1],zero,zero
               	movups	%xmm1, 0x60(%rsp)
               	movups	%xmm0, 0x30(%rsp)
               	leaq	0x60(%rsp), %rdi
               	leaq	0x50(%rsp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	movups	0x30(%rsp), %xmm0
               	movl	$0x20, %ecx
               	testq	%rax, %rax
               	movq	%r15, %r14
               	cmovneq	%rcx, %r14
               	movups	%xmm0, 0x50(%rsp)
               	movl	%r12d, 0x5c(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movl	$0xb1, %ecx
               	sarxq	%rax, %rcx, %rcx
               	testb	$0x1, %cl
               	je	<addr>
               	movl	$0x0, 0x50(%rsp,%rax,4)
               	nopl	(%rax)
               	jmp	<addr>
               	movups	0x40(%rsp), %xmm15
               	vinsertps	$0xb1, %xmm15, %xmm0, %xmm1 # xmm1 = zero,xmm0[1,2],xmm15[2]
               	movups	%xmm1, 0x60(%rsp)
               	movups	%xmm0, 0x30(%rsp)
               	leaq	0x60(%rsp), %rdi
               	leaq	0x50(%rsp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	movups	0x30(%rsp), %xmm0
               	movl	$0x20, %ecx
               	testq	%rax, %rax
               	cmovneq	%rcx, %r14
               	movups	%xmm0, 0x50(%rsp)
               	movl	%r13d, 0x5c(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movl	$0xf0, %ecx
               	sarxq	%rax, %rcx, %rcx
               	testb	$0x1, %cl
               	je	<addr>
               	movl	$0x0, 0x50(%rsp,%rax,4)
               	jmp	<addr>
               	movups	0x40(%rsp), %xmm15
               	vinsertps	$0xf0, %xmm15, %xmm0, %xmm1 # xmm1 = xmm0[0,1,2],xmm15[3]
               	movups	%xmm1, 0x60(%rsp)
               	movups	%xmm0, 0x30(%rsp)
               	leaq	0x60(%rsp), %rdi
               	leaq	0x50(%rsp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	movups	0x30(%rsp), %xmm0
               	movl	$0x20, %ecx
               	testq	%rax, %rax
               	cmovneq	%rcx, %r14
               	movups	%xmm0, 0x50(%rsp)
               	xorl	%eax, %eax
               	movl	%r13d, 0x50(%rsp)
               	jmp	<addr>
               	incq	%rax
               	nop
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movl	$0xcf, %ecx
               	sarxq	%rax, %rcx, %rcx
               	testb	$0x1, %cl
               	je	<addr>
               	movl	$0x0, 0x50(%rsp,%rax,4)
               	nopl	(%rax)
               	jmp	<addr>
               	movups	0x40(%rsp), %xmm15
               	vinsertps	$0xcf, %xmm15, %xmm0, %xmm1 # xmm1 = zero,zero,zero,zero
               	movups	%xmm1, 0x60(%rsp)
               	movups	%xmm0, 0x30(%rsp)
               	leaq	0x60(%rsp), %rdi
               	leaq	0x50(%rsp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	movups	0x30(%rsp), %xmm0
               	movl	$0x20, %ecx
               	testq	%rax, %rax
               	movq	%r14, %r13
               	cmovneq	%rcx, %r13
               	movups	%xmm0, 0x50(%rsp)
               	xorl	%eax, %eax
               	movl	%ebx, 0x5c(%rsp)
               	jmp	<addr>
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movl	$0x3a, %ecx
               	sarxq	%rax, %rcx, %rcx
               	testb	$0x1, %cl
               	je	<addr>
               	movl	$0x0, 0x50(%rsp,%rax,4)
               	jmp	<addr>
               	movups	0x40(%rsp), %xmm15
               	vinsertps	$0x3a, %xmm15, %xmm0, %xmm1 # xmm1 = xmm0[0],zero,xmm0[2],zero
               	movups	%xmm1, 0x60(%rsp)
               	movups	%xmm0, 0x30(%rsp)
               	leaq	0x60(%rsp), %rdi
               	leaq	0x50(%rsp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	movups	0x30(%rsp), %xmm0
               	movl	$0x20, %ecx
               	testq	%rax, %rax
               	movq	%r13, %rbx
               	cmovneq	%rcx, %rbx
               	movups	%xmm0, 0x50(%rsp)
               	movl	%r12d, 0x54(%rsp)
               	xorl	%edx, %edx
               	movq	%rdx, %rax
               	jmp	<addr>
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movl	$0x96, %ecx
               	sarxq	%rax, %rcx, %rcx
               	testb	$0x1, %cl
               	je	<addr>
               	movl	%edx, 0x50(%rsp,%rax,4)
               	nop
               	jmp	<addr>
               	movups	0x40(%rsp), %xmm15
               	vinsertps	$0x96, %xmm15, %xmm0, %xmm0 # xmm0 = xmm0[0],zero,zero,xmm0[3]
               	movups	%xmm0, 0x60(%rsp)
               	leaq	0x60(%rsp), %rdi
               	leaq	0x50(%rsp), %rsi
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
               	addq	$0x50, %rsp
               	retq

<check_blends>:
               	subq	$0x90, %rsp
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
               	movl	%eax, 0x40(%rsp)
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
               	movl	%eax, 0x50(%rsp)
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
               	movl	%eax, 0x60(%rsp)
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
               	movl	%eax, 0x44(%rsp)
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
               	movl	%eax, 0x54(%rsp)
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
               	movl	%eax, 0x64(%rsp)
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
               	movl	%eax, 0x48(%rsp)
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
               	movl	%eax, 0x58(%rsp)
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
               	movl	%eax, 0x68(%rsp)
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
               	movl	%eax, 0x4c(%rsp)
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
               	movl	%eax, 0x5c(%rsp)
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
               	movl	%eax, 0x6c(%rsp)
               	movups	0x40(%rsp), %xmm14
               	movups	%xmm14, 0x30(%rsp)
               	movups	0x50(%rsp), %xmm14
               	movups	%xmm14, 0x20(%rsp)
               	movups	0x60(%rsp), %xmm14
               	movups	%xmm14, 0x10(%rsp)
               	xorl	%edx, %edx
               	movq	%rdx, %rax
               	jmp	<addr>
               	movl	%ecx, 0x70(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	sarxq	%rax, %rdx, %rcx
               	testb	$0x1, %cl
               	je	<addr>
               	movl	0x50(%rsp,%rax,4), %ecx
               	jmp	<addr>
               	movl	0x40(%rsp,%rax,4), %ecx
               	nopl	(%rax,%rax)
               	jmp	<addr>
               	movups	0x30(%rsp), %xmm14
               	movups	0x20(%rsp), %xmm15
               	vblendps	$0x0, %xmm15, %xmm14, %xmm0 # xmm0 = xmm14[0,1,2,3]
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0x80(%rsp), %rdi
               	leaq	0x70(%rsp), %rsi
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
               	movl	%ecx, 0x70(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movl	$0x5, %ecx
               	sarxq	%rax, %rcx, %rcx
               	testb	$0x1, %cl
               	je	<addr>
               	movl	0x50(%rsp,%rax,4), %ecx
               	jmp	<addr>
               	movl	0x40(%rsp,%rax,4), %ecx
               	jmp	<addr>
               	movups	0x30(%rsp), %xmm14
               	movups	0x20(%rsp), %xmm15
               	vblendps	$0x5, %xmm15, %xmm14, %xmm0 # xmm0 = xmm15[0],xmm14[1],xmm15[2],xmm14[3]
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0x80(%rsp), %rdi
               	leaq	0x70(%rsp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x40, %ecx
               	testq	%rax, %rax
               	cmovneq	%rcx, %rbx
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	%ecx, 0x70(%rsp,%rax,4)
               	incq	%rax
               	nopl	(%rax)
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movl	$0xa, %ecx
               	sarxq	%rax, %rcx, %rcx
               	testb	$0x1, %cl
               	je	<addr>
               	movl	0x50(%rsp,%rax,4), %ecx
               	jmp	<addr>
               	movl	0x40(%rsp,%rax,4), %ecx
               	nop
               	jmp	<addr>
               	movups	0x30(%rsp), %xmm14
               	movups	0x20(%rsp), %xmm15
               	vblendps	$0xa, %xmm15, %xmm14, %xmm0 # xmm0 = xmm14[0],xmm15[1],xmm14[2],xmm15[3]
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0x80(%rsp), %rdi
               	leaq	0x70(%rsp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x40, %ecx
               	testq	%rax, %rax
               	cmovneq	%rcx, %rbx
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	%ecx, 0x70(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movl	$0xf, %ecx
               	sarxq	%rax, %rcx, %rcx
               	nopl	(%rax)
               	testb	$0x1, %cl
               	je	<addr>
               	movl	0x50(%rsp,%rax,4), %ecx
               	jmp	<addr>
               	movl	0x40(%rsp,%rax,4), %ecx
               	jmp	<addr>
               	movups	0x30(%rsp), %xmm14
               	movups	0x20(%rsp), %xmm15
               	vblendps	$0xf, %xmm15, %xmm14, %xmm0 # xmm0 = xmm15[0,1,2,3]
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0x80(%rsp), %rdi
               	leaq	0x70(%rsp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x40, %ecx
               	testq	%rax, %rax
               	cmovneq	%rcx, %rbx
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	%ecx, 0x70(%rsp,%rax,4)
               	incq	%rax
               	nopl	(%rax)
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movl	$0x9, %ecx
               	sarxq	%rax, %rcx, %rcx
               	testb	$0x1, %cl
               	je	<addr>
               	movl	0x50(%rsp,%rax,4), %ecx
               	jmp	<addr>
               	movl	0x40(%rsp,%rax,4), %ecx
               	nop
               	jmp	<addr>
               	movups	0x30(%rsp), %xmm14
               	movups	0x20(%rsp), %xmm15
               	vblendps	$0x9, %xmm15, %xmm14, %xmm0 # xmm0 = xmm15[0],xmm14[1,2],xmm15[3]
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0x80(%rsp), %rdi
               	leaq	0x70(%rsp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x40, %ecx
               	testq	%rax, %rax
               	cmovneq	%rcx, %rbx
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	%ecx, 0x70(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movl	0x60(%rsp,%rax,4), %ecx
               	shrq	$0x1f, %rcx
               	nopw	(%rax,%rax)
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	0x50(%rsp,%rax,4), %ecx
               	jmp	<addr>
               	movl	0x40(%rsp,%rax,4), %ecx
               	jmp	<addr>
               	vmovups	0x30(%rsp), %xmm14
               	vmovups	0x10(%rsp), %xmm15
               	vblendvps	%xmm15, 0x20(%rsp), %xmm14, %xmm0
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0x80(%rsp), %rdi
               	leaq	0x70(%rsp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x40, %ecx
               	testq	%rax, %rax
               	cmoveq	%rbx, %rcx
               	movups	0x30(%rsp), %xmm14
               	movups	0x20(%rsp), %xmm15
               	vblendpd	$0x2, %xmm15, %xmm14, %xmm0 # xmm0 = xmm14[0],xmm15[1]
               	movups	%xmm0, 0x80(%rsp)
               	vmovd	%xmm0, %eax
               	movl	0x40(%rsp), %edx
               	cmpl	%edx, %eax
               	jne	<addr>
               	vpextrd	$0x1, %xmm0, %eax
               	movl	0x44(%rsp), %edx
               	cmpl	%edx, %eax
               	jne	<addr>
               	vpextrd	$0x2, %xmm0, %eax
               	movl	0x58(%rsp), %edx
               	cmpl	%edx, %eax
               	jne	<addr>
               	vpextrd	$0x3, %xmm0, %eax
               	movl	0x5c(%rsp), %edx
               	cmpl	%edx, %eax
               	je	<addr>
               	movl	$0x40, %ecx
               	vmovups	0x30(%rsp), %xmm14
               	vmovups	0x10(%rsp), %xmm15
               	vblendvpd	%xmm15, 0x20(%rsp), %xmm14, %xmm0
               	movups	%xmm0, 0x80(%rsp)
               	xorl	%eax, %eax
               	movl	0x80(%rsp,%rax,4), %edi
               	movq	%rax, %r8
               	orq	$0x1, %r8
               	movl	0x60(%rsp,%r8,4), %edx
               	shrq	$0x1f, %rdx
               	nopl	(%rax)
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	0x50(%rsp,%rax,4), %edx
               	movl	$0x40, %r8d
               	cmpl	%edx, %edi
               	cmovneq	%r8, %rcx
               	jmp	<addr>
               	movl	0x40(%rsp,%rax,4), %edx
               	nopl	(%rax,%rax)
               	jmp	<addr>
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, %rax
               	popq	%rbx
               	addq	$0x90, %rsp
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
               	xorl	%r12d, %r12d
               	movq	%r12, %rbx
               	callq	<addr>
               	orq	%rax, %rbx
               	callq	<addr>
               	orq	%rax, %rbx
               	callq	<addr>
               	orq	%rax, %rbx
               	callq	<addr>
               	orq	%rax, %rbx
               	callq	<addr>
               	orq	%rax, %rbx
               	callq	<addr>
               	orq	%rax, %rbx
               	callq	<addr>
               	orq	%rax, %rbx
               	incq	%r12
               	nopl	(%rax)
               	cmpl	$0x12c, %r12d           # imm = 0x12C
               	jl	<addr>
               	movq	%rbx, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
