
compound_assign_once.x64:	file format elf64-x86-64

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

<once_through_pointers>:
               	leaq	<rip>, %rax      # <addr>
               	leaq	0x18(%rax), %rcx
               	movl	0x8(%rax), %edx
               	movq	%rdx, %rsi
               	andq	$0x7f, %rsi
               	shlq	$0x39, %rsi
               	sarq	$0x39, %rsi
               	incq	%rsi
               	andq	$0x7f, %rsi
               	andq	$-0x80, %rdx
               	orq	%rsi, %rdx
               	movl	%edx, 0x8(%rax)
               	cmpq	%rcx, %rcx
               	jne	<addr>
               	movl	0x8(%rax), %edx
               	andq	$0x7f, %rdx
               	shlq	$0x39, %rdx
               	sarq	$0x39, %rdx
               	cmpl	$0x1, %edx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movslq	(%rax), %rdx
               	addq	$0x5, %rdx
               	movl	%edx, (%rax)
               	cmpq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rax      # <addr>
               	movslq	(%rax), %rcx
               	cmpl	$0x5, %ecx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movl	0x8(%rax), %ecx
               	andq	$-0xf81, %rcx           # imm = 0xF07F
               	orq	$0x180, %rcx            # imm = 0x180
               	movl	%ecx, 0x8(%rax)
               	leaq	0x18(%rax), %rcx
               	movl	0x8(%rax), %edx
               	sarq	$0x7, %rdx
               	andq	$0x1f, %rdx
               	leaq	(%rdx,%rdx,2), %rdx
               	andq	$0x1f, %rdx
               	movl	0x8(%rax), %esi
               	andq	$-0xf81, %rsi           # imm = 0xF07F
               	shlq	$0x7, %rdx
               	orq	%rsi, %rdx
               	movl	%edx, 0x8(%rax)
               	cmpq	%rcx, %rcx
               	jne	<addr>
               	movl	0x8(%rax), %eax
               	sarq	$0x7, %rax
               	andq	$0x1f, %rax
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	leaq	<rip>, %rax      # <addr>
               	xorl	%edx, %edx
               	movl	%edx, (%rax)
               	incq	%rdx
               	movl	%edx, (%rax)
               	movl	0x8(%rcx), %edx
               	movq	%rdx, %rsi
               	andq	$0x7f, %rsi
               	shlq	$0x39, %rsi
               	sarq	$0x39, %rsi
               	incq	%rsi
               	andq	$0x7f, %rsi
               	andq	$-0x80, %rdx
               	orq	%rsi, %rdx
               	movl	%edx, 0x8(%rcx)
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	leaq	<rip>, %rcx      # <addr>
               	addq	$0x18, %rcx
               	movl	0x8(%rcx), %edx
               	movq	%rdx, %rsi
               	sarq	$0x7, %rsi
               	andq	$0x1f, %rsi
               	shlq	%rsi
               	andq	$0x1f, %rsi
               	andq	$-0xf81, %rdx           # imm = 0xF07F
               	shlq	$0x7, %rsi
               	orq	%rsi, %rdx
               	movl	%edx, 0x8(%rcx)
               	movslq	(%rax), %rdx
               	incq	%rdx
               	movl	%edx, (%rax)
               	movl	0x4(%rcx), %edx
               	leaq	(%rdx,%rdx,2), %rdx
               	movl	%edx, 0x4(%rcx)
               	movslq	(%rax), %rdx
               	incq	%rdx
               	movl	%edx, (%rax)
               	movq	0x8(%rcx), %rax
               	movq	%rax, %rdx
               	sarq	$0xc, %rdx
               	movabsq	$0xffffffffff, %r11     # imm = 0xFFFFFFFFFF
               	andq	%r11, %rdx
               	shlq	$0x18, %rdx
               	sarq	$0x18, %rdx
               	decq	%rdx
               	movabsq	$0xffffffffff, %r11     # imm = 0xFFFFFFFFFF
               	andq	%r11, %rdx
               	movabsq	$-0xffffffffff001, %r11 # imm = 0xFFF0000000000FFF
               	andq	%r11, %rax
               	shlq	$0xc, %rdx
               	orq	%rdx, %rax
               	movq	%rax, 0x8(%rcx)
               	leaq	<rip>, %rax      # <addr>
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	leaq	<rip>, %rcx      # <addr>
               	addq	$0x18, %rcx
               	movsd	0x10(%rcx), %xmm0
               	movabsq	$0x3ff0000000000000, %rdx # imm = 0x3FF0000000000000
               	movq	%rdx, %xmm15
               	addsd	%xmm15, %xmm0
               	movsd	%xmm0, 0x10(%rcx)
               	movslq	(%rax), %rdx
               	incq	%rdx
               	movl	%edx, (%rax)
               	movzbq	0xe(%rcx), %rdx
               	andq	$-0x11, %rdx
               	orq	$0x10, %rdx
               	movb	%dl, 0xe(%rcx)
               	movslq	(%rax), %rax
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	xorl	%eax, %eax
               	retq

<common_type>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x28, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	leaq	<rip>, %rax      # <addr>
               	movl	0x8(%rax), %ecx
               	andq	$-0x80, %rcx
               	orq	$0x7d, %rcx
               	movl	%ecx, 0x8(%rax)
               	movl	0x8(%rax), %ecx
               	andq	$0x7f, %rcx
               	shlq	$0x39, %rcx
               	sarq	$0x39, %rcx
               	movl	%ecx, %ecx
               	shrq	%rcx
               	andq	$0x7f, %rcx
               	movl	0x8(%rax), %edx
               	andq	$-0x80, %rdx
               	orq	%rdx, %rcx
               	movl	%ecx, 0x8(%rax)
               	movl	0x8(%rax), %ecx
               	andq	$0x7f, %rcx
               	shlq	$0x39, %rcx
               	sarq	$0x39, %rcx
               	cmpl	$-0x2, %ecx
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	0x8(%rax), %ecx
               	andq	$-0x80, %rcx
               	orq	$0x7d, %rcx
               	movl	%ecx, 0x8(%rax)
               	movl	0x8(%rax), %ecx
               	andq	$0x7f, %rcx
               	shlq	$0x39, %rcx
               	sarq	$0x39, %rcx
               	movl	%ecx, %ecx
               	movl	$0xcccccccd, %edx       # imm = 0xCCCCCCCD
               	imulq	%rcx, %rdx
               	shrq	$0x22, %rdx
               	leaq	(%rdx,%rdx,4), %rdx
               	subq	%rdx, %rcx
               	movl	0x8(%rax), %edx
               	andq	$-0x80, %rdx
               	orq	%rdx, %rcx
               	movl	%ecx, 0x8(%rax)
               	movl	0x8(%rax), %ecx
               	andq	$0x7f, %rcx
               	shlq	$0x39, %rcx
               	sarq	$0x39, %rcx
               	cmpl	$0x3, %ecx
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	0x8(%rax), %ecx
               	andq	$-0x80, %rcx
               	orq	$0x3, %rcx
               	movl	%ecx, 0x8(%rax)
               	movl	0x8(%rax), %ecx
               	andq	$0x7f, %rcx
               	shlq	$0x39, %rcx
               	sarq	$0x39, %rcx
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rcx, %xmm0
               	movabsq	$0x3ff8000000000000, %rcx # imm = 0x3FF8000000000000
               	movq	%rcx, %xmm15
               	mulsd	%xmm15, %xmm0
               	cvttsd2si	%xmm0, %rcx
               	andq	$0x7f, %rcx
               	movl	0x8(%rax), %edx
               	andq	$-0x80, %rdx
               	orq	%rdx, %rcx
               	movl	%ecx, 0x8(%rax)
               	movl	0x8(%rax), %ecx
               	andq	$0x7f, %rcx
               	shlq	$0x39, %rcx
               	sarq	$0x39, %rcx
               	cmpl	$0x4, %ecx
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	xorl	%edx, %edx
               	movzbq	0xe(%rax), %rcx
               	andq	$-0x11, %rcx
               	movb	%cl, 0xe(%rax)
               	movzbq	0xe(%rax), %rcx
               	sarq	$0x4, %rcx
               	andq	$0x1, %rcx
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rcx, %xmm0
               	movabsq	$0x3fd0000000000000, %rcx # imm = 0x3FD0000000000000
               	movq	%rcx, %xmm15
               	addsd	%xmm15, %xmm0
               	movq	%rdx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%sil
               	movzbq	%sil, %rsi
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rsi
               	andq	$0x1, %rsi
               	movzbq	0xe(%rax), %rdi
               	andq	$-0x11, %rdi
               	shlq	$0x4, %rsi
               	orq	%rdi, %rsi
               	movb	%sil, 0xe(%rax)
               	movzbq	0xe(%rax), %rsi
               	sarq	$0x4, %rsi
               	andq	$0x1, %rsi
               	cmpl	$0x1, %esi
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	0x8(%rax), %esi
               	andq	$-0xf81, %rsi           # imm = 0xF07F
               	orq	$0xf00, %rsi            # imm = 0xF00
               	movl	%esi, 0x8(%rax)
               	movl	0x8(%rax), %esi
               	sarq	$0x7, %rsi
               	andq	$0x1f, %rsi
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rsi, %xmm0
               	movabsq	$0x3fe0000000000000, %rsi # imm = 0x3FE0000000000000
               	movq	%rsi, %xmm15
               	subsd	%xmm15, %xmm0
               	cvttsd2si	%xmm0, %rdi
               	andq	$0x1f, %rdi
               	movl	0x8(%rax), %r8d
               	andq	$-0xf81, %r8            # imm = 0xF07F
               	shlq	$0x7, %rdi
               	orq	%r8, %rdi
               	movl	%edi, 0x8(%rax)
               	movl	0x8(%rax), %eax
               	sarq	$0x7, %rax
               	andq	$0x1f, %rax
               	cmpl	$0x1d, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x1000001, %eax        # imm = 0x1000001
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rax, %xmm0
               	xorl	%eax, %eax
               	movq	%rax, %xmm15
               	addss	%xmm15, %xmm0
               	cvttss2si	%xmm0, %rax
               	cmpl	$0x1000000, %eax        # imm = 0x1000000
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movabsq	$-0x4000000000000000, %rax # imm = 0xC000000000000000
               	xorps	%xmm0, %xmm0
               	movq	%rax, %r10
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
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movq	%rax, %xmm15
               	divsd	%xmm15, %xmm0
               	movapd	%xmm0, %xmm14
               	movabsq	$0x43e0000000000000, %r11 # imm = 0x43E0000000000000
               	movq	%r11, %xmm15
               	ucomisd	%xmm15, %xmm14
               	jae	<addr>
               	cvttsd2si	%xmm14, %rax
               	jmp	<addr>
               	subsd	%xmm15, %xmm14
               	cvttsd2si	%xmm14, %rax
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	orq	%r11, %rax
               	movabsq	$0x6000000000000000, %r11 # imm = 0x6000000000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rdx, %xmm0
               	movq	%rcx, %xmm15
               	addsd	%xmm15, %xmm0
               	movq	%rdx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	andq	$0xff, %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0xc, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x3f, %edi
               	movl	$0x1, %eax
               	xorps	%xmm0, %xmm0
               	movq	%rax, %r10
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
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movq	%rax, -0x8(%rbp)
               	movsd	-0x8(%rbp), %xmm1
               	movq	%rsi, %xmm15
               	vfmsub213sd	%xmm15, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) - xmm15
               	movsd	%xmm0, -0x8(%rbp)
               	movq	-0x8(%rbp), %rcx
               	movq	%rcx, %rax
               	sarq	$0x3f, %rax
               	movabsq	$0x7fffffffffffffff, %rsi # imm = 0x7FFFFFFFFFFFFFFF
               	andq	%rcx, %rsi
               	shrq	$0x34, %rsi
               	leaq	-0x3ff(%rsi), %rbx
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rcx
               	movabsq	$0x10000000000000, %r8  # imm = 0x10000000000000
               	orq	%rcx, %r8
               	leaq	-0x433(%rsi), %rcx
               	movq	%rcx, %rsi
               	sarq	$0x3f, %rsi
               	xorq	%rsi, %rcx
               	subq	%rsi, %rcx
               	movq	%rcx, %r9
               	andq	$0x7f, %r9
               	andq	$0x3f, %rcx
               	movq	%rdi, %r12
               	subq	%rcx, %r12
               	movq	%r9, %rdi
               	shrq	$0x6, %rdi
               	movq	%rdi, %r9
               	negq	%r9
               	movq	%r9, %rdi
               	xorq	$-0x1, %rdi
               	movq	%r8, %r13
               	shlq	%cl, %r13
               	movq	%r8, %r14
               	pushq	%rcx
               	movq	%r12, %rcx
               	shrq	%cl, %r14
               	popq	%rcx
               	shrq	%r14
               	movq	%rdx, %r15
               	shlq	%cl, %r15
               	orq	%r15, %r14
               	movq	%r13, %r15
               	andq	%rdi, %r15
               	andq	%rdi, %r14
               	andq	%r9, %r13
               	orq	%r13, %r14
               	movq	%rdx, %r13
               	shrq	%cl, %r13
               	pushq	%rcx
               	movq	%r12, %rcx
               	shlq	%cl, %rdx
               	popq	%rcx
               	shlq	%rdx
               	shrq	%cl, %r8
               	movq	%r8, %rcx
               	orq	%rdx, %rcx
               	andq	%rdi, %rcx
               	movq	%r13, %rdx
               	andq	%r9, %rdx
               	orq	%rcx, %rdx
               	andq	%r13, %rdi
               	movq	%rsi, %rcx
               	xorq	$-0x1, %rcx
               	movq	%r15, %r8
               	andq	%rcx, %r8
               	andq	%rsi, %rdx
               	orq	%r8, %rdx
               	andq	%r14, %rcx
               	andq	%rdi, %rsi
               	orq	%rcx, %rsi
               	movq	%rbx, %rcx
               	sarq	$0x3f, %rcx
               	xorq	$-0x1, %rcx
               	andq	%rcx, %rdx
               	andq	%rcx, %rsi
               	cmpl	$0x80, %ebx
               	setge	%cl
               	movzbq	%cl, %rcx
               	negq	%rcx
               	xorq	%rax, %rdx
               	xorq	%rax, %rsi
               	cmpq	%rax, %rdx
               	setb	%dil
               	movzbq	%dil, %rdi
               	subq	%rax, %rdx
               	subq	%rax, %rsi
               	subq	%rdi, %rsi
               	movq	%rax, %rdi
               	xorq	$-0x1, %rdi
               	movabsq	$0x7fffffffffffffff, %r8 # imm = 0x7FFFFFFFFFFFFFFF
               	xorq	%rax, %r8
               	movq	%rcx, %rax
               	xorq	$-0x1, %rax
               	andq	%rax, %rdx
               	andq	%rcx, %rdi
               	orq	%rdi, %rdx
               	andq	%rsi, %rax
               	andq	%r8, %rcx
               	orq	%rcx, %rax
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x3f, %esi
               	xorl	%edi, %edi
               	movl	$0x7, %eax
               	xorps	%xmm0, %xmm0
               	movq	%rax, %r10
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
               	movabsq	$-0x4010000000000000, %rax # imm = 0xBFF0000000000000
               	movq	%rax, -0x8(%rbp)
               	movsd	-0x8(%rbp), %xmm1
               	mulsd	%xmm1, %xmm0
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movq	%rax, %xmm15
               	divsd	%xmm15, %xmm0
               	movsd	%xmm0, -0x8(%rbp)
               	movq	-0x8(%rbp), %rcx
               	movq	%rcx, %rax
               	sarq	$0x3f, %rax
               	movabsq	$0x7fffffffffffffff, %rdx # imm = 0x7FFFFFFFFFFFFFFF
               	andq	%rcx, %rdx
               	shrq	$0x34, %rdx
               	leaq	-0x3ff(%rdx), %rbx
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rcx
               	movabsq	$0x10000000000000, %r8  # imm = 0x10000000000000
               	orq	%rcx, %r8
               	leaq	-0x433(%rdx), %rcx
               	movq	%rcx, %rdx
               	sarq	$0x3f, %rdx
               	xorq	%rdx, %rcx
               	subq	%rdx, %rcx
               	movq	%rcx, %r9
               	andq	$0x7f, %r9
               	andq	$0x3f, %rcx
               	movq	%rsi, %r12
               	subq	%rcx, %r12
               	movq	%r9, %rsi
               	shrq	$0x6, %rsi
               	movq	%rsi, %r9
               	negq	%r9
               	movq	%r9, %rsi
               	xorq	$-0x1, %rsi
               	movq	%r8, %r13
               	shlq	%cl, %r13
               	movq	%r8, %r14
               	pushq	%rcx
               	movq	%r12, %rcx
               	shrq	%cl, %r14
               	popq	%rcx
               	shrq	%r14
               	movq	%rdi, %r15
               	shlq	%cl, %r15
               	orq	%r15, %r14
               	movq	%r13, %r15
               	andq	%rsi, %r15
               	andq	%rsi, %r14
               	andq	%r9, %r13
               	orq	%r13, %r14
               	movq	%rdi, %r13
               	shrq	%cl, %r13
               	pushq	%rcx
               	movq	%r12, %rcx
               	shlq	%cl, %rdi
               	popq	%rcx
               	shlq	%rdi
               	shrq	%cl, %r8
               	movq	%r8, %rcx
               	orq	%rdi, %rcx
               	andq	%rsi, %rcx
               	movq	%r13, %rdi
               	andq	%r9, %rdi
               	orq	%rcx, %rdi
               	andq	%r13, %rsi
               	movq	%rdx, %rcx
               	xorq	$-0x1, %rcx
               	movq	%r15, %r8
               	andq	%rcx, %r8
               	andq	%rdx, %rdi
               	orq	%r8, %rdi
               	andq	%r14, %rcx
               	andq	%rsi, %rdx
               	orq	%rcx, %rdx
               	movq	%rbx, %rcx
               	sarq	$0x3f, %rcx
               	xorq	$-0x1, %rcx
               	movq	%rdi, %rsi
               	andq	%rcx, %rsi
               	movq	%rdx, %rdi
               	andq	%rcx, %rdi
               	cmpl	$0x80, %ebx
               	setge	%cl
               	movzbq	%cl, %rcx
               	negq	%rcx
               	movq	%rsi, %rdx
               	xorq	%rax, %rdx
               	movq	%rdi, %rsi
               	xorq	%rax, %rsi
               	cmpq	%rax, %rdx
               	setb	%dil
               	movzbq	%dil, %rdi
               	subq	%rax, %rdx
               	subq	%rax, %rsi
               	subq	%rdi, %rsi
               	movq	%rax, %rdi
               	xorq	$-0x1, %rdi
               	movabsq	$0x7fffffffffffffff, %r8 # imm = 0x7FFFFFFFFFFFFFFF
               	xorq	%rax, %r8
               	movq	%rcx, %rax
               	xorq	$-0x1, %rax
               	andq	%rax, %rdx
               	andq	%rcx, %rdi
               	orq	%rdi, %rdx
               	andq	%rsi, %rax
               	andq	%r8, %rcx
               	orq	%rcx, %rax
               	movq	%rdx, %rcx
               	xorq	$-0x3, %rcx
               	xorq	$-0x1, %rax
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	<rip>, %rdx      # <addr>
               	xorl	%edi, %edi
               	movq	0x8(%rdx), %rax
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rax
               	movq	$0x3, (%rdx)
               	movq	%rax, 0x8(%rdx)
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rax
               	shlq	$0x1c, %rax
               	movq	%rax, %rcx
               	sarq	$0x1c, %rcx
               	shlq	$0x24, %rax
               	movq	%rax, %rsi
               	orq	$0x3, %rsi
               	movq	%rcx, %rax
               	sarq	$0x3f, %rax
               	xorq	%rax, %rsi
               	xorq	%rax, %rcx
               	cmpq	%rax, %rsi
               	setb	%r9b
               	movzbq	%r9b, %r9
               	movq	%rsi, %r8
               	subq	%rax, %r8
               	subq	%rax, %rcx
               	movq	%rcx, %rsi
               	subq	%r9, %rsi
               	movabsq	$-0x8000000000000000, %r12 # imm = 0x8000000000000000
               	andq	%rax, %r12
               	testq	%rsi, %rsi
               	setne	%r9b
               	movzbq	%r9b, %r9
               	movq	%rsi, %rax
               	shrq	$0x20, %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, %rcx
               	shlq	$0x5, %rcx
               	leaq	0x1(%rcx), %rbx
               	movq	%rsi, %rax
               	shrq	%cl, %rax
               	movq	%rax, %rcx
               	shrq	$0x10, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	shlq	$0x4, %rcx
               	addq	%rcx, %rbx
               	shrq	%cl, %rax
               	movq	%rax, %rcx
               	shrq	$0x8, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rbx
               	shrq	%cl, %rax
               	movq	%rax, %rcx
               	shrq	$0x4, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rbx
               	shrq	%cl, %rax
               	movq	%rax, %rcx
               	shrq	$0x2, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	shlq	%rcx
               	addq	%rcx, %rbx
               	shrq	%cl, %rax
               	shrq	%rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	leaq	(%rbx,%rcx), %rax
               	imulq	%r9, %rax
               	movl	$0x40, %ecx
               	subq	%rax, %rcx
               	andq	$0x3f, %rcx
               	movq	$-0x1, %r9
               	shrq	%cl, %r9
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	imulq	%r9, %rcx
               	andq	%r8, %rcx
               	testq	%rcx, %rcx
               	setne	%r13b
               	movzbq	%r13b, %r13
               	movq	%rax, %r9
               	andq	$0x7f, %r9
               	movq	%rax, %rcx
               	andq	$0x3f, %rcx
               	movl	$0x3f, %ebx
               	movq	%rbx, %r14
               	subq	%rcx, %r14
               	shrq	$0x6, %r9
               	negq	%r9
               	movq	%r9, %r15
               	xorq	$-0x1, %r15
               	movq	%rsi, %r10
               	shrq	%cl, %r10
               	movq	%r10, 0x38(%rsp)
               	pushq	%rcx
               	movq	%r14, %rcx
               	shlq	%cl, %rsi
               	popq	%rcx
               	shlq	%rsi
               	shrq	%cl, %r8
               	movq	%r8, %rcx
               	orq	%rsi, %rcx
               	andq	%r15, %rcx
               	movq	0x38(%rsp), %rsi
               	andq	%r9, %rsi
               	orq	%rsi, %rcx
               	orq	%r13, %rcx
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
               	addq	$0x3ff, %rax            # imm = 0x3FF
               	shlq	$0x34, %rax
               	orq	%r12, %rax
               	movq	%rax, -0x8(%rbp)
               	movsd	-0x8(%rbp), %xmm1
               	mulsd	%xmm1, %xmm0
               	movabsq	$0x3ff8000000000000, %rax # imm = 0x3FF8000000000000
               	movq	%rax, %xmm15
               	mulsd	%xmm15, %xmm0
               	movsd	%xmm0, -0x8(%rbp)
               	movq	-0x8(%rbp), %rcx
               	movq	%rcx, %rax
               	sarq	$0x3f, %rax
               	movabsq	$0x7fffffffffffffff, %rsi # imm = 0x7FFFFFFFFFFFFFFF
               	andq	%rcx, %rsi
               	shrq	$0x34, %rsi
               	leaq	-0x3ff(%rsi), %r12
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rcx
               	movabsq	$0x10000000000000, %r9  # imm = 0x10000000000000
               	orq	%rcx, %r9
               	leaq	-0x433(%rsi), %rcx
               	movq	%rcx, %rsi
               	sarq	$0x3f, %rsi
               	xorq	%rsi, %rcx
               	subq	%rsi, %rcx
               	movq	%rcx, %r8
               	andq	$0x7f, %r8
               	andq	$0x3f, %rcx
               	movq	%rbx, %r13
               	subq	%rcx, %r13
               	shrq	$0x6, %r8
               	movq	%r8, %rbx
               	negq	%rbx
               	movq	%rbx, %r8
               	xorq	$-0x1, %r8
               	movq	%r9, %r14
               	shlq	%cl, %r14
               	movq	%r9, %r15
               	pushq	%rcx
               	movq	%r13, %rcx
               	shrq	%cl, %r15
               	popq	%rcx
               	shrq	%r15
               	movq	%rdi, %r10
               	shlq	%cl, %r10
               	movq	%r10, 0x38(%rsp)
               	movq	%r15, %r10
               	movq	0x38(%rsp), %r15
               	orq	%r10, %r15
               	movq	%r14, %r10
               	andq	%r8, %r10
               	movq	%r10, 0x38(%rsp)
               	andq	%r8, %r15
               	andq	%rbx, %r14
               	orq	%r14, %r15
               	movq	%rdi, %r14
               	shrq	%cl, %r14
               	movq	%r13, %r10
               	movq	%rdi, %r13
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %r13
               	popq	%rcx
               	shlq	%r13
               	shrq	%cl, %r9
               	movq	%r9, %rcx
               	orq	%r13, %rcx
               	andq	%r8, %rcx
               	movq	%r14, %r9
               	andq	%rbx, %r9
               	orq	%rcx, %r9
               	andq	%r14, %r8
               	movq	%rsi, %rcx
               	xorq	$-0x1, %rcx
               	movq	0x38(%rsp), %rbx
               	andq	%rcx, %rbx
               	andq	%rsi, %r9
               	orq	%rbx, %r9
               	andq	%r15, %rcx
               	andq	%r8, %rsi
               	orq	%rcx, %rsi
               	movq	%r12, %rcx
               	sarq	$0x3f, %rcx
               	xorq	$-0x1, %rcx
               	movq	%r9, %r8
               	andq	%rcx, %r8
               	movq	%rsi, %r9
               	andq	%rcx, %r9
               	cmpl	$0x80, %r12d
               	setge	%cl
               	movzbq	%cl, %rcx
               	negq	%rcx
               	movq	%r8, %rsi
               	xorq	%rax, %rsi
               	movq	%r9, %r8
               	xorq	%rax, %r8
               	cmpq	%rax, %rsi
               	setb	%r9b
               	movzbq	%r9b, %r9
               	subq	%rax, %rsi
               	subq	%rax, %r8
               	subq	%r9, %r8
               	movq	%rax, %r9
               	xorq	$-0x1, %r9
               	movabsq	$0x7fffffffffffffff, %rbx # imm = 0x7FFFFFFFFFFFFFFF
               	xorq	%rax, %rbx
               	movq	%rcx, %rax
               	xorq	$-0x1, %rax
               	andq	%rax, %rsi
               	andq	%rcx, %r9
               	orq	%r9, %rsi
               	andq	%r8, %rax
               	andq	%rbx, %rcx
               	orq	%rcx, %rax
               	movabsq	$0xfffffffff, %rcx      # imm = 0xFFFFFFFFF
               	andq	%rax, %rcx
               	movq	0x8(%rdx), %rax
               	movabsq	$-0x1000000000, %r8     # imm = 0xFFFFFFF000000000
               	andq	%rax, %r8
               	movq	%rdi, %rax
               	orq	%rsi, %rax
               	orq	%r8, %rcx
               	movq	%rax, (%rdx)
               	movq	%rcx, 0x8(%rdx)
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rcx
               	movq	%rax, %rdx
               	shlq	$0x1c, %rdx
               	shlq	$0x1c, %rcx
               	shrq	$0x24, %rax
               	orq	%rcx, %rax
               	movq	%rax, %rcx
               	sarq	$0x1c, %rcx
               	shrq	$0x1c, %rdx
               	shlq	$0x24, %rax
               	orq	%rdx, %rax
               	xorq	$0x4, %rax
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq

<assignment_value>:
               	leaq	<rip>, %rax      # <addr>
               	movq	0x38(%rax), %rcx
               	movabsq	$-0xffffffffff001, %r11 # imm = 0xFFF0000000000FFF
               	andq	%r11, %rcx
               	movabsq	$0x7fffffffff000, %r11  # imm = 0x7FFFFFFFFF000
               	orq	%r11, %rcx
               	movq	%rcx, 0x38(%rax)
               	movq	%rcx, %rdx
               	sarq	$0xc, %rdx
               	movabsq	$0xffffffffff, %r11     # imm = 0xFFFFFFFFFF
               	andq	%r11, %rdx
               	shlq	$0x18, %rdx
               	sarq	$0x18, %rdx
               	incq	%rdx
               	movabsq	$0xffffffffff, %r11     # imm = 0xFFFFFFFFFF
               	andq	%r11, %rdx
               	movabsq	$-0xffffffffff001, %r11 # imm = 0xFFF0000000000FFF
               	andq	%r11, %rcx
               	movq	%rdx, %rsi
               	shlq	$0xc, %rsi
               	orq	%rsi, %rcx
               	movq	%rcx, 0x38(%rax)
               	movq	%rdx, %rcx
               	shlq	$0x18, %rcx
               	sarq	$0x18, %rcx
               	movabsq	$-0x8000000000, %r11    # imm = 0xFFFFFF8000000000
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x10, %eax
               	retq
               	movq	0x38(%rax), %rcx
               	movq	%rcx, %rdx
               	sarq	$0xc, %rdx
               	movabsq	$0xffffffffff, %r11     # imm = 0xFFFFFFFFFF
               	andq	%r11, %rdx
               	shlq	$0x18, %rdx
               	sarq	$0x18, %rdx
               	incq	%rdx
               	movabsq	$0xffffffffff, %r11     # imm = 0xFFFFFFFFFF
               	andq	%r11, %rdx
               	movabsq	$-0xffffffffff001, %r11 # imm = 0xFFF0000000000FFF
               	andq	%r11, %rcx
               	movq	%rdx, %rsi
               	shlq	$0xc, %rsi
               	orq	%rsi, %rcx
               	movq	%rcx, 0x38(%rax)
               	movq	%rdx, %rcx
               	shlq	$0x18, %rcx
               	sarq	$0x18, %rcx
               	movabsq	$-0x7fffffffff, %r11    # imm = 0xFFFFFF8000000001
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x11, %eax
               	retq
               	movl	0x38(%rax), %ecx
               	andq	$-0x80, %rcx
               	orq	$0x3f, %rcx
               	movl	%ecx, 0x38(%rax)
               	movl	0x38(%rax), %ecx
               	andq	$0x7f, %rcx
               	shlq	$0x39, %rcx
               	sarq	$0x39, %rcx
               	incq	%rcx
               	andq	$0x7f, %rcx
               	movl	0x38(%rax), %edx
               	andq	$-0x80, %rdx
               	orq	%rcx, %rdx
               	movl	%edx, 0x38(%rax)
               	shlq	$0x39, %rcx
               	sarq	$0x39, %rcx
               	cmpl	$-0x40, %ecx
               	jne	<addr>
               	movl	0x38(%rax), %ecx
               	andq	$0x7f, %rcx
               	shlq	$0x39, %rcx
               	sarq	$0x39, %rcx
               	cmpl	$-0x40, %ecx
               	je	<addr>
               	movl	$0x12, %eax
               	retq
               	leaq	<rip>, %rcx      # <addr>
               	movl	0x8(%rcx), %edx
               	andq	$-0x80, %rdx
               	orq	$0x3c, %rdx
               	movl	%edx, 0x8(%rcx)
               	movl	0x8(%rcx), %edx
               	andq	$0x7f, %rdx
               	shlq	$0x39, %rdx
               	sarq	$0x39, %rdx
               	addq	$0xa, %rdx
               	andq	$0x7f, %rdx
               	movl	0x8(%rcx), %esi
               	andq	$-0x80, %rsi
               	orq	%rdx, %rsi
               	movl	%esi, 0x8(%rcx)
               	shlq	$0x39, %rdx
               	sarq	$0x39, %rdx
               	cmpl	$-0x3a, %edx
               	je	<addr>
               	movl	$0x13, %eax
               	retq
               	movl	0x8(%rcx), %edx
               	andq	$-0xf81, %rdx           # imm = 0xF07F
               	orq	$0xf80, %rdx            # imm = 0xF80
               	movl	%edx, 0x8(%rcx)
               	movl	0x8(%rcx), %edx
               	sarq	$0x7, %rdx
               	andq	$0x1f, %rdx
               	incq	%rdx
               	andq	$0x1f, %rdx
               	movl	0x8(%rcx), %esi
               	andq	$-0xf81, %rsi           # imm = 0xF07F
               	movq	%rdx, %rdi
               	shlq	$0x7, %rdi
               	orq	%rdi, %rsi
               	movl	%esi, 0x8(%rcx)
               	testl	%edx, %edx
               	jne	<addr>
               	movl	0x8(%rcx), %ecx
               	sarq	$0x7, %rcx
               	testb	$0x1f, %cl
               	je	<addr>
               	movl	$0x14, %eax
               	retq
               	movzbq	0x3e(%rax), %rcx
               	andq	$-0x11, %rcx
               	orq	$0x10, %rcx
               	movb	%cl, 0x3e(%rax)
               	xorl	%eax, %eax
               	retq

<int128_operand>:
               	leaq	<rip>, %rcx      # <addr>
               	movl	0x50(%rcx), %eax
               	andq	$-0x80, %rax
               	orq	$0x7d, %rax
               	movl	%eax, 0x50(%rcx)
               	movl	0x50(%rcx), %eax
               	andq	$0x7f, %rax
               	shlq	$0x39, %rax
               	sarq	$0x39, %rax
               	movl	$0x3, %esi
               	imulq	%rax, %rsi
               	movq	%rsi, %rax
               	andq	$0x7f, %rax
               	movl	0x50(%rcx), %edx
               	andq	$-0x80, %rdx
               	orq	%rdx, %rax
               	movl	%eax, 0x50(%rcx)
               	movl	0x50(%rcx), %eax
               	andq	$0x7f, %rax
               	shlq	$0x39, %rax
               	sarq	$0x39, %rax
               	cmpl	$-0x9, %eax
               	je	<addr>
               	movl	$0x18, %eax
               	retq
               	movzbq	0x56(%rcx), %rax
               	andq	$-0x11, %rax
               	movb	%al, 0x56(%rcx)
               	movzbq	0x56(%rcx), %rax
               	andq	$-0x11, %rax
               	orq	$0x10, %rax
               	movb	%al, 0x56(%rcx)
               	movzbq	0x56(%rcx), %rax
               	sarq	$0x4, %rax
               	andq	$0x1, %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x1a, %eax
               	retq
               	xorl	%eax, %eax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbp
               	retq
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbp
               	retq
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbp
               	retq
               	callq	<addr>
               	popq	%rbp
               	retq
